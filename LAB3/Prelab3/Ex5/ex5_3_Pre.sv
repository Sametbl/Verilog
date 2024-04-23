module ex5_3_Pre(
		input  logic [9:0] SW,
		output logic [9:0] LEDR
);
assign LEDR[3:0] = SW[3:0];
assign LEDR[9] = SW[9];

sign_bit   test(.Exp_diff(SW[3:0]), .Frac_A(SW[6:4]), .Frac_B(SW[8:7]), .Mode(SW[9]), .SIGN(LEDR[6]) );

endmodule