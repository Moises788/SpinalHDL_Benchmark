package spinal.DDRAxi

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axilite._

/** Bus converter: N-bit AXI R -> M-bit samples (Resource Optimized) */
class BitGearbox(inWidth: Int, outWidth: Int) extends Component {
  val io = new Bundle {
    val input  = slave Stream (Bits(inWidth bits))
    val output = master Stream (Bits(outWidth bits))
  }
  
  // The buffer must hold the remaining bits (outWidth - 1) plus the new incoming bits (inWidth)
  val bufferWidth = inWidth + outWidth
  val countWidth  = log2Up(bufferWidth + 1)

  val shiftReg = Reg(Bits(bufferWidth bits)) init (0)
  val bitCount = Reg(UInt(countWidth bits)) init (0)

  // Ready to accept new data if there is enough space in the buffer
  io.input.ready  := bitCount <= U(bufferWidth - inWidth, countWidth bits)
  
  // Valid output if we have accumulated enough bits for one complete output word
  io.output.valid := bitCount >= U(outWidth, countWidth bits)
  io.output.payload := shiftReg(outWidth - 1 downto 0)

  val popAmount = io.output.fire ? U(outWidth, countWidth bits) | U(0, countWidth bits)
  val poppedReg = (shiftReg >> popAmount).resize(bufferWidth)
  val insertPos = (bitCount - popAmount).resize(log2Up(bufferWidth + 1))

  when(io.input.fire) {
    val shiftedIn = (io.input.payload.resize(bufferWidth) << insertPos).resize(bufferWidth)
    shiftReg := poppedReg | shiftedIn
  } otherwise {
    shiftReg := poppedReg
  }
  
  bitCount := bitCount + (io.input.fire ? U(inWidth, countWidth bits) | U(0, countWidth bits)) - popAmount
}

