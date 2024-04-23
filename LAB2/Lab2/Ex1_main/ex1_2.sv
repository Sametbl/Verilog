
	module ex1_2 (
			input  logic [3:0] KEY,
			input  logic [1:0] SW,
			output logic [9:0] LEDR
	);
	// Reset switch is ACTIVE_LOW, therefore we inverted SW0
	FSM_ex1_FF			test(.clk(~KEY[0]), .reset(~SW[0]), .W(SW[1]),
								  .PreState(LEDR[8:0]), .Output(LEDR[9]) );

	endmodule