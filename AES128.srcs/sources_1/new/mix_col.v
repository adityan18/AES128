`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/18/2024 08:36:30 PM
// Design Name:
// Module Name: mix_col
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


module mix_col(
    input clk,
    input en,
    input [31:0] rowInput, /*Input Bytes to be substituted */
    output outputPresent,
    output [31:0] rowOutput /* Mix Column Multiplier */
    );

    /**** Locals ****/
    reg [31:0] localMixColOp = 0;
    reg localOutputPresent;

    reg [7:0] a [0:3]; /* Input A for Galois Multiplication */
	reg [7:0] b [0:3]; /* Input B for Galois Multiplication */
	wire [7:0] p [0:3]; /* Product of Galois Multiplication */
	reg rst_g = 0;

    reg [127:0] mix_col1 = {8'h2, 8'h3, 8'h1, 8'h1,
                            8'h1, 8'h2, 8'h3, 8'h1,
                            8'h1, 8'h1, 8'h2, 8'h3,
                            8'h3, 8'h1, 8'h1, 8'h2};

	genvar k;

	integer i;

    reg [7:0] mix_col_counter = 127;
    reg [1:0]flag = 0;

    /**** Instantiations ****/
    generate
		for (k = 0; k < 4; k = k + 1) begin
			galois g (a[k], b[k], rst_g, p[k]);
		end
	endgenerate

    /**** Procedural Blocks ****/
    always @(posedge clk) begin
        if(localOutputPresent == 0) begin
            case (flag)
                0: begin
                    rst_g = 1;
                    localOutputPresent = 0;
                    localMixColOp = 0;
                    mix_col_counter = 127;
                    i = 5;
                    flag = 1;
                end
                1: begin
                    rst_g = 0;
                    {a[0], b[0]} = {mix_col1[(mix_col_counter)-:8], rowInput[31-:8]};
                    {a[1], b[1]} = {mix_col1[(mix_col_counter - 08)-:8], rowInput[23-:8]};
                    {a[2], b[2]} = {mix_col1[(mix_col_counter - 16)-:8], rowInput[15-:8]};
                    {a[3], b[3]} = {mix_col1[(mix_col_counter - 24)-:8], rowInput[07-:8]};
                    flag = 2;
                end
                2: begin
                    i = i - 1;
                    localMixColOp[(i * 8 - 1)-:8] = p[0] ^ p[1] ^ p[2] ^ p[3];
                    mix_col_counter = mix_col_counter - 32;
                    if(i==1) begin
                        localOutputPresent = 1;
                    end
                    rst_g = 1;
                    flag = 1;
                end
                default: begin
                end
            endcase
        end
    end

    always @(posedge en) begin
        localOutputPresent = 0;
        flag = 0;
    end

    /**** Assignments ****/
    assign rowOutput = localMixColOp;
    assign outputPresent = localOutputPresent;

endmodule
