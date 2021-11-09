;buildInfoPackage: chisel3, version: 3.3.2, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit CPUTop : 
  module ProgramCounter : 
    input clock : Clock
    input reset : Reset
    output io : {flip jump : UInt<1>, flip comp : UInt<1>, flip run : UInt<1>, flip stop : UInt<1>, flip programCounterJump : UInt<16>, programCounter : UInt<16>}
    
    reg addressCounterReg : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[ProgramCounter.scala 15:34]
    node jump = or(io.jump, io.comp) @[ProgramCounter.scala 16:23]
    wire W1 : UInt<16> @[ProgramCounter.scala 18:16]
    node _T = add(addressCounterReg, UInt<16>("h01")) @[ProgramCounter.scala 19:27]
    node _T_1 = tail(_T, 1) @[ProgramCounter.scala 19:27]
    W1 <= _T_1 @[ProgramCounter.scala 19:6]
    wire W2 : UInt<16> @[ProgramCounter.scala 20:16]
    node _T_2 = mux(jump, io.programCounterJump, W1) @[ProgramCounter.scala 21:12]
    W2 <= _T_2 @[ProgramCounter.scala 21:6]
    wire W3 : UInt<1> @[ProgramCounter.scala 22:16]
    node _T_3 = eq(io.run, UInt<1>("h00")) @[ProgramCounter.scala 23:21]
    node _T_4 = or(io.stop, _T_3) @[ProgramCounter.scala 23:18]
    W3 <= _T_4 @[ProgramCounter.scala 23:6]
    wire W4 : UInt<16> @[ProgramCounter.scala 24:16]
    node _T_5 = mux(W3, addressCounterReg, W2) @[ProgramCounter.scala 25:12]
    W4 <= _T_5 @[ProgramCounter.scala 25:6]
    addressCounterReg <= W4 @[ProgramCounter.scala 27:21]
    io.programCounter <= addressCounterReg @[ProgramCounter.scala 28:21]
    
  module DataMemory : 
    input clock : Clock
    input reset : Reset
    output io : {flip address : UInt<16>, flip writeEnable : UInt<1>, flip dataWrite : UInt<32>, dataRead : UInt<32>, flip testerEnable : UInt<1>, flip testerAddress : UInt<16>, testerDataRead : UInt<32>, flip testerWriteEnable : UInt<1>, flip testerDataWrite : UInt<32>}
    
    cmem memory : UInt<32>[65536] @[DataMemory.scala 18:20]
    when io.testerEnable : @[DataMemory.scala 20:24]
      read mport _T = memory[io.testerAddress], clock @[DataMemory.scala 22:37]
      io.testerDataRead <= _T @[DataMemory.scala 22:23]
      io.dataRead <= UInt<32>("h00") @[DataMemory.scala 23:17]
      when io.testerWriteEnable : @[DataMemory.scala 24:32]
        write mport _T_1 = memory[io.testerAddress], clock
        _T_1 <= io.testerDataWrite
        io.testerDataRead <= io.testerDataWrite @[DataMemory.scala 26:25]
        skip @[DataMemory.scala 24:32]
      skip @[DataMemory.scala 20:24]
    else : @[DataMemory.scala 28:16]
      read mport _T_2 = memory[io.address], clock @[DataMemory.scala 30:31]
      io.dataRead <= _T_2 @[DataMemory.scala 30:17]
      io.testerDataRead <= UInt<32>("h00") @[DataMemory.scala 31:23]
      when io.writeEnable : @[DataMemory.scala 32:26]
        write mport _T_3 = memory[io.address], clock
        _T_3 <= io.dataWrite
        io.dataRead <= io.dataWrite @[DataMemory.scala 34:19]
        skip @[DataMemory.scala 32:26]
      skip @[DataMemory.scala 28:16]
    
  module ProgramMemory : 
    input clock : Clock
    input reset : Reset
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
    
  module RegisterFile : 
    input clock : Clock
    input reset : Reset
    output io : {flip aSel : UInt<4>, flip bSel : UInt<4>, flip writeData : UInt<32>, flip writeSel : UInt<4>, flip writeEnable : UInt<1>, a : UInt<32>, b : UInt<32>}
    
    reg registers : UInt<32>[16], clock @[RegisterFile.scala 27:22]
    registers[0] <= UInt<1>("h00") @[RegisterFile.scala 28:16]
    when io.writeEnable : @[RegisterFile.scala 31:22]
      node _T = gt(io.writeSel, UInt<1>("h00")) @[RegisterFile.scala 32:20]
      when _T : @[RegisterFile.scala 32:27]
        registers[io.writeSel] <= io.writeData @[RegisterFile.scala 33:27]
        skip @[RegisterFile.scala 32:27]
      skip @[RegisterFile.scala 31:22]
    io.a <= registers[io.aSel] @[RegisterFile.scala 38:5]
    io.b <= registers[io.bSel] @[RegisterFile.scala 39:5]
    
  module ControlUnit : 
    input clock : Clock
    input reset : Reset
    output io : {flip instRead : UInt<32>, jump : UInt<1>, stop : UInt<1>, run : UInt<1>, sel : UInt<4>, imi : UInt<10>, aSel : UInt<4>, bSel : UInt<4>, writeSel : UInt<4>, writeEnable : UInt<1>, dmWriteEnable : UInt<1>}
    
    node instType = bits(io.instRead, 31, 30) @[ControlUnit.scala 40:26]
    node _T = bits(io.instRead, 29, 29) @[ControlUnit.scala 41:18]
    io.run <= _T @[ControlUnit.scala 41:7]
    node _T_1 = bits(io.instRead, 28, 28) @[ControlUnit.scala 42:19]
    io.stop <= _T_1 @[ControlUnit.scala 42:8]
    node _T_2 = bits(io.instRead, 27, 24) @[ControlUnit.scala 43:18]
    io.sel <= _T_2 @[ControlUnit.scala 43:7]
    node _T_3 = bits(io.instRead, 23, 23) @[ControlUnit.scala 44:26]
    io.writeEnable <= _T_3 @[ControlUnit.scala 44:15]
    node _T_4 = bits(io.instRead, 22, 22) @[ControlUnit.scala 45:28]
    io.dmWriteEnable <= _T_4 @[ControlUnit.scala 45:17]
    node _T_5 = bits(io.instRead, 21, 18) @[ControlUnit.scala 46:23]
    io.writeSel <= _T_5 @[ControlUnit.scala 46:12]
    node _T_6 = bits(io.instRead, 7, 4) @[ControlUnit.scala 48:19]
    io.aSel <= _T_6 @[ControlUnit.scala 48:8]
    node _T_7 = bits(io.instRead, 3, 0) @[ControlUnit.scala 49:19]
    io.bSel <= _T_7 @[ControlUnit.scala 49:8]
    io.imi <= UInt<1>("h01") @[ControlUnit.scala 50:7]
    io.jump <= UInt<1>("h00") @[ControlUnit.scala 51:8]
    node _T_8 = eq(UInt<1>("h01"), instType) @[Conditional.scala 37:30]
    when _T_8 : @[Conditional.scala 40:58]
      node _T_9 = bits(io.instRead, 17, 8) @[ControlUnit.scala 61:22]
      io.imi <= _T_9 @[ControlUnit.scala 61:11]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_10 = eq(UInt<2>("h02"), instType) @[Conditional.scala 37:30]
      when _T_10 : @[Conditional.scala 39:67]
        node _T_11 = bits(io.instRead, 17, 8) @[ControlUnit.scala 64:22]
        io.imi <= _T_11 @[ControlUnit.scala 64:11]
        io.jump <= UInt<1>("h01") @[ControlUnit.scala 65:12]
        skip @[Conditional.scala 39:67]
    
  module ALU : 
    input clock : Clock
    input reset : Reset
    output io : {flip a : UInt<32>, flip b : UInt<32>, flip im : UInt<16>, flip sel : UInt<4>, res : UInt<32>, comp : UInt<1>}
    
    io.res <= UInt<1>("h00") @[ALU.scala 25:7]
    io.comp <= UInt<1>("h00") @[ALU.scala 26:8]
    node _T = eq(UInt<1>("h00"), io.sel) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      node _T_1 = add(io.a, io.im) @[ALU.scala 32:16]
      node _T_2 = tail(_T_1, 1) @[ALU.scala 32:16]
      io.res <= _T_2 @[ALU.scala 32:11]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_3 = eq(UInt<1>("h01"), io.sel) @[Conditional.scala 37:30]
      when _T_3 : @[Conditional.scala 39:67]
        node _T_4 = add(io.a, io.b) @[ALU.scala 35:16]
        node _T_5 = tail(_T_4, 1) @[ALU.scala 35:16]
        io.res <= _T_5 @[ALU.scala 35:11]
        skip @[Conditional.scala 39:67]
      else : @[Conditional.scala 39:67]
        node _T_6 = eq(UInt<2>("h02"), io.sel) @[Conditional.scala 37:30]
        when _T_6 : @[Conditional.scala 39:67]
          node _T_7 = sub(io.a, io.im) @[ALU.scala 38:16]
          node _T_8 = tail(_T_7, 1) @[ALU.scala 38:16]
          io.res <= _T_8 @[ALU.scala 38:11]
          skip @[Conditional.scala 39:67]
        else : @[Conditional.scala 39:67]
          node _T_9 = eq(UInt<2>("h03"), io.sel) @[Conditional.scala 37:30]
          when _T_9 : @[Conditional.scala 39:67]
            node _T_10 = mul(io.a, io.b) @[ALU.scala 41:16]
            io.res <= _T_10 @[ALU.scala 41:11]
            skip @[Conditional.scala 39:67]
          else : @[Conditional.scala 39:67]
            node _T_11 = eq(UInt<3>("h04"), io.sel) @[Conditional.scala 37:30]
            when _T_11 : @[Conditional.scala 39:67]
              io.res <= io.a @[ALU.scala 46:11]
              skip @[Conditional.scala 39:67]
            else : @[Conditional.scala 39:67]
              node _T_12 = eq(UInt<3>("h05"), io.sel) @[Conditional.scala 37:30]
              when _T_12 : @[Conditional.scala 39:67]
                io.res <= io.a @[ALU.scala 49:11]
                skip @[Conditional.scala 39:67]
              else : @[Conditional.scala 39:67]
                node _T_13 = eq(UInt<3>("h06"), io.sel) @[Conditional.scala 37:30]
                when _T_13 : @[Conditional.scala 39:67]
                  io.res <= io.a @[ALU.scala 52:11]
                  skip @[Conditional.scala 39:67]
                else : @[Conditional.scala 39:67]
                  node _T_14 = eq(UInt<3>("h07"), io.sel) @[Conditional.scala 37:30]
                  when _T_14 : @[Conditional.scala 39:67]
                    io.res <= io.im @[ALU.scala 57:11]
                    io.comp <= UInt<1>("h01") @[ALU.scala 58:12]
                    skip @[Conditional.scala 39:67]
                  else : @[Conditional.scala 39:67]
                    node _T_15 = eq(UInt<4>("h08"), io.sel) @[Conditional.scala 37:30]
                    when _T_15 : @[Conditional.scala 39:67]
                      io.res <= io.a @[ALU.scala 61:11]
                      node _T_16 = eq(io.a, io.b) @[ALU.scala 62:14]
                      when _T_16 : @[ALU.scala 62:21]
                        io.comp <= UInt<1>("h01") @[ALU.scala 63:14]
                        skip @[ALU.scala 62:21]
                      skip @[Conditional.scala 39:67]
                    else : @[Conditional.scala 39:67]
                      node _T_17 = eq(UInt<4>("h09"), io.sel) @[Conditional.scala 37:30]
                      when _T_17 : @[Conditional.scala 39:67]
                        io.res <= io.a @[ALU.scala 67:11]
                        node _T_18 = lt(io.a, io.b) @[ALU.scala 67:24]
                        node _T_19 = eq(_T_18, UInt<1>("h01")) @[ALU.scala 67:28]
                        when _T_19 : @[ALU.scala 67:37]
                          io.comp <= UInt<1>("h01") @[ALU.scala 68:14]
                          skip @[ALU.scala 67:37]
                        skip @[Conditional.scala 39:67]
                      else : @[Conditional.scala 39:67]
                        node _T_20 = eq(UInt<4>("h0a"), io.sel) @[Conditional.scala 37:30]
                        when _T_20 : @[Conditional.scala 39:67]
                          io.res <= UInt<16>("h0ffff") @[ALU.scala 72:12]
                          io.comp <= UInt<1>("h01") @[ALU.scala 73:13]
                          skip @[Conditional.scala 39:67]
    
  module CPUTop : 
    input clock : Clock
    input reset : UInt<1>
    output io : {done : UInt<1>, flip run : UInt<1>, flip testerDataMemEnable : UInt<1>, flip testerDataMemAddress : UInt<16>, testerDataMemDataRead : UInt<32>, flip testerDataMemWriteEnable : UInt<1>, flip testerDataMemDataWrite : UInt<32>, flip testerProgMemEnable : UInt<1>, flip testerProgMemAddress : UInt<16>, testerProgMemDataRead : UInt<32>, flip testerProgMemWriteEnable : UInt<1>, flip testerProgMemDataWrite : UInt<32>}
    
    inst programCounter of ProgramCounter @[CPUTop.scala 25:30]
    programCounter.clock <= clock
    programCounter.reset <= reset
    inst dataMemory of DataMemory @[CPUTop.scala 26:26]
    dataMemory.clock <= clock
    dataMemory.reset <= reset
    inst programMemory of ProgramMemory @[CPUTop.scala 27:29]
    programMemory.clock <= clock
    programMemory.reset <= reset
    inst registerFile of RegisterFile @[CPUTop.scala 28:28]
    registerFile.clock <= clock
    registerFile.reset <= reset
    inst controlUnit of ControlUnit @[CPUTop.scala 29:27]
    controlUnit.clock <= clock
    controlUnit.reset <= reset
    inst alu of ALU @[CPUTop.scala 30:19]
    alu.clock <= clock
    alu.reset <= reset
    programCounter.io.run <= io.run @[CPUTop.scala 33:25]
    programMemory.io.address <= programCounter.io.programCounter @[CPUTop.scala 34:28]
    programCounter.io.jump <= controlUnit.io.jump @[CPUTop.scala 37:26]
    programCounter.io.comp <= alu.io.comp @[CPUTop.scala 38:26]
    programCounter.io.stop <= controlUnit.io.stop @[CPUTop.scala 39:26]
    node _T = bits(alu.io.res, 31, 16) @[CPUTop.scala 40:53]
    programCounter.io.programCounterJump <= _T @[CPUTop.scala 40:40]
    controlUnit.io.instRead <= programMemory.io.instructionRead @[CPUTop.scala 42:27]
    registerFile.io.aSel <= controlUnit.io.aSel @[CPUTop.scala 44:24]
    registerFile.io.bSel <= controlUnit.io.bSel @[CPUTop.scala 45:24]
    registerFile.io.writeSel <= controlUnit.io.writeSel @[CPUTop.scala 46:28]
    registerFile.io.writeEnable <= controlUnit.io.writeEnable @[CPUTop.scala 47:31]
    registerFile.io.writeData <= dataMemory.io.dataRead @[CPUTop.scala 48:29]
    alu.io.a <= registerFile.io.a @[CPUTop.scala 50:12]
    alu.io.b <= registerFile.io.b @[CPUTop.scala 51:12]
    alu.io.sel <= controlUnit.io.sel @[CPUTop.scala 52:14]
    alu.io.im <= controlUnit.io.imi @[CPUTop.scala 53:13]
    dataMemory.io.dataWrite <= alu.io.res @[CPUTop.scala 55:27]
    dataMemory.io.writeEnable <= controlUnit.io.dmWriteEnable @[CPUTop.scala 56:29]
    dataMemory.io.address <= programCounter.io.programCounter @[CPUTop.scala 57:25]
    programMemory.io.testerAddress <= io.testerProgMemAddress @[CPUTop.scala 61:34]
    io.testerProgMemDataRead <= programMemory.io.testerDataRead @[CPUTop.scala 62:28]
    programMemory.io.testerDataWrite <= io.testerProgMemDataWrite @[CPUTop.scala 63:36]
    programMemory.io.testerEnable <= io.testerProgMemEnable @[CPUTop.scala 64:33]
    programMemory.io.testerWriteEnable <= io.testerProgMemWriteEnable @[CPUTop.scala 65:38]
    dataMemory.io.testerAddress <= io.testerDataMemAddress @[CPUTop.scala 67:31]
    io.testerDataMemDataRead <= dataMemory.io.testerDataRead @[CPUTop.scala 68:28]
    dataMemory.io.testerDataWrite <= io.testerDataMemDataWrite @[CPUTop.scala 69:33]
    dataMemory.io.testerEnable <= io.testerDataMemEnable @[CPUTop.scala 70:30]
    dataMemory.io.testerWriteEnable <= io.testerDataMemWriteEnable @[CPUTop.scala 71:35]
    io.done <= UInt<1>("h00") @[CPUTop.scala 73:11]
    node _T_1 = eq(alu.io.res, UInt<16>("h0ffff")) @[CPUTop.scala 74:20]
    when _T_1 : @[CPUTop.scala 74:33]
      io.done <= UInt<1>("h01") @[CPUTop.scala 75:13]
      skip @[CPUTop.scala 74:33]
    
