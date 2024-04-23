module Mux_2X1_8bit_OH(
		input  logic [1:0] Sel,
		input  logic [7:0] X, Y,
		output logic [7:0] I_out
);

Mux_2X1_onehot		Mux1 (.Sel(Sel), .a(X[0]), .b(Y[0]), .OUT(I_out[0]));
Mux_2X1_onehot		Mux2 (.Sel(Sel), .a(X[1]), .b(Y[1]), .OUT(I_out[1]));
Mux_2X1_onehot		Mux3 (.Sel(Sel), .a(X[2]), .b(Y[2]), .OUT(I_out[2]));
Mux_2X1_onehot		Mux4 (.Sel(Sel), .a(X[3]), .b(Y[3]), .OUT(I_out[3]));
Mux_2X1_onehot		Mux5 (.Sel(Sel), .a(X[4]), .b(Y[4]), .OUT(I_out[4]));
Mux_2X1_onehot		Mux6 (.Sel(Sel), .a(X[5]), .b(Y[5]), .OUT(I_out[5]));
Mux_2X1_onehot		Mux7 (.Sel(Sel), .a(X[6]), .b(Y[6]), .OUT(I_out[6]));
Mux_2X1_onehot		Mux8 (.Sel(Sel), .a(X[7]), .b(Y[7]), .OUT(I_out[7]));

endmodule