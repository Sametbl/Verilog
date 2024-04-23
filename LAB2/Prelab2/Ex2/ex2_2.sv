module ex2_2 (
		input  logic [3:0] KEY,
		input  logic [0:0] SW,
		output logic [9:0] LEDR
);

ex2_Pre_SV 	test(.clk(~KEY[3]), .reset(~KEY[0]), .W(SW[0]), .State(LEDR[3:0]), .Output(LEDR[9]) );

endmodule