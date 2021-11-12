import chisel3._
import chisel3.util._

// Jana s181482 & Gustav s190141

class ALU extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val im = Input(UInt(16.W))
    val sel = Input(UInt(4.W))
    val res = Output(UInt(32.W))
    val comp = Output(Bool())
  })

  // initialise variable names
  val a = io.a
  val b = io.b
  val im = io.im
  val sel = io.sel
  var res = io.res
  var comp = io.comp

  // Default value for result
  res := 0.U
  comp := 0.B

  // The ALU selection
  switch(sel) { // Op-code
    // Arithmetic
    is("b0000".U) {
      res := a + im
    } // ADDI - Immediate Add
    is("b0001".U) {
      res := a + b
    } // ADD - Addition
    is("b0010".U) {
      res := a - im
    } //SUBI - Immediate Sub
    is("b0011".U){
      res := a * b
    } // MULT - Multiplication

    // Data transfer
    is("b0100".U) {
      res := im
    } // LI - Load immediate
    is("b0101".U) {
      res := a
    } // LD - Load data
    is("b0110".U) {
      res := a
    } // SD - Store data

    // Branches
    is("b0111".U) {
      res := im
      comp := 1.B
    } // JR - Jump
    is("b1000".U) {
      res := im
      when(a === b) {
        comp := 1.B
      }
    } // JEQ - Jump if equal
    is("b1001".U) {
      res := im; when(a < b === 1.B) {
        comp := 1.B
      }
    } // JLT - Jump if less than
     is("b1010".U){
       res := 65535.U
       comp := 1.B
     } // END - End execution. Set to max value for 16 bit


    //    // Logical
    //    is("b0100".U){res = a | b} // OR - Bitwise OR
    //    is("b0101".U){res = a & b} // AND - Bitwise AND
    //    is("b0110".U){res = !a} // NOT - Bitwise NOT

    // Branches
    //    is("b1101".U){res = } // JGT - Jump if greater than
    //    is("b1110".U){res = } // NOP - No operation

  }
}