`timescale 1ns/1ps
`include "TOP.v"
module IntelligentFileReader (
    output reg [31:0] MemInput [0:199],
    output reg [31:0] SeqInput [0:199]
);
    integer InputFile;
    integer MemFile;
    integer i = 0;
    integer return_value;
    initial begin
        InputFile = $fopen("vector_input.out", "r");
        MemFile = $fopen("vector_memory.out", "r");
        repeat(200) begin
            return_value = $fscanf(InputFile, "%h", SeqInput[i]);
            return_value = $fscanf(MemFile, "%h", MemInput[i]);
            i = i + 1;
        end
        $fclose(InputFile);
        $fclose(MemFile);
    end
endmodule

module EnhancedSRAM(
    input wire clk,
    input wire WR,   // 0 for Read, 1 for Write
    input wire CS,   // 0 valid
    input wire [9:0] ADDR,
`ifdef debug_print_ram // ports for testbench
    input wire PassClock,
    input wire [3:0] PassNumber,
`endif
    inout wire [31:0] DATA
);
    wire ReadSymbol = ~CS & ~WR;
    wire WriteSymbol = ~CS & WR;
    reg [31:0] KernelBlock [0:1023];
    reg [31:0] resource;
    assign DATA = ReadSymbol ? resource : 32'bz;
    integer Status = 0;
