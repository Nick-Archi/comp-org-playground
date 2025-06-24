`timescale 1ns/1ns

module tb_my1BitALUv2();

	reg in1, in2, carryIn, ainvert, binvert;
	reg [1:0]op;
	
	wire carryOut, result;
	
	my1BitALUv2 UUT(in1, in2, carryIn, ainvert, binvert, op, carryOut, result);
	
	
	initial begin
	// testing a AND b 
	#5  in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; op = 0;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; op=0;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; op=0;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; op=0;

	// testing a AND ~b
	#5 	in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 1; op = 0;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 1; op = 0;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 1; op = 0;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 1; op = 0;
	
	// testing ~a AND ~b
	#5 	in1 = 0; in2 = 0; carryIn = 0; ainvert = 1; binvert = 1; op = 0;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 1; binvert = 1; op = 0;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 1; binvert = 1; op = 0;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 1; binvert = 1; op = 0;	

	// testing a OR b 
	#5  in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; op = 1;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; op = 1;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; op = 1;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; op = 1;

	// testing a OR ~b
	#5 	in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 1; op = 1;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 1; op = 1;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 1; op = 1;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 1; op = 1;
	
	// testing ~a OR ~b
	#5 	in1 = 0; in2 = 0; carryIn = 0; ainvert = 1; binvert = 1; op = 1;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 1; binvert = 1; op = 1;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 1; binvert = 1; op = 1;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 1; binvert = 1; op = 1;	
	
	// testing a + b
	#5 	in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; op = 2;	
	#5 	in1 = 0; in2 = 0; carryIn = 1; ainvert = 0; binvert = 0; op = 2;
	#5 	in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; op = 2;
	#5 	in1 = 0; in2 = 1; carryIn = 1; ainvert = 0; binvert = 0; op = 2;
	#5 	in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; op = 2;
	#5 	in1 = 1; in2 = 0; carryIn = 1; ainvert = 0; binvert = 0; op = 2;
	#5 	in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; op = 2;
	#5 	in1 = 1; in2 = 1; carryIn = 1; ainvert = 0; binvert = 0; op = 2;
	
	// testing a + ~b => (a - b)
	#5 	in1 = 0; in2 = 0; carryIn = 1; ainvert = 0; binvert = 1; op = 2; // shouldn't make too much sense since can't be a -0...
	#5 	in1 = 0; in2 = 1; carryIn = 1; ainvert = 0; binvert = 1; op = 2;
	#5 	in1 = 1; in2 = 0; carryIn = 1; ainvert = 0; binvert = 1; op = 2;
	#5 	in1 = 1; in2 = 1; carryIn = 1; ainvert = 0; binvert = 1; op = 2;

	// I don't think this should be tested, since it'll be mostly undefined behavior? Only complementing 1 bit...
	// testing -a - b
	/*
	#5 	in1 = 0; in2 = 0; carryIn = 1; ainvert = 0; binvert = 1; op = 2; // shouldn't make too much sense since can't be a -0...
	#5 	in1 = 0; in2 = 1; carryIn = 1; ainvert = 0; binvert = 1; op = 2;
	#5 	in1 = 1; in2 = 0; carryIn = 1; ainvert = 0; binvert = 1; op = 2;
	#5 	in1 = 1; in2 = 1; carryIn = 1; ainvert = 0; binvert = 1; op = 2;	
	*/

	end

endmodule