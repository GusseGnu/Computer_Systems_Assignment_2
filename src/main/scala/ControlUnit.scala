import chisel3._
import chisel3.util._

class ControlUnit extends Module {
  val io = IO(new Bundle {
    val instRead = Input(UInt(32.W))
    // ProgramCounter control signals
    var jump = Output(Bool())
    var stop = Output(Bool())
    var run = Output(Bool())
    // ALU control signals
    var sel = Output(UInt(4.W))
    var imi = Output(UInt(10.W))
    // RegisterFile control signals
    var aSel = Output(UInt(4.W))
    var bSel = Output(UInt(4.W))
    var writeSel = Output(UInt(4.W))
    var writeEnable = Output(Bool()) // b29
    // DataMemory control signals
    var dmWriteEnable = Output(Bool()) // b28

  })

  // declare variables and assign role to bit in instruction input
  val instRead = io.instRead
  val instType = instRead(31,30)
  io.run = instRead(29)
  io.stop = instRead(28)
  io.sel = instRead(27,24)
  io.writeEnable = instRead(23)
  io.dmWriteEnable = instRead(22)
  io.writeSel = instRead(21,18)

  /* Instruction input format:
  R: {00 RS}{sel_}{wW wS}{el 00}{0000}{0000}{aSel}{bSel}
  I: {01 RS}{sel_}{wW wS}{el im i___ ____}{aSel}{bSel}
  J: {10 RS}{sel_}{wW wS}{el im i___ ____}{aSel}{bSel}
  */

  switch(instRead(31,30)) {
    is("b00".U){
      io.aSel = instRead(7,4)
      io.bSel = instRead(3,0)
    }
    is("b01".U){
      io.imi = instRead(17,8)
      io.aSel = instRead(7,4)
      io.bSel = instRead(3,0)
    }
    is("b10".U){
      io.imi = instRead(17,8)
      io.aSel = instRead(7,4)
      io.bSel = instRead(3,0)
      io.jump = 1.B
    }
  }

}