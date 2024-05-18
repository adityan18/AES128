`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/18/2024 01:05:11 PM
// Design Name:
// Module Name: rcon_tb
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


module rcon_tb(

    );

    reg [7:0] round;
    wire [7:0] rcon;
    rcon dut (round, rcon);

    initial begin
        round = 8'h1; #1;
        round = 8'h2; #1;
        round = 8'h3; #1;
        round = 8'h4; #1;
        round = 8'h5; #1;
        round = 8'h6; #1;
        round = 8'h7; #1;
        round = 8'h8; #1;
        round = 8'h9; #1;
        round = 8'hA; #1;
    end
endmodule
