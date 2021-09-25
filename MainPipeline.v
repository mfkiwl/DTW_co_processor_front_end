`ifndef main_pipeline
`define main_pipeline
`include "Macro.v"
`include "DistanceCalculator.v"
`include "DTWCalculator.v"
module MainPipeline (
    input clk,
    input rst,
    input valid, //Indicates whether the input data is valid (1 -> valid, 0 -> invalid)
    input ready_o,
    input [9:0] a1_i_0,// Input data
    input [9:0] a1_i_1,
    input [9:0] a1_i_2,
    input [9:0] a1_i_3,
    input [9:0] a1_i_4,
    input [9:0] a1_i_5,
    input [9:0] a2_i_0,
    input [9:0] a2_i_1,
    input [9:0] a2_i_2,
    input [9:0] a2_i_3,
    input [9:0] a2_i_4,
    input [9:0] a2_i_5,
    input [9:0] a3_i_0,
    input [9:0] a3_i_1,
    input [9:0] a3_i_2,
    input [9:0] a3_i_3,
    input [9:0] a3_i_4,
    input [9:0] a3_i_5, 
    input [9:0] b1_i_0,
    input [9:0] b1_i_1,
    input [9:0] b1_i_2,
    input [9:0] b1_i_3,
    input [9:0] b1_i_4,
    input [9:0] b1_i_5,
    input [9:0] b2_i_0,
    input [9:0] b2_i_1,
    input [9:0] b2_i_2,
    input [9:0] b2_i_3,
    input [9:0] b2_i_4,
    input [9:0] b2_i_5,
    input [9:0] b3_i_0,
    input [9:0] b3_i_1,
    input [9:0] b3_i_2,
    input [9:0] b3_i_3,
    input [9:0] b3_i_4,
    input [9:0] b3_i_5, 
    input legal_i_0,
    input legal_i_1,
    input legal_i_2,
    input legal_i_3,
    input legal_i_4,
    input legal_i_5,
    input [5:0] data_number, //Indicates the process number for input data, range from 0 to 39
    output reg DTWVUpdatedTag,
    output reg [5:0] ProcessNumber_DTWB, //Corresponding process number of the DTW buffer, range from 0 to 39
    output reg finish, //Indicates whether the calculation is completed (1 -> finished, 0 -> not finished)
    output [1:0] NumberVector_0,
    output [1:0] NumberVector_1,
    output [1:0] NumberVector_2,
    output [1:0] NumberVector_3,
    output [1:0] NumberVector_4,
    output [1:0] NumberVector_5,
    output [`dtw_width - 1:0] dtw_result //Indicates the dtw calculation result
);
    //2 stages pipeline
    //Distance Calculating Stage: Input->data, Output->distance vector
    //             |
    //             |
    //DTW Calculating Stage: Input->preDTW, prepreDTW, distance vector, Output->DTW
    wire [9:0] a1 [0:5];//Data
    wire [9:0] a2 [0:5];
    wire [9:0] a3 [0:5];
    wire [9:0] b1 [0:5];
    wire [9:0] b2 [0:5];
    wire [9:0] b3 [0:5];

    `ifdef debug_dtw
    always @(posedge clk) begin
        if(ProcessNumber_DTWB == `debug_dtw_rd1 || ProcessNumber_DTWB == `debug_dtw_rd2 || ProcessNumber_DTWB == `debug_dtw_rd3) begin
            $display("Round Number: %d", ProcessNumber_DTWB);
            $display("DTWBuffer[0] = 0x%h", DTWBuffer[0]); 
            $display("DTWBuffer[0] = 0x%h", DTWBuffer[1]); 
            $display("DTWBuffer[0] = 0x%h", DTWBuffer[2]); 
            $display("DTWBuffer[0] = 0x%h", DTWBuffer[3]); 
            $display("DTWBuffer[0] = 0x%h", DTWBuffer[4]); 
            $display("DTWBuffer[0] = 0x%h", DTWBuffer[5]); 
        end
    end
    `endif
    wire legal [0:5];//Which Result Is Legal
    reg  legal_DB [0:5];//Which Result Is Legal

    wire [5:0] ResourceNumber; //Corresponding process number of the data, range from 0 to 39
    reg  [5:0] ProcessNumber_DB; //Corresponding process number of the distance buffer, range from 0 to 39

    wire [`distance_width - 1:0] DistanceVector [0:5];
    wire DVUpdatedTag;
    reg [`distance_width - 1:0] DistanceBuffer [0:5];

    wire [`dtw_width - 1:0] DTWVector [0:5];
    wire [1:0] NumberVector [0:5];
    reg [`dtw_width - 1:0] DTWBuffer [0:5];
    reg [`dtw_width - 1:0] preDTWBuffer [0:5];
    DistanceCalculator UDC0(a1[0], a2[0], a3[0], b1[0], b2[0], b3[0], DistanceVector[0]);
    DistanceCalculator UDC1(a1[1], a2[1], a3[1], b1[1], b2[1], b3[1], DistanceVector[1]);
    DistanceCalculator UDC2(a1[2], a2[2], a3[2], b1[2], b2[2], b3[2], DistanceVector[2]);
    DistanceCalculator UDC3(a1[3], a2[3], a3[3], b1[3], b2[3], b3[3], DistanceVector[3]);
    DistanceCalculator UDC4(a1[4], a2[4], a3[4], b1[4], b2[4], b3[4], DistanceVector[4]);
    DistanceCalculator UDC5(a1[5], a2[5], a3[5], b1[5], b2[5], b3[5], DistanceVector[5]);
    wire [`dtw_width - 1:0] pre_DTW_0 [0:5];
    wire [`dtw_width - 1:0] pre_DTW_1 [0:5];
    wire [`dtw_width - 1:0] pre_DTW_2 [0:5];
    assign NumberVector_0 = NumberVector[0];
    assign NumberVector_1 = NumberVector[1];
    assign NumberVector_2 = NumberVector[2];
    assign NumberVector_3 = NumberVector[3];
    assign NumberVector_4 = NumberVector[4];
    assign NumberVector_5 = NumberVector[5];
    assign pre_DTW_1[0] = preDTWBuffer[0];
    assign pre_DTW_1[1] = preDTWBuffer[1];
    assign pre_DTW_1[2] = preDTWBuffer[2];
    assign pre_DTW_1[3] = preDTWBuffer[3];
    assign pre_DTW_1[4] = preDTWBuffer[4];
    assign pre_DTW_1[5] = preDTWBuffer[5];
    //odd: -1, =
    //even: =, +1
    assign pre_DTW_0[0] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[0]: -`dtw_width'b1;
    assign pre_DTW_0[1] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[1] : DTWBuffer[0];
    assign pre_DTW_0[2] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[2] : DTWBuffer[1];
    assign pre_DTW_0[3] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[3] : DTWBuffer[2];
    assign pre_DTW_0[4] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[4] : DTWBuffer[3];
    assign pre_DTW_0[5] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[5] : DTWBuffer[4];
    assign pre_DTW_2[0] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[1] : DTWBuffer[0];
    assign pre_DTW_2[1] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[2] : DTWBuffer[1];
    assign pre_DTW_2[2] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[3] : DTWBuffer[2];
    assign pre_DTW_2[3] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[4] : DTWBuffer[3];
    assign pre_DTW_2[4] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? DTWBuffer[5] : DTWBuffer[4];
    assign pre_DTW_2[5] = !(ProcessNumber_DTWB & 6'd1 == 6'd1) ? -`dtw_width'b1 : DTWBuffer[5];
    DTWCalculator UDTWC0(pre_DTW_0[0], pre_DTW_1[0], pre_DTW_2[0], DistanceBuffer[0], DTWVector[0], NumberVector[0]);
    DTWCalculator UDTWC1(pre_DTW_0[1], pre_DTW_1[1], pre_DTW_2[1], DistanceBuffer[1], DTWVector[1], NumberVector[1]);
    DTWCalculator UDTWC2(pre_DTW_0[2], pre_DTW_1[2], pre_DTW_2[2], DistanceBuffer[2], DTWVector[2], NumberVector[2]);
    DTWCalculator UDTWC3(pre_DTW_0[3], pre_DTW_1[3], pre_DTW_2[3], DistanceBuffer[3], DTWVector[3], NumberVector[3]);
    DTWCalculator UDTWC4(pre_DTW_0[4], pre_DTW_1[4], pre_DTW_2[4], DistanceBuffer[4], DTWVector[4], NumberVector[4]);
    DTWCalculator UDTWC5(pre_DTW_0[5], pre_DTW_1[5], pre_DTW_2[5], DistanceBuffer[5], DTWVector[5], NumberVector[5]);
    assign dtw_result = DTWBuffer[2];

    assign            ResourceNumber = data_number;
    assign            legal[0] = legal_i_0;
    assign            legal[1] = legal_i_1;
    assign            legal[2] = legal_i_2;
    assign            legal[3] = legal_i_3;
    assign            legal[4] = legal_i_4;
    assign            legal[5] = legal_i_5;
    assign            a1[0] = a1_i_0;
    assign            a1[1] = a1_i_1;
    assign            a1[2] = a1_i_2;
    assign            a1[3] = a1_i_3;
    assign            a1[4] = a1_i_4;
    assign            a1[5] = a1_i_5;
    assign            a2[0] = a2_i_0;
    assign            a2[1] = a2_i_1;
    assign            a2[2] = a2_i_2;
    assign            a2[3] = a2_i_3;
    assign            a2[4] = a2_i_4;
    assign            a2[5] = a2_i_5;
    assign            a3[0] = a3_i_0;
    assign            a3[1] = a3_i_1;
    assign            a3[2] = a3_i_2;
    assign            a3[3] = a3_i_3;
    assign            a3[4] = a3_i_4;
    assign            a3[5] = a3_i_5; 
    assign            b1[0] = b1_i_0;
    assign            b1[1] = b1_i_1;
    assign            b1[2] = b1_i_2;
    assign            b1[3] = b1_i_3;
    assign            b1[4] = b1_i_4;
    assign            b1[5] = b1_i_5;
    assign            b2[0] = b2_i_0;
    assign            b2[1] = b2_i_1;
    assign            b2[2] = b2_i_2;
    assign            b2[3] = b2_i_3;
    assign            b2[4] = b2_i_4;
    assign            b2[5] = b2_i_5;
    assign            b3[0] = b3_i_0;
    assign            b3[1] = b3_i_1;
    assign            b3[2] = b3_i_2;
    assign            b3[3] = b3_i_3;
    assign            b3[4] = b3_i_4;
    assign            b3[5] = b3_i_5;  
    assign            DVUpdatedTag = ResourceNumber == ProcessNumber_DB ? 1'b0:1'b1;

    //This always block conducts the function of updating DistanceBuffer.
    always @(posedge clk or negedge rst) begin
            if (DVUpdatedTag) begin
                DistanceBuffer[0] <= DistanceVector[0];
                DistanceBuffer[1] <= DistanceVector[1];
                DistanceBuffer[2] <= DistanceVector[2];
                DistanceBuffer[3] <= DistanceVector[3];
                DistanceBuffer[4] <= DistanceVector[4];
                DistanceBuffer[5] <= DistanceVector[5];
                legal_DB[0] <= legal[0];
                legal_DB[1] <= legal[1];
                legal_DB[2] <= legal[2];
                legal_DB[3] <= legal[3];
                legal_DB[4] <= legal[4];
                legal_DB[5] <= legal[5];
            end
    end

    //This always block conducts the function of updating DTWBuffer and preDTWBuffer.
    always @(posedge clk or negedge rst) begin
        if ((!rst) | (ready_o)) begin
            ProcessNumber_DTWB <= -6'd1;
            ProcessNumber_DB <= -6'd1;
            DTWVUpdatedTag <= 1'b0;
            DTWBuffer[0] <= `dtw_width'b0;
            DTWBuffer[1] <= `dtw_width'b0;
            DTWBuffer[2] <= `dtw_width'b0;
            DTWBuffer[3] <= `dtw_width'b0;
            DTWBuffer[4] <= `dtw_width'b0;
            DTWBuffer[5] <= `dtw_width'b0;
            preDTWBuffer[0] <= `dtw_width'b0;
            preDTWBuffer[1] <= `dtw_width'b0;
            preDTWBuffer[2] <= `dtw_width'b0;
            preDTWBuffer[3] <= `dtw_width'b0;
            preDTWBuffer[4] <= `dtw_width'b0;
            preDTWBuffer[5] <= `dtw_width'b0;
            finish <= 1'b1;
        end else begin
            if(valid & (ProcessNumber_DTWB != 6'd39)) begin
                finish <=1'b0;
            end
            if (DVUpdatedTag == 1'b1 && finish == 1'b0) begin
                DTWVUpdatedTag <= 1'b1;
                ProcessNumber_DTWB <= ProcessNumber_DB;
                ProcessNumber_DB   <= data_number;
            end else begin
                DTWVUpdatedTag <= 1'b0;
            end
            if (DTWVUpdatedTag == 1'b1 && finish == 1'b0) begin         
                preDTWBuffer[0] <= DTWBuffer[0];
                preDTWBuffer[1] <= DTWBuffer[1];
                preDTWBuffer[2] <= DTWBuffer[2];
                preDTWBuffer[3] <= DTWBuffer[3];
                preDTWBuffer[4] <= DTWBuffer[4];
                preDTWBuffer[5] <= DTWBuffer[5];
                if(ProcessNumber_DTWB == 6'd39) begin
                    //finish <= ProcessNumber_DTWB == 6'd39 ? 1'b1 : 1'b0;
                    finish <= 1'b1;
                end else begin
                    DTWBuffer[0] <= legal_DB[0] ? DTWVector[0] : -`dtw_width'b1; //If illegal, give it the max value to clear its influence
                    DTWBuffer[1] <= legal_DB[1] ? DTWVector[1] : -`dtw_width'b1;
                    DTWBuffer[2] <= legal_DB[2] ? DTWVector[2] : -`dtw_width'b1;
                    DTWBuffer[3] <= legal_DB[3] ? DTWVector[3] : -`dtw_width'b1;
                    DTWBuffer[4] <= legal_DB[4] ? DTWVector[4] : -`dtw_width'b1;
                    DTWBuffer[5] <= legal_DB[5] ? DTWVector[5] : -`dtw_width'b1;
                end             
            end 
        end
    end
endmodule
`endif