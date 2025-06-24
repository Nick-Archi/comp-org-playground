`timescale 1ns/1ns

module tb_myAND();

	reg in1, in2;
	wire out1;

	myAND UUT(in1, in2, out1);
	
	initial begin
		in1 = 0; in2 = 0;
		#5 in1 = 0; in2 = 0;
		#5 in1 = 0; in2 = 1;
		#5 in1 = 1; in2 = 0;
		#5 in1 = 1; in2 = 1;
	end
endmodule