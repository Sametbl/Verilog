module expo_diff(
		input  logic [2:0] Exp_A, Exp_B,   // both are unsigned 
		output logic [3:0] Exp_diff,
		output logic Same_exp, Co     // C_out = 1, choose A (Exp_A > Exp_B)
);

// A and B are 3 bit unsigned number
// so we used a 4-bit full adder with an additional bit for the sign
Full_Adder_4bit  diff(.A({1'b0, Exp_A}), .B({1'b0, Exp_B}), .En(1), .C_in(1), .Sum(Exp_diff[3:0]) );

assign Co = ~Exp_diff[3];

Comparator_4bit 		check(.A({1'b0, Exp_A}), .B({1'b0, Exp_B}), .Same(Same_exp) );

endmodule


