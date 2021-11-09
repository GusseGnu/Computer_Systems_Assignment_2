import chisel3._
import chisel3.iotesters.PeekPokeTester

// Jana s181482

class ALUTester(dut: ALU) extends PeekPokeTester(dut) {

  //ALU running for 5 clock cycles
  poke(dut.io.a, 123)
  poke(dut.io.b, 321)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 0)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 1)
  poke(dut.io.b, 2)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 1)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 3)
  poke(dut.io.b, 4)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 2)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 5)
  poke(dut.io.b, 6)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 3)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 7)
  poke(dut.io.b, 8)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 4)
  step(1)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 9)
  poke(dut.io.b, 10)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 5)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 11)
  poke(dut.io.b, 12)
  poke(dut.io.im, 13)
  poke(dut.io.sel, 6)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 13)
  poke(dut.io.b, 14)
  poke(dut.io.im, 69)
  poke(dut.io.sel, 7)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 15)
  poke(dut.io.b, 16)
  poke(dut.io.im, 420)
  poke(dut.io.sel, 8)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 17)
  poke(dut.io.b, 18)
  poke(dut.io.im, 255)
  poke(dut.io.sel, 9)
  step(5)

  //ALU running for another 5 clock cycles
  poke(dut.io.a, 19)
  poke(dut.io.b, 20)
  poke(dut.io.im, 111)
  poke(dut.io.sel, 10)
  step(5)

}

object ALUTester {
  def main(args: Array[String]): Unit = {
    println("Testing ALU")
    iotesters.Driver.execute(
      Array("--generate-vcd-output", "on",
        "--target-dir", "generated",
        "--top-name", "ALU"),
      () => new ALU()) {
      c => new ALUTester(c)
    }
  }
}
