/*
* Description:
* [] This file is intended to be a control unit that would dissect an N-bit opcode to produce the 
* necessary control signals for the rest of the computer datapath.
*
* Objective
* [] generate control signals from N-bit instruction
*/
module myControlUnit #(parameter OPCODELEN = 7, parameter ALUOPLEN = 3)
(
	opcode,		// N-bit instruction opcode
	branch,		// branch or not
	memRea,		// memory read
	memToReg, 	// memory to register
	aluOp,		// N-bit operation for ALU
	memWri,		// memory write
	aluSrc,		// operand for ALU from registers or not
	regWri		// perform write to register or not
);

	input[OPCODELEN-1:0] opcode;
	
	output branch, memRea, memToReg, memWri, aluSrc, regWri;
	output[ALUOPLEN-1:0] aluOp;

	// combinational piece of logic...
	always@(*) begin
		// [TODO] implement case statements to check instruction and output necessary signals
	end

endmodule