module Full_Adder_8bit (
		input  logic [0:0] a0, a1, a2, a3, a4, a5, a6, a7,
		input  logic [0:0] b0, b1, b2, b3, b4, b5, b6, b7,
		output logic [7:0] Sum,
	   output logic [0:0] C_out
);

wire logic [7:0] Cout;  // To wiring C_out of a Full adder to C_in of other
wire logic [7:0] A, B;
assign A = {a7, a6, a5, a4, a3, a2, a1, a0};
assign B = {b7, b6, b5, b4, b3, b2, b1, b0};

Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(0),       .C_out(Cout[0]));
Full_Adder	digit2 (.A(A[1]), .B(B[1] ^ En), .Sum(Sum[1]), .C_in(Cout[0]), .C_out(Cout[1]));
Full_Adder 	digit3 (.A(A[2]), .B(B[2] ^ En), .Sum(Sum[2]), .C_in(Cout[1]), .C_out(Cout[2]));
Full_Adder 	digit4 (.A(A[3]), .B(B[3] ^ En), .Sum(Sum[3]), .C_in(Cout[2]), .C_out(Cout[3]));
Full_Adder 	digit5 (.A(A[4]), .B(B[4] ^ En), .Sum(Sum[4]), .C_in(Cout[3]), .C_out(Cout[4]));
Full_Adder 	digit6 (.A(A[5]), .B(B[5] ^ En), .Sum(Sum[5]), .C_in(Cout[4]), .C_out(Cout[5]));
Full_Adder 	digit7 (.A(A[6]), .B(B[6] ^ En), .Sum(Sum[6]), .C_in(Cout[5]), .C_out(Cout[6]));
Full_Adder 	digit8 (.A(A[7]), .B(B[7] ^ En), .Sum(Sum[7]), .C_in(Cout[6]), .C_out(Cout[7]));

// I forgot that we can use 'generate' for the code above, I will use it later on

assign C_out = Cout[7];
endmodule