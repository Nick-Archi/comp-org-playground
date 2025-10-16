/*
* Description:
* [] This file is intended to be the implementation of a register file that would provide
* operations to read and write values to essentially an array of memory.
*
* Objective
* [] read, write operations
* [] register 0 is special register that only returns 0
*/
module myRegFile #(parameter WIDTH = 32, parameter NUMOFREGS = 32)
(
	clk,
	regWrite,	// write enable	
	rreg1, 		// read reg1
	rreg2, 		// read reg2
	wreg, 		// write reg
	wdata,		// data to write to reg
	rdata1, 	// data from reg1
	rdata2		// data from reg2
);

	input[$clog2(NUMOFREGS)-1:0] rreg1, rreg2, wreg;
	input[WIDTH-1:0] wdata;
	input clk, regWrite;
	
	output reg[WIDTH-1:0] rdata1, rdata2;
	
	// internal memory for the registers
	reg[WIDTH-1:0] mem[0:(NUMOFREGS-1)];
	
	// combinational logic for reading from register
	always@(*) begin
		if(rreg1 == 0) begin
			rdata1 = 0;
		end
		else begin
			rdata1 = mem[rreg1];
		end
		
		if(rreg2 == 0) begin
			rdata2 = 0;
		end
		else begin
			rdata2 = mem[rreg2];
		end
	end
	
	// sequential update for writes
	always@(posedge clk) begin
		mem[0] <= 0;
		if(regWrite && (wreg != 0)) begin
			mem[wreg] <= wdata;
		end
	end

endmodule