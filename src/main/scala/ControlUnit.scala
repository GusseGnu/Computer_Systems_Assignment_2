import chisel3._
import chisel3.util._

class ControlUnit extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(16.W))
    // ProgramCounter control signals
    val jump = Output(Bool())
    val stop = Output(Bool())
    val run = Output(Bool())
    // ALU control signals
    val sel = Output(UInt(4.W))
    // RegisterFile control signals
    val aSel = Output(UInt(4.W))
    val bSel = Output(UInt(4.W))
    val writeSel = Output(UInt(4.W))
    val writeEnable = Output(Bool())
    // DataMemory control signals
    val dmWriteEnable = Output(Bool())

  })

  switch(io.opcode) {





  }

}