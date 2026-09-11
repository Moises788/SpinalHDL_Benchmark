package spinal.DDRAxi

import spinal.core._
import spinal.lib._
//import spinal.lib.bus.amba4.axilite._


class StreamLoopback(sampleWidth: Int = 256, fifoDepth: Int = 512) extends Component {
  
  //val axiLiteConfig = AxiLite4Config(addressWidth = 5, dataWidth = 32)

  val io = new Bundle {
    // Port that receives data from the Read DMA (DDR -> PL)
    val dataIn  = slave Stream(Bits(sampleWidth bits))
    
    // NEW PORT: Sends data to the Write DMA (PL -> DDR)
    val dataOut = master Stream(Bits(sampleWidth bits))
    
    // Port for the PS (Zynq) to read the status via PYNQ
    //val axiLite = slave(AxiLite4(axiLiteConfig))
  }

  //val ctrl = AxiLite4SlaveFactory(io.axiLite)

  // ---------------------------------------------------------------------
  // 1. The Elastic Buffer (FIFO)
  // ---------------------------------------------------------------------
  // An internal FPGA memory that cushions the speed difference 
  // between the DDR Read and Write operations.
  val fifo = StreamFifo(Bits(sampleWidth bits), fifoDepth)

  // ---------------------------------------------------------------------
  // 2. Counters and Throttle
  // ---------------------------------------------------------------------
  val samplesReceived = Reg(UInt(32 bits)) init(0)
  val samplesSent     = Reg(UInt(32 bits)) init(0)
  val throttleCounter = Reg(UInt(32 bits)) init(0)
  
  // Throttle Register (Simulates the "processing" delay in the PL)
  //val throttleConfig  = ctrl.createReadAndWrite(UInt(32 bits), address = 0x04) init(0)

  // ---------------------------------------------------------------------
  // 3. Input Logic (Receives from the Read IP -> Writes to the FIFO)
  // ---------------------------------------------------------------------
  val isReady = throttleCounter === 0
  
  // The IP only accepts data if the Throttle allows it AND the FIFO is not full
  io.dataIn.ready      := isReady && fifo.io.push.ready
  fifo.io.push.valid   := io.dataIn.valid && isReady
  fifo.io.push.payload := io.dataIn.payload

  when(io.dataIn.fire) {
    samplesReceived := samplesReceived + 1
    throttleCounter := 0 // Reloads the delay
  } otherwise {
    when(throttleCounter =/= 0) {
      throttleCounter := throttleCounter - 1
    }
  }

  // ---------------------------------------------------------------------
  // 4. Output Logic (Reads from the FIFO -> Sends to the Write IP)
  // ---------------------------------------------------------------------
  // The FIFO output is connected directly to the IP output
  io.dataOut << fifo.io.pop

  when(io.dataOut.fire) {
    samplesSent := samplesSent + 1
  }

  // ---------------------------------------------------------------------
  // 5. PYNQ Commands (AXI-Lite)
  // ---------------------------------------------------------------------
  //ctrl.read(samplesReceived, address = 0x00)
  //ctrl.read(samplesSent,     address = 0x0C) // New: Checks how many samples were sent!

 // val clearCmd = ctrl.isWriting(0x08)
  //when(clearCmd) {
   // samplesReceived := 0
    //samplesSent     := 0
  //}

  //AxiLite4SpecRenamer(io.axiLite)
}

// -----------------------------------------------------------------------
// VHDL Generator
// -----------------------------------------------------------------------
object GenStreamLoopbackVhdl extends App {
  SpinalConfig(
    targetDirectory = "hw/gen_vhdl",
    // Configured for Active LOW (Zynq standard / peripheral_aresetn)
    defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW) 
  ).generateVhdl(new StreamLoopback())

}