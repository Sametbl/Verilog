module frac_diff(
		input  logic [3:0] Frac_A, Frac_B, 
		output logic Co
);
wire logic [7:0] Frac_dif;

// We extend A and B to 8-bit
Full_Adder_8bit    Diff(.a({4'b0000, Frac_A}), .b({4'b0000, Frac_B}), .En(1), .C_in(1), .Sum(Frac_dif) );

assign Co = ~Frac_dif[7];

endmodule
	