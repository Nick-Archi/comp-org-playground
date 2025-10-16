`timescale 1ns/1ns 

`define assert(act, exp) \
	if(act != exp) begin \
		$display("ASSERT FAILED %m: Actual = %h , Expect = %h", act, exp); \
		$finish; \
	end

module tb_myRegFile #(parameter WIDTH = 32, parameter NUMOFREGS = 32)();

	reg clk, regWrite;
	reg[$clog2(NUMOFREGS)-1:0] rreg1, rreg2, wreg;
	reg[WIDTH-1:0] wdata;
	
	wire[WIDTH-1:0] rdata1, rdata2;
	
	myRegFile #(.WIDTH(WIDTH), .NUMOFREGS(NUMOFREGS)) UUT
	(
		.clk(clk),
		.regWrite(regWrite),
		.rreg1(rreg1), 
		.rreg2(rreg2), 
		.wreg(wreg),
		.wdata(wdata),
		.rdata1(rdata1),
		.rdata2(rdata2)
	);
	
	// setup test vectors
	integer i, val;
	reg[WIDTH-1:0] test_vector[NUMOFREGS-1:0];
	
	/*
		Proposed Test Cases:
		[] Test that all registers can contain values
		[] Test that written values are in correct registers
	*/
	
	initial begin
		val = 32'hFFFFFFFF;
		for(i = 0; i < NUMOFREGS; i = i + 1) begin
			test_vector[i] = val;
			val = (val >> 1);
		end
	end
	
	// signal setup
	initial begin
		i = 0;
		clk = 0;
		regWrite = 0;
		rreg1 = 0;
		rreg2 = 0;
		wreg = 0;
	end
	
	always begin
		#2 clk = ~clk;
	end
	
	initial begin
		// test writes
		regWrite = 1;
		for(i = 0; i < NUMOFREGS; i = i + 1) begin
			wreg = i;
			wdata = test_vector[i];
			#4;
		end
		
		// test reads
		regWrite = 0;
		for(i = 0; i < NUMOFREGS; i = i + 1) begin
			rreg1 = i;
			rreg2 = 31 - i;
			
			#0; // allow delta cycles to stablize before checking output
			// asserts
			if(i == 0) begin
				`assert(rdata1, 0)
			end
			else begin
				`assert(rdata1, test_vector[i])
			end			
		end		
	end
	
endmodule