`ifndef path_tracker
`define path_tracker
`include "PathCalculator.v"
module PathTracker (
    input clk,
    input rst,
    input ready_o,
    input finish,
    input [1:0] MP_NumberBuffer_0, //Number Buffer of the main pipeline
    input [1:0] MP_NumberBuffer_1,
    input [1:0] MP_NumberBuffer_2,
    input [1:0] MP_NumberBuffer_3,
    input [1:0] MP_NumberBuffer_4,
    input [1:0] MP_NumberBuffer_5,
    input MP_DTWVUpdatedTag, //DTWVUpdatedTag of the main pipeline
    input [5:0] MP_ProcessNumber_DTWB,
    output reg [4:0] XStatus_o,
    output reg [4:0] YStatus_o,
    output reg [5:0] counter,
    output reg ready,
    output reg StatusUpdatedTag //Indicates whether the XStatus_o and YStatus_o are updated
);
    reg [1:0] NumberBuffer_0 [0:38];
    reg [1:0] NumberBuffer_1 [0:38];
    reg [1:0] NumberBuffer_2 [0:38];
    reg [1:0] NumberBuffer_3 [0:38];
    reg [1:0] NumberBuffer_4 [0:38];
    reg [1:0] NumberBuffer_5 [0:38];
    reg [5:0] StatusNumber;
    reg ready_o_r;
    wire [4:0] NextXStatus;
    wire [4:0] NextYStatus;
    wire skip; //statusnumber+=2, else +=1
    PathCalculator UPC(
        .CurrentX(XStatus_o), 
        .CurrentY(YStatus_o), 
        .ChosenNumber_0(NumberBuffer_0[38-StatusNumber]), 
        .ChosenNumber_1(NumberBuffer_1[38-StatusNumber]), 
        .ChosenNumber_2(NumberBuffer_2[38-StatusNumber]), 
        .ChosenNumber_3(NumberBuffer_3[38-StatusNumber]), 
        .ChosenNumber_4(NumberBuffer_4[38-StatusNumber]), 
        .ChosenNumber_5(NumberBuffer_5[38-StatusNumber]), 
        .skip(skip), 
        .NextX(NextXStatus), 
        .NextY(NextYStatus)
    );

    //This always block fill the number buffer
    always @(posedge clk) begin
        ready_o_r <= ready_o;
        if (MP_DTWVUpdatedTag && finish == 1'b0) begin
            NumberBuffer_0[MP_ProcessNumber_DTWB] <= MP_NumberBuffer_0;
            NumberBuffer_1[MP_ProcessNumber_DTWB] <= MP_NumberBuffer_1;
            NumberBuffer_2[MP_ProcessNumber_DTWB] <= MP_NumberBuffer_2;
            NumberBuffer_3[MP_ProcessNumber_DTWB] <= MP_NumberBuffer_3;
            NumberBuffer_4[MP_ProcessNumber_DTWB] <= MP_NumberBuffer_4;
            NumberBuffer_5[MP_ProcessNumber_DTWB] <= MP_NumberBuffer_5;
            `ifdef debug_number
                if (MP_ProcessNumber_DTWB == `debug_num_rd1 || MP_ProcessNumber_DTWB == `debug_num_rd2 || MP_ProcessNumber_DTWB == `debug_num_rd3) begin
                    $display("Round Number: %d", MP_ProcessNumber_DTWB);
                    $display("NumberBuffer_0: %d", MP_NumberBuffer_0);
                    $display("NumberBuffer_1: %d", MP_NumberBuffer_1);
                    $display("NumberBuffer_2: %d", MP_NumberBuffer_2);
                    $display("NumberBuffer_3: %d", MP_NumberBuffer_3);
                    $display("NumberBuffer_4: %d", MP_NumberBuffer_4);
                    $display("NumberBuffer_5: %d", MP_NumberBuffer_5);                
                end
            `endif
        end 
    end

    //This always block conducts the function of tracking the path
    always @(posedge clk or negedge rst) begin
        if ((!rst)|ready_o) begin
            StatusNumber <= 6'd0; //start from 0
            counter <= 6'd0;
            StatusUpdatedTag <= 1'b0;
            XStatus_o <= 5'd19;
            YStatus_o <= 5'd19;
        end else begin
            if (finish && (!ready)) begin
                if (StatusUpdatedTag) begin
                    XStatus_o <= NextXStatus;
                    YStatus_o <= NextYStatus;
                    StatusNumber <= skip? (StatusNumber + 2'd2):(StatusNumber + 1'd1);
                    counter <= counter+1'b1;
                end else begin
                    StatusUpdatedTag <= 1'b1;
                end
            end else begin
                StatusNumber <= 6'd0;
            end
        end
    end

    always @(posedge clk or posedge finish or negedge rst) begin
        if (!rst) begin
            ready <= 1'b1;
        end else begin
            if(finish & (~ready_o_r)) begin
                ready <= (XStatus_o==5'd0)&&(YStatus_o==5'd0);
            end
        end
    end
endmodule
`endif