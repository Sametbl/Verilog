module Adder(
		input  logic [9:0] SW,
		output logic [9:0] LEDR,
		output logic [6:0] HEX0, HEX1, HEX2
);

wire logic [5:0] SUM;

Full_Adder_Nbit #(5) test(.A(SW[4:0]), .B(SW[9:5]), .Sum(SUM[4:0]), .C_out(SUM[5]), .En(0) );

Display  out(.binary(SUM), .hex0(HEX0), .hex1(HEX1), .hex2(HEX2) );

endmodule