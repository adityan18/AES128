`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07/13/2022 07:00:10 PM
// Design Name:
// Module Name: top
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


module top_tb ();

	reg  clk  ;
	reg  rst1 ;
	wire flag1;

	reg  rst2 ;
	wire flag2;

	encrypt dut1 (clk,rst1,flag1);

	decrypt dut2 (clk,rst2,flag2);

	initial begin
		clk = 0;
		forever begin
			#1;    clk = ~clk;
		end
	end

	initial begin
		rst1 = 1;
		rst2 = 1;
		#5;
		rst1 = 0;
	end

	always @ (flag1) begin
		if (flag1) begin
			#10;
			rst2 = 0;
			// $finish;
		end
	end

	always @ (flag2) begin
		if(flag2) begin
			#10;
			$finish;
		end
	end
endmodule
