`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/18/2024 10:07:03 AM
// Design Name:
// Module Name: rcon
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


module rcon(
    input [7:0] round, /* Round Number */
    output [7:0] rcon /* RCON Column*/
);

    /**** Locals ****/
    reg [7:0] localRcon = 8'h0;

    /**** Procedural Blocks ****/
    always @(round) begin
        case(round)
            8'h01: localRcon <= 8'h01;
            8'h02: localRcon <= 8'h02;
            8'h03: localRcon <= 8'h04;
            8'h04: localRcon <= 8'h08;
            8'h05: localRcon <= 8'h10;
            8'h06: localRcon <= 8'h20;
            8'h07: localRcon <= 8'h40;
            8'h08: localRcon <= 8'h80;
            8'h09: localRcon <= 8'h1b;
            8'h0A: localRcon <= 8'h36;
            default: localRcon <= localRcon;
        endcase
    end

    /**** Assignments ****/
    assign rcon = localRcon;
endmodule
