
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module ex1_3(
			input  logic [9:0] SW,
			input  logic [1:0] KEY,
			output logic [9:0] LEDR,
			output logic [6:0] HEX0, HEX1, HEX2, HEX3
	);
	wire logic [7:0] X, OUT;
	wire logic [15:0] P;
	assign X = SW[7:0];
	assign LEDR[7:0] = OUT;

	Multiplier  test(.INPUT(X), .EA(SW[9]), .EB(SW[8]), .Product(P),  
						  .clk(~KEY[1]), .reset(~KEY[0]),  .current_value(OUT) );

	Display  out(.hex_in(P), .hex0(HEX0), .hex1(HEX1), .hex2(HEX2), .hex3(HEX3) );
	endmodule