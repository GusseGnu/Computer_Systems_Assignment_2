import chisel3._
import chisel3.iotesters.PeekPokeTester

// Gustav s190141

class ProgramMemoryTester(dut: ProgramMemory) extends PeekPokeTester(dut) {

//Program Memory running for 5 clock cycles
poke(dut.io.address, 0)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 0)
poke(dut.io.testerWriteEnable, 0)
poke(dut.io.testerDataWrite, 0)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 1)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 1)
poke(dut.io.testerWriteEnable, 0)
poke(dut.io.testerDataWrite, 0)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 2)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 10)
poke(dut.io.testerWriteEnable, 0)
poke(dut.io.testerDataWrite, 0)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 10)
poke(dut.io.address, 63)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 255)
poke(dut.io.testerWriteEnable, 1)
poke(dut.io.testerDataWrite, 6969)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 32)
poke(dut.io.address, 1)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 65535)
poke(dut.io.testerWriteEnable, 0)
poke(dut.io.testerDataWrite, 0)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 6969)
poke(dut.io.address, 1)
poke(dut.io.testerEnable, 0)
poke(dut.io.testerAddress, 420)
poke(dut.io.testerWriteEnable, 0)
poke(dut.io.testerDataWrite, 0)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 42069)
poke(dut.io.address, 1)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 123)
poke(dut.io.testerWriteEnable, 0)
poke(dut.io.testerDataWrite, 4321)
step(5)

//Program Memory running for 5 clock cycles
poke(dut.io.address, 65535)
poke(dut.io.address, 1)
poke(dut.io.testerEnable, 1)
poke(dut.io.testerAddress, 321)
poke(dut.io.testerWriteEnable, 1)
poke(dut.io.testerDataWrite, 1337)
step(5)

}

object ProgramMemoryTester {
  def main(args: Array[String]): Unit = {
    println("Testing Program Memory")
    iotesters.Driver.execute(
      Array("--generate-vcd-output", "on",
        "--target-dir", "generated",
        "--top-name", "ProgramMemory"),
      () => new ProgramMemory()) {
      c => new ProgramMemoryTester(c)
    }
  }
}
