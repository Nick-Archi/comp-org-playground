`timescale 1 ns / 1 ns

module tb_myXOR();

	reg in1, in2;
	wire out;
	
	myXOR theXOR(in1, in2, out);
	
	initial begin
		in1 = 0; in2 = 0;
		#10 in1 = 0; in2 = 0;
		#10 in1 = 0; in2 = 1;
		#10 in1 = 1; in2 = 0;
		#10 in1 = 1; in2 = 1;
	end
	
endmodule
	