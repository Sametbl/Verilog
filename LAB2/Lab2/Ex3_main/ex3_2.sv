
	module ex3_2 (
			input  logic [0:0] KEY,
			input  logic [1:0] SW,
			output logic [9:0] LEDR
	);
	// LEDR[3:0] to display sequence of 0's    // Initially HIGH
	// LEDR[7:4] to display sequence of 1's    // Initially LOW
	sequence_detect	test(.clk(~KEY[0]), .reset(~SW[0]), .W(SW[1]),
								  .zero(LEDR[3:0]), .one(LEDR[7:4]), .Z(LEDR[9]) );
								  

	endmodule