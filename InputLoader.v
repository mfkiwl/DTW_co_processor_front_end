`ifndef InputLoader
`define InputLoader
module InputLoader (
    input        clk,
    input        rst,
    input        valid,/////////////////////////////////////////
    input        ready,
    input [31:0] Sin_i,
    input [31:0] Data,
    output [9:0] a1_0,
    output [9:0] a1_1,
    output [9:0] a1_2,
    output [9:0] a1_3,
    output [9:0] a1_4,
    output [9:0] a1_5,
    output [9:0] a2_0,
    output [9:0] a2_1,
    output [9:0] a2_2,
    output [9:0] a2_3,
    output [9:0] a2_4,
    output [9:0] a2_5,
    output [9:0] a3_0,
    output [9:0] a3_1,
    output [9:0] a3_2,
    output [9:0] a3_3,
    output [9:0] a3_4,
    output [9:0] a3_5, 
    output [9:0] b1_0,
    output [9:0] b1_1,
    output [9:0] b1_2,
    output [9:0] b1_3,
    output [9:0] b1_4,
    output [9:0] b1_5,
    output [9:0] b2_0,
    output [9:0] b2_1,
    output [9:0] b2_2,
    output [9:0] b2_3,
    output [9:0] b2_4,
    output [9:0] b2_5,
    output [9:0] b3_0,
    output [9:0] b3_1,
    output [9:0] b3_2,
    output [9:0] b3_3,
    output [9:0] b3_4,
    output [9:0] b3_5,
    output legal_0,
    output legal_1,
    output legal_2,
    output legal_3,
    output legal_4,
    output legal_5, 
    output [4:0] i_YStatus,//to get addr for reading next b1b2b3 input.
    output [5:0] next_datanumber);

reg [9:0] b1 [0:5];
reg [9:0] b2 [0:5];
reg [9:0] b3 [0:5];
reg [9:0] a1 [0:19];
reg [9:0] a2 [0:19];
reg [9:0] a3 [0:19];
//======================
reg [5:0] legal;      // fake regs
reg [9:0] b1_w [0:5]; //
reg [9:0] b2_w [0:5]; //
reg [9:0] b3_w [0:5]; //
//======================
wire [4:0] XStatus [0:5]; //indexes for a1 a2 a3
reg  [5:0] current_datanumber;
wire [5:0] temp_datanumber;//next_datanumber+1

assign a1_0 = a1[XStatus[0]];
assign a1_1 = a1[XStatus[1]];
assign a1_2 = a1[XStatus[2]];
assign a1_3 = a1[XStatus[3]];
assign a1_4 = a1[XStatus[4]];
assign a1_5 = a1[XStatus[5]];
assign a2_0 = a2[XStatus[0]];
assign a2_1 = a2[XStatus[1]];
assign a2_2 = a2[XStatus[2]];
assign a2_3 = a2[XStatus[3]];
assign a2_4 = a2[XStatus[4]];
assign a2_5 = a2[XStatus[5]];
assign a3_0 = a3[XStatus[0]];
assign a3_1 = a3[XStatus[1]];
assign a3_2 = a3[XStatus[2]];
assign a3_3 = a3[XStatus[3]];
assign a3_4 = a3[XStatus[4]];
assign a3_5 = a3[XStatus[5]];
assign b1_0 = b1_w[0];
assign b1_1 = b1_w[1];
assign b1_2 = b1_w[2];
assign b1_3 = b1_w[3];
assign b1_4 = b1_w[4];
assign b1_5 = b1_w[5];
assign b2_0 = b2_w[0];
assign b2_1 = b2_w[1];
assign b2_2 = b2_w[2];
assign b2_3 = b2_w[3];
assign b2_4 = b2_w[4];
assign b2_5 = b2_w[5];
assign b3_0 = b3_w[0];
assign b3_1 = b3_w[1];
assign b3_2 = b3_w[2];
assign b3_3 = b3_w[3];
assign b3_4 = b3_w[4];
assign b3_5 = b3_w[5];
assign legal_0 = legal[0];
assign legal_1 = legal[1];
assign legal_2 = legal[2];
assign legal_3 = legal[3];
assign legal_4 = legal[4];
assign legal_5 = legal[5];
assign next_datanumber = current_datanumber+1'b1;
assign temp_datanumber = current_datanumber+2'd2;

