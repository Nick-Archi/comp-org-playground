`timescale 1ns/1ns

`define assert(sig, val) \
  if ((sig) !== (val)) begin \
    $display("ASSERTION FAILED in %m: %s=%h, expected %h", `"sig`", sig, val); \
    $finish; \
  end

module tb_my1BitALUv3();

	reg in1, in2, ainvert, bnegate, less;
	reg [1:0]op;
	
	wire carryOut, result;
	
	my1BitALUv3 UUT
	(
		.in1 (in1), 
		.in2 (in2), 
		.carryIn (bnegate), 
		.ainvert (ainvert), 
		.binvert (bnegate), 
		.less (less), 
		.op (op), 
		.carryOut (carryOut), 
		.result (result)
	);
		
	initial begin
	// testing a AND b 
	#5  in1 = 0; in2 = 0; ainvert = 0; bnegate = 0; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 0; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 0; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 0; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 1)

	// testing a AND ~b
	#5 	in1 = 0; in2 = 0; ainvert = 0; bnegate = 1; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 1; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 1; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 1; less = 0; op = 0;
	#1 `assert(carryOut, 0) `assert(result, 1)
	
	// testing ~a AND ~b
	#5 	in1 = 0; in2 = 0; ainvert = 1; bnegate = 1; less = 0; op = 0;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 0; in2 = 1; ainvert = 1; bnegate = 1; less = 0; op = 0;
	#5 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 1; in2 = 0; ainvert = 1; bnegate = 1; less = 0; op = 0;
	#5 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 1; in2 = 1; ainvert = 1; bnegate = 1; less = 0; op = 0;
	#5 `assert(carryOut, 0) `assert(result, 0)	

	// testing a OR b 
	#5  in1 = 0; in2 = 0; ainvert = 0; bnegate = 0; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 0; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 0; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 0; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)

	// testing a OR ~b
	#5 	in1 = 0; in2 = 0; ainvert = 0; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	
	// testing ~a OR ~b
	#5 	in1 = 0; in2 = 0; ainvert = 1; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 0; in2 = 1; ainvert = 1; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 0; ainvert = 1; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 1; ainvert = 1; bnegate = 1; less = 0; op = 1;
	#5 `assert(carryOut, 0) `assert(result, 0)	
	
	// testing a + b
	#5 	in1 = 0; in2 = 0; ainvert = 0; bnegate = 0; less = 0; op = 2;
	#5 `assert(carryOut, 0) `assert(result, 0)
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 0; less = 0; op = 2;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 0; less = 0; op = 2;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 0; less = 0; op = 2;
	#5 `assert(carryOut, 1) `assert(result, 0)
	
	// testing a + ~b => (a - b)
	#5 	in1 = 0; in2 = 0; ainvert = 0; bnegate = 1; less = 0; op = 2; // shouldn't make too much sense since can't be a -0...
	#5 `assert(carryOut, 1) `assert(result, 0)
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 1; less = 0; op = 2;
	#5 `assert(carryOut, 0) `assert(result, 1)
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 1; less = 0; op = 2;
	#5 `assert(carryOut, 1) `assert(result, 1)
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 1; less = 0; op = 2;
	#5 `assert(carryOut, 1) `assert(result, 0)

	// I don't think this should be tested, since it'll be mostly undefined behavior? Only complementing 1 bit...
	// testing -a - b
	/*
	#5 	in1 = 0; in2 = 0; ainvert = 0; bnegate = 1; op = 2; // shouldn't make too much sense since can't be a -0...
	#5 	in1 = 0; in2 = 1; ainvert = 0; bnegate = 1; op = 2;
	#5 	in1 = 1; in2 = 0; ainvert = 0; bnegate = 1; op = 2;
	#5 	in1 = 1; in2 = 1; ainvert = 0; bnegate = 1; op = 2;	
	*/

	end

endmodule