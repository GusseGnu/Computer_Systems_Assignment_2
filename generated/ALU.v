module ALU(
  input         clock,
  input         reset,
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
  wire  _T_18 = io_a < io_b; // @[ALU.scala 67:24]
  wire  _T_20 = 4'ha == io_sel; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_2 = _T_20 ? 16'hffff : 16'h0; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_4 = _T_17 ? io_a : {{16'd0}, _GEN_2}; // @[Conditional.scala 39:67]
  wire  _GEN_5 = _T_17 ? _T_18 : _T_20; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_6 = _T_15 ? io_a : _GEN_4; // @[Conditional.scala 39:67]
  wire  _GEN_7 = _T_15 ? _T_16 : _GEN_5; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_8 = _T_14 ? {{16'd0}, io_im} : _GEN_6; // @[Conditional.scala 39:67]
  wire  _GEN_9 = _T_14 | _GEN_7; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_10 = _T_13 ? io_a : _GEN_8; // @[Conditional.scala 39:67]
  wire  _GEN_11 = _T_13 ? 1'h0 : _GEN_9; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_12 = _T_12 ? io_a : _GEN_10; // @[Conditional.scala 39:67]
  wire  _GEN_13 = _T_12 ? 1'h0 : _GEN_11; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_14 = _T_11 ? io_a : _GEN_12; // @[Conditional.scala 39:67]
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
