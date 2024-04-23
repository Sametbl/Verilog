module AU_f(
		input  logic [7:0] A, B, 
		input  logic Mode,
		output logic [7:0] Result,
		output logic Overflow, Underflow, Zero  // (Overflow = 1):   the Result is greater than 6
															 //    ==> Not greater than 7 because it represent Infinity (or Reserved)
															 // (Zero = 1):       the Result is a literal zero number 
);															 // (Underflow  = 1): the Result < 2^(-3)

wire logic [7:0] Temp_Frac, Extend_Big;
wire logic [5:0] Shifted_Smol;
wire logic [3:0] Exp_diff, Exp_dif_2s, Shift_N;
wire logic [3:0] Big_Num, Smol_Num, Final_exp;
wire logic C_mux, Same_exp, Exp_AB , Frac_AB;  //Exp_AB = 1 => Exp_A - Exp_B >0   (Frac_AB similarly)

expo_diff          exp_compare (.Exp_A(A[6:4]), .Exp_B(B[6:4]), .Exp_diff(Exp_diff), .Co(Exp_AB), .Same_exp(Same_exp) );
frac_diff          frac_compare(.Frac_A(A[3:0]), .Frac_B(B[3:0]), .Co(Frac_AB) );
Full_Adder_4bit    complement_2(.A(0), .B(Exp_diff[3:0]), .En(1), .C_in(1), .Sum(Exp_dif_2s) );
assign C_mux =  ~((~Same_exp & Exp_AB) | (Same_exp & Frac_AB) );

MUX_2X1_4bit		 Shift_size  (.Sel(C_mux), .A(Exp_diff), .B(Exp_dif_2s), .Selected(Shift_N) );
MUX_2X1_4bit		 Bigger_Num  (.Sel(C_mux), .A(A[3:0]), .B(B[3:0]), .Selected(Big_Num)  );
MUX_2X1_4bit		 Smaller_Num (.Sel(C_mux), .A(B[3:0]), .B(A[3:0]), .Selected(Smol_Num) );

S_frac_shift       Shift_Frac  (.S_fract(Smol_Num), .Ikura(Shift_N), .Shifted_fract(Shifted_Smol) );
assign Extend_Big = {2'b00, 1'b1, Big_Num, 1'b0};

// We extend inputs to 8-bit to use 8-bit full_adder
assign Sub = (A[7] ^ B[7]) ^ Mode; // When Same sign but Mode = 1	 OR Difference sign but Mode = 0 
Full_Adder_8bit    Diff      (.a(Extend_Big), .b({2'b00, Shifted_Smol}), .En(Sub), .C_in(Sub), .Sum(Temp_Frac) );

MUX_2X1_4bit		 Large_exp (.Sel(C_mux), .A({1'b0, A[6:4]}), .B({1'b0, B[6:4]}), .Selected(Final_exp) );
Normalize          Normalize (.Final_exp(Final_exp[2:0]), .Temp_Frac(Temp_Frac[6:1]),
										.Result_exp(Result[6:4]), .Result_frac(Result[3:0]),
										.Overflow(Overflow), .Underflow(Underflow) );
																
sign_bit          Result_sign(.Frac_A(A[3:0]), .Frac_B(B[3:0]), .Exp_diff(Exp_diff), .Zero_detect(Zero),
							         .A_bit7(A[7]), .B_bit7(B[7]), .Exp(A[6:4]), .Mode(Mode) , .SIGN(Result[7]) );

endmodule
