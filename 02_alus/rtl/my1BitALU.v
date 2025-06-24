module my1BitALU(in1, in2, carryIn, op, carryOut, result);

	input in1, in2, carryIn;
	input [1:0]op;
	output carryOut, result;
	reg carryOut, result;
	
	wire out1, out2, out3, out4;
	
	myAND And1(in1, in2, out1);
	myOR Or1(in1, in2, out2);
	my1BitAdder _1BitAdder(in1, in2, carryIn, out3, out4);
	
	always@(*) begin
	
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
		
	end

endmodule