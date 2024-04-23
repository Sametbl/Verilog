module MUX_2X1_4bit(
		input  logic Sel,
		input  logic [3:0] A, B,
		output logic [3:0] Selected
);
Mux_2X1 		bit1(.Sel(Sel), .a(A[0]), .b(B[0]), .OUT(Selected[0]) );
Mux_2X1 		bit2(.Sel(Sel), .a(A[1]), .b(B[1]), .OUT(Selected[1]) );
Mux_2X1 		bit3(.Sel(Sel), .a(A[2]), .b(B[2]), .OUT(Selected[2]) );
Mux_2X1 		bit4(.Sel(Sel), .a(A[3]), .b(B[3]), .OUT(Selected[3]) );

endmodule