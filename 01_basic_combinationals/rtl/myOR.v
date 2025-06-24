module myOR(in1, in2, out1);

	input in1, in2;
	output out1;
	reg out1;
	
	always@(in1, in2) begin
		if(in1 == 0) begin
			if(in2 == 0) begin
				out1 = 0;
			end
			
			else begin
				out1 = 1;
			end
		end
		
		else begin
			out1 = 1;
		end
	end

endmodule