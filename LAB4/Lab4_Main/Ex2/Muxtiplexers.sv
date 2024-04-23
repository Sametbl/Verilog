module Mux_16X1_onehot(
		input  logic [15:0] Sel,
		input  logic In0, In1, In2, In3, In4, In5, In6, In7, In8,
		input  logic In9, In10, In11, In12, In13, In14, In15,
		output logic Output
);
wire logic [1:0] MUX_OUT;
assign Output = MUX_OUT[0] | MUX_OUT[1];

Mux_8X1_onehot		 MUX_1(.Sel(Sel[7:0]), .Output(MUX_OUT[0]),
								 .In0(In0),  .In1(In1),  .In2(In2),  .In3(In3), 
								 .In4(In4),  .In5(In5),  .In6(In6),  .In7(In7)   );  

Mux_8X1_onehot		 MUX_2(.Sel(Sel[15:8]), .Output(MUX_OUT[1]),
								 .In0(In8),   .In1(In9),   .In2(In10),  .In3(In11), 
								 .In4(In12),  .In5(In13),  .In6(In14),  .In7(In15)   ); 

endmodule 

//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------
 
module Mux_8X1_onehot(
	 input  logic [7:0] Sel,
	 input  logic In0, In1, In2, In3, In4, In5, In6, In7,
	 output logic Output
);
wire logic [3:0]Mux_out;
assign Output = Mux_out[0] | Mux_out[1] | Mux_out[2] | Mux_out[3];

Mux_2X1_onehot		Mux_1(.Sel(Sel[1:0]), .a(In0), .b(In1), .OUT(Mux_out[0]));
Mux_2X1_onehot		Mux_2(.Sel(Sel[3:2]), .a(In2), .b(In3), .OUT(Mux_out[1]));
Mux_2X1_onehot		Mux_3(.Sel(Sel[5:4]), .a(In4), .b(In5), .OUT(Mux_out[2]));
Mux_2X1_onehot		Mux_4(.Sel(Sel[7:6]), .a(In6), .b(In7), .OUT(Mux_out[3]));

endmodule

//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------

module Mux_2X1_onehot (
	 input  logic a, b,
    input  logic [1:0] Sel,
	 output logic OUT
);

assign OUT = (a & Sel[0]) | (b & Sel[1]);
endmodule





























/*
module Mux_16X1(
		input  logic [3:0] Sel,
		input  logic In0, In1, In2, In3, In4, In5, In6, In7, In8,
		input  logic In9, In10, In11, In12, In13, In14, In15,
		output logic Output
);
wire logic Layer_1, Layer_2;

Mux_8X1		Top   (.Sel(Sel[2:0]), Output(Layer_1),
						 .In0(In0),  .In1(In1),  .In2(In2),  .In3(In3), 
						 .In4(In4),  .In5(In5),  .In6(In6),  .In7(In7)   );  

Mux_8X1		Bottom(.Sel(Sel[2:0]), Output(Layer_2),
					    .In0(In8),   .In1(In9),   .In2(In10),  .In3(In11), 
						 .In4(In12),  .In5(In13),  .In6(In14),  .In7(In15)   );   						


Mux_2X1		Top_or_Bot (.Sel(Sel[3]), .a(Layer_1), .b(Layer_2), .OUT(Output) );
endmodule						 
						*/