/** Core IP: Dual-Clock Resource-Optimized Reads DDR via AXI4 -> PL via Stream (Asynchronous FIFO) */
class DdrToStreamPynq(
    sampleWidth: Int = 256,
    axiDataWidth: Int = 128,
    axiAddressWidth: Int = 32
) extends Component {

  require(isPow2(axiDataWidth / 8), "axiDataWidth must be a byte-multiple power of two")
  val axiBytes    = axiDataWidth / 8
  val axiSizeCode = log2Up(axiBytes) 

  val axiConfig = Axi4Config(
    addressWidth = axiAddressWidth, dataWidth = axiDataWidth, idWidth = 4,
    useId = true, useRegion = false, useBurst = true, useLock = false,
    useCache = true, useSize = true, useQos = false, useLen = true,
    useResp = true, useProt = true, useStrb = false
  )

  val axiLiteConfig = AxiLite4Config(addressWidth = 6, dataWidth = 32)

  // Dual-clock top interface
  val io = new Bundle {
    val streamClk   = in Bool()
    val streamReset = in Bool()

    val axi     = master(Axi4ReadOnly(axiConfig)) 
    val axiLite = slave(AxiLite4(axiLiteConfig))
    val dataOut = master Stream (Bits(sampleWidth bits))
  }

  // Define the separate clock domain for the output stream
  val streamClockDomain = ClockDomain(
    clock = io.streamClk,
    reset = io.streamReset,
    config = ClockDomainConfig(resetActiveLevel = LOW)
  )

  // ---------------------------------------------------------------------
  // 1. Fast Domain (AXI): Main Logic, FSM, and AXI-Lite Registers
  // This section natively runs on the implicit default clock (AXI clock)
  // ---------------------------------------------------------------------
  val ctrl = AxiLite4SlaveFactory(io.axiLite)

  val busy           = RegInit(False)
  val done           = RegInit(False)
  val error          = RegInit(False)
  val durationCycles = Reg(UInt(32 bits)) init (0)

  // Telemetry snapshots
  val time_AR_Accept    = Reg(UInt(32 bits)) init (0)
  val time_First_RData  = Reg(UInt(32 bits)) init (0)
  val time_First_Stream = Reg(UInt(32 bits)) init (0)
  val time_Done         = Reg(UInt(32 bits)) init (0) 

  val got_AR     = RegInit(False)
  val got_R      = RegInit(False)
  val got_Stream = RegInit(False)

  val startAddr    = ctrl.createReadAndWrite(UInt(axiAddressWidth bits), 0x08) init (0)
  val sampleLength = ctrl.createReadAndWrite(UInt(32 bits), 0x0C) init (0) 

  // Optimized internal counters (20 bits save LUTs/FFs compared to 32 bits)
  val samplesSent    = Reg(UInt(20 bits)) init (0)
  val arBeatsIssued  = Reg(UInt(20 bits)) init (0)
  val rBeatsReceived = Reg(UInt(20 bits)) init (0)
  val validDropCount = Reg(UInt(20 bits)) init (0) 

  // Map control registers to AXI-Lite
  ctrl.read(busy,  0x00, 0)
  ctrl.read(done,  0x00, 1)
  ctrl.read(error, 0x00, 2)
  ctrl.read(durationCycles, 0x04)
  
  // Map snapshot registers
  ctrl.read(time_AR_Accept, 0x14)
  ctrl.read(time_First_RData, 0x18)
  ctrl.read(time_First_Stream, 0x1C)
  ctrl.read(time_Done, 0x20)

  // Map optimized counters (resized to 32 bits for the AXI-Lite bus)
  ctrl.read(samplesSent.resized,    0x24)
  ctrl.read(arBeatsIssued.resized,  0x28)
  ctrl.read(rBeatsReceived.resized, 0x2C)
  ctrl.read(validDropCount.resized, 0x30) 

  val startTrigger = ctrl.isWriting(0x10)

  val curAddress     = Reg(UInt(axiAddressWidth bits)) init (0)
  val remainingBeats = Reg(UInt(32 bits)) init (0)

  // FSM Start Trigger
  when(startTrigger && !busy) {
    busy           := True
    done           := False
    error          := False
    durationCycles := 0
    samplesSent    := 0
    arBeatsIssued  := 0
    rBeatsReceived := 0
    validDropCount := 0
    curAddress     := startAddr

    got_AR             := False
    got_R              := False
    got_Stream         := False
    time_AR_Accept     := 0
    time_First_RData   := 0
    time_First_Stream  := 0
    time_Done          := 0

    // Calculate total beats required based on sample size and AXI bus width
    val totalBits  = sampleLength * sampleWidth
    val totalBytes = (totalBits + 7) >> 3
    remainingBeats := ((totalBytes + (axiBytes - 1)) >> log2Up(axiBytes)).resized
  }

  // Global cycle counter (tracks AXI clock cycles)
  when(busy) { durationCycles := durationCycles + 1 }

  // ---------------------------------------------------------------------
  // 2. Fast Domain: AXI Read Request Generator (AR Channel)
  // ---------------------------------------------------------------------
  val arValidReg = RegInit(False)
  val maxBurst   = U(256, 32 bits) // Maximum AXI4 burst length
  
  // Ensure we don't cross 4KB address boundaries (AXI4 requirement)
  val bytesTo4K  = U(4096, 13 bits) - curAddress(11 downto 0).resize(13)
  val boundBeats = (bytesTo4K >> log2Up(axiBytes)).resize(32 bits)

  def uMin(a: UInt, b: UInt): UInt = (a < b) ? a | b
  val burstLen = uMin(uMin(remainingBeats, maxBurst), boundBeats)

  io.axi.ar.valid         := arValidReg
  io.axi.ar.payload.addr  := curAddress
  io.axi.ar.payload.id    := 0
  io.axi.ar.payload.len   := (burstLen - 1).resize(8)
  io.axi.ar.payload.size  := axiSizeCode
  io.axi.ar.payload.burst := B"01"
  io.axi.ar.payload.cache := B"0011"
  io.axi.ar.payload.prot  := 0

  // Issue new read request if not currently issuing, no error, and beats remain
  when(busy && !error && remainingBeats =/= 0 && !arValidReg) {
    arValidReg := True
  }

  when(io.axi.ar.fire) {
    arValidReg     := False
    curAddress     := curAddress + (burstLen << log2Up(axiBytes)).resize(axiAddressWidth)
    remainingBeats := remainingBeats - burstLen
    arBeatsIssued  := arBeatsIssued + burstLen.resized
  }

  // Snapshot: First AR accepted
  when(io.axi.ar.fire && !got_AR) {
    got_AR         := True
    time_AR_Accept := durationCycles
  }

  // ---------------------------------------------------------------------
  // 3. Fast Domain: AXI R -> Gearbox
  // ---------------------------------------------------------------------
  val gearbox = new BitGearbox(axiDataWidth, sampleWidth).setDefinitionName("BitGearboxRead")

  val rValidGated = io.axi.r.valid && !error
  gearbox.io.input.valid   := rValidGated
  gearbox.io.input.payload := io.axi.r.payload.data
  
  // Continue asserting ready even on error to drain the AXI bus and prevent deadlocks
  io.axi.r.ready           := gearbox.io.input.ready && !error

  when(io.axi.r.fire) {
    rBeatsReceived := rBeatsReceived + 1
    when(io.axi.r.payload.resp =/= B"00") { // Check for AXI read errors
      error := True
      busy  := False
    }
  }

  // Snapshot: First RData received
  when(io.axi.r.fire && !got_R) {
    got_R             := True
    time_First_RData  := durationCycles
  }

  // ---------------------------------------------------------------------
  // 4. The Bridge: Asynchronous Cross-Clock FIFO (StreamFifoCC)
  // ---------------------------------------------------------------------
  val cdcFifo = new StreamFifoCC(
    dataType  = Bits(sampleWidth bits),
    depth     = 64, // Sufficient depth to absorb fast AXI bursts
    pushClock = ClockDomain.current, // Implicit fast AXI clock
    popClock  = streamClockDomain    // Explicit slow Stream clock
  ).setDefinitionName("StreamFifoCC_DdrToStream")

  

  val pipedStream = gearbox.io.output.m2sPipe()

  cdcFifo.io.push.valid   := pipedStream.valid && busy
  cdcFifo.io.push.payload := pipedStream.payload
  pipedStream.ready       := cdcFifo.io.push.ready && busy
  // Snapshot: First data sent to stream boundary
  when(cdcFifo.io.push.fire && !got_Stream) {
    got_Stream         := True
    time_First_Stream  := durationCycles
  }

  // Safely count samples and finish the transaction when pushing into the FIFO.
  // This keeps the FSM logic perfectly synced with the AXI clock domain.
  when(cdcFifo.io.push.fire) {
    samplesSent := samplesSent + 1
    when(samplesSent === sampleLength - 1) {
      busy      := False
      done      := True
      time_Done := durationCycles
    }
  }

  // ---------------------------------------------------------------------
  // 5. Slow Domain (Stream): Output and Starvation Detection
  // ---------------------------------------------------------------------
  val dropToggleStreamWire = Bool() // Raw wire to cross the clock boundary

  val streamArea = new ClockingArea(streamClockDomain) {
    // Route the safely crossed payload to the output
    io.dataOut << cdcFifo.io.pop

    // Safely cross the 'busy' flag into the slow domain to enable counting
    val busyCC = BufferCC(busy, init = False)
    
    val outValidPrev = RegNext(io.dataOut.valid) init(False)
    val dropToggleStream = RegInit(False)
    
    // Toggle the flip-flop whenever a starvation event (TValid drop) occurs
    when(busyCC && outValidPrev && !io.dataOut.valid) {
      dropToggleStream := !dropToggleStream 
    }
    
    dropToggleStreamWire := dropToggleStream
  }

  // ---------------------------------------------------------------------
  // 6. Fast Domain (AXI): Receiving Starvation Events Safely
  // ---------------------------------------------------------------------
  // Synchronize the toggle signal back into the fast AXI clock domain
  val dropToggleCC = BufferCC(dropToggleStreamWire, init = False)
  
  val dropToggleCCPrev = RegNext(dropToggleCC) init(False)

  // Increment the telemetry counter whenever the synchronized toggle state changes
  when(dropToggleCC =/= dropToggleCCPrev) {
    validDropCount := validDropCount + 1
  }
private def tagLibraryChildren(root: Component, tag: String): Unit = {
  root.children.foreach { child =>
    val currentName = Option(child.definitionName).getOrElse(child.getClass.getSimpleName)
    val isClockSync = currentName.startsWith("BufferCC") || currentName.startsWith("CC_")
    if (!isClockSync && !currentName.contains(tag)) {
      child.setDefinitionName(s"${currentName}_$tag")
    }
    if (!isClockSync) tagLibraryChildren(child, tag)
  }
}
  tagLibraryChildren(this, "DdrToStream")
  // Spec Renaming for Vivado compatibility
  Axi4SpecRenamer(io.axi)
  AxiLite4SpecRenamer(io.axiLite)
}

object GenDdrToStream extends App {
  SpinalConfig(
    targetDirectory = "hw/gen_vhdl",
    defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
  ).generateVhdl(new DdrToStreamPynq(sampleWidth = 256, axiDataWidth = 128, axiAddressWidth = 32))
}