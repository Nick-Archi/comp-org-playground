`timescale 1ns/1ns

`define assert(act, exp) \
	if(act != exp) begin \
		$display("ASSERT FAILED %m: Actual = %h , Expect = %h", act, exp); \
		$finish; \
	end

module tb_myNBitALUv2 #(parameter WIDTH = 32)();

	reg[WIDTH-1:0] in1, in2;
	reg ainvert, bnegate;
	reg[1:0] op;
	
	wire carryOut;
	wire[WIDTH-1:0] result;
	wire overflow, zero;
	
	myNBitALUv2 #(.WIDTH(WIDTH)) UUT
	(
		.in1(in1), 
		.in2(in2), 
		.ainvert(ainvert), 
		.bnegate(bnegate), 
		.op(op), 
		.result(result),
		.overflow(overflow),
		.zero(zero)
	);
	
	initial begin
	
	// AND testing
	#5 in1 = 32'h00000000; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b00;
	#5 `assert(result, 32'h00000000) `assert(overflow, 0) `assert(zero, 1)
	#5 in1 = 32'h00000001; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b00;
	#5 `assert(result, 32'h00000001) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; ainvert = 0; bnegate = 0; op = 2'b00;
	#5 `assert(result, 32'h0000000A) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h7FFFFFFE; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b00;
	#5 `assert(result, 32'h00000000) `assert(overflow, 0) `assert(zero, 1)
	#5 in1 = 32'hFFFFFFFF; in2 = 32'hA0A0A0A0; ainvert = 0; bnegate = 0; op = 2'b00;
	#5 `assert(result, 32'hA0A0A0A0) `assert(overflow, 0) `assert(zero, 0)
	
	// OR testing
	#5 in1 = 32'h00000000; in2 = 32'h00000000; ainvert = 0; bnegate = 0; op = 2'b01;
	#5 `assert(result, 32'h00000000) `assert(overflow, 0) `assert(zero, 1)
	#5 in1 = 32'h00000001; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b01;
	#5 `assert(result, 32'h00000001) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; ainvert = 0; bnegate = 0; op = 2'b01;
	#5 `assert(result, 32'h0000000F) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h7FFFFFFE; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b01;
	#5 `assert(result, 32'h7FFFFFFF) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h7FFFFFFE; in2 = 32'hA0A0A0A0; ainvert = 0; bnegate = 0; op = 2'b01;
	#5 `assert(result, 32'hFFFFFFFE) `assert(overflow, 0) `assert(zero, 0)
	
	// ADD testing
	#5 in1 = 32'h00000000; in2 = 32'h00000000; ainvert = 0; bnegate = 0; op = 2'b10;
	#5 `assert(result, 32'h00000000) `assert(overflow, 0) `assert(zero, 1)
	#5 in1 = 32'h00000001; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b10;
	#5 `assert(result, 32'h00000002) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; ainvert = 0; bnegate = 0; op = 2'b10;
	#5 `assert(result, 32'h00000019) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h7FFFFFFE; in2 = 32'h00000001; ainvert = 0; bnegate = 0; op = 2'b10;
	#5 `assert(result, 32'h7FFFFFFF) `assert(overflow, 0) `assert(zero, 0)
	#5 in1 = 32'h7FFFFFFE; in2 = 32'hA0A0A0A0; ainvert = 0; bnegate = 0; op = 2'b10;
	#5 `assert(result, 32'hFFFFFFFE) `assert(overflow, 1) `assert(zero, 0)	
	
	end

endmodule