assign XStatus[0] = current_datanumber[5:1]-2'd2; 
assign XStatus[1] = current_datanumber[5:1]-1'd1;
assign XStatus[2] = current_datanumber[5:1];
assign XStatus[3] = current_datanumber[5:1]+1'd1;
assign XStatus[4] = current_datanumber[5:1]+2'd2;
assign XStatus[5] = current_datanumber[5:1]+2'd3;
assign i_YStatus = (temp_datanumber < 3'd6) ? (temp_datanumber[4:0]) : (next_datanumber[5:1]+2'd3);

always @(*) begin //for assigning legal. let dc optimize
    case(current_datanumber)
        6'd0,6'd38: legal <= {3'b0,1'b1,2'b0};
        6'd1,6'd37: legal <= {2'b0,2'b11,2'b0};
        6'd2,6'd36: legal <= {2'b0,3'b111,1'b0};
        6'd3,6'd35: legal <= {1'b0,4'b1111,1'b0};
        6'd4,6'd34: legal <= {1'b0,5'b11111};
        6'd63,6'd39:legal <= 6'd0;
        default: legal <= 6'b111111;
    endcase
end

always @(*) begin //for assigning b123_w. let dc optimize
    case(current_datanumber)
    6'd0,6'd38: begin
        b1_w[0] <= 10'bx;  b1_w[1] <= 10'bx;  b1_w[2] <= b1[0];
        b1_w[3] <= 10'bx;  b1_w[4] <= 10'bx;  b1_w[5] <= 10'bx;
        b2_w[0] <= 10'bx;  b2_w[1] <= 10'bx;  b2_w[2] <= b2[0];
        b2_w[3] <= 10'bx;  b2_w[4] <= 10'bx;  b2_w[5] <= 10'bx;
        b3_w[0] <= 10'bx;  b3_w[1] <= 10'bx;  b3_w[2] <= b3[0];
        b3_w[3] <= 10'bx;  b3_w[4] <= 10'bx;  b3_w[5] <= 10'bx;
    end
    6'd1,6'd37: begin
        b1_w[0] <= 10'bx;  b1_w[1] <= 10'bx;  b1_w[2] <= b1[0];
        b1_w[3] <= b1[1];  b1_w[4] <= 10'bx;  b1_w[5] <= 10'bx;
        b2_w[0] <= 10'bx;  b2_w[1] <= 10'bx;  b2_w[2] <= b2[0];
        b2_w[3] <= b2[1];  b2_w[4] <= 10'bx;  b2_w[5] <= 10'bx;
        b3_w[0] <= 10'bx;  b3_w[1] <= 10'bx;  b3_w[2] <= b3[0];
        b3_w[3] <= b3[1];  b3_w[4] <= 10'bx;  b3_w[5] <= 10'bx;
    end
    6'd2,6'd36: begin
        b1_w[0] <= 10'bx;  b1_w[1] <= b1[0];  b1_w[2] <= b1[1];
        b1_w[3] <= b1[2];  b1_w[4] <= 10'bx;  b1_w[5] <= 10'bx;
        b2_w[0] <= 10'bx;  b2_w[1] <= b2[0];  b2_w[2] <= b2[1];
        b2_w[3] <= b2[2];  b2_w[4] <= 10'bx;  b2_w[5] <= 10'bx;
        b3_w[0] <= 10'bx;  b3_w[1] <= b3[0];  b3_w[2] <= b3[1];
        b3_w[3] <= b3[2];  b3_w[4] <= 10'bx;  b3_w[5] <= 10'bx;      
    end
    6'd3,6'd35: begin
        b1_w[0] <= 10'bx;  b1_w[1] <= b1[0];  b1_w[2] <= b1[1];
        b1_w[3] <= b1[2];  b1_w[4] <= b1[3];  b1_w[5] <= 10'bx;
        b2_w[0] <= 10'bx;  b2_w[1] <= b2[0];  b2_w[2] <= b2[1];
        b2_w[3] <= b2[2];  b2_w[4] <= b1[3];  b2_w[5] <= 10'bx;
        b3_w[0] <= 10'bx;  b3_w[1] <= b3[0];  b3_w[2] <= b3[1];
        b3_w[3] <= b3[2];  b3_w[4] <= b1[3];  b3_w[5] <= 10'bx;       
    end
    6'd4,6'd34: begin
        b1_w[0] <= b1[0];  b1_w[1] <= b1[1];  b1_w[2] <= b1[2];
        b1_w[3] <= b1[3];  b1_w[4] <= b1[4];  b1_w[5] <= 10'bx;
        b2_w[0] <= b2[0];  b2_w[1] <= b2[1];  b2_w[2] <= b2[2];
        b2_w[3] <= b2[3];  b2_w[4] <= b2[4];  b2_w[5] <= 10'bx;
        b3_w[0] <= b3[0];  b3_w[1] <= b3[1];  b3_w[2] <= b3[2];
        b3_w[3] <= b3[3];  b3_w[4] <= b3[4];  b3_w[5] <= 10'bx;             
    end
    default:begin
        b1_w[0] <= b1[0];  b1_w[1] <= b1[1];  b1_w[2] <= b1[2];
        b1_w[3] <= b1[3];  b1_w[4] <= b1[4];  b1_w[5] <= b1[5];
        b2_w[0] <= b2[0];  b2_w[1] <= b2[1];  b2_w[2] <= b2[2];
        b2_w[3] <= b2[3];  b2_w[4] <= b2[4];  b2_w[5] <= b2[5];
        b3_w[0] <= b3[0];  b3_w[1] <= b3[1];  b3_w[2] <= b3[2];
        b3_w[3] <= b3[3];  b3_w[4] <= b3[4];  b3_w[5] <= b3[5];        
    end
    endcase
end

always @ (posedge clk or negedge rst) begin
    if(!rst) begin
        current_datanumber <= 6'd62;//62 = -2 ///////////////////////////////
    end else begin
        if(ready) begin
            current_datanumber <= 6'd62;//62 = -2
        end else begin
            current_datanumber <= current_datanumber==6'd39 ? 6'd39 : (current_datanumber+1'b1);
        end
        if(next_datanumber < 6'd20 & (~ready)) begin
            a1[next_datanumber] <= Sin_i[29:20];
            a2[next_datanumber] <= Sin_i[19:10];
            a3[next_datanumber] <= Sin_i[9:0];
        end
        if((next_datanumber < 6'd6)|(next_datanumber > 6'd5 & next_datanumber < 6'd34 & (next_datanumber[0]))) begin //b1b2b3 contained by shift regs
            b1[5] <= b1[4];
            b1[4] <= b1[3];
            b1[3] <= b1[2];
            b1[2] <= b1[1];
            b1[1] <= b1[0];
            b1[0] <= Data[29:20];
            b2[5] <= b2[4];
            b2[4] <= b2[3];
            b2[3] <= b2[2];
            b2[2] <= b2[1];
            b2[1] <= b2[0];
            b2[0] <= Data[19:10];
            b3[5] <= b3[4];
            b3[4] <= b3[3];
            b3[3] <= b3[2];
            b3[2] <= b3[1];
            b3[1] <= b3[0];
            b3[0] <= Data[9:0];
        end

    end
end
endmodule
`endif