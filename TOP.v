`ifndef TOP
`define TOP
`include "Macro.v"
`include "MainPipeline.v"
`include "PathTracker.v"
`include "InputLoader.v"

module TOP (
    input         clk_i,
    input         rst_i, 
    input         valid_i,
    input  [31:0] Sin_i,      
    inout  [31:0] Data,
    output [9:0]  addr_o,  
    output  reg   WR_o,
    output  reg   CS_o,
    output  reg   ready_o );

wire [5:0]  legal;
wire [9:0]  b1 [0:5];
wire [9:0]  b2 [0:5];
wire [9:0]  b3 [0:5];
wire [9:0]  a1 [0:5];
wire [9:0]  a2 [0:5];
wire [9:0]  a3 [0:5];
wire [5:0]  data_number;//0-39
wire [5:0]  ProcessNumber_DTWB;
wire [4:0]  i_YStatus;//to get addr for b1b2b3 from sram
wire        DTWVUpdatedTag;
wire [5:0]  PT_counter;
wire        ready_MP,ready_PT;
wire [1:0]  NumberBuffer [0:5];
wire [31:0] Data_in;
reg  [31:0] Data_out;
reg  [31:0] Sin_r;
wire [4:0]  XStatus,YStatus;
wire [`dtw_width - 1:0]  dtw_result;

assign Data_in = Data;
assign Data = ((~CS_o)&WR_o)? Data_out : 32'bz;
assign addr_o = WR_o? {{4{1'b0}},PT_counter}+5'h14 : {{5{1'b0}},i_YStatus};

InputLoader UIL(
    .clk(clk_i),
    .rst(rst_i),
    .valid(valid_i),
    .Sin_i(Sin_r),
    .ready(ready_o),
    .Data(Data_in),
    .a1_0(a1[0]),
    .a1_1(a1[1]),
    .a1_2(a1[2]),
    .a1_3(a1[3]),
    .a1_4(a1[4]),
    .a1_5(a1[5]),
    .a2_0(a2[0]),
    .a2_1(a2[1]),
    .a2_2(a2[2]),
    .a2_3(a2[3]),
    .a2_4(a2[4]),
    .a2_5(a2[5]),
    .a3_0(a3[0]),
    .a3_1(a3[1]),
    .a3_2(a3[2]),
    .a3_3(a3[3]),
    .a3_4(a3[4]),
    .a3_5(a3[5]),
    .b1_0(b1[0]),
    .b1_1(b1[1]),
    .b1_2(b1[2]),
    .b1_3(b1[3]),
    .b1_4(b1[4]),
    .b1_5(b1[5]),
    .b2_0(b2[0]),
    .b2_1(b2[1]),
    .b2_2(b2[2]),
    .b2_3(b2[3]),
    .b2_4(b2[4]),
    .b2_5(b2[5]),
    .b3_0(b3[0]),
    .b3_1(b3[1]),
    .b3_2(b3[2]),
    .b3_3(b3[3]),
    .b3_4(b3[4]),
    .b3_5(b3[5]),
    .legal_0(legal[0]),
    .legal_1(legal[1]),
    .legal_2(legal[2]),
    .legal_3(legal[3]),
    .legal_4(legal[4]),
    .legal_5(legal[5]),
    .i_YStatus(i_YStatus),
    .next_datanumber(data_number));

MainPipeline UMP(   
                    .clk(clk_i),
                    .rst(rst_i),
                    .valid(valid_i), 
                    .ready_o(ready_o),
                    .a1_i_0(a1[0]),
                    .a1_i_1(a1[1]),
                    .a1_i_2(a1[2]),
                    .a1_i_3(a1[3]),
                    .a1_i_4(a1[4]),
                    .a1_i_5(a1[5]),
                    .a2_i_0(a2[0]),
                    .a2_i_1(a2[1]),
                    .a2_i_2(a2[2]),
                    .a2_i_3(a2[3]),
                    .a2_i_4(a2[4]),
                    .a2_i_5(a2[5]),
                    .a3_i_0(a3[0]),
                    .a3_i_1(a3[1]),
                    .a3_i_2(a3[2]),
                    .a3_i_3(a3[3]),
                    .a3_i_4(a3[4]),
                    .a3_i_5(a3[5]),
                    .b1_i_0(b1[0]),
                    .b1_i_1(b1[1]),
                    .b1_i_2(b1[2]),
                    .b1_i_3(b1[3]),
                    .b1_i_4(b1[4]),
                    .b1_i_5(b1[5]),
                    .b2_i_0(b2[0]),
                    .b2_i_1(b2[1]),
                    .b2_i_2(b2[2]),
                    .b2_i_3(b2[3]),
                    .b2_i_4(b2[4]),
                    .b2_i_5(b2[5]),
                    .b3_i_0(b3[0]),
                    .b3_i_1(b3[1]),
                    .b3_i_2(b3[2]),
                    .b3_i_3(b3[3]),
                    .b3_i_4(b3[4]),
                    .b3_i_5(b3[5]),
                    .legal_i_0(legal[0]),
                    .legal_i_1(legal[1]),
                    .legal_i_2(legal[2]),
                    .legal_i_3(legal[3]),
                    .legal_i_4(legal[4]),
                    .legal_i_5(legal[5]),
                    .data_number(data_number),
                    .DTWVUpdatedTag(DTWVUpdatedTag),
                    .ProcessNumber_DTWB(ProcessNumber_DTWB), 
                    .finish(ready_MP), 
                    .NumberVector_0(NumberBuffer[0]),
                    .NumberVector_1(NumberBuffer[1]),
                    .NumberVector_2(NumberBuffer[2]),
                    .NumberVector_3(NumberBuffer[3]),
                    .NumberVector_4(NumberBuffer[4]),
                    .NumberVector_5(NumberBuffer[5]),
                    .dtw_result(dtw_result) );

PathTracker UPT(
    .clk(clk_i),
    .rst(rst_i),
    .finish(ready_MP),
    .ready_o(ready_o),
    .MP_NumberBuffer_0(NumberBuffer[0]),
    .MP_NumberBuffer_1(NumberBuffer[1]),
    .MP_NumberBuffer_2(NumberBuffer[2]),
    .MP_NumberBuffer_3(NumberBuffer[3]),
    .MP_NumberBuffer_4(NumberBuffer[4]),
    .MP_NumberBuffer_5(NumberBuffer[5]),
    .MP_DTWVUpdatedTag(DTWVUpdatedTag),
    .MP_ProcessNumber_DTWB(ProcessNumber_DTWB),
    .XStatus_o(XStatus),
    .YStatus_o(YStatus),
    .counter(PT_counter),
    .ready(ready_PT),
    .StatusUpdatedTag(StatusUpdatedTag)  );


//1 clk latency to synchronize
always @(posedge clk_i) begin
    Sin_r <= Sin_i;
end
//control logics for dc to optimize
always @(*) begin
    begin
        case ({ready_MP,ready_PT,valid_i})
            3'b011,3'b010: begin  //calculating
                WR_o <= 1'b0;
                CS_o <= 1'b0;
                ready_o <= 1'b0;
                Data_out <= 32'dx;
            end
            3'b101,3'b100 : begin //writing sram
                WR_o <= 1'b1;
                CS_o <= 1'b0;
                ready_o <= 1'b0;
                Data_out <= {{3{1'b0}},YStatus,{3{1'b0}},XStatus,{(16-`dtw_width){1'b0}},{(PT_counter==6'b0)?dtw_result:{`dtw_width{1'b0}}}};
            end
            3'b110 : begin //ready
                WR_o <= 1'bx;
                CS_o <= 1'b1;
                ready_o <= 1'b1;
                Data_out <= 32'dx;
            end
            3'b111 : begin //reading 1st input
                WR_o <= 1'b0;
                CS_o <= 1'b0;
                ready_o <= 1'b0;
                Data_out <= 32'dx;
            end
            default :begin
                WR_o <= 1'bx;
                CS_o <= 1'b1;
                ready_o <= 1'bx;
                Data_out <= 32'dx;
            end
        endcase
    end
end


endmodule
`endif