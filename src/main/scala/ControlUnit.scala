import chisel3._
import chisel3.util._

// Aleksandar s194066

class ControlUnit extends Module {
  val io = IO(new Bundle {
    val instRead = Input(UInt(32.W))
    // ProgramCounter control signals
    val jump = Output(Bool())
    val stop = Output(Bool())
    val run = Output(Bool())
    // ALU control signals
    val sel = Output(UInt(4.W))
    val imi = Output(UInt(10.W))
    // RegisterFile control signals
    val aSel = Output(UInt(4.W))
    val bSel = Output(UInt(4.W))
    val writeSel = Output(UInt(4.W))
    val writeEnable = Output(Bool()) // b29
    // DataMemory control signals
    val dmWriteEnable = Output(Bool()) // b28

  })

  // declare valiables and assign role to bit in instruction input

  val instRead = io.instRead
  var jump = io.jump
  var stop = io.stop
  var run = io.run
  var sel = io.sel
  var imi = io.imi
  var aSel = io.aSel
  var bSel = io.bSel
  var writeSel = io.writeSel
  var writeEnable = io.writeEnable
  var dmWriteEnable = io.dmWriteEnable

  var instType = instRead(31, 30)
  run := instRead(29)
  stop := instRead(28)
  sel := instRead(27, 24)
  writeEnable := instRead(23)
  dmWriteEnable := instRead(22)
  writeSel := instRead(21, 18)

  aSel := instRead(7, 4)
  bSel := instRead(3, 0)
  imi := 1.U
  jump := 0.B

  /* Instruction input format:
  R: {00 RS}{sel_}{wW wS}{el 00}{0000}{0000}{aSel}{bSel}
  I: {01 RS}{sel_}{wW wS}{el im i___ ____}{aSel}{bSel}
  J: {10 RS}{sel_}{wW wS}{el im i___ ____}{aSel}{bSel}
  */

  switch(instType) {
    is("b01".U){
      imi := instRead(17, 8)
    }
    is("b10".U){
      imi := instRead(17, 8)
      //jump := 1.B
    }
  }

}