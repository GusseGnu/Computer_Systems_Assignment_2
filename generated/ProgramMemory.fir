;buildInfoPackage: chisel3, version: 3.3.2, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit ProgramMemory : 
  module ProgramMemory : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip address : UInt<16>, instructionRead : UInt<32>, flip testerEnable : UInt<1>, flip testerAddress : UInt<16>, testerDataRead : UInt<32>, flip testerWriteEnable : UInt<1>, flip testerDataWrite : UInt<32>}
    
    cmem memory : UInt<32>[65536] @[ProgramMemory.scala 16:20]
    when io.testerEnable : @[ProgramMemory.scala 18:24]
      read mport _T = memory[io.testerAddress], clock @[ProgramMemory.scala 20:37]
      io.testerDataRead <= _T @[ProgramMemory.scala 20:23]
      io.instructionRead <= UInt<32>("h00") @[ProgramMemory.scala 21:24]
      when io.testerWriteEnable : @[ProgramMemory.scala 22:32]
        write mport _T_1 = memory[io.testerAddress], clock
        _T_1 <= io.testerDataWrite
        io.testerDataRead <= io.testerDataWrite @[ProgramMemory.scala 24:25]
        skip @[ProgramMemory.scala 22:32]
      skip @[ProgramMemory.scala 18:24]
    else : @[ProgramMemory.scala 26:16]
      read mport _T_2 = memory[io.address], clock @[ProgramMemory.scala 28:38]
      io.instructionRead <= _T_2 @[ProgramMemory.scala 28:24]
      io.testerDataRead <= UInt<32>("h00") @[ProgramMemory.scala 29:23]
      skip @[ProgramMemory.scala 26:16]
    
