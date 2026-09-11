package spinal.DDRAxi

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axilite._

/** Inverse IP: Dual-Clock Reads from PL (Slow Clock) -> CDC FIFO -> Gearbox -> Writes to DDR (Fast Clock) */
class StreamToDdrPynq(
    sampleWidth: Int = 256,
    axiDataWidth: Int = 128,
    axiAddressWidth: Int = 32,
    fifoDepth: Int = 1024 
) extends Component {

  require(isPow2(axiDataWidth / 8), "axiDataWidth must be a byte-multiple power of two")
  val axiBytes    = axiDataWidth / 8
  val axiSizeCode = log2Up(axiBytes) 

  val axiConfig = Axi4Config(
    addressWidth = axiAddressWidth, dataWidth = axiDataWidth, idWidth = 4,
    useId = true, useRegion = false, useBurst = true, useLock = false,
    useCache = true, useSize = true, useQos = false, useLen = true,
    useResp = true, useProt = true, useStrb = true // STRB is mandatory for writing
  )

  val axiLiteConfig = AxiLite4Config(addressWidth = 6, dataWidth = 32) 

  // Dual-clock top interface
  val io = new Bundle {
    val streamClk   = in Bool()
    val streamReset = in Bool()

    val axi     = master(Axi4WriteOnly(axiConfig)) 
    val axiLite = slave(AxiLite4(axiLiteConfig))
    val dataIn  = slave Stream(Bits(sampleWidth bits)) 
  }

  // Define the separate clock domain for the input stream (PL Side)
  val streamClockDomain = ClockDomain(
    clock = io.streamClk,
    reset = io.streamReset,
    config = ClockDomainConfig(resetActiveLevel = LOW)
  )

  // ---------------------------------------------------------------------
  // 1. Fast Domain (AXI): AXI-Lite Registers for PYNQ
  // ---------------------------------------------------------------------
  val ctrl = AxiLite4SlaveFactory(io.axiLite)

  val busy           = RegInit(False)
  val done           = RegInit(False)
  val error          = RegInit(False)
  val durationCycles = Reg(UInt(32 bits)) init(0)

  // Snapshot Registers for Write Performance Analysis
  val time_AW_Accept   = Reg(UInt(32 bits)) init(0)
  val time_First_WData = Reg(UInt(32 bits)) init(0)
  val time_B_Resp      = Reg(UInt(32 bits)) init(0)
  val time_Done        = Reg(UInt(32 bits)) init(0) 

  // Snapshot Flags
  val got_AW = RegInit(False)
  val got_W  = RegInit(False)
  val got_B  = RegInit(False)

  val destAddr     = ctrl.createReadAndWrite(UInt(axiAddressWidth bits), 0x08) init(0)
  val sampleLength = ctrl.createReadAndWrite(UInt(32 bits), 0x0C) init(0)

  ctrl.read(busy,           0x00, 0)
  ctrl.read(done,           0x00, 1)
  ctrl.read(error,          0x00, 2)
  ctrl.read(durationCycles, 0x04)

  // Mapping the snapshots to AXI-Lite
  ctrl.read(time_AW_Accept,   0x14)
  ctrl.read(time_First_WData, 0x18)
  ctrl.read(time_B_Resp,      0x1C)
  ctrl.read(time_Done,        0x20) 

  // Resource-Optimized Debug Counters (20-bits internally, 32-bits on bus)
  val samplesReceived = Reg(UInt(20 bits)) init(0)
  val awBeatsIssued   = Reg(UInt(20 bits)) init(0)
  val wBeatsSent      = Reg(UInt(20 bits)) init(0)
  val validDropCount  = Reg(UInt(20 bits)) init(0)

  ctrl.read(samplesReceived.resized, 0x24)
  ctrl.read(awBeatsIssued.resized,   0x28)
  ctrl.read(wBeatsSent.resized,      0x2C)
  ctrl.read(validDropCount.resized,  0x30)

  val startTrigger = ctrl.isWriting(0x10)

  // ---------------------------------------------------------------------
  // 2. Fast Domain (AXI): Brain, Calculations and Timer
  // ---------------------------------------------------------------------
  val curAddress       = Reg(UInt(axiAddressWidth bits)) init(0)
  val remainingAWBeats = Reg(UInt(32 bits)) init(0)
  
  // Counters for perfect write Handshake
  val awRequests = Reg(UInt(32 bits)) init(0)
  val bResponses = Reg(UInt(32 bits)) init(0)

  when(startTrigger && !busy) {
    busy             := True
    done             := False
    error            := False
    durationCycles   := 0
    awRequests       := 0
    bResponses       := 0
    curAddress       := destAddr
    
    samplesReceived  := 0
    awBeatsIssued    := 0
    wBeatsSent       := 0
    validDropCount   := 0

    got_AW           := False
    got_W            := False
    got_B            := False
    time_AW_Accept   := 0
    time_First_WData := 0
    time_B_Resp      := 0
    time_Done        := 0
    
    val totalBits    = sampleLength * sampleWidth
    val totalBytes   = (totalBits + 7) >> 3
    remainingAWBeats := ((totalBytes + (axiBytes - 1)) >> log2Up(axiBytes)).resized
  }

  when(busy) { durationCycles := durationCycles + 1 }

  // ---------------------------------------------------------------------
  // 3. Fast Domain (AXI): Write Request Generator (AW Channel)
  // ---------------------------------------------------------------------
  val activeBurstLen = Reg(UInt(9 bits)) init(0) 
  val awValidReg     = RegInit(False)
  
  val maxBurst   = U(256, 32 bits)
  val bytesTo4K  = U(4096, 13 bits) - curAddress(11 downto 0).resize(13)
  val boundBeats = (bytesTo4K >> log2Up(axiBytes)).resize(32 bits) 
  
  def uMin(a: UInt, b: UInt): UInt = (a < b) ? a | b
  val burstLen = uMin(uMin(remainingAWBeats, maxBurst), boundBeats)

  io.axi.aw.valid         := awValidReg
  io.axi.aw.payload.addr  := curAddress
  io.axi.aw.payload.id    := 0
  io.axi.aw.payload.len   := (burstLen - 1).resize(8)
  io.axi.aw.payload.size  := axiSizeCode 
  io.axi.aw.payload.burst := B"01"
  io.axi.aw.payload.cache := B"0011"
  io.axi.aw.payload.prot  := 0

  when(busy && !error && remainingAWBeats =/= 0 && activeBurstLen === 0 && !awValidReg) {
    awValidReg := True
  }

  when(io.axi.aw.fire) {
    awValidReg       := False
    curAddress       := curAddress + (burstLen << log2Up(axiBytes)).resize(axiAddressWidth)
    remainingAWBeats := remainingAWBeats - burstLen
    activeBurstLen   := burstLen.resize(9)
    awRequests       := awRequests + 1 
    awBeatsIssued    := awBeatsIssued + burstLen.resized 
  }

  when(io.axi.aw.fire && !got_AW) {
    got_AW := True
    time_AW_Accept := durationCycles
  }

  // ---------------------------------------------------------------------
  // 4. The Bridge: Cross-Clock FIFO (StreamFifoCC)
  // ---------------------------------------------------------------------
  val cdcFifo = new StreamFifoCC(
    dataType  = Bits(sampleWidth bits),
    depth     = fifoDepth,
    pushClock = streamClockDomain,       // Slow clock
    popClock  = ClockDomain.current      // Fast clock (AXI)
  ).setDefinitionName("StreamFifoCC_StreamToDdr")

  // Map the CDC FIFO occupancy to AXI-Lite (using the pop domain occupancy signal)
  ctrl.read(cdcFifo.io.popOccupancy.resized, 0x34)

  // ---------------------------------------------------------------------
  // 5. Slow Domain (Stream): PL Feeds the FIFO
  // ---------------------------------------------------------------------
  val dropToggleStreamWire = Bool()

  val streamArea = new ClockingArea(streamClockDomain) {
    
    // Cross the 'busy' flag to the slow domain safely
    val busyCC = BufferCC(busy, init = False)

    // Gate the input stream based on the busy flag. 
    // This replaces a hard "flush" and ensures stale data isn't pushed while idle.
    cdcFifo.io.push.valid   := io.dataIn.valid && busyCC
    cdcFifo.io.push.payload := io.dataIn.payload
    io.dataIn.ready         := cdcFifo.io.push.ready && busyCC

    // Starvation Detection (TValid drop) on the PL side
    val inValidPrev = RegNext(io.dataIn.valid) init(False)
    val dropToggleStream = RegInit(False)
    
    // Toggle state when valid drops while busy
    when(busyCC && inValidPrev && !io.dataIn.valid) {
      dropToggleStream := !dropToggleStream
    }
    
    dropToggleStreamWire := dropToggleStream
  }

  // ---------------------------------------------------------------------
  // 6. Fast Domain (AXI): Gearbox, W Channel & Handshake
  // ---------------------------------------------------------------------
  
  // Safe Starvation counter crossing
  val dropToggleCC = BufferCC(dropToggleStreamWire, init = False)
  val dropToggleCCPrev = RegNext(dropToggleCC) init(False)

  when(dropToggleCC =/= dropToggleCCPrev) {
    validDropCount := validDropCount + 1
  }

  val gearbox = new BitGearbox(sampleWidth, axiDataWidth).setDefinitionName("BitGearboxWrite")
  
  // Feed the gearbox from the safe fast-side of the CDC FIFO
  cdcFifo.io.pop >> gearbox.io.input 

  io.axi.w.valid        := gearbox.io.output.valid && (activeBurstLen =/= 0) && !error
  io.axi.w.payload.data := gearbox.io.output.payload
  io.axi.w.payload.last := (activeBurstLen === 1) 
  io.axi.w.payload.strb := B(axiBytes bits, default -> True) 

  gearbox.io.output.ready := io.axi.w.ready && (activeBurstLen =/= 0) && !error

  // Count received samples accurately on the fast side as they exit the CDC FIFO.
  // This avoids a complex gray counter across domains and yields the exact same total.
  when(cdcFifo.io.pop.fire) {
    samplesReceived := samplesReceived + 1
  }

  when(io.axi.w.fire) {
    activeBurstLen := activeBurstLen - 1
    wBeatsSent     := wBeatsSent + 1 
  }

  when(io.axi.w.fire && !got_W) {
    got_W := True
    time_First_WData := durationCycles
  }

  // ---------------------------------------------------------------------
  // 7. Fast Domain (AXI): Memory Receipt (B Channel) and Conclusion
  // ---------------------------------------------------------------------
  io.axi.b.ready := True

  when(io.axi.b.fire) {
    bResponses := bResponses + 1
    when(io.axi.b.payload.resp =/= B"00") { 
      error := True
      busy  := False // Abort on error
    }
  }

  when(io.axi.b.fire && !got_B && (awRequests === bResponses + 1) && remainingAWBeats === 0) {
    got_B       := True
    time_B_Resp := durationCycles
  }

  when(busy && awRequests =/= 0 && bResponses === awRequests && remainingAWBeats === 0) {
    busy      := False
    done      := True
    time_Done := durationCycles 
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
  tagLibraryChildren(this, "StreamDDR")

  Axi4SpecRenamer(io.axi)
  AxiLite4SpecRenamer(io.axiLite)
}

object GenStreamToDdrVhdl extends App {
  SpinalConfig(
    targetDirectory = "hw/gen_vhdl",
    defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
  ).generateVhdl(new StreamToDdrPynq(sampleWidth = 256, axiDataWidth = 128, axiAddressWidth = 32, fifoDepth = 1024))
}