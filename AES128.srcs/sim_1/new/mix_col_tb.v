`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/18/2024 09:19:28 PM
// Design Name:
// Module Name: mix_col_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module mix_col_tb(

    );

    reg [31:0] rowInput;
    wire [31:0] rowOutput;
    wire rowOutputPresent;
    reg clk;
    reg en;

    initial begin
		clk = 0;
		forever begin
			#1;    clk = ~clk;
		end
	end

    mix_col dut(clk, en, rowInput, rowOutputPresent, rowOutput);

    initial begin
        en = 1;
        rowInput = {8'hd4, 8'hbf, 8'h5d, 8'h30};
        #50;
        en = 0; #50;
        en = 1;
        rowInput = {8'he0, 8'hb4, 8'h52, 8'hae};
        #50;
        en = 0; #50;
        en = 1;
        rowInput = {8'hb8, 8'h41, 8'h11, 8'hf1};
        #50;
        en = 0; #50;
        en = 1;
        rowInput = {8'h1e, 8'h27, 8'h98, 8'he5};
        #50;
        en = 0; #50;
        en = 1;
        $finish();
    end
endmodule
