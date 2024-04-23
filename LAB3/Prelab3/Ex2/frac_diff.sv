module frac_diff(
		input  logic [3:0] Frac_A, Frac_B, Exp_diff,
		output logic [3:0] Bigger_Frac, Smaller_Frac
);
wire logic [4:0] Fraction_diff;
wire logic same_expo;
assign same_expo = ~(Exp_diff[0] | Exp_diff[1] | Exp_diff[2] | Exp_diff[3]); 

Full_Adder_5bit  frac(.A(Frac_A), .B(Frac_B), .En(1), .Sum(Fraction_diff) );


assign Bigger_Frac = same_expo ? (Fraction_diff[4] ? Frac_B : Frac_A) :
										   (Exp_diff[3] ? Frac_B : Frac_A);
											
assign Smaller_Frac = same_expo ? (Fraction_diff[4] ? Frac_A : Frac_B) :
										   (Exp_diff[3] ? Frac_A : Frac_B);

endmodule
	