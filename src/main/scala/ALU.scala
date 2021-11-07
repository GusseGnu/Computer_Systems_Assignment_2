import chisel3._
import chisel3.util._

class ALU extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val sel = Input(UInt(16.W))
    val res = Output(UInt(16.W))
    val comp = Output(UInt(1.W))
  })

  // initialise variable names
  val a = io.a
  val b = io.b
  val sel = io.sel
  var res = io.res
  var comp = io.comp

  // Default value for result
  res := 0.U
  comp = 1.U

  // The ALU selection
  switch(sel){ // Op-code
    // Arithmetic
    is("b0000".U){res = a + b} // ADDI - Immediate Add
    is("b0001".U){res = a + b} // ADD - Addition
    is("b0010".U){res = a - b} // SUBI - Immediate Sub
    is("b0011".U){res = a * b} // MULT - Multiplication

    // Data transfer
    is("b0100".U){res = a} // LI - Load immediate
    is("b0101".U){res = a} // LD - Load data
    is("b0110".U){res = a} // SD - Store data

    // Branches
    is("b0111".U){res = a; comp = 1.U} // JR - Jump
    is("b1000".U){res = a; if (a == b) {comp = 1.U}} // JEQ - Jump if equal
    is("b1001".U){res = a; if (a < b == 1.B) {comp = 1.U}} // JLT - Jump if less than
    is("b1010".U){res = 65535.U; comp = 1.U} // END - End execution

    
    //    // Logical
    //    is("b0100".U){res = a | b} // OR - Bitwise OR
    //    is("b0101".U){res = a & b} // AND - Bitwise AND
    //    is("b0110".U){res = !a} // NOT - Bitwise NOT

    // Branches
    //    is("b1101".U){res = } // JGT - Jump if greater than
    //    is("b1110".U){res = } // NOP - No operation

  }

  // https://github.com/schoeberl/chisel-examples/blob/master/src/main/scala/simple/Alu.scala

  // https://backend.orbit.dtu.dk/ws/portalfiles/portal/200376461/chisel_book.pdf (s. 29-36 + s. 105-113)

}