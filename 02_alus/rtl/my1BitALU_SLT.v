/*
* my1BitALU_SLT
* 
* Objective:
* [] MSB ALU that has overflow and MSB set capabilities
*
*/

module my1BitALU_SLT
(
	in1, 
	in2, 
	carryIn, 
	ainvert, 
	binvert, 
	less, 
	op, 
	result, 
	set, 
	overflow
);

	input in1, in2, carryIn, ainvert, binvert, less;
	input [1:0]op;
	output result, set, overflow;
	reg result, set, overflow;
	
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
		set = 0;
		overflow = 0;

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
				set = out3;
				result = out3;
				
				// check overflow 
				if(nIn1 == nIn2) begin //check if sign of nIn1 == sign of nIn2, since nIn1 will always be positive for ADD/SUB operations
					if(carryIn != out4) begin // check that carryIn equals carryOut
						overflow = 1;
					end
				end
			end
			
			2'b11: begin
				result = less;
			end
			
			default: begin
				set = 0;
				result = 0;
			end
		
		endcase
		// print stuff
		//$display("in2 = %d", in2);
	end

endmodule