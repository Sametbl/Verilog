module Full_Adder_16bit (
		input  logic [15:0] A, B,    // A and B are positive values 
		input  logic En,   
		output logic [15:0] S,
		output logic C_out
);
wire logic Cout_1;	// Carry out of first 8-bit Full Adder to connect 2 8-bit full adders
Full_Adder_8bit  First (.a0(A[0]), .a1(A[1]), .a2(A[2]), .a3(A[3]), .a4(A[4]), .a5(A[5]), .a6(A[6]), .a7(A[7]), 
								.b0(B[0]), .b1(B[1]), .b2(B[2]), .b3(B[3]), .b4(B[4]), .b5(B[5]), .b6(B[6]), .b7(B[7]), 
								.Sum(S[7:0]), .C_out(Cout_1), .Invert_B(En), .C_in(En) );  // En= 0 => Addition
 
Full_Adder_8bit  Second(.a0(A[8]), .a1(A[9]), .a2(A[10]), .a3(A[11]), .a4(A[12]), .a5(A[13]), .a6(A[14]), .a7(A[15]), 
								.b0(B[8]), .b1(B[9]), .b2(B[10]), .b3(B[11]), .b4(B[12]), .b5(B[13]), .b6(B[14]), .b7(B[15]), 
								.Sum(S[15:8]), .C_out(C_out), .Invert_B(En), .C_in(Cout_1)   );  
endmodule							

//---------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------

module Full_Adder_8bit (
		input  logic [0:0] a0, a1, a2, a3, a4, a5, a6, a7, C_in,
		input  logic [0:0] b0, b1, b2, b3, b4, b5, b6, b7, Invert_B,
		output logic [7:0] Sum,
		output logic [0:0] C_out
);

wire logic [7:0] Cout;  
wire logic [7:0] A, B;
assign A = {a7, a6, a5, a4, a3, a2, a1, a0};
assign B = {b7, b6, b5, b4, b3, b2, b1, b0};

Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ Invert_B), .Sum(Sum[0]), .C_in(C_in),    .C_out(Cout[0]));
Full_Adder	digit2 (.A(A[1]), .B(B[1] ^ Invert_B), .Sum(Sum[1]), .C_in(Cout[0]), .C_out(Cout[1]));
Full_Adder 	digit3 (.A(A[2]), .B(B[2] ^ Invert_B), .Sum(Sum[2]), .C_in(Cout[1]), .C_out(Cout[2]));
Full_Adder 	digit4 (.A(A[3]), .B(B[3] ^ Invert_B), .Sum(Sum[3]), .C_in(Cout[2]), .C_out(Cout[3]));
Full_Adder 	digit5 (.A(A[4]), .B(B[4] ^ Invert_B), .Sum(Sum[4]), .C_in(Cout[3]), .C_out(Cout[4]));
Full_Adder 	digit6 (.A(A[5]), .B(B[5] ^ Invert_B), .Sum(Sum[5]), .C_in(Cout[4]), .C_out(Cout[5]));
Full_Adder 	digit7 (.A(A[6]), .B(B[6] ^ Invert_B), .Sum(Sum[6]), .C_in(Cout[5]), .C_out(Cout[6]));
Full_Adder 	digit8 (.A(A[7]), .B(B[7] ^ Invert_B), .Sum(Sum[7]), .C_in(Cout[6]), .C_out(Cout[7]));
assign C_out = Cout[7];
endmodule

//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------

module Full_Adder(
		input  logic A, B, C_in,
		output logic Sum, C_out
);

// Sum   = [A] XOR [B] XOR [C_in]
// C_out = A.B + (  [C_in].([A] XOR [B])  ) 
assign Sum   =  A ^ B ^ C_in;
assign C_out = (A & B) | ( C_in & (A ^ B) );

endmodule




