	module sign_bit(
			input  logic [3:0] Frac_A, Frac_B, Exp_diff,      // Exp_diff: Always compare A to B
			input  logic A_bit7, B_bit7, Mode,
			output logic SIGN				 // SIGN = 1: Negative
	);
	wire logic [4:0] Frac_diff;
	wire logic same_expo, same_sign;
	wire logic sign_A, sign_B;
	
	// Imagine We only performing Addition but
	// In SUB mode, sign of B in toggle, A - B = A + (-B), or  A - (-B) = A + B
	assign sign_B = Mode ^ B_bit7;      // Toggle sign of B
	assign sign_A = A_bit7;
	assign same_exp  = ~(Exp_diff[0] | Exp_diff[1] | Exp_diff[2] | Exp_diff[3]); 
	
	Full_Adder_5bit  frac(.A(Frac_A), .B(Frac_B), .En(1), .Sum(Frac_diff) );

	// If same_exp = 0: SIGN = sign_B when Exp_diff = 1
	//						  SIGN = sign_A when Exp_diff = 0
	// If same_exp = 1: SIGN = sign_B when Frac_diff[4] = 1
	//                  SIGN = sign_A when Frac_diff[4] = 0 
	assign SIGN = (~same_exp & (Exp_diff[3]  & sign_B | ~Exp_diff[3] & sign_A) )   | 
					  ( same_exp & (Frac_diff[4] & sign_B | Frac_diff[4] & sign_A) );
	endmodule





	module Full_Adder_5bit(
			input  logic [4:0] A,
			input  logic [4:0] B,
			input  logic En,        
			output logic [4:0] Sum,
			output logic [0:0] C_out
	);
	wire logic [4:0] cout;  
	Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(En),     .C_out(cout[0]));
	Full_Adder	digit2 (.A(A[1]), .B(B[1] ^ En), .Sum(Sum[1]), .C_in(cout[0]), .C_out(cout[1]));
	Full_Adder 	digit3 (.A(A[2]), .B(B[2] ^ En), .Sum(Sum[2]), .C_in(cout[1]), .C_out(cout[2]));
	Full_Adder 	digit4 (.A(A[3]), .B(B[3] ^ En), .Sum(Sum[3]), .C_in(cout[2]), .C_out(cout[3]));
	Full_Adder 	digit5 (.A(A[4]), .B(B[4] ^ En), .Sum(Sum[4]), .C_in(cout[3]), .C_out(cout[4]));
	assign C_out = cout[4];
	endmodule


	module Full_Adder(
			input  logic A, B, C_in,
			output logic Sum, C_out
	);
	// Sum   = [A] XOR [B] XOR [C_in]
	// C_out = A.B + (  [C_in].([A] XOR [B])  ) 

	assign Sum   =  A ^ B ^ C_in;
	assign C_out = (A & B) | ( C_in & (A ^ B) );
	endmodule



