`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/09/2024 08:44:25 PM
// Design Name:
// Module Name: rot_tb
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


module rot_tb(

    );

    reg clk;
    wire flag;

    rot dut(clk, flag);

    initial begin
        clk = 0;
        #5;
        clk = 1;
        #10;
    end
endmodule
