module S_frac_shift( 
		input  logic [3:0] S_fract, Exp_diff,   // Exp_diff is signed
		output logic [5:0] Shifted_fract
);
// Exp_diff is expected range: 0 -> 6 (max difference = -3 to 3)
wire logic [5:0] temp;
wire logic [2:0] size;

// temp = Leading 1 ++ Fractional part ++ Extra bit 
assign temp  = {1'b1, S_fract, 1'b0};

Mux_8X1    Right_a0(.Sel(size), .In0(temp[0]), .In1(temp[1]), .In2(temp[2]), .In3(temp[3]), .In4(temp[4]), .In5(temp[5]),
										  .In6(0), .In7(0), .Output(Shifted_fract[0]));

Mux_8X1    Right_a2(.Sel(size), .In0(temp[1]), .In1(temp[2]), .In2(temp[3]), .In3(temp[4]), .In4(temp[5]),
										  .In5(0), .In6(0), .In7(0), .Output(Shifted_fract[1]));

Mux_8X1    Right_a3(.Sel(size), .In0(temp[2]), .In1(temp[3]), .In2(temp[4]), .In3(temp[5]),
						              .In4(0), .In5(0), .In6(0), .In7(0), .Output(Shifted_fract[2]));

Mux_8X1    Right_a4(.Sel(size), .In0(temp[3]), .In1(temp[4]), .In2(temp[5]),
										  .In3(0), .In4(0), .In5(0), .In6(0), .In7(0), .Output(Shifted_fract[3]));

Mux_8X1    Right_a5(.Sel(size), .In0(temp[4]), .In1(temp[5]),
										  .In2(0), .In3(0), .In4(0), .In5(0), .In6(0), .In7(0), .Output(Shifted_fract[4]));

Mux_8X1    Right_a6(.Sel(size), .In0(temp[5]),
										  .In1(0), .In2(0), .In3(0), .In4(0), .In5(0), .In6(0), .In7(0), .Output(Shifted_fract[5]));
									 				 

Full_Adder_Subtractor_4bit     Abs(.A(0), .B({1'b0, Exp_diff[2:0]}), .En(Exp_diff[3]), .Sum(size) );
endmodule 




module Full_Adder_Subtractor_4bit(
		input  logic [3:0] A,
		input  logic [3:0] B,
		input  logic En,         
		output logic [3:0] Sum,
		output logic [0:0] C_out
);
wire logic [3:0] cout;  
Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(En),     .C_out(cout[0]));
Full_Adder	digit2 (.A(A[1]), .B(B[1] ^ En), .Sum(Sum[1]), .C_in(cout[0]), .C_out(cout[1]));
Full_Adder 	digit3 (.A(A[2]), .B(B[2] ^ En), .Sum(Sum[2]), .C_in(cout[1]), .C_out(cout[2]));
Full_Adder 	digit4 (.A(A[3]), .B(B[3] ^ En), .Sum(Sum[3]), .C_in(cout[2]), .C_out(cout[3]));
assign C_out = cout[3];
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