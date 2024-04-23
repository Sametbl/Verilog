module ex2_3_Pre(
		input  logic [9:0] SW,
		output logic [9:0] LEDR
);

frac_diff	test(.Frac_A(SW[3:0]), .Frac_B(SW[7:4]), .Exp_diff({SW[9],{3{SW[8]}}}),
					  .Bigger_Frac(LEDR[9:6]), .Smaller_Frac(LEDR[3:0]) );
					  
endmodule