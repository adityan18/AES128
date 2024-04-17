`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07/12/2022 06:25:52 AM
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


module encrypt (
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

	reg [3:0] round                    ;
	reg [7:0] sb       [0:15][0:15]    ;
	reg [7:0] key      [ 0:3][ 0:3]    ;
	reg [7:0] key_final[ 0:3][0:43]    ;
	reg [7:0] temp                  = 0;
	reg [7:0] mat      [ 0:3][ 0:3]    ;
	reg [7:0] mat2     [ 0:3][ 0:3]    ;
	reg [7:0] mix_col  [ 0:3][ 0:3]    ;
	reg [7:0] rcon     [ 0:3][ 0:9]    ;
	reg [7:0] key_col  [ 0:3]          ;


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
		fd0 = $fopen("key.mem", "r");
		for(i = 0; i < 4; i = i + 1) begin
			for(j = 0; j < 4; j = j + 1) begin
				rv0 = $fscanf(fd0, "%h", key[i][j]);
			end
			key_col[i] <= key[i][3];
		end

		fd1 = $fopen("sbox.mem", "r");
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

		fd4 = $fopen("mix_col.mem", "r");
		for(i = 0; i < 4; i = i + 1) begin
			for(j = 0; j < 4; j = j+ 1) begin
				rv4 = $fscanf(fd4, "%h", mix_col[i][j]);
			end
		end
	end

	reg [2:0] PS;
	reg [2:0] NS;

	parameter IDLE       = 0;
	parameter XOR        = 1;
	parameter SUB_BYTES  = 3;
	parameter SHIFT_ROWS = 2;
	parameter MIX_COL_1  = 6;
	parameter MIX_COL_2  = 7;
	parameter MIX_COL_3  = 5;
	parameter HOLD       = 4;

	always @(PS) begin
		case (PS)
			IDLE : begin
				fd3 = $fopen("data.mem", "r");
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
					for(j = 0; j < 4; j = j+ 1) begin
						mat[i][j] = mat[i][j] ^ key[i][j];
					end
				end

				// KEY Generation
				{key_col[0], key_col[1], key_col[2], key_col[3]} = {key[1][3], key[2][3], key[3][3], key[0][3]};

				NS = (round == 10) ? HOLD : SUB_BYTES;
			end
			SUB_BYTES : begin
				for(i = 0; i < 4; i = i + 1) begin
					for(j = 0; j < 4; j = j+ 1) begin
						mat[i][j] = sb[mat[i][j][7:4]][mat[i][j][3:0]];
					end
				end
				// Key Generation

				for (i = 0; i < 4; i = i + 1) begin
					key_col[i] <= sb[key_col[i][7:4]][key_col[i][3:0]];
				end
				NS = SHIFT_ROWS;
			end
			SHIFT_ROWS : begin
				for (i = 0; i < 4; i = i + 1) begin
					{mat[i][0], mat[i][1], mat[i][2], mat[i][3]} = {mat[i][i], mat[i][(i+1)%4], mat[i][(i+2)%4], mat[i][(i+3)%4]};
				end
				// Key Generation
				for (i = 0; i < 4; i = i + 1) begin
					key[i][0] = key[i][0] ^ key_col[i] ^ rcon[i][round];
				end

				for (i = 1; i < 4; i = i + 1) begin
					for (j = 0; j < 4; j = j + 1) begin
						key[j][i] = key[j][i] ^ key[j][i-1];
					end
				end
				round = round + 1;
				NS    = (round == 10) ? XOR : MIX_COL_1;
			end
			MIX_COL_1 : begin
				rst_g = 0;
				for (l=0;l<4;l=l+1)begin
					a[l] = mix_col[kk][l];
					b[l] = mat[l][hh];
				end
				NS <= MIX_COL_2;
			end
			MIX_COL_2 : begin
				rst_g        = 0;
				mat2[kk][hh] = p[0]^p[1]^p[2]^p[3];
				NS           <= MIX_COL_3;
			end
			MIX_COL_3 : begin
				rst_g = 1;
				if (kk == 3 && hh == 3) begin
					NS = XOR;
					for (i = 0; i < 4; i = i + 1) begin
						for (j = 0; j < 4; j = j + 1) begin
							mat[i][j] = mat2[i][j];
						end
					end
				end
				else NS = MIX_COL_1;
				kk = kk+1;
				if(kk==0) hh=hh+1;
			end
			HOLD : begin
				for (i = 0; i < 4; i = i + 1) begin
					for (j = 0; j < 4; j = j + 1) begin
						mat[i][j] = mat[i][j];
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

	always @(key) begin
		for (i = 0; i < 4 ; i = i + 1) begin
			for (j = temp; j < temp + 4; j = j + 1) begin
				key_final[i][j] = key[i][j%4];
			end
		end
		temp <= temp + 4;
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
