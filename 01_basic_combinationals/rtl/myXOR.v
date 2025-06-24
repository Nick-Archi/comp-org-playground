module myXOR(in1, in2, out);

	input in1, in2;
	output out;
	reg out;
	
	always@(in1, in2) begin
		if(in1 == in2)
			begin
				out = 0;
			end
		else
			begin
				out = 1;
			end
	end

endmodule