`timescale 1ns/1ns
`include "TOP.v"
module SuperTestbench;

reg [10:0] counter;
reg counter_full;
reg clk,rst,valid;
reg [31:0] ramword [0:63];
wire [9:0] addr;
reg [9:0] addr_reg;
reg [31:0] Sin_i [0:21];
reg [31:0] Sin_i_r;
wire[31:0] Data;
reg [31:0] Data_r;
wire CS,WR,ready;
assign Data = ((~WR)&(~CS))?Data_r:32'bz;

always #10 clk = ~clk;
always @(posedge clk) begin
    if ((~WR)&(~CS))
        Data_r = ramword[addr[5:0]];
end

always @(posedge clk) begin
    if (counter_full == 1'b0) begin
        counter <= counter + 1;
        if (counter == 11'd80) begin
            counter_full <= 1'd1;
            `ifdef debug_print_ram
            $display("ramword[0] = 0x%h", ramword[0]); 
            $display("ramword[1] = 0x%h", ramword[1]); 
            $display("ramword[2] = 0x%h", ramword[2]); 
            $display("ramword[3] = 0x%h", ramword[3]); 
            $display("ramword[4] = 0x%h", ramword[4]); 
            $display("ramword[5] = 0x%h", ramword[5]); 
            $display("ramword[6] = 0x%h", ramword[6]); 
            $display("ramword[7] = 0x%h", ramword[7]); 
            $display("ramword[8] = 0x%h", ramword[8]); 
            $display("ramword[9] = 0x%h", ramword[9]); 
            $display("ramword[10] = 0x%h", ramword[10]); 
            $display("ramword[11] = 0x%h", ramword[11]); 
            $display("ramword[12] = 0x%h", ramword[12]);
            $display("ramword[13] = 0x%h", ramword[13]);
            $display("ramword[14] = 0x%h", ramword[14]);
            $display("ramword[15] = 0x%h", ramword[15]);
            $display("ramword[16] = 0x%h", ramword[16]);
            $display("ramword[17] = 0x%h", ramword[17]);
            $display("ramword[18] = 0x%h", ramword[18]);
            $display("ramword[19] = 0x%h", ramword[19]);
            $display("ramword[20] = 0x%h", ramword[20]);
            $display("ramword[21] = 0x%h", ramword[21]);
            $display("ramword[22] = 0x%h", ramword[22]);
            $display("ramword[23] = 0x%h", ramword[23]);
            $display("ramword[24] = 0x%h", ramword[24]);
            $display("ramword[25] = 0x%h", ramword[25]);
            $display("ramword[26] = 0x%h", ramword[26]);
            $display("ramword[27] = 0x%h", ramword[27]);
            $display("ramword[28] = 0x%h", ramword[28]);
            $display("ramword[29] = 0x%h", ramword[29]);
            $display("ramword[30] = 0x%h", ramword[30]);
            $display("ramword[31] = 0x%h", ramword[31]);
            $display("ramword[32] = 0x%h", ramword[32]);
            $display("ramword[33] = 0x%h", ramword[33]);
            $display("ramword[34] = 0x%h", ramword[34]);
            $display("ramword[35] = 0x%h", ramword[35]);
            $display("ramword[36] = 0x%h", ramword[36]);
            $display("ramword[37] = 0x%h", ramword[37]);
            $display("ramword[38] = 0x%h", ramword[38]);
            $display("ramword[39] = 0x%h", ramword[39]);
            $display("ramword[40] = 0x%h", ramword[40]);
            $display("ramword[41] = 0x%h", ramword[41]);
            $display("ramword[42] = 0x%h", ramword[42]);
            $display("ramword[43] = 0x%h", ramword[43]);
            $display("ramword[44] = 0x%h", ramword[44]);
            $display("ramword[45] = 0x%h", ramword[45]);
            $display("ramword[46] = 0x%h", ramword[46]);
            $display("ramword[47] = 0x%h", ramword[47]);
            $display("ramword[48] = 0x%h", ramword[48]);
            $display("ramword[49] = 0x%h", ramword[49]);
            $display("ramword[50] = 0x%h", ramword[50]);
            $display("ramword[51] = 0x%h", ramword[51]);
            $display("ramword[52] = 0x%h", ramword[52]);
            $display("ramword[53] = 0x%h", ramword[53]);
            $display("ramword[54] = 0x%h", ramword[54]);
            $display("ramword[55] = 0x%h", ramword[55]);
            $display("ramword[56] = 0x%h", ramword[56]);
            $display("ramword[57] = 0x%h", ramword[57]);
            $display("ramword[58] = 0x%h", ramword[58]);
            $display("ramword[59] = 0x%h", ramword[59]);
            $display("ramword[60] = 0x%h", ramword[60]);
            $display("ramword[61] = 0x%h", ramword[61]);
            $display("ramword[62] = 0x%h", ramword[62]);
            $display("ramword[63] = 0x%h", ramword[63]);     
            `endif
            $finish;      
        end 
    end
end

initial begin
    counter = 11'd0;
    counter_full = 1'b0;
    ramword[0] = {{2{1'b0}},10'd0, 10'd0, 10'd0};
    ramword[1] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    ramword[2] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    ramword[3] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    ramword[4] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    ramword[5] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    ramword[6] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[7] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[8] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[9] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[10] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[11] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[12] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[13] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    ramword[14] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    ramword[15] = {{2{1'b0}},10'd6, 10'd6, 10'd6};
    ramword[16] = {{2{1'b0}},10'd6, 10'd6, 10'd6};
    ramword[17] = {{2{1'b0}},10'd6, 10'd6, 10'd6};
    ramword[18] = {{2{1'b0}},10'd7, 10'd7, 10'd7};
    ramword[19] = {{2{1'b0}},10'd8, 10'd8, 10'd8};
    Sin_i[19] = {{2{1'b0}},10'd0, 10'd0, 10'd0};
    Sin_i[18] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    Sin_i[17] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    Sin_i[16] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    Sin_i[15] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[14] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[13] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[12] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[11] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[10] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[9] = {{2{1'b0}},10'd4, 10'd4, 10'd4};
    Sin_i[8] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[7] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[6] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[5] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[4] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[3] = {{2{1'b0}},10'd5, 10'd5, 10'd5};
    Sin_i[2] = {{2{1'b0}},10'd6, 10'd6, 10'd6};
    Sin_i[1] = {{2{1'b0}},10'd7, 10'd7, 10'd7};
    Sin_i[0] = {{2{1'b0}},10'd8, 10'd8, 10'd8};
    /*
    Sin_i[39] = {{2{1'b0}},10'd0, 10'd0, 10'd0};
    Sin_i[38] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    Sin_i[37] = {{2{1'b0}},10'd1, 10'd1, 10'd1};
    Sin_i[36] = {{2{1'b0}},10'd2, 10'd2, 10'd2};
    Sin_i[35] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[34] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[33] = {{2{1'b0}},10'd3, 10'd3, 10'd3};
    Sin_i[32] = {{2{1'b0}},10'd7, 10'd7, 10'd7};
    Sin_i[31] = {{2{1'b0}},10'd8, 10'd8, 10'd8};
    Sin_i[30] = {{2{1'b0}},10'd9, 10'd9, 10'd9};
    Sin_i[29] = {{2{1'b0}},10'd10, 10'd10, 10'd10};
    Sin_i[28] = {{2{1'b0}},10'd11, 10'd11, 10'd11};
    Sin_i[27] = {{2{1'b0}},10'd12, 10'd12, 10'd12};
    Sin_i[26] = {{2{1'b0}},10'd13, 10'd13, 10'd13};
    Sin_i[25] = {{2{1'b0}},10'd14, 10'd14, 10'd14};
    Sin_i[24] = {{2{1'b0}},10'd15, 10'd15, 10'd15};
    Sin_i[23] = {{2{1'b0}},10'd16, 10'd16, 10'd16};
    Sin_i[22] = {{2{1'b0}},10'd16, 10'd16, 10'd16};
    Sin_i[21] = {{2{1'b0}},10'd17, 10'd17, 10'd17};
    Sin_i[20] = {{2{1'b0}},10'd18, 10'd18, 10'd18};
    */
   
    //clk&rst
    clk = 1'b0;
    rst = 1'b1;
    valid = 1'b0;
    #15 rst = 1'b0;
    #15 rst = 1'b1;   
    #25 valid = 1'b1;
end

always @(posedge clk) begin
    Sin_i_r   <= Sin_i[21];
    Sin_i[21] <= Sin_i[20];
    Sin_i[20] <= Sin_i[19];
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
    addr_reg <= addr;
    if(WR&(~CS))  ramword[addr[5:0]] <= Data;
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