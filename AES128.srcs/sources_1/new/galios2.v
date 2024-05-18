`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/09/2024 08:42:40 PM
// Design Name:
// Module Name: galios2
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


module galois2(
    input [7:0] a,
    input [7:0] b,
    input rst,
    output [7:0] p
    );

	reg     [7:0] temp  = 0;
	reg           dummy    ;
	reg     [7:0] ret      ;
	integer       i;
	integer       j    ;
	always@(*)
	begin
		if (rst) temp = 0;
		else
			begin
				for(i=0;i<8;i=i+1)
					begin
						dummy   = temp[7];
						temp[7] = temp[6];
						temp[6] = temp[5];
						temp[5] = temp[4];
						temp[4] = temp[3] ^ dummy;
						temp[3] = temp[2] ^ dummy;
						temp[2] = temp[1];
						temp[1] = temp[0]^dummy;
						temp[0] = dummy;

						for(j=0;j<8;j=j+1)
							begin
								temp[j] = temp[j]^(a[j] & b[8-i-1]);
							end
					end

				ret = temp;
			end
	end

	assign p = ret;
endmodule
