module sign_bit(
		input  logic [3:0] Frac_A, Frac_B, Exp_diff,  // Exp_diff: Always compare A to B
		input  logic [2:0] Exp,    
		input  logic A_bit7, B_bit7, Mode,
		output logic Zero_detect, SIGN				 // SIGN = 1: Negative
);
wire logic [7:0] Frac_dif;
wire logic same_expo, same_frac;
wire logic sign_A, sign_B;

// Imagine We only performing Addition but
// In SUB mode, we toggle sing of B, A - B = A + (-B), or  A - (-B) = A + B
assign sign_B = Mode ^ B_bit7;      // Toggle sign of B when mode = 1
assign sign_A = A_bit7;
assign same_exp  = ~(Exp_diff[0] | Exp_diff[1] | Exp_diff[2] | Exp_diff[3]); 

// We extend A and B to 8-bit
Full_Adder_8bit    Diff(.a({4'b0000, Frac_A}), .b({4'b0000, Frac_B}), .En(1), .C_in(1), .Sum(Frac_dif) );

// If same_exp = 0: SIGN = sign_B when Exp_diff = 1
//						  SIGN = sign_A when Exp_diff = 0
// If same_exp = 1: SIGN = sign_B when Frac_diff[7] = 1
//                  SIGN = sign_A when Frac_diff[7] = 0 

assign Sub = sign_A ^ sign_B;
assign SIGN =  (  ~same_exp & (Exp_diff[3] & sign_B | ~Exp_diff[3] & sign_A)) | 
				   (   same_exp & (Frac_dif[7] & sign_B | ~Frac_dif[7] & sign_A));

Comparator_4bit		Compare_Frac(.A(Frac_A), .B(Frac_B), .Same(same_frac) );			

// A or B = 0 000 0000 is not consider as zero in our implementation
// => A = B = 2^(-3) when A = B = 0 000 0000 and the result is 2^(-2)
// => No zero detection when A = B = 0 000 0000
assign Zero_detect = Sub & same_exp & same_frac;
endmodule













module Comparator_4bit(
		input  logic [3:0] A,
		input  logic [3:0] B,
		output logic Same
);

assign Same = ~( (A[0] ^ B[0]) | (A[1] ^ B[1]) | (A[2] ^ B[2]) | (A[3] ^ B[3])  );
endmodule




