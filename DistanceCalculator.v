`ifndef distance_calculator
`define distance_calculator
`include "Macro.v"
module DistanceCalculator(
  input  [9:0]  a_0,
  input  [9:0]  a_1,
  input  [9:0]  a_2,
  input  [9:0]  b_0,
  input  [9:0]  b_1,
  input  [9:0]  b_2,
  output [`distance_width - 1:0] distance
);
//This module calculates the distance between tensors
  wire  judge_0 = $signed(a_0) > $signed(b_0);
  wire [10:0] ab0 = $signed(a_0) - $signed(b_0);
  wire [10:0] ba0 = $signed(b_0) - $signed(a_0);
  wire [`distance_width - 1:0] intern_0 = judge_0 ? $signed(ab0) : $signed(ba0);

  wire  judge_1 = $signed(a_1) > $signed(b_1);
  wire [10:0] ab1 = $signed(a_1) - $signed(b_1); 
  wire [10:0] ba1 = $signed(b_1) - $signed(a_1); 
  wire [`distance_width - 1:0] intern_1 = judge_1 ? $signed(ab1) : $signed(ba1);

  wire  judge_2 = $signed(a_2) > $signed(b_2); 
  wire [10:0] ab2 = $signed(a_2) - $signed(b_2);
  wire [10:0] ba2 = $signed(b_2) - $signed(a_2);
  wire [`distance_width - 1:0] intern_2 = judge_2 ? $signed(ab2) : $signed(ba2);

  assign distance = $signed(intern_0) + $signed(intern_1) + $signed(intern_2);
endmodule
`endif