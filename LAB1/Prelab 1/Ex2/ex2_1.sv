module ex2_1(
		input  logic [9:0] SW,
		input  logic [1:0] KEY,
		output logic [9:0] LEDR,
		output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4
);
initial begin 
			X = 0;
			Y = 0;
			OUTPUT = 0;
end

wire logic [15:0] OUTPUT, temp;
wire logic [7:0] X, Y;

assign X = ~SW[9] & ~KEY[0] ? SW[7:0] : X;
assign Y =  SW[9] & ~KEY[0] ? SW[7:0] : Y;
assign LEDR[7:0] = SW[9] ? Y: X;
assign LEDR[9]   = SW[9];
assign temp = ~KEY[1] ? OUTPUT: temp;

Byte_multiplier  test(.A(X),  .B(Y),  .Result(OUTPUT) );

Display  out(.binary(temp),  .hex0(HEX0),  .hex1(HEX1), .hex2(HEX2), .hex3(HEX3), .hex4(HEX4) );

endmodule