`ifdef debug_print_ram
    integer FW_p;
    initial begin
        FW_p = $fopen("vector_output.out", "w");
    end
    wire [31:0] MemInput [0:199];
    wire [31:0] SeqInput [0:199];
    IntelligentFileReader IFT(MemInput, SeqInput);
    always @(posedge PassClock) begin
        if (PassNumber != 4'd0) begin
            $display("PassNumber is %d", PassNumber - 1);
`endif
`ifdef SRAM_check
            $display("SRAMWord[0] = 0x%h", KernelBlock[0]); 
            $display("SRAMWord[1] = 0x%h", KernelBlock[1]); 
            $display("SRAMWord[2] = 0x%h", KernelBlock[2]);
            $display("SRAMWord[3] = 0x%h", KernelBlock[3]);
            $display("SRAMWord[4] = 0x%h", KernelBlock[4]);
            $display("SRAMWord[5] = 0x%h", KernelBlock[5]);
            $display("SRAMWord[6] = 0x%h", KernelBlock[6]);
            $display("SRAMWord[7] = 0x%h", KernelBlock[7]);
            $display("SRAMWord[8] = 0x%h", KernelBlock[8]);
            $display("SRAMWord[9] = 0x%h", KernelBlock[9]);
            $display("SRAMWord[10] = 0x%h", KernelBlock[10]);
            $display("SRAMWord[11] = 0x%h", KernelBlock[11]);
            $display("SRAMWord[12] = 0x%h", KernelBlock[12]);
            $display("SRAMWord[13] = 0x%h", KernelBlock[13]);
            $display("SRAMWord[14] = 0x%h", KernelBlock[14]);
            $display("SRAMWord[15] = 0x%h", KernelBlock[15]);
            $display("SRAMWord[16] = 0x%h", KernelBlock[16]);
            $display("SRAMWord[17] = 0x%h", KernelBlock[17]);
            $display("SRAMWord[18] = 0x%h", KernelBlock[18]);
            $display("SRAMWord[19] = 0x%h", KernelBlock[19]);
`endif
`ifdef debug_print_ram
            //From 20 - 60
            $display("SRAMWord[20] = 0x%h", KernelBlock[20]);
            $display("SRAMWord[21] = 0x%h", KernelBlock[21]);
            $display("SRAMWord[22] = 0x%h", KernelBlock[22]);
            $display("SRAMWord[23] = 0x%h", KernelBlock[23]);
            $display("SRAMWord[24] = 0x%h", KernelBlock[24]);
            $display("SRAMWord[25] = 0x%h", KernelBlock[25]);
            $display("SRAMWord[26] = 0x%h", KernelBlock[26]);
            $display("SRAMWord[27] = 0x%h", KernelBlock[27]);
            $display("SRAMWord[28] = 0x%h", KernelBlock[28]);
            $display("SRAMWord[29] = 0x%h", KernelBlock[29]);
            $display("SRAMWord[30] = 0x%h", KernelBlock[30]);
            $display("SRAMWord[31] = 0x%h", KernelBlock[31]);
            $display("SRAMWord[32] = 0x%h", KernelBlock[32]);
            $display("SRAMWord[33] = 0x%h", KernelBlock[33]);
            $display("SRAMWord[34] = 0x%h", KernelBlock[34]);
            $display("SRAMWord[35] = 0x%h", KernelBlock[35]);
            $display("SRAMWord[36] = 0x%h", KernelBlock[36]);
            $display("SRAMWord[37] = 0x%h", KernelBlock[37]);
            $display("SRAMWord[38] = 0x%h", KernelBlock[38]);
            $display("SRAMWord[39] = 0x%h", KernelBlock[39]);
            $display("SRAMWord[40] = 0x%h", KernelBlock[40]);
            $display("SRAMWord[41] = 0x%h", KernelBlock[41]);
            $display("SRAMWord[42] = 0x%h", KernelBlock[42]);
            $display("SRAMWord[43] = 0x%h", KernelBlock[43]);
            $display("SRAMWord[44] = 0x%h", KernelBlock[44]);
            $display("SRAMWord[45] = 0x%h", KernelBlock[45]);
            $display("SRAMWord[46] = 0x%h", KernelBlock[46]);
            $display("SRAMWord[47] = 0x%h", KernelBlock[47]);
            $display("SRAMWord[48] = 0x%h", KernelBlock[48]);
            $display("SRAMWord[49] = 0x%h", KernelBlock[49]);
            $display("SRAMWord[50] = 0x%h", KernelBlock[50]);
            $display("SRAMWord[51] = 0x%h", KernelBlock[51]);
            $display("SRAMWord[52] = 0x%h", KernelBlock[52]);
            $display("SRAMWord[53] = 0x%h", KernelBlock[53]);
            $display("SRAMWord[54] = 0x%h", KernelBlock[54]);
            $display("SRAMWord[55] = 0x%h", KernelBlock[55]);
            $display("SRAMWord[56] = 0x%h", KernelBlock[56]);
            $display("SRAMWord[57] = 0x%h", KernelBlock[57]);
            $display("SRAMWord[58] = 0x%h", KernelBlock[58]);
            $display("SRAMWord[59] = 0x%h", KernelBlock[59]);
            $fwrite(FW_p, "%h ", KernelBlock[20]);
            $fwrite(FW_p, "%h ", KernelBlock[21]);
            $fwrite(FW_p, "%h ", KernelBlock[22]);
            $fwrite(FW_p, "%h ", KernelBlock[23]);
            $fwrite(FW_p, "%h ", KernelBlock[24]);
            $fwrite(FW_p, "%h ", KernelBlock[25]);
            $fwrite(FW_p, "%h ", KernelBlock[26]);
            $fwrite(FW_p, "%h ", KernelBlock[27]);
            $fwrite(FW_p, "%h ", KernelBlock[28]);
            $fwrite(FW_p, "%h ", KernelBlock[29]);
            $fwrite(FW_p, "%h ", KernelBlock[30]);
            $fwrite(FW_p, "%h ", KernelBlock[31]);
            $fwrite(FW_p, "%h ", KernelBlock[32]);
            $fwrite(FW_p, "%h ", KernelBlock[33]);
            $fwrite(FW_p, "%h ", KernelBlock[34]);
            $fwrite(FW_p, "%h ", KernelBlock[35]);
            $fwrite(FW_p, "%h ", KernelBlock[36]);
            $fwrite(FW_p, "%h ", KernelBlock[37]);
            $fwrite(FW_p, "%h ", KernelBlock[38]);
            $fwrite(FW_p, "%h ", KernelBlock[39]);
            $fwrite(FW_p, "%h ", KernelBlock[40]);
            $fwrite(FW_p, "%h ", KernelBlock[41]);
            $fwrite(FW_p, "%h ", KernelBlock[42]);
            $fwrite(FW_p, "%h ", KernelBlock[43]);
            $fwrite(FW_p, "%h ", KernelBlock[44]);
            $fwrite(FW_p, "%h ", KernelBlock[45]);
            $fwrite(FW_p, "%h ", KernelBlock[46]);
            $fwrite(FW_p, "%h ", KernelBlock[47]);
            $fwrite(FW_p, "%h ", KernelBlock[48]);
            $fwrite(FW_p, "%h ", KernelBlock[49]);
            $fwrite(FW_p, "%h ", KernelBlock[50]);
            $fwrite(FW_p, "%h ", KernelBlock[51]);
            $fwrite(FW_p, "%h ", KernelBlock[52]);
            $fwrite(FW_p, "%h ", KernelBlock[53]);
            $fwrite(FW_p, "%h ", KernelBlock[54]);
            $fwrite(FW_p, "%h ", KernelBlock[55]);
            $fwrite(FW_p, "%h ", KernelBlock[56]);
            $fwrite(FW_p, "%h ", KernelBlock[57]);
            $fwrite(FW_p, "%h ", KernelBlock[58]);
            $fwrite(FW_p, "%h ", KernelBlock[59]);
            $fwrite(FW_p, "\n");            
        end
        if (PassNumber >= 4'd10) begin
            $finish;
        end
        repeat(1024) begin
            KernelBlock[Status] = 32'd0;
            Status = Status + 1;
        end
        Status = 0;
        repeat(20) begin
            KernelBlock[Status] = MemInput[PassNumber * 20 + Status];
            Status = Status + 1;
        end
        Status = 0;
    end
`endif
    always @ (posedge clk) begin
        if (ReadSymbol) begin
            resource <= KernelBlock[ADDR];
        end
    end  
    always @ (posedge clk) begin
        if (WriteSymbol) begin
            KernelBlock[ADDR] <= DATA;
        end
    end
