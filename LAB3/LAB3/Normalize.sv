module Normalize(
		input  logic [2:0] Final_exp,   
		input  logic [5:0] Temp_Frac,
		output logic [3:0] Result_frac,
		output logic [2:0] Result_exp,
		output logic Overflow, Underflow
);
// Temp_Frac = { Carry, Leading 1, Fraction Sum}
// Maximum Right shift to get the leading 1 is four 00.0001 -> 01.0000
// Maximum Left shift the carry to leading 1 is one, 10.0100 ->01.0010 
wire logic none, one, two, three, four, Carry_R;
wire logic undefined, zero_frac;
wire logic [2:0] Sel, add_exp;
wire logic [4:0] Shifted_fract;
wire logic [7:0] Exp_added;

// Carry_R = Signal to Shift right due to Carry
// Other are like their names suggested, Specify the number of Left shift
assign none   = ~Temp_Frac[5] &  Temp_Frac[4];
assign one    = ~Temp_Frac[5] & ~Temp_Frac[4] &  Temp_Frac[3];
assign two    = ~Temp_Frac[5] & ~Temp_Frac[4] & ~Temp_Frac[3] &  Temp_Frac[2];
assign three  = ~Temp_Frac[5] & ~Temp_Frac[4] & ~Temp_Frac[3] & ~Temp_Frac[2] &  Temp_Frac[1];
assign four   = ~Temp_Frac[5] & ~Temp_Frac[4] & ~Temp_Frac[3] & ~Temp_Frac[2] & ~Temp_Frac[1] & Temp_Frac[0];
assign Carry_R = Temp_Frac[5];

// Sel = Number of Left Shift,  Speical case Sel = 5: Shift Right once
assign Sel[0] = one | three | Carry_R; 
assign Sel[1] = two | three;
assign Sel[2] = four | Carry_R;

assign add_exp[0] = Sel[0];              // if Carry = 1,  add_exp = Result_exp + 1 
assign add_exp[1] = Sel[1] & ~Carry_R;   // else           add_exp = Result_exp - Sel
assign add_exp[2] = Sel[2] & ~Carry_R;

// undefined : In case Temp_Frac = 6'b000000 (zero detected) or Result_exp < 0 (underflow)
// => Result_exp should be 0
assign zero_frac  = ~(Temp_Frac[5] | Temp_Frac[4] | Temp_Frac[3] | Temp_Frac[2] | Temp_Frac[1] | Temp_Frac[0]);
assign undefined  =  zero_frac | Underflow;

// Result_exp always 3'b111 when Overflow to represent infinity
// And fraction = 0 when Underflow
// fraction = 0 when Overflow occured (IEEE 754 standard) to avoid NaN case
assign Result_exp  = (Exp_added[2:0]     & {3{~undefined}}) | {3{Overflow}};  
assign Result_frac =  Shifted_fract[3:0] & {4{~(Underflow | Overflow)}};

// Overflow = Exp >= 7
// Undeflow = Exp <  0  
assign Underflow   =  Exp_added[7];   // Negative Exp (with bias)
assign Overflow    = (Exp_added[2] & Exp_added[1] & Exp_added[0]) |   // When Result_exp = 7
							(Final_exp[2] & Final_exp[1] & Final_exp[0]);    // Or Final_exp = 7 
							

Full_Adder_8bit   New_exp(.a({4'b0000, Final_exp}), .b({4'b0000, add_exp}), .En(~Carry_R), .C_in(~Carry_R), .Sum(Exp_added));  

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
							 
							
						
			