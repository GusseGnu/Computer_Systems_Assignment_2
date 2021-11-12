import chisel3._
import chisel3.util._

// Aleksandar s194066

class CPUTop extends Module {
  val io = IO(new Bundle {
    val done = Output(Bool ())
    val run = Input(Bool ())
    //This signals are used by the tester for loading and dumping the memory content, do not touch
    val testerDataMemEnable = Input(Bool ())
    val testerDataMemAddress = Input(UInt (16.W))
    val testerDataMemDataRead = Output(UInt (32.W))
    val testerDataMemWriteEnable = Input(Bool ())
    val testerDataMemDataWrite = Input(UInt (32.W))
    //This signals are used by the tester for loading and dumping the memory content, do not touch
    val testerProgMemEnable = Input(Bool ())
    val testerProgMemAddress = Input(UInt (16.W))
    val testerProgMemDataRead = Output(UInt (32.W))
    val testerProgMemWriteEnable = Input(Bool ())
    val testerProgMemDataWrite = Input(UInt (32.W))
  })

  //Creating components
  val programCounter = Module(new ProgramCounter())
  val dataMemory = Module(new DataMemory())
  val programMemory = Module(new ProgramMemory())
  val registerFile = Module(new RegisterFile())
  val controlUnit = Module(new ControlUnit())
  val alu = Module(new ALU())

  //Connecting the modules
  programCounter.io.run := io.run
  programMemory.io.address := programCounter.io.programCounter

  ////////////////////////////////////////////
  programCounter.io.jump := controlUnit.io.jump
  programCounter.io.comp := alu.io.comp
  programCounter.io.stop := controlUnit.io.stop
  programCounter.io.programCounterJump := alu.io.res(15,0)

  controlUnit.io.instRead := programMemory.io.instructionRead

  registerFile.io.aSel := controlUnit.io.aSel
  registerFile.io.bSel := controlUnit.io.bSel
  registerFile.io.writeSel := controlUnit.io.writeSel
  registerFile.io.writeEnable := controlUnit.io.writeEnable
  registerFile.io.writeData := dataMemory.io.dataRead

  alu.io.a := registerFile.io.a
  alu.io.b := registerFile.io.b
  alu.io.sel := controlUnit.io.sel
  alu.io.im := controlUnit.io.imi

  dataMemory.io.dataWrite := alu.io.res
  dataMemory.io.writeEnable := controlUnit.io.dmWriteEnable
  dataMemory.io.address := programCounter.io.programCounter
  ////////////////////////////////////////////

  //This signals are used by the tester for loading the program to the program memory, do not touch
  programMemory.io.testerAddress := io.testerProgMemAddress
  io.testerProgMemDataRead := programMemory.io.testerDataRead
  programMemory.io.testerDataWrite := io.testerProgMemDataWrite
  programMemory.io.testerEnable := io.testerProgMemEnable
  programMemory.io.testerWriteEnable := io.testerProgMemWriteEnable
  //This signals are used by the tester for loading and dumping the data memory content, do not touch
  dataMemory.io.testerAddress := io.testerDataMemAddress
  io.testerDataMemDataRead := dataMemory.io.testerDataRead
  dataMemory.io.testerDataWrite := io.testerDataMemDataWrite
  dataMemory.io.testerEnable := io.testerDataMemEnable
  dataMemory.io.testerWriteEnable := io.testerDataMemWriteEnable

  io.done := 0.U
  when (alu.io.res === 65535.U) {
    io.done := 1.B
  }
}