import chisel3._
import chisel3.util._

// Gustav s190141

class RegisterFile extends Module {
  val io = IO(new Bundle {
    val aSel = Input(UInt(4.W))
    val bSel = Input(UInt(4.W))
    val writeData = Input(UInt(32.W))
    val writeSel = Input(UInt(4.W))
    val writeEnable = Input(Bool())
    val a = Output(UInt(32.W))
    val b = Output(UInt(32.W))
  })

  // initialise variable names
  val aSel = io.aSel
  val bSel = io.bSel
  val writeData = io.writeData
  val writeSel = io.writeSel
  val writeEnable = io.writeEnable
  val a = io.a
  val b = io.b

  // declare registers (16 of them)
  val registers = Reg(Vec(16, UInt(32.W)))
  registers(0) := 0.U

  // when writeEnable is high and the selected register is not 0, write data to register
  when (writeEnable) {
    when (writeSel > 0.U) {
      registers(writeSel) := writeData
    }
  }

  // set the output to be what was selected
  a := registers(aSel)
  b := registers(bSel)

  // https://therestlessengineer.com/processor-episode-3/
}