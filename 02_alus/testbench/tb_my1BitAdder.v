`timescale 1ns/1ns

module tb_my1BitAdder();

	reg in1, in2, carryIn;
	wire carryOut, sum;
	
	my1BitAdder UUT(in1, in2, carryIn, sum, carryOut);
	
	initial begin
		in1 = 0; in2 = 0; carryIn = 0;
		#5 in1 = 0; in2 = 0; carryIn = 1;
		#5 in1 = 0; in2 = 1; carryIn = 0;
		#5 in1 = 0; in2 = 1; carryIn = 1;
		#5 in1 = 1; in2 = 0; carryIn = 0;
		#5 in1 = 1; in2 = 0; carryIn = 1;
		#5 in1 = 1; in2 = 1; carryIn = 0;
		#5 in1 = 1; in2 = 1; carryIn = 1;
	end

endmodule