/*
* Objective:
* [] Combine 1BitALU units together to make a N bit ALU
*/

/*
* in1, 1st N bit input
* in2, 2nd N bit input
* carryIn, 1 bit value used for two's complement of in2 during subraction
* invert1, 1 bit set to invert the value of 1st input (in1)
* invert2, 1 bit set to invert the value of 2nd input (in2)
* op, 2 bit value to indicate operation to perform
* carryOut, 1 bit to indicate carryOut after operations
* result, N bit output
*
* op: 0 (and), 1 (or), 2 (addition, subtraction), else (result = 0)
* to perform subtraction, invert2 needs to be set, and carryIn = 1 so it would be, in1 + (~in2 + 1) (two's complement)
*/
module myNBitALU #(parameter WIDTH = 32) 
(
	in1, 
	in2, 
	carryIn, 
	invert1, 
	invert2, 
	op, 
	carryOut, 
	result
);

	input[WIDTH-1:0] in1, in2;
	input carryIn, invert1, invert2;
	input[1:0] op;
	
	output carryOut;
	output [WIDTH-1:0] result;
	
	wire[WIDTH:0] carry; // used to simulate chained carry between ALUs
	// cannot be reg because this is being driven by the output from instantiated modules

	// start intantiating the 1bit ALUs needed
	/*
	* This generate block will instantiate each 1 bit ALU. Tying
	* each 1 bit input/output to its respective value.
	* The carryIn and carryOut may be a little tricky. 
	* carryIn[0] <- initial carryIn into overall ALU structure.
	* carryOut[0] -> carryIn[1] based on HW design
	*/
	generate
		for(genvar i = 0; i < WIDTH; i = i + 1) begin : ALU
			my1BitALUv2 alu
			(
				.in1 (in1[i]),
				.in2 (in2[i]),
				.carryIn (carry[i]), // input gathered from carry[]
				.ainvert (invert1),
				.binvert (invert2),
				.op (op), // all ALUs can see the same op
				.carryOut (carry[i+1]), // output written to carry[]
				.result (result[i])
			);
		end
	endgenerate
	
	assign carry[0] = carryIn; // grab the initial 1 bit carryIn from top module
	assign carryOut = carry[WIDTH]; // ensure that carryOut and carry are wires
	
	/* // TODO: Remove eventually...since now using totally combinational logic
	always@(in1, in2, carryIn, invert1, invert2, carry, op) begin
		/* 
		* ex) WIDTH initially 32, WIDTH - 1 = 31, the 31st bit is used to detect if 
		* overflow occurred during signed calculations
		*/
		//carryOut = carry[WIDTH-1]; // I Guess ideally, this wouldn't really be separate and the upper logic should 
		// do it's best to analyze what the carryOut was set to?
		// todo: might be able to do something like carryOut = ALU[WIDTH].carryOut or something?

	//end
	
	
endmodule

/*
NOTES:
A lot of the stuff in here, I've never done in the graduate courese I took in university. 
* repetition based building and chaining of 1 bit ALUs 
* using parameterized variables 
*/