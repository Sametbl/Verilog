module ex3_2 (
		input  logic [3:0] KEY,
		input  logic [0:0] SW,
		output logic [3:0] LEDR
);

Shift_register_4bit		test(.clk(~KEY[3]), .reset(~KEY[0]), .IN(SW[0]), .L(LEDR[3:0]) );

endmodule