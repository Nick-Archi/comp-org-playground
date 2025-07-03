`timescale 1ns/1ns

`define assert(act, exp) \
	if((act) !== (exp)) begin \
		$display("ASSERTION FAILED (%m): Expected = %h, Actual = %h\n", exp, act); \
		$finish; \
	end
	
module tb_my1BitALU_SLT();

	reg in1, in2, carryIn, ainvert, binvert, less;
	reg [1:0]op;
	wire result, set, overflow;

	my1BitALU_SLT UUT
	(
		.in1 (in1), 
		.in2 (in2), 
		.carryIn (carryIn), 
		.ainvert (ainvert), 
		.binvert (binvert), 
		.less (less), 
		.op (op), 
		.result (result), 
		.set (set), 
		.overflow (overflow)
	);
	
	initial begin
		/* Test AND functionality */
		#5 in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 0;
		#1 `assert(result, 0)
		#5 in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 0;
		#1 `assert(result, 0)
		#5 in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 0;
		#1 `assert(result, 0)
		#5 in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 0;
		#1 `assert(result, 1)
		
		/* Test OR functionality */
		#5 in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 1;
		#1 `assert(result, 0)
		#5 in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 1;
		#1 `assert(result, 1)
		#5 in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 1;
		#1 `assert(result, 1)
		#5 in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 1;
		#1 `assert(result, 1)
		
		/* Test ADD functionality */
		#5 in1 = 0; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 0) `assert(overflow, 0)
		#5 in1 = 0; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 1) `assert(overflow, 0)
		#5 in1 = 1; in2 = 0; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 1) `assert(overflow, 0)
		// (-)in1 + (-)in2 giving overflow, ex) 1001 + 1001 (-7) + (-7)
		#5 in1 = 1; in2 = 1; carryIn = 0; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 0) `assert(overflow, 1)
		
		/* Test ADD & overflow functionality */
		#5 in1 = 0; in2 = 0; carryIn = 1; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 1) `assert(overflow, 1)
		#5 in1 = 0; in2 = 1; carryIn = 1; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 0) `assert(overflow, 0)
		#5 in1 = 1; in2 = 0; carryIn = 1; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 0) `assert(overflow, 0)
		#5 in1 = 1; in2 = 1; carryIn = 1; ainvert = 0; binvert = 0; less = 0; op = 2;
		#1 `assert(result, 1) `assert(overflow, 0)
		
		/* Test SUB & overflow functionality */
		#5 in1 = 0; in2 = 0; carryIn = 1; ainvert = 0; binvert = 1; less = 0; op = 2;
		#1 `assert(result, 0) `assert(overflow, 0)
		// (+)in1 - (-)in2, ex) 7 - (-)7
		#5 in1 = 0; in2 = 1; carryIn = 1; ainvert = 0; binvert = 1; less = 0; op = 2;
		#1 `assert(result, 1) `assert(overflow, 1)
		#5 in1 = 1; in2 = 0; carryIn = 1; ainvert = 0; binvert = 1; less = 0; op = 2;
		#1 `assert(result, 1) `assert(overflow, 0)
		// (-)in1 - (-)in2
		#5 in1 = 1; in2 = 1; carryIn = 1; ainvert = 0; binvert = 1; less = 0; op = 2;
		#1 `assert(result, 0)	`assert(overflow, 0)
		
	end

endmodule