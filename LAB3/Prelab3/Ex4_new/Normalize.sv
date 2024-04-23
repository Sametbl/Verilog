module Normalize(
		input  logic [2:0] Final_exp,    // From ex1
		input  logic [5:0] Temp_Frac,
		output logic [4:0] Result_frac,
		output logic [2:0] Result_exp,
		output logic Overflow
);
// Temp_Frac = { Carry, Leading 1, Fraction Sum}
// Maximum Right shift to get the leading 1 is four 00.0001 -> 01.0000
// Maximum Left shift the carry to leading 1 is one, 10.0100 ->01.0010 
wire logic none, one, two, three, four, Carry_R;
wire logic [2:0] Sel, add_exp;
wire logic [4:0] Shifted_fract;
wire logic [3:0] Exp_added;

// Carry_R = Signal to Shift right due to Carry
// Other are like their names suggested, Specify the number of Left shift
assign none  =  Temp_Frac[4];
assign one   = ~Temp_Frac[4] &  Temp_Frac[3];
assign two   = ~Temp_Frac[4] & ~Temp_Frac[3] &  Temp_Frac[2];
assign three = ~Temp_Frac[4] & ~Temp_Frac[3] & ~Temp_Frac[2] &  Temp_Frac[1];
assign four  = ~Temp_Frac[4] & ~Temp_Frac[3] & ~Temp_Frac[2] & ~Temp_Frac[1] & Temp_Frac[0];
assign Carry_R = Temp_Frac[5];

// Sel = Number of Left Shift,  Speical case Sel = 5: Shift Right once
assign Sel[0] = one | three | Carry_R; 
assign Sel[1] = two | three;
assign Sel[2] = four | Carry_R;

assign add_exp[0]  = Sel[0];              // if Carry = 1,  add_exp = 1 
assign add_exp[1]  = Sel[1] & ~Carry_R;   // else           add_exp = (-) Sel
assign add_exp[2]  = Sel[2] & ~Carry_R;
assign Result_exp  = Exp_added[2:0];
assign Result_frac = Shifted_fract[4:0];
// Overflow = Exp < 0    OR    Exp = 7
assign Overflow    = Exp_added[3] | (Exp_added[2] & Exp_added[1] & Exp_added[0]);

// Only adds "add_exp" when Carry = 1
Full_Adder_4bit   New_exp(.A({1'b0, Final_exp}), .B({1'b0, add_exp}), .En(~Carry_R), .C_in(~Carry_R), .Sum(Exp_added));  

Mux_8X1    Left_a0(.Sel(Sel), .In0(Temp_Frac[0]), .In1(0), .In2(0), .In3(0), .In4(0), .In5(Temp_Frac[1]),
										.In6(0), .In7(0), .Output(Shifted_fract[0]));

Mux_8X1    Left_a1(.Sel(Sel), .In0(Temp_Frac[1]), .In1(Temp_Frac[0]), .In2(0), .In3(0), .In4(0),
										.In5(Temp_Frac[2]), .In6(0), .In7(0), .Output(Shifted_fract[1]));

Mux_8X1    Left_a2(.Sel(Sel), .In0(Temp_Frac[2]), .In1(Temp_Frac[1]), .In2(Temp_Frac[0]), .In3(0),
						            .In4(0), .In5(Temp_Frac[3]), .In6(0), .In7(0), .Output(Shifted_fract[2]));

Mux_8X1    Left_a3(.Sel(Sel), .In0(Temp_Frac[3]), .In1(Temp_Frac[2]), .In2(Temp_Frac[1]),	.In3(Temp_Frac[0]), 
										.In4(0), .In5(Temp_Frac[4]), .In6(0), .In7(0), .Output(Shifted_fract[3]));
										
Mux_8X1    Left_a4(.Sel(Sel), .In0(Temp_Frac[4]), .In1(Temp_Frac[3]), .In2(Temp_Frac[2]),	.In3(Temp_Frac[1]), 
										.In4(Temp_Frac[0]), .In5(Temp_Frac[5]), .In6(0), .In7(0), .Output(Shifted_fract[4]));
endmodule
							 
							
						

module Full_Adder_4bit(
		input  logic [3:0] A,
		input  logic [3:0] B,
		input  logic En, C_in,        
		output logic [3:0] Sum,
		output logic [0:0] C_out
);
wire logic [3:0] cout;  
Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(C_in),    .C_out(cout[0]));
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
			