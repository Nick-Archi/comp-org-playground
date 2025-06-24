`timescale 1ns/1ns

module tb_myNBitALU #(parameter WIDTH = 32)();

	reg[WIDTH-1:0] in1, in2;
	reg carryIn, invert1, invert2;
	reg[1:0] op;
	
	wire carryOut;
	wire[WIDTH-1:0] result;
	
	myNBitALU #(.WIDTH(WIDTH)) UUT
	(
		.in1(in1),
		.in2(in2),
		.carryIn(carryIn),
		.invert1(invert1),
		.invert2(invert2),
		.op(op),
		.carryOut(carryOut),
		.result(result)
	);
	
	initial begin
	
	// AND testing
	#5 in1 = 32'h00000000; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b00;
	#5 in1 = 32'h00000001; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b00;
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b00;
	#5 in1 = 32'h7FFFFFFE; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b00;
	#5 in1 = 32'hFFFFFFFF; in2 = 32'hA0A0A0A0; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b00;
	
	// OR testing
	#5 in1 = 32'h00000000; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b01;
	#5 in1 = 32'h00000001; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b01;
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b01;
	#5 in1 = 32'h00000000; in2 = 32'hA0B0C0D0; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b01;
	#5 in1 = 32'h0FFFFFFF; in2 = 32'hF0000000; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b01;
	
	// Addition testing
	#5 in1 = 32'h00000000; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b10;
	#5 in1 = 32'h00000001; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b10;
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b10;
	#5 in1 = 32'h00000000; in2 = 32'h00000001; carryIn = 1; invert1 = 0; invert2 = 0; op = 2'b10;
	#5 in1 = 32'h7FFFFFFF; in2 = 32'h00000000; carryIn = 1; invert1 = 0; invert2 = 0; op = 2'b10; // overflow test
	#5 in1 = 32'h7FFFFFFF; in2 = 32'h00000001; carryIn = 0; invert1 = 0; invert2 = 0; op = 2'b10; // overflow test
	
	// subtraction testing (in1 - in2)
	#5 in1 = 32'h00000000; in2 = 32'h00000000; carryIn = 1; invert1 = 0; invert2 = 1; op = 2'b10;
	#5 in1 = 32'h0000000A; in2 = 32'h00000002; carryIn = 1; invert1 = 0; invert2 = 1; op = 2'b10;
	#5 in1 = 32'h0000000A; in2 = 32'h00000004; carryIn = 1; invert1 = 0; invert2 = 1; op = 2'b10;
	#5 in1 = 32'h0000FFFA; in2 = 32'h0000000A; carryIn = 1; invert1 = 0; invert2 = 1; op = 2'b10;
	#5 in1 = 32'hFFFFFFFF; in2 = 32'h00000001; carryIn = 1; invert1 = 0; invert2 = 1; op = 2'b10;
	
	// Inverted in1 AND in2 testing (NOR)
	#5 in1 = 32'h00000000; in2 = 32'h00000001; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b00;
	#5 in1 = 32'h00000001; in2 = 32'h00000001; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b00;
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b00;
	#5 in1 = 32'h7FFFFFFE; in2 = 32'h00000001; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b00;
	#5 in1 = 32'hFFFFFFFF; in2 = 32'hA0A0A0A0; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b00;
	
	// Inverted in1 OR in2 testing (NAND)
	#5 in1 = 32'h00000000; in2 = 32'h00000001; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b01;
	#5 in1 = 32'h00000001; in2 = 32'h00000001; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b01;
	#5 in1 = 32'h0000000F; in2 = 32'h0000000A; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b01;
	#5 in1 = 32'h00000000; in2 = 32'hA0B0C0D0; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b01;
	#5 in1 = 32'h0FFFFFFF; in2 = 32'hF0000000; carryIn = 0; invert1 = 1; invert2 = 1; op = 2'b01;	
	
	end

endmodule