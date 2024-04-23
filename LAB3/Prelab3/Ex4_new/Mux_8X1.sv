module Mux_8X1(
	 input  logic [2:0] Sel,
	 input  logic In0, In1, In2, In3, In4, In5, In6, In7,
	 output logic Output
);
wire logic Layer1_1, Layer1_2, Layer1_3, Layer1_4;
wire logic Layer2_1, Layer2_2; 

Mux_2X1		LXX_1(.Sel(Sel[0]), .a(In0), .b(In1), .OUT(Layer1_1));
Mux_2X1		LXX_2(.Sel(Sel[0]), .a(In2), .b(In3), .OUT(Layer1_2));
Mux_2X1		LXX_M(.Sel(Sel[1]), .a(Layer1_1), .b(Layer1_2), .OUT(Layer2_1));

Mux_2X1		HXX_3(.Sel(Sel[0]), .a(In4), .b(In5), .OUT(Layer1_3));
Mux_2X1		HXX_4(.Sel(Sel[0]), .a(In6), .b(In7), .OUT(Layer1_4));
Mux_2X1		HXX_M(.Sel(Sel[1]), .a(Layer1_3), .b(Layer1_4), .OUT(Layer2_2));

Mux_2X1		Main (.Sel(Sel[2]), .a(Layer2_1), .b(Layer2_2), .OUT(Output));
endmodule



module Mux_2X1 (
	 input  logic a, b, Sel,
	 output logic OUT
);
assign OUT = (a & ~Sel) | (b & Sel);
endmodule