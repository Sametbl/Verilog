
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module ex1_1(
			input  logic [7:0] SW,
			input  logic [1:0] KEY,
			output logic [9:0] LEDR,
			output logic [6:0] HEX0, HEX1, HEX2, HEX3
	);
	wire logic [7:0] A, S;
	assign A = SW[7:0];
	assign LEDR[7:0] = S;

	accumulator  test(.A(A), .S(S),  .carry(LEDR[8]),  .overflow(LEDR[9]),
							.clk(~KEY[1]), .reset(~KEY[0]) );
							
	// Displaying result S and input A on 7 segments display
	Display		 out(.hex_in_A(A), .hex_in_S(S), .hex0(HEX0), .hex1(HEX1), .hex2(HEX2), .hex3(HEX3) );
	endmodule 