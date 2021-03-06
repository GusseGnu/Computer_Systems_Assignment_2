import chisel3._

// Jana s181482

class ProgramCounter extends Module {
  val io = IO(new Bundle {
    val jump = Input(Bool())
    //val comp = Input(Bool())
    val run = Input(Bool())
    val stop = Input(Bool())
    val programCounterJump = Input(UInt(16.W))
    val programCounter = Output(UInt(16.W))
  })

  val addressCounterReg = RegInit(0.U(16.W))
  val jump = io.jump
  val W1 = Wire(UInt(16.W))
  val W2 = Wire(UInt(16.W))
  val W3 = Wire(Bool())
  val W4 = Wire(UInt(16.W))

  // The wires have been implemented in accordance with the truth table
  // and the programCounter-diagram from the assignment text
  W1 := addressCounterReg + 1.U(16.W)
  W2 := Mux(jump, io.programCounterJump, W1)
  W3 := (io.stop || !io.run)
  W4 := Mux(W3, addressCounterReg, W2)
  addressCounterReg := W4
  io.programCounter := addressCounterReg
}