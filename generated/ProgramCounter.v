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
  reg [15:0] addressCounterReg; // @[ProgramCounter.scala 12:34]
  wire [15:0] W1 = addressCounterReg + 16'h1; // @[ProgramCounter.scala 15:27]
  wire  _T_3 = ~io_run; // @[ProgramCounter.scala 19:21]
  wire  W3 = io_stop | _T_3; // @[ProgramCounter.scala 19:18]
  assign io_programCounter = addressCounterReg; // @[ProgramCounter.scala 37:21]
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
