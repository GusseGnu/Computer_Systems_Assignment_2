import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.PeekPokeTester
import java.util

object Programs{
  val program1 = Array(
    "h64C40000".U(32.W), // LI R1, 0 // 0110 0100 1100 0100 0000 0000 0000 0000
    "h64C80000".U(32.W), // LI R2, 0 // 0110 0100 1100 1000 0000 0000 0000 0000
    "h64CC0000".U(32.W), // LI R3, 0 // 0110 0100 1100 1100 0000 0000 0000 0000
    "h64D19000".U(32.W), // LI R4, 400 //
    "h64D81400".U(32.W), // LI R6, 20
    "h64DC1300".U(32.W), // LI R7, 19
    "h64E0FF00".U(32.W), // LI R8, 255
    "h25D40030".U(32.W), // LD R5, R3
    "hA8000F10".U(32.W), // JEQ 15, R1, R0
    "hA8000F20".U(32.W), // JEQ 15, R2, R0
    "hA8000F17".U(32.W), // JEQ 15, R1, R7
    "hA8000F27".U(32.W), // JEQ 15, R2, R7
    "hA8000F50".U(32.W), // JEQ 15, R5, R0
    "hA7001100".U(32.W), // JR 17
    "h26D00000".U(32.W), // SD R0, R4
    "hA7001E00".U(32.W), // JR 30
    "h62E40130".U(32.W), // SUBI R9, R3, 1
    "h62E81430".U(32.W), // SUBI R10, R3, 20
    "h60EC0130".U(32.W), // ADDI R11, R3, 1
    "h60F01430".U(32.W), // ADDI R12, R3, 20
    "h25D40090".U(32.W), // LD R5, R9
    "hA8000F50".U(32.W), // JEQ 15, R5, R0
    "h25D400A0".U(32.W), // LD R5, R10
    "hA8000F50".U(32.W), // JEQ 15, R5, R0
    "h25D400B0".U(32.W), // LD R5, R11
    "hA8000F50".U(32.W), // JEQ 15, R5, R0
    "h25D400C0".U(32.W), // LD R5, R12
    "hA8000F50".U(32.W), // JEQ 15, R5, R0
    "h26D00080".U(32.W), // SD R8, R4
    "h60CC0130".U(32.W), // ADDI R3, R3, 1
    "h60D00140".U(32.W), // ADDI R4, R4, 1
    "h60C40110".U(32.W), // ADDI R1, R1, 1
    "hA9000816".U(32.W), // JLT 8, R1, R6
    "h64C40000".U(32.W), // LI R1, 0
    "h60C80120".U(32.W), // ADDI R2, R2, 1
    "hA9000826".U(32.W), // JLT 8, R2, R6
    "hBA000000".U(32.W)  // END
  )

  val program2 = Array(
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W)
  )
}