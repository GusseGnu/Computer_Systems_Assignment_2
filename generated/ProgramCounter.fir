;buildInfoPackage: chisel3, version: 3.3.2, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit ProgramCounter : 
  module ProgramCounter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip jump : UInt<1>, flip run : UInt<1>, flip stop : UInt<1>, flip programCounterJump : UInt<16>, programCounter : UInt<16>}
    
    reg addressCounterReg : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[ProgramCounter.scala 12:34]
    wire W1 : UInt<16> @[ProgramCounter.scala 14:16]
    node _T = add(addressCounterReg, UInt<16>("h01")) @[ProgramCounter.scala 15:27]
    node _T_1 = tail(_T, 1) @[ProgramCounter.scala 15:27]
    W1 <= _T_1 @[ProgramCounter.scala 15:6]
    wire W2 : UInt<16> @[ProgramCounter.scala 16:16]
    node _T_2 = mux(io.jump, io.programCounterJump, W1) @[ProgramCounter.scala 17:12]
    W2 <= _T_2 @[ProgramCounter.scala 17:6]
    wire W3 : UInt<1> @[ProgramCounter.scala 18:16]
    node _T_3 = eq(io.run, UInt<1>("h00")) @[ProgramCounter.scala 19:21]
    node _T_4 = or(io.stop, _T_3) @[ProgramCounter.scala 19:18]
    W3 <= _T_4 @[ProgramCounter.scala 19:6]
    wire W4 : UInt<16> @[ProgramCounter.scala 20:16]
    node _T_5 = mux(W3, addressCounterReg, W2) @[ProgramCounter.scala 21:12]
    W4 <= _T_5 @[ProgramCounter.scala 21:6]
    addressCounterReg <= W4 @[ProgramCounter.scala 36:21]
    io.programCounter <= addressCounterReg @[ProgramCounter.scala 37:21]
    
