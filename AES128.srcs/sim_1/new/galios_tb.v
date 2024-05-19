`timescale 1ns / 1ps

module galios_tb ();
	reg  [7:0] a,b;
	wire [7:0] r  ;
	reg        rst;

	// div d1 (a,b,r,q);
	galois t1 (a,b,rst,r);
/*db c7 52 ae*/
	initial
		begin
			a=8'h02;
			b=8'he0; //db
			#10 rst=1;
			#10 rst=0;
			a=8'h02;
			b=8'hb4; //d6 73
			#10 rst=1;
			#10 rst=0;
			a=8'h03;
			b=8'hb4; //83 c7
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
			a=8'h03;
			b=8'hae; //e9
			#10 rst=1;
			#10 rst=0;
			a=8'h01;
			b=8'hae; //95 ae
			#10 rst=1;
			#10 rst=0;
			a=8'h03;
			b=8'he0; // d0 3b
			#10 rst=1;
			#10 rst=0;
			a=8'h03;
			b=8'h1e; // 22
			#10 rst=1;
			#10 rst=0;
			a=8'h03;
			b=8'hd4; // 67
			#10 rst=1;

			#10 $finish;
		end

endmodule