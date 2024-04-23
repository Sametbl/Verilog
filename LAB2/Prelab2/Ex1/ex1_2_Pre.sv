module ex1_2_Pre (
		input  logic [3:0] KEY,
		input  logic [0:0] SW,
		output logic [9:0] LEDR
);

ex1_Pre_FF 	test(.clk(~KEY[3]), .reset(~KEY[0]), .W(SW[0]), .PreState(LEDR[8:0]), .Output(LEDR[9]) );

endmodule