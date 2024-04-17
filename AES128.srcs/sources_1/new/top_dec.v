`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 01/10/2023 11:31:15 PM
// Design Name:
// Module Name: top_dec
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


module decrypt (
	input      clk ,
	input      rst ,
	output reg flag
);

	integer fd0;
	integer fd1;
	integer fd2;
	integer fd3;
	integer fd4;
	integer fd5;
	integer rv0;
	integer rv1;
	integer rv2;
	integer rv3;
	integer rv4;
	integer rv5;
	integer i  ;
	integer j  ;
	reg[1:0] kk = 0;
	reg     [1:0] hh = 0;
	integer       l     ;

	reg [3:0] round                        ;
	reg [7:0] sb       [0:15][0:15]        ;
	reg [7:0] j_counter             = 8'd40;
	// reg [7:0] key    [ 0:3][ 0:3];
	reg [7:0] key    [0:3][0:43]    ;
	reg [7:0] temp               = 0;
	reg [7:0] mat    [0:3][ 0:3]    ;
	reg [7:0] mat2   [0:3][ 0:3]    ;
	reg [7:0] mix_col[0:3][ 0:3]    ;
	reg [7:0] rcon   [0:3][ 0:9]    ;
	reg [7:0] key_col[0:3]          ;

	reg [7:0] a [0:3];
	reg [7:0] b [0:3];
	wire [7:0] p [0:3];
	reg rst_g;
	genvar k;
	generate
		for (k = 0; k < 4; k = k + 1) begin
			galois g (a[k], b[k], rst_g, p[k]);
		end
	endgenerate


	initial begin
		fd0 = $fopen("key_final.mem", "r");
		for(i = 0; i < 4; i = i + 1) begin
			for(j = 0; j < 44; j = j + 1) begin
				rv0 = $fscanf(fd0, "%h", key[i][j]);
			end
		end

		fd1 = $fopen("revsbox.mem", "r");
		for(i = 0; i < 16; i = i + 1) begin
			for(j = 0; j < 16; j = j + 1) begin
				rv1 = $fscanf(fd1, "%h", sb[i][j]);
			end
		end

		fd2 = $fopen("rcon.mem", "r");
		for(i = 0; i < 4; i = i + 1) begin
			for(j = 0; j < 10; j = j+ 1) begin
				rv2 = $fscanf(fd2, "%h", rcon[i][j]);
			end
		end

		fd4 = $fopen("dec_mix_col.mem", "r");
		for(i = 0; i < 4; i = i + 1) begin
			for(j = 0; j < 4; j = j+ 1) begin
				rv4 = $fscanf(fd4, "%h", mix_col[i][j]);
			end
		end
	end

	reg [2:0] PS;
	reg [2:0] NS;

	parameter IDLE           = 0;
	parameter XOR            = 1;
	parameter INV_SUB_BYTES  = 3;
	parameter INV_SHIFT_ROWS = 2;
	parameter INV_MIX_COL_1  = 6;
	parameter INV_MIX_COL_2  = 7;
	parameter INV_MIX_COL_3  = 5;
	parameter HOLD           = 4;

	always @(PS) begin
		case (PS)
			IDLE : begin
				fd3 = $fopen("data_dec.mem", "r");
				for(i = 0; i < 4; i = i + 1) begin
					for(j = 0; j < 4; j = j+ 1) begin
						rv3 = $fscanf(fd3, "%h", mat[i][j]);
					end
				end
				round = 0;
				flag  = 0;
				NS    = XOR;
				rst_g = 1;
			end

			XOR : begin
				for(i = 0; i < 4; i = i + 1) begin
					for(j = j_counter; j < j_counter+4; j = j+ 1) begin
						mat[i][j%4] = mat[i][j%4] ^ key[i][j];
					end
				end
				NS = (round == 10) ? HOLD : INV_SHIFT_ROWS;
			end
			INV_SHIFT_ROWS : begin
				{mat[0][0], mat[0][1], mat[0][2], mat[0][3]} = {mat[0][0], mat[0][1], mat[0][2], mat[0][3]};
				{mat[1][0], mat[1][1], mat[1][2], mat[1][3]} = {mat[1][3], mat[1][0], mat[1][1], mat[1][2]};
				{mat[2][0], mat[2][1], mat[2][2], mat[2][3]} = {mat[2][2], mat[2][3], mat[2][0], mat[2][1]};
				{mat[3][0], mat[3][1], mat[3][2], mat[3][3]} = {mat[3][1], mat[3][2], mat[3][3], mat[3][0]};

				round     = round + 1;
				j_counter = j_counter - 4;
				NS        = INV_SUB_BYTES;
			end
			INV_SUB_BYTES : begin
				for(i = 0; i < 4; i = i + 1) begin
					for(j = 0; j < 4; j = j+ 1) begin
						mat[i][j] = sb[mat[i][j][7:4]][mat[i][j][3:0]];
					end
				end
				NS = (round == 10) ? XOR : INV_MIX_COL_1;
			end
			INV_MIX_COL_1 : begin
				rst_g = 0;
				for (l=0;l<4;l=l+1)begin
					a[l] = mix_col[kk][l];
					b[l] = mat[l][hh];
				end
				NS <= INV_MIX_COL_2;
			end
			INV_MIX_COL_2 : begin
				rst_g        = 0;
				mat2[kk][hh] = p[0]^p[1]^p[2]^p[3];
				NS           <= INV_MIX_COL_3;
			end
			INV_MIX_COL_3 : begin
				rst_g = 1;
				if (kk == 3 && hh == 3) begin
					NS = XOR;
					for (i = 0; i < 4; i = i + 1) begin
						for (j = 0; j < 4; j = j + 1) begin
							mat[i][j] = mat2[i][j];
						end
					end
				end
				else NS = INV_MIX_COL_1;
				kk = kk+1;
				if(kk==0) hh=hh+1;
				// NS    <= MIX_COL_1;
			end
			HOLD : begin
				for (i = 0; i < 4; i = i + 1) begin
					for (j = 0; j < 4; j = j + 1) begin
						mat[i][j] = mat[i][j];
					end
				end
				fd3 = $fopen("data.mem", "r");
				for(i = 0; i < 4; i = i + 1) begin
					for(j = 0; j < 4; j = j+ 1) begin
						rv3 = $fscanf(fd3, "%h", mat[i][j]);
					end
				end
				flag = 1 ;

				NS = HOLD;
			end
			default : begin
				NS = IDLE;
			end
		endcase
	end

	always @(clk) begin
		if (rst) begin
			PS <= IDLE;
		end
		else begin
			PS <= NS;
		end
	end
endmodule
