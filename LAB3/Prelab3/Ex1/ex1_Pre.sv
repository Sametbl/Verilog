module ex1_Pre(
		input  logic [9:0] SW,
		output logic [9:0] LEDR
);

expo_diff   test(.Exp_A(SW[3:0]), .Exp_B(SW[7:4]), .Exp_diff(LEDR[3:0]), .Final_exp(LEDR[9:7]) );

endmodule