module myINV(in1, out1);

	input in1;
	output out1;
	reg out1;
	
	always@(in1) begin
		if(in1) begin
			out1 = 0;
		end
		else begin
			out1 = 1;
		end
	end

endmodule