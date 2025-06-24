`timescale 1ns/1ns

module tb_myINV();

	reg in1;
	wire out1;
	
	myINV theINV(in1, out1);
	
	initial begin
		in1 = 0;
		#5 in1 = 0;
		#5 in1 = 1;
	end

endmodule