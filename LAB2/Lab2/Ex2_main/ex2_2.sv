module ex2_2 (
		input  logic [0:0] KEY,
		input  logic [1:0] SW,
		output logic [9:0] LEDR
);
FSM_SV 	test(.clk(~KEY[0]), .reset(~SW[0]), .W(SW[1]), .State(LEDR[3:0]), .Output(LEDR[9]) );

endmodule