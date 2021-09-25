`ifndef dtw_calculator
`define dtw_calculator
`include "DistanceCalculator.v"
module DTWCalculator(
  input  [`dtw_width - 1:0] pre_DTW_0,
  input  [`dtw_width - 1:0] pre_DTW_1,
  input  [`dtw_width - 1:0] pre_DTW_2,
  input  [`distance_width - 1:0] distance,
  output [`dtw_width - 1:0] DTW,
  output [1:0] Number
);
//This module calculates the DTW and tracks the path
  wire  judge_0 = pre_DTW_0 < pre_DTW_2;
  wire [`dtw_width - 1:0] intern = judge_0 ? pre_DTW_0 : pre_DTW_2;
  wire [1:0] number_intern = judge_0 ? 2'b00 : 2'b10;
  wire  judge_1 = intern < pre_DTW_1;
  wire [`dtw_width - 1:0] cons = judge_1 ? intern : pre_DTW_1;
  assign Number = judge_1 ? number_intern : 2'b01;
  assign DTW = distance + cons; 
endmodule
`endif