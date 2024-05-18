`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06/29/2022 10:23:24 PM
// Design Name:
// Module Name: keyGeneration_tb
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


module keyGeneration_tb(

    );

    reg clk, en;
    reg [127:0] key;
    wire [127:0] roundKey;
    reg [2:0] round;
    wire keyReady;

    key_generator dut(clk, en, key, keyReady, round, roundKey);

    initial begin
        clk = 0;
        forever begin
            #1; clk = ~clk;
        end
    end

    initial begin
        en = 1;
        key = {8'h2b, 8'h28, 8'hab, 8'h09,
        8'h7e, 8'hae, 8'hf7, 8'hcf,
        8'h15, 8'hd2, 8'h15, 8'h4f,
        8'h16, 8'ha6, 8'h88, 8'h3c};
        # 50;
        en = 0;
        # 10;
        en = 1;
        key = {8'h2b, 8'h28, 8'hab, 8'h09,
        8'h7e, 8'hae, 8'hf7, 8'hcf,
        8'h15, 8'hd2, 8'h15, 8'h4f,
        8'h16, 8'ha6, 8'h88, 8'h3c};
        # 50;
        $finish;
    end

endmodule
