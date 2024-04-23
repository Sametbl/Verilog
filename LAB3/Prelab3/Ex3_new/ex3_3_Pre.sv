module ex3_3_Pre(
		input  logic [9:0] SW,
		input  logic CLOCK_50,
		output logic [9:0] LEDR
);
assign LEDR[3:0] = SW[3:0];
S_frac_shift		test(.S_fract(SW[3:0]), .Exp_diff(SW[7:4]), .clk_50(CLOCK_50),
							  .Shifted_fract(LEDR[9:4]), .reset(SW[9]) );

endmodule 