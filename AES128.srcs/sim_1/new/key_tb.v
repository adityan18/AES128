`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2022 10:23:24 PM
// Design Name: 
// Module Name: key_tb
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


module key_tb(

    );

    reg clk, rst;
    wire flag;
    key dut(clk, rst, flag);

    initial begin
        clk = 0;
        forever begin
            #1; clk = ~clk;
        end
    end

    initial begin
        rst = 1;
        #5;
        rst = 0;
    end 

    always @ (flag) begin
        if (flag) begin
            #10;
            $finish;
        end
    end
endmodule
