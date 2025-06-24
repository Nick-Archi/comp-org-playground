module my1BitAdder(in1, in2, carryIn, sum, carryOut);

	input in1, in2, carryIn;
	output carryOut, sum;
	
	wire out1, out2, out3, out4;
	
	// For carryOut portion
	myAND 	And1(in1, in2, out1);
	myAND 	And2(in1, carryIn, out2);
	myAND 	And3(in2, carryIn, out3);
	myOR 	Or1(out1, out2, out4);
	myOR	Or2(out3, out4, carryOut);
	
	// Summation portion
	wire out5, out6, out7, out8, out9;
	wire out10, out11, out12, out13, out14, out15;
	
	myINV 	Inv1(in1, out5);
	myINV 	Inv2(in2, out6);
	myINV	Inv3(carryIn, out7);
	
	myAND 	And4(in1, out6, out8);
	myAND	And5(out8, out7, out9);
	
	myAND 	And6(out5, in2, out10);
	myAND	And7(out10, out7, out11);
	
	myAND	And8(out5, out6, out12);
	myAND	And9(out12, carryIn, out13);
	
	myAND	And10(in1, in2, out14);
	myAND	And11(out14, carryIn, out15);
	
	wire out16, out17;
	
	myOR	Or3(out9, out11, out16);
	myOR	Or4(out13, out15, out17);
	myOR	Or5(out16, out17, sum);

endmodule