/*
* Update on the my1BitALU component. 
* Adding capabilities to: 
* 	- subtract b from a via 2's complement of b
* 	- a NOR b
*/

module my1BitALUv2(in1, in2, carryIn, ainvert, binvert, op, carryOut, result);

	input in1, in2, carryIn, ainvert, binvert;
	input [1:0]op;
	output carryOut, result;
	reg carryOut, result;
	
	wire out1, out2, out3, out4;
	
	reg nIn1, nIn2;
	wire out5, out6;

	myAND And1(nIn1, nIn2, out1);
	myOR Or1(nIn1, nIn2, out2);
	my1BitAdder _1BitAdder(nIn1, nIn2, carryIn, out3, out4);
	
	myINV Inv1(in1, out5);
	myINV Inv2(in2, out6);
		
	always@(*) begin

		result = 0;
		carryOut = 0;

		nIn1 = in1;
		nIn2 = in2;
		
		if(ainvert) begin
			nIn1 = out5;
		end
		
		if(binvert) begin
			nIn2 = out6;
		end

		case(op)
		
			2'b00: begin
				result = out1;
			end

			2'b01: begin
				result = out2;
			end
			
			2'b10: begin
				result = out3;
				carryOut = out4;
			end
			
			default: begin
				result = 0;
			end
		
		endcase
		// print stuff
		//$display("in2 = %d", in2);
	end

endmodule