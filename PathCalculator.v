`ifndef path_calculator
`define path_calculator
module PathCalculator (
    input [4:0] CurrentX,
    input [4:0] CurrentY,
    input [1:0] ChosenNumber_0,
    input [1:0] ChosenNumber_1,
    input [1:0] ChosenNumber_2,
    input [1:0] ChosenNumber_3,
    input [1:0] ChosenNumber_4,
    input [1:0] ChosenNumber_5,
    output skip, //statusnumber+=2, else +=1
    output [4:0] NextX,
    output [4:0] NextY
);
    reg [1:0] ChosenNumber;
    always @(*) begin
        case (CurrentY - CurrentX)
            5'd1: ChosenNumber <= ChosenNumber_2;
            5'd3: ChosenNumber <= ChosenNumber_1;
            5'd5: ChosenNumber <= ChosenNumber_0;
            -5'd1: ChosenNumber <= ChosenNumber_3;
            -5'd3: ChosenNumber <= ChosenNumber_4;
            -5'd5: ChosenNumber <= ChosenNumber_5; 
            5'd0: ChosenNumber <= ChosenNumber_2;
            5'd2: ChosenNumber <= ChosenNumber_1;
            5'd4: ChosenNumber <= ChosenNumber_0;
            -5'd2: ChosenNumber <= ChosenNumber_3;
            -5'd4: ChosenNumber <= ChosenNumber_4;
            default: ChosenNumber <= ChosenNumber_5; 
        endcase
    end
    assign NextX = (CurrentX == 5'd0 | ChosenNumber == 2'd2) ? CurrentX : CurrentX - 1'b1 ;
    assign NextY = (CurrentY == 5'd0 | ChosenNumber == 2'd0) ? CurrentY : CurrentY - 1'b1 ;
    assign skip = (ChosenNumber == 2'd1) ? 1'b1:1'b0;
endmodule
`endif