endmodule

`ifdef test_TOP
module EnhancedSuperTestbench;
    wire [31:0] MemInput [0:199];
    wire [31:0] SeqInput [0:199];
    IntelligentFileReader IFT(MemInput, SeqInput);
    reg ini;
    reg clk;
    reg nrst;
    wire WR;
    wire CS;
    wire [9:0] ADDR;
    reg PassClock;
    reg [3:0] PassNumber;
    wire [31:0] DATA;
    // DTW Processor
    reg [31:0] dtw_in;
    reg dtw_valid;
    wire dtw_ready;
    TOP uut(clk, nrst, dtw_valid, dtw_in, DATA, ADDR, WR, CS, dtw_ready);
    EnhancedSRAM ES(clk, WR, CS, ADDR, PassClock, PassNumber, DATA);
    initial begin
        PassClock = 1'b1;
        PassNumber = 4'b0;
        ini = 1'b0;
        clk = 1'b0;
        nrst = 1'b0;
        dtw_in = 32'd0;
        dtw_valid = 1'b0;
        #(10 * `cycle);
        nrst = 1'b1;
    end
    always #(100 * `cycle) PassClock = ~PassClock;
    always #(`cycle / 2) clk = ~clk;
    always @(negedge PassClock) begin
        if (ini == 1'b0) begin
            ini = 1'b1;
        end else begin
            PassNumber = PassNumber + 4'b1;
        end
    end
    integer counter = 0;
    always @(posedge PassClock) begin
        #(`cycle * 10) dtw_valid = 1'b1;
        repeat(20) begin
            dtw_in = SeqInput[PassNumber * 20 + counter];
            #(`cycle);
            counter = counter + 1;
        end
        counter = 0;
        dtw_valid = 1'b0;
        dtw_in = 32'h0;
    end
endmodule
`endif

`ifdef test_SRAM
module EnhancedSuperTestbench;
    reg ini;
    reg clk;
    reg WR;
    reg CS;
    reg [9:0] ADDR;
    reg PassClock;
    reg [3:0] PassNumber;
    wire [31:0] DATA;
    EnhancedSRAM ES(clk, WR, CS, ADDR, PassClock, PassNumber, DATA);
    initial begin
        PassClock = 1'b1;
        PassNumber = 4'b0;
        ini = 1'b0;
    end
    always #(100 * `cycle) PassClock = ~PassClock;
    always @(negedge PassClock) begin
        if (ini == 1'b0) begin
            ini = 1'b1;
        end else begin
            PassNumber = PassNumber + 4'b1;
        end
    end
endmodule
`endif

`ifdef test_Reader
module EnhancedSuperTestbench;
    wire [31:0] MemInput [0:199];
    wire [31:0] SeqInput [0:199];
    IntelligentFileReader IFT(MemInput, SeqInput);
    integer i = 0;
    initial begin
        # 10;
        repeat(200) begin
        $display("%d: MemInput: %h", i, MemInput[i]);
        $display("%d: SeqInput: %h", i, SeqInput[i]);
        i = i + 1;
        end
    end
endmodule
`endif