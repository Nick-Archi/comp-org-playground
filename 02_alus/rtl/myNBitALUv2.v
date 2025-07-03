/*
* Objective:
* [] Combine 1BitALU units together to make a N bit ALU
* [] MSB ALU will be specialized to determine overflow and SLT operations
* [] Modifications to test for equality after less operation
*/

/*
* in1, 1st N bit input
* in2, 2nd N bit input
* ainvert, 1 bit set to invert the value of 1st input (in1)
* bnegate, 1 bit set to invert the value of 2nd input (in2) and also act as the CarryIn
* op, 2 bit value to indicate operation to perform
* carryOut, 1 bit to indicate carryOut after operations
* result, N bit output
*
* op: 0 (and), 1 (or), 2 (addition, subtraction), 3 (less), else (result = 0)
* to perform subtraction, invert2 needs to be set, and carryIn = 1 so it would be, in1 + (~in2 + 1) (two's complement)
*/
module myNBitALUv2 #(parameter WIDTH = 32) 
(
	in1, 
	in2,  
	ainvert, 
	bnegate, 
	op, 
	result,
	overflow,
	zero
);

	input[WIDTH-1:0] in1, in2;
	input ainvert, bnegate;
	input[1:0] op;
	
	wire set;
	
	output overflow, zero;
	output [WIDTH-1:0] result;
	
	wire[WIDTH:0] carry; // used to simulate chained carry between ALUs
	// cannot be reg because this is being driven by the output from instantiated modules

	/*
	* This generate block will instantiate each 1 bit ALU. Tying
	* each 1 bit input/output to its respective value.
	* The carryIn and carryOut may be a little tricky. 
	* carryIn[0] <- initial carryIn into overall ALU structure.
	* carryOut[0] -> carryIn[1] based on HW design
	*/
	generate
		genvar i;
		for(i = 0; i < WIDTH - 1; i = i + 1) begin : ALU
			my1BitALUv3 alu
			(
				.in1 (in1[i]),
				.in2 (in2[i]),
				.carryIn (carry[i]), // input gathered from carry[]				
				.ainvert (ainvert),
				.binvert (carry[i]),
				.less (i == 0 ? set : 1'b0), // conditional to set the less input of the 1st ALU to the output of the set from the MSB ALU
				.op (op), // all ALUs can see the same op
				.carryOut (carry[i+1]), // output written to carryIn of next ALU
				.result (result[i])
			);
		end
	endgenerate
	
	// create the MSB ALU for overflow, less, and set capabilities
	my1BitALU_SLT msb_ALU
	(
		.in1 (in1[WIDTH - 1]), 				
		.in2 (in2[WIDTH - 1]), 
		.carryIn (carry[WIDTH - 1]), 
		.ainvert (ainvert), 
		.binvert (bnegate), 
		.less (1'b0), // less is tied off
		.op (op), 
		.result (result[WIDTH-1]), 
		.set (set), 
		.overflow (overflow)
	);
	
	assign carry[0] = bnegate; // grab the initial 1 bit carryIn from top module
	assign zero = (result == 0) ? 1 : 0; // shortcut...because I'm not about to create all these OR gates and do this...
	
endmodule

/*
NOTES:
A lot of the stuff in here, I've never done in the graduate courese I took in university. 
* repetition based building and chaining of 1 bit ALUs 
* using parameterized variables 
*/