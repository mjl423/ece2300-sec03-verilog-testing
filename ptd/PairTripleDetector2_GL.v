//========================================================================
// PairTripleDetector2_GL
//========================================================================

`ifndef PAIR_TRIPLE_DETECTOR2_GL_V
`define PAIR_TRIPLE_DETECTOR2_GL_V

`include "ece2300/ece2300-misc.v"
`include "ptd/PairTripleDetector_GL.v"

module PairTripleDetector2_GL
(
  input  wire [2:0] a,
  input  wire [2:0] b,
  output wire       out
);

  wire out_a;
  wire out_b;

  PairTripleDetector_GL detector_a
  (
    .in0 (a[0]),
    .in1 (a[1]),
    .in2 (a[2]),
    .out (out_a)
  );

  PairTripleDetector_GL detector_b
  (
    .in0 (b[0]),
    .in1 (b[1]),
    .in2 (b[2]),
    .out (out_b)
  );

  or (out, out_a, out_b);

endmodule

`endif  /* PAIR_TRIPLE_DETECTOR2_GL_V */

