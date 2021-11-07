import chisel3._
import chisel3.iotesters.PeekPokeTester

class ProgramMemoryTester(dut: ProgramMemory) extends PeekPokeTester(dut) {

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 0)
  step(5)

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 1)
  step(5)

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 10)
  step(5)

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 32)
  step(5)

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 6969)
  step(5)

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 42069)
  step(5)

  //Program Memory running for 5 clock cycles
  poke(dut.io.address, 65535)
  step(5)

}

object ProgramMemoryTester {
  def main(args: Array[String]): Unit = {
    println("Testing Program Counter")
    iotesters.Driver.execute(
      Array("--generate-vcd-output", "on",
        "--target-dir", "generated",
        "--top-name", "ProgramMemory"),
      () => new ProgramMemory()) {
      c => new ProgramMemoryTester(c)
    }
  }
}
