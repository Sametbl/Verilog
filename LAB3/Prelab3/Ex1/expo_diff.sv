
	module expo_diff(
			input  logic [2:0] Exp_A, Exp_B,   // both are unsigned 
			output logic [3:0] Exp_diff,
			output logic [2:0] Final_exp
	);
	// Exp_diff = A - B, if Exp_diff[3] = 1, B > A
	// A and B are 3 bit unsigned number
	// so I used a 4-bit full adder with an additional bit for the sign
	Full_Adder_Subtractor_4bit  diff(.A(Exp_A), .B(Exp_B), .En(1), .Sum(Exp_diff[3:0]) );


	wire logic [2:0] select;
	assign select = { 3{Exp_diff[3]} }; // For decide the Larger exponent

	assign Final_exp = (Exp_B & select) | (Exp_A & ~select);
	endmodule
	
	
	