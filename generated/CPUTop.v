module ProgramCounter(
  input         clock,
  input         reset,
  input         io_jump,
  input         io_run,
  input         io_stop,
  input  [15:0] io_programCounterJump,
  output [15:0] io_programCounter
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] addressCounterReg; // @[ProgramCounter.scala 15:34]
  wire [15:0] W1 = addressCounterReg + 16'h1; // @[ProgramCounter.scala 20:27]
  wire  _T_3 = ~io_run; // @[ProgramCounter.scala 24:21]
  wire  W3 = io_stop | _T_3; // @[ProgramCounter.scala 24:18]
  assign io_programCounter = addressCounterReg; // @[ProgramCounter.scala 29:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  addressCounterReg = _RAND_0[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      addressCounterReg <= 16'h0;
    end else if (!(W3)) begin
      if (io_jump) begin
        addressCounterReg <= io_programCounterJump;
      end else begin
        addressCounterReg <= W1;
      end
    end
  end
endmodule
module DataMemory(
  input         clock,
  input  [15:0] io_address,
  input         io_writeEnable,
  input  [31:0] io_dataWrite,
  output [31:0] io_dataRead,
  input         io_testerEnable,
  input  [15:0] io_testerAddress,
  output [31:0] io_testerDataRead,
  input         io_testerWriteEnable,
  input  [31:0] io_testerDataWrite
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:65535]; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_2_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_2_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_1_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_1_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_1_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_1_en; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_3_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_3_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_3_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_3_en; // @[DataMemory.scala 18:20]
  wire [31:0] _GEN_5 = io_testerWriteEnable ? io_testerDataWrite : memory__T_data; // @[DataMemory.scala 24:32]
  wire [31:0] _GEN_11 = io_writeEnable ? io_dataWrite : memory__T_2_data; // @[DataMemory.scala 32:26]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign memory__T_3_data = io_dataWrite;
  assign memory__T_3_addr = io_address;
  assign memory__T_3_mask = 1'h1;
  assign memory__T_3_en = io_testerEnable ? 1'h0 : io_writeEnable;
  assign io_dataRead = io_testerEnable ? 32'h0 : _GEN_11; // @[DataMemory.scala 23:17 DataMemory.scala 30:17 DataMemory.scala 34:19]
  assign io_testerDataRead = io_testerEnable ? _GEN_5 : 32'h0; // @[DataMemory.scala 22:23 DataMemory.scala 26:25 DataMemory.scala 31:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(memory__T_1_en & memory__T_1_mask) begin
      memory[memory__T_1_addr] <= memory__T_1_data; // @[DataMemory.scala 18:20]
    end
    if(memory__T_3_en & memory__T_3_mask) begin
      memory[memory__T_3_addr] <= memory__T_3_data; // @[DataMemory.scala 18:20]
    end
  end
endmodule
module ProgramMemory(
  input         clock,
  input  [15:0] io_address,
  output [31:0] io_instructionRead,
  input         io_testerEnable,
  input  [15:0] io_testerAddress,
  output [31:0] io_testerDataRead,
  input         io_testerWriteEnable,
  input  [31:0] io_testerDataWrite
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:65535]; // @[ProgramMemory.scala 16:20]
  wire [31:0] memory__T_data; // @[ProgramMemory.scala 16:20]
  wire [15:0] memory__T_addr; // @[ProgramMemory.scala 16:20]
  wire [31:0] memory__T_2_data; // @[ProgramMemory.scala 16:20]
  wire [15:0] memory__T_2_addr; // @[ProgramMemory.scala 16:20]
  wire [31:0] memory__T_1_data; // @[ProgramMemory.scala 16:20]
  wire [15:0] memory__T_1_addr; // @[ProgramMemory.scala 16:20]
  wire  memory__T_1_mask; // @[ProgramMemory.scala 16:20]
  wire  memory__T_1_en; // @[ProgramMemory.scala 16:20]
  wire [31:0] _GEN_5 = io_testerWriteEnable ? io_testerDataWrite : memory__T_data; // @[ProgramMemory.scala 24:32]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[ProgramMemory.scala 16:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[ProgramMemory.scala 16:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign io_instructionRead = io_testerEnable ? 32'h0 : memory__T_2_data; // @[ProgramMemory.scala 23:21 ProgramMemory.scala 30:21]
  assign io_testerDataRead = io_testerEnable ? _GEN_5 : 32'h0; // @[ProgramMemory.scala 22:23 ProgramMemory.scala 26:25 ProgramMemory.scala 31:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(memory__T_1_en & memory__T_1_mask) begin
      memory[memory__T_1_addr] <= memory__T_1_data; // @[ProgramMemory.scala 16:20]
    end
  end
endmodule
module RegisterFile(
  input         clock,
  input  [3:0]  io_aSel,
  input  [3:0]  io_bSel,
  input  [31:0] io_writeData,
  input  [3:0]  io_writeSel,
  input         io_writeEnable,
  output [31:0] io_a,
  output [31:0] io_b
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_1; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_2; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_3; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_4; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_5; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_6; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_7; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_8; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_9; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_10; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_11; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_12; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_13; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_14; // @[RegisterFile.scala 27:22]
  reg [31:0] registers_15; // @[RegisterFile.scala 27:22]
  wire  _T = io_writeSel > 4'h0; // @[RegisterFile.scala 32:20]
  wire [31:0] _GEN_49 = 4'h1 == io_aSel ? registers_1 : registers_0; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_50 = 4'h2 == io_aSel ? registers_2 : _GEN_49; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_51 = 4'h3 == io_aSel ? registers_3 : _GEN_50; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_52 = 4'h4 == io_aSel ? registers_4 : _GEN_51; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_53 = 4'h5 == io_aSel ? registers_5 : _GEN_52; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_54 = 4'h6 == io_aSel ? registers_6 : _GEN_53; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_55 = 4'h7 == io_aSel ? registers_7 : _GEN_54; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_56 = 4'h8 == io_aSel ? registers_8 : _GEN_55; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_57 = 4'h9 == io_aSel ? registers_9 : _GEN_56; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_58 = 4'ha == io_aSel ? registers_10 : _GEN_57; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_59 = 4'hb == io_aSel ? registers_11 : _GEN_58; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_60 = 4'hc == io_aSel ? registers_12 : _GEN_59; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_61 = 4'hd == io_aSel ? registers_13 : _GEN_60; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_62 = 4'he == io_aSel ? registers_14 : _GEN_61; // @[RegisterFile.scala 38:5]
  wire [31:0] _GEN_65 = 4'h1 == io_bSel ? registers_1 : registers_0; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_66 = 4'h2 == io_bSel ? registers_2 : _GEN_65; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_67 = 4'h3 == io_bSel ? registers_3 : _GEN_66; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_68 = 4'h4 == io_bSel ? registers_4 : _GEN_67; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_69 = 4'h5 == io_bSel ? registers_5 : _GEN_68; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_70 = 4'h6 == io_bSel ? registers_6 : _GEN_69; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_71 = 4'h7 == io_bSel ? registers_7 : _GEN_70; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_72 = 4'h8 == io_bSel ? registers_8 : _GEN_71; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_73 = 4'h9 == io_bSel ? registers_9 : _GEN_72; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_74 = 4'ha == io_bSel ? registers_10 : _GEN_73; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_75 = 4'hb == io_bSel ? registers_11 : _GEN_74; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_76 = 4'hc == io_bSel ? registers_12 : _GEN_75; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_77 = 4'hd == io_bSel ? registers_13 : _GEN_76; // @[RegisterFile.scala 39:5]
  wire [31:0] _GEN_78 = 4'he == io_bSel ? registers_14 : _GEN_77; // @[RegisterFile.scala 39:5]
  assign io_a = 4'hf == io_aSel ? registers_15 : _GEN_62; // @[RegisterFile.scala 38:5]
  assign io_b = 4'hf == io_bSel ? registers_15 : _GEN_78; // @[RegisterFile.scala 39:5]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h0 == io_writeSel) begin
          registers_0 <= io_writeData;
        end else begin
          registers_0 <= 32'h0;
        end
      end else begin
        registers_0 <= 32'h0;
      end
    end else begin
      registers_0 <= 32'h0;
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h1 == io_writeSel) begin
          registers_1 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h2 == io_writeSel) begin
          registers_2 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h3 == io_writeSel) begin
          registers_3 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h4 == io_writeSel) begin
          registers_4 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h5 == io_writeSel) begin
          registers_5 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h6 == io_writeSel) begin
          registers_6 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h7 == io_writeSel) begin
          registers_7 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h8 == io_writeSel) begin
          registers_8 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'h9 == io_writeSel) begin
          registers_9 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'ha == io_writeSel) begin
          registers_10 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'hb == io_writeSel) begin
          registers_11 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'hc == io_writeSel) begin
          registers_12 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'hd == io_writeSel) begin
          registers_13 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'he == io_writeSel) begin
          registers_14 <= io_writeData;
        end
      end
    end
    if (io_writeEnable) begin
      if (_T) begin
        if (4'hf == io_writeSel) begin
          registers_15 <= io_writeData;
        end
      end
    end
  end
endmodule
module ControlUnit(
  input  [31:0] io_instRead,
  output        io_stop,
  output        io_writeDataSel,
  output [3:0]  io_sel,
  output [9:0]  io_imi,
  output [3:0]  io_aSel,
  output [3:0]  io_bSel,
  output [3:0]  io_writeSel,
  output        io_writeEnable,
  output        io_dmWriteEnable
);
  assign io_stop = io_instRead[28]; // @[ControlUnit.scala 48:8]
  assign io_writeDataSel = io_instRead[29]; // @[ControlUnit.scala 47:16]
  assign io_sel = io_instRead[27:24]; // @[ControlUnit.scala 49:7]
  assign io_imi = io_instRead[17:8]; // @[ControlUnit.scala 42:7 ControlUnit.scala 53:7]
  assign io_aSel = io_instRead[7:4]; // @[ControlUnit.scala 54:8]
  assign io_bSel = io_instRead[3:0]; // @[ControlUnit.scala 55:8]
  assign io_writeSel = io_instRead[21:18]; // @[ControlUnit.scala 52:12]
  assign io_writeEnable = io_instRead[23]; // @[ControlUnit.scala 50:15]
  assign io_dmWriteEnable = io_instRead[22]; // @[ControlUnit.scala 51:17]
endmodule
module ALU(
  input  [31:0] io_a,
  input  [31:0] io_b,
  input  [15:0] io_im,
  input  [3:0]  io_sel,
  output [31:0] io_res,
  output        io_comp
);
  wire  _T = 4'h0 == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_24 = {{16'd0}, io_im}; // @[ALU.scala 32:16]
  wire [31:0] _T_2 = io_a + _GEN_24; // @[ALU.scala 32:16]
  wire  _T_3 = 4'h1 == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _T_5 = io_a + io_b; // @[ALU.scala 35:16]
  wire  _T_6 = 4'h2 == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _T_8 = io_a - _GEN_24; // @[ALU.scala 38:16]
  wire  _T_9 = 4'h3 == io_sel; // @[Conditional.scala 37:30]
  wire [63:0] _T_10 = io_a * io_b; // @[ALU.scala 41:16]
  wire  _T_11 = 4'h4 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_12 = 4'h5 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_13 = 4'h6 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_14 = 4'h7 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_15 = 4'h8 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_16 = io_a == io_b; // @[ALU.scala 62:14]
  wire  _T_17 = 4'h9 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_18 = io_a < io_b; // @[ALU.scala 67:25]
  wire  _T_20 = 4'ha == io_sel; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_2 = _T_20 ? 16'hffff : 16'h0; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_4 = _T_17 ? io_im : _GEN_2; // @[Conditional.scala 39:67]
  wire  _GEN_5 = _T_17 ? _T_18 : _T_20; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_6 = _T_15 ? io_im : _GEN_4; // @[Conditional.scala 39:67]
  wire  _GEN_7 = _T_15 ? _T_16 : _GEN_5; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_8 = _T_14 ? io_im : _GEN_6; // @[Conditional.scala 39:67]
  wire  _GEN_9 = _T_14 | _GEN_7; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_10 = _T_13 ? io_a : {{16'd0}, _GEN_8}; // @[Conditional.scala 39:67]
  wire  _GEN_11 = _T_13 ? 1'h0 : _GEN_9; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_12 = _T_12 ? io_a : _GEN_10; // @[Conditional.scala 39:67]
  wire  _GEN_13 = _T_12 ? 1'h0 : _GEN_11; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_14 = _T_11 ? {{16'd0}, io_im} : _GEN_12; // @[Conditional.scala 39:67]
  wire  _GEN_15 = _T_11 ? 1'h0 : _GEN_13; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_16 = _T_9 ? _T_10 : {{32'd0}, _GEN_14}; // @[Conditional.scala 39:67]
  wire  _GEN_17 = _T_9 ? 1'h0 : _GEN_15; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_18 = _T_6 ? {{32'd0}, _T_8} : _GEN_16; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_6 ? 1'h0 : _GEN_17; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_20 = _T_3 ? {{32'd0}, _T_5} : _GEN_18; // @[Conditional.scala 39:67]
  wire  _GEN_21 = _T_3 ? 1'h0 : _GEN_19; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_22 = _T ? {{32'd0}, _T_2} : _GEN_20; // @[Conditional.scala 40:58]
  assign io_res = _GEN_22[31:0]; // @[ALU.scala 25:7 ALU.scala 32:11 ALU.scala 35:11 ALU.scala 38:11 ALU.scala 41:11 ALU.scala 46:11 ALU.scala 49:11 ALU.scala 52:11 ALU.scala 57:11 ALU.scala 61:11 ALU.scala 67:11 ALU.scala 72:12]
  assign io_comp = _T ? 1'h0 : _GEN_21; // @[ALU.scala 26:8 ALU.scala 58:12 ALU.scala 63:14 ALU.scala 68:14 ALU.scala 73:13]
endmodule
module CPUTop(
  input         clock,
  input         reset,
  output        io_done,
  input         io_run,
  input         io_testerDataMemEnable,
  input  [15:0] io_testerDataMemAddress,
  output [31:0] io_testerDataMemDataRead,
  input         io_testerDataMemWriteEnable,
  input  [31:0] io_testerDataMemDataWrite,
  input         io_testerProgMemEnable,
  input  [15:0] io_testerProgMemAddress,
  output [31:0] io_testerProgMemDataRead,
  input         io_testerProgMemWriteEnable,
  input  [31:0] io_testerProgMemDataWrite
);
  wire  programCounter_clock; // @[CPUTop.scala 25:30]
  wire  programCounter_reset; // @[CPUTop.scala 25:30]
  wire  programCounter_io_jump; // @[CPUTop.scala 25:30]
  wire  programCounter_io_run; // @[CPUTop.scala 25:30]
  wire  programCounter_io_stop; // @[CPUTop.scala 25:30]
  wire [15:0] programCounter_io_programCounterJump; // @[CPUTop.scala 25:30]
  wire [15:0] programCounter_io_programCounter; // @[CPUTop.scala 25:30]
  wire  dataMemory_clock; // @[CPUTop.scala 26:26]
  wire [15:0] dataMemory_io_address; // @[CPUTop.scala 26:26]
  wire  dataMemory_io_writeEnable; // @[CPUTop.scala 26:26]
  wire [31:0] dataMemory_io_dataWrite; // @[CPUTop.scala 26:26]
  wire [31:0] dataMemory_io_dataRead; // @[CPUTop.scala 26:26]
  wire  dataMemory_io_testerEnable; // @[CPUTop.scala 26:26]
  wire [15:0] dataMemory_io_testerAddress; // @[CPUTop.scala 26:26]
  wire [31:0] dataMemory_io_testerDataRead; // @[CPUTop.scala 26:26]
  wire  dataMemory_io_testerWriteEnable; // @[CPUTop.scala 26:26]
  wire [31:0] dataMemory_io_testerDataWrite; // @[CPUTop.scala 26:26]
  wire  programMemory_clock; // @[CPUTop.scala 27:29]
  wire [15:0] programMemory_io_address; // @[CPUTop.scala 27:29]
  wire [31:0] programMemory_io_instructionRead; // @[CPUTop.scala 27:29]
  wire  programMemory_io_testerEnable; // @[CPUTop.scala 27:29]
  wire [15:0] programMemory_io_testerAddress; // @[CPUTop.scala 27:29]
  wire [31:0] programMemory_io_testerDataRead; // @[CPUTop.scala 27:29]
  wire  programMemory_io_testerWriteEnable; // @[CPUTop.scala 27:29]
  wire [31:0] programMemory_io_testerDataWrite; // @[CPUTop.scala 27:29]
  wire  registerFile_clock; // @[CPUTop.scala 28:28]
  wire [3:0] registerFile_io_aSel; // @[CPUTop.scala 28:28]
  wire [3:0] registerFile_io_bSel; // @[CPUTop.scala 28:28]
  wire [31:0] registerFile_io_writeData; // @[CPUTop.scala 28:28]
  wire [3:0] registerFile_io_writeSel; // @[CPUTop.scala 28:28]
  wire  registerFile_io_writeEnable; // @[CPUTop.scala 28:28]
  wire [31:0] registerFile_io_a; // @[CPUTop.scala 28:28]
  wire [31:0] registerFile_io_b; // @[CPUTop.scala 28:28]
  wire [31:0] controlUnit_io_instRead; // @[CPUTop.scala 29:27]
  wire  controlUnit_io_stop; // @[CPUTop.scala 29:27]
  wire  controlUnit_io_writeDataSel; // @[CPUTop.scala 29:27]
  wire [3:0] controlUnit_io_sel; // @[CPUTop.scala 29:27]
  wire [9:0] controlUnit_io_imi; // @[CPUTop.scala 29:27]
  wire [3:0] controlUnit_io_aSel; // @[CPUTop.scala 29:27]
  wire [3:0] controlUnit_io_bSel; // @[CPUTop.scala 29:27]
  wire [3:0] controlUnit_io_writeSel; // @[CPUTop.scala 29:27]
  wire  controlUnit_io_writeEnable; // @[CPUTop.scala 29:27]
  wire  controlUnit_io_dmWriteEnable; // @[CPUTop.scala 29:27]
  wire [31:0] alu_io_a; // @[CPUTop.scala 30:19]
  wire [31:0] alu_io_b; // @[CPUTop.scala 30:19]
  wire [15:0] alu_io_im; // @[CPUTop.scala 30:19]
  wire [3:0] alu_io_sel; // @[CPUTop.scala 30:19]
  wire [31:0] alu_io_res; // @[CPUTop.scala 30:19]
  wire  alu_io_comp; // @[CPUTop.scala 30:19]
  ProgramCounter programCounter ( // @[CPUTop.scala 25:30]
    .clock(programCounter_clock),
    .reset(programCounter_reset),
    .io_jump(programCounter_io_jump),
    .io_run(programCounter_io_run),
    .io_stop(programCounter_io_stop),
    .io_programCounterJump(programCounter_io_programCounterJump),
    .io_programCounter(programCounter_io_programCounter)
  );
  DataMemory dataMemory ( // @[CPUTop.scala 26:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_writeEnable(dataMemory_io_writeEnable),
    .io_dataWrite(dataMemory_io_dataWrite),
    .io_dataRead(dataMemory_io_dataRead),
    .io_testerEnable(dataMemory_io_testerEnable),
    .io_testerAddress(dataMemory_io_testerAddress),
    .io_testerDataRead(dataMemory_io_testerDataRead),
    .io_testerWriteEnable(dataMemory_io_testerWriteEnable),
    .io_testerDataWrite(dataMemory_io_testerDataWrite)
  );
  ProgramMemory programMemory ( // @[CPUTop.scala 27:29]
    .clock(programMemory_clock),
    .io_address(programMemory_io_address),
    .io_instructionRead(programMemory_io_instructionRead),
    .io_testerEnable(programMemory_io_testerEnable),
    .io_testerAddress(programMemory_io_testerAddress),
    .io_testerDataRead(programMemory_io_testerDataRead),
    .io_testerWriteEnable(programMemory_io_testerWriteEnable),
    .io_testerDataWrite(programMemory_io_testerDataWrite)
  );
  RegisterFile registerFile ( // @[CPUTop.scala 28:28]
    .clock(registerFile_clock),
    .io_aSel(registerFile_io_aSel),
    .io_bSel(registerFile_io_bSel),
    .io_writeData(registerFile_io_writeData),
    .io_writeSel(registerFile_io_writeSel),
    .io_writeEnable(registerFile_io_writeEnable),
    .io_a(registerFile_io_a),
    .io_b(registerFile_io_b)
  );
  ControlUnit controlUnit ( // @[CPUTop.scala 29:27]
    .io_instRead(controlUnit_io_instRead),
    .io_stop(controlUnit_io_stop),
    .io_writeDataSel(controlUnit_io_writeDataSel),
    .io_sel(controlUnit_io_sel),
    .io_imi(controlUnit_io_imi),
    .io_aSel(controlUnit_io_aSel),
    .io_bSel(controlUnit_io_bSel),
    .io_writeSel(controlUnit_io_writeSel),
    .io_writeEnable(controlUnit_io_writeEnable),
    .io_dmWriteEnable(controlUnit_io_dmWriteEnable)
  );
  ALU alu ( // @[CPUTop.scala 30:19]
    .io_a(alu_io_a),
    .io_b(alu_io_b),
    .io_im(alu_io_im),
    .io_sel(alu_io_sel),
    .io_res(alu_io_res),
    .io_comp(alu_io_comp)
  );
  assign io_done = alu_io_res == 32'hffff; // @[CPUTop.scala 73:11 CPUTop.scala 75:13]
  assign io_testerDataMemDataRead = dataMemory_io_testerDataRead; // @[CPUTop.scala 68:28]
  assign io_testerProgMemDataRead = programMemory_io_testerDataRead; // @[CPUTop.scala 62:28]
  assign programCounter_clock = clock;
  assign programCounter_reset = reset;
  assign programCounter_io_jump = alu_io_comp; // @[CPUTop.scala 37:26]
  assign programCounter_io_run = io_run; // @[CPUTop.scala 33:25]
  assign programCounter_io_stop = controlUnit_io_stop; // @[CPUTop.scala 39:26]
  assign programCounter_io_programCounterJump = alu_io_res[15:0]; // @[CPUTop.scala 40:40]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = registerFile_io_b[15:0]; // @[CPUTop.scala 57:25]
  assign dataMemory_io_writeEnable = controlUnit_io_dmWriteEnable; // @[CPUTop.scala 56:29]
  assign dataMemory_io_dataWrite = alu_io_res; // @[CPUTop.scala 55:27]
  assign dataMemory_io_testerEnable = io_testerDataMemEnable; // @[CPUTop.scala 70:30]
  assign dataMemory_io_testerAddress = io_testerDataMemAddress; // @[CPUTop.scala 67:31]
  assign dataMemory_io_testerWriteEnable = io_testerDataMemWriteEnable; // @[CPUTop.scala 71:35]
  assign dataMemory_io_testerDataWrite = io_testerDataMemDataWrite; // @[CPUTop.scala 69:33]
  assign programMemory_clock = clock;
  assign programMemory_io_address = programCounter_io_programCounter; // @[CPUTop.scala 34:28]
  assign programMemory_io_testerEnable = io_testerProgMemEnable; // @[CPUTop.scala 64:33]
  assign programMemory_io_testerAddress = io_testerProgMemAddress; // @[CPUTop.scala 61:34]
  assign programMemory_io_testerWriteEnable = io_testerProgMemWriteEnable; // @[CPUTop.scala 65:38]
  assign programMemory_io_testerDataWrite = io_testerProgMemDataWrite; // @[CPUTop.scala 63:36]
  assign registerFile_clock = clock;
  assign registerFile_io_aSel = controlUnit_io_aSel; // @[CPUTop.scala 44:24]
  assign registerFile_io_bSel = controlUnit_io_bSel; // @[CPUTop.scala 45:24]
  assign registerFile_io_writeData = controlUnit_io_writeDataSel ? dataMemory_io_dataRead : alu_io_res; // @[CPUTop.scala 48:29]
  assign registerFile_io_writeSel = controlUnit_io_writeSel; // @[CPUTop.scala 46:28]
  assign registerFile_io_writeEnable = controlUnit_io_writeEnable; // @[CPUTop.scala 47:31]
  assign controlUnit_io_instRead = programMemory_io_instructionRead; // @[CPUTop.scala 42:27]
  assign alu_io_a = registerFile_io_a; // @[CPUTop.scala 50:12]
  assign alu_io_b = registerFile_io_b; // @[CPUTop.scala 51:12]
  assign alu_io_im = {{6'd0}, controlUnit_io_imi}; // @[CPUTop.scala 53:13]
  assign alu_io_sel = controlUnit_io_sel; // @[CPUTop.scala 52:14]
endmodule
