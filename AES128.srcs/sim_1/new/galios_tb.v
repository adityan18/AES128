`timescale 1ns / 1ps

module galios_tb ();
	reg  [7:0] a,b;
	wire [7:0] r  ;
	reg        rst;

	// div d1 (a,b,r,q);
	galios t1 (a,b,rst,r);

	initial
		begin
			a=8'h02;
			b=8'he0;
			#10 rst=1;
			#10 rst=0;
			a=8'h03;
			b=8'hb4;
			#10 rst=1;
			#10 rst=0;
			a=8'h01;
			b=8'h52;
			#10 rst=1;
			#10 rst=0;
			a=8'h01;
			b=8'hae;
			#10 rst=1;
			#10 rst=0;

			#10 $finish;
		end

endmodule