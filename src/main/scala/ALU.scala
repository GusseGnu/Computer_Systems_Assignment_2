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
    is("b0000".U) { // ADDI - Immediate Add
      res := a + im
    }
    is("b0001".U) { // ADD - Addition
      res := a + b
    }
    is("b0010".U) { //SUBI - Immediate Sub
      res := a - im
    }
    is("b0011".U){ // MULT - Multiplication
      res := a * b
    }

    // Data transfer
    is("b0100".U) { // LI - Load immediate
      res := im
    }
    is("b0101".U) { // LD - Load data
      res := a
    }
    is("b0110".U) { // SD - Store data
      res := a
    }

    // Branches
    is("b0111".U) { // JR - Jump
      res := im
      comp := 1.B
    }
    is("b1000".U) { // JEQ - Jump if equal
      res := im
      when(a === b) {
        comp := 1.B
      }
    }
    is("b1001".U) { // JLT - Jump if less than
      res := im; when(a < b === 1.B) {
        comp := 1.B
      }
    }
     is("b1010".U){ // END - End execution. Set to max value for 16 bit
       res := 65535.U
       comp := 1.B
     }

  }
}