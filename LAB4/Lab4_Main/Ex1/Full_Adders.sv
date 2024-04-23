
	module Full_Adder_16bit (
			input  logic [15:0] A, B,    // A and B are positive values 
			input  logic En,   
			output logic [15:0] S,
			output logic C_out
	);
	wire logic Cout_1;	// Carry out of first 8-bit Full Adder to connect 2 8-bit full adders

	Full_Adder_8bit  First (.A(A[7:0]),  .B(B[7:0]),  .Invert_B(En), .C_in(En),     .Sum(S[7:0]),  .C_out(Cout_1));
	Full_Adder_8bit  Second(.A(A[15:8]), .B(B[15:8]), .Invert_B(En), .C_in(Cout_1), .Sum(S[15:8]), .C_out(C_out) );
	endmodule							

	//---------------------------------------------------------------------------------------------------------
	//---------------------------------------------------------------------------------------------------------

	module Full_Adder_8bit (
			input  logic C_in, Invert_B,
			input  logic [7:0] A, B,
			output logic [7:0] Sum,
			output logic [0:0] C_out
	);
	wire logic [7:0] Cout;  
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




