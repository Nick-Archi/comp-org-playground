`timescale 1ns/1ns

module tb_my1BitALU();

	reg in1, in2, carryIn;
	reg [1:0]op;
	
	wire carryOut, result;

	my1BitALU UUT(in1, in2, carryIn, op, carryOut, result);
	
	initial begin

	#5 in1 = 0; in2 = 0; carryIn = 0; op = 0;
	#5 in1 = 0; in2 = 0; carryIn = 1; op = 0;
	#5 in1 = 0; in2 = 1; carryIn = 0; op = 0;
	#5 in1 = 0; in2 = 1; carryIn = 1; op = 0;
	#5 in1 = 1; in2 = 0; carryIn = 0; op = 0;
	#5 in1 = 1; in2 = 0; carryIn = 1; op = 0;
	#5 in1 = 1; in2 = 1; carryIn = 0; op = 0;
	#5 in1 = 1; in2 = 1; carryIn = 1; op = 0;

	#5 in1 = 0; in2 = 0; carryIn = 0; op = 1;	
	#5 in1 = 0; in2 = 0; carryIn = 1; op = 1;
	#5 in1 = 0; in2 = 1; carryIn = 0; op = 1;
	#5 in1 = 0; in2 = 1; carryIn = 1; op = 1;
	#5 in1 = 1; in2 = 0; carryIn = 0; op = 1;
	#5 in1 = 1; in2 = 0; carryIn = 1; op = 1;
	#5 in1 = 1; in2 = 1; carryIn = 0; op = 1;
	#5 in1 = 1; in2 = 1; carryIn = 1; op = 1;
	
	#5 in1 = 0; in2 = 0; carryIn = 0; op = 2;	
	#5 in1 = 0; in2 = 0; carryIn = 1; op = 2;
	#5 in1 = 0; in2 = 1; carryIn = 0; op = 2;
	#5 in1 = 0; in2 = 1; carryIn = 1; op = 2;
	#5 in1 = 1; in2 = 0; carryIn = 0; op = 2;
	#5 in1 = 1; in2 = 0; carryIn = 1; op = 2;
	#5 in1 = 1; in2 = 1; carryIn = 0; op = 2;
	#5 in1 = 1; in2 = 1; carryIn = 1; op = 2;
	
	#5 in1 = 0; in2 = 0; carryIn = 0; op = 3;	
	#5 in1 = 0; in2 = 0; carryIn = 1; op = 3;
	#5 in1 = 0; in2 = 1; carryIn = 0; op = 3;
	#5 in1 = 0; in2 = 1; carryIn = 1; op = 3;
	#5 in1 = 1; in2 = 0; carryIn = 0; op = 3;
	#5 in1 = 1; in2 = 0; carryIn = 1; op = 3;
	#5 in1 = 1; in2 = 1; carryIn = 0; op = 3;
	#5 in1 = 1; in2 = 1; carryIn = 1; op = 3;
	
	end


endmodule