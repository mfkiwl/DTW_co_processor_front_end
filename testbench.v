`timescale 1ns/1ns
`include "TOP.v"
module Testbench;

reg clk,rst,valid;
reg [31:0] ramword [0:63];
wire [9:0] addr;
reg [9:0] addr_reg;
reg [31:0] Sin_i [0:19];
reg [31:0] Sin_i_r;
wire[31:0] Data;
wire CS,WR,ready;

always #10 clk = ~clk;
assign Data = ((!WR)&CS)?ramword[addr[5:0]]:32'bz;

initial begin
    //template
    ramword[0] = {{2{1'b0}},10'd0, 10'd0, 10'd0};
    ramword[1] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    ramword[2] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    ramword[3] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    ramword[4] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[5] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    ramword[6] = {{2{1'b0}},10'd6, 10'd6, 10'd6};
    ramword[7] = {{2{1'b0}},10'd7, 10'd7, 10'd7};
    ramword[8] = {{2{1'b0}},10'd8, 10'd8, 10'd8};
    ramword[9] = {{2{1'b0}},10'd9, 10'd9, 10'd9};
    ramword[10] = {{2{1'b0}},10'd10, 10'd10, 10'd10};
    ramword[11] = {{2{1'b0}},10'd11, 10'd11, 10'd11};
    ramword[12] = {{2{1'b0}},10'd12, 10'd12, 10'd12};
    ramword[13] = {{2{1'b0}},10'd13, 10'd13, 10'd13};
    ramword[14] = {{2{1'b0}},10'd14, 10'd14, 10'd14};
    ramword[15] = {{2{1'b0}},10'd15, 10'd15, 10'd15};
    ramword[16] = {{2{1'b0}},10'd16, 10'd16, 10'd16};
    ramword[17] = {{2{1'b0}},10'd17, 10'd17, 10'd17};
    ramword[18] = {{2{1'b0}},10'd18, 10'd18, 10'd18};
    ramword[19] = {{2{1'b0}},10'd19, 10'd19, 10'd19};
    //input
    Sin_i[19] = {{2{1'b0}},10'd0, 10'd0, 10'd0};
    Sin_i[18] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    Sin_i[17] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    Sin_i[16] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[15] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    Sin_i[14] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[13] = {{2{1'b0}},10'd6, 10'd6, 10'd6};
    Sin_i[12] = {{2{1'b0}},10'd7, 10'd7, 10'd7};
    Sin_i[11] = {{2{1'b0}},10'd8, 10'd8, 10'd8};
    Sin_i[10] = {{2{1'b0}},10'd9, 10'd9, 10'd9};
    Sin_i[9] = {{2{1'b0}},10'd10, 10'd10, 10'd10};
    Sin_i[8] = {{2{1'b0}},10'd11, 10'd11, 10'd11};
    Sin_i[7] = {{2{1'b0}},10'd12, 10'd12, 10'd12};
    Sin_i[6] = {{2{1'b0}},10'd13, 10'd13, 10'd13};
    Sin_i[5] = {{2{1'b0}},10'd14, 10'd14, 10'd14};
    Sin_i[4] = {{2{1'b0}},10'd15, 10'd15, 10'd15};
    Sin_i[3] = {{2{1'b0}},10'd16, 10'd16, 10'd16};
    Sin_i[2] = {{2{1'b0}},10'd17, 10'd17, 10'd17};
    Sin_i[1] = {{2{1'b0}},10'd18, 10'd18, 10'd18};
    Sin_i[0] = {{2{1'b0}},10'd19, 10'd19, 10'd19};

    //clk&rst
    clk = 1'b0;
    rst = 1'b1;
    valid = 1'b1;
    #15 rst = 1'b0;
    #15 rst = 1'b1;   
end

always @(posedge clk) begin
    Sin_i_r   <= Sin_i[19];
    Sin_i[19] <= Sin_i[18];
    Sin_i[18] <= Sin_i[17];
    Sin_i[17] <= Sin_i[16];
    Sin_i[16] <= Sin_i[15];
    Sin_i[15] <= Sin_i[14];
    Sin_i[14] <= Sin_i[13];
    Sin_i[13] <= Sin_i[12];
    Sin_i[12] <= Sin_i[11];
    Sin_i[11] <= Sin_i[10];
    Sin_i[10] <= Sin_i[9];
    Sin_i[9] <= Sin_i[8];
    Sin_i[8] <= Sin_i[7];
    Sin_i[7] <= Sin_i[6];
    Sin_i[6] <= Sin_i[5];
    Sin_i[5] <= Sin_i[4];
    Sin_i[4] <= Sin_i[3];
    Sin_i[3] <= Sin_i[2];
    Sin_i[2] <= Sin_i[1];
    Sin_i[1] <= Sin_i[0];
    //Sin_i[0] <= ;
    addr_reg <= addr;
    if(WR&CS)  ramword[addr[5:0]] <= Data;
end

TOP UUT(
    .clk_i(clk),
    .rst_i(rst), 
    .valid_i(valid),
    .Sin_i(Sin_i_r),      
    .Data(Data),
    .addr_o(addr),  
    .WR_o(WR),
    .CS_o(CS),
    .ready_o(ready)
);

endmodule