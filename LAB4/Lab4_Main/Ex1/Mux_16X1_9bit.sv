module Mux_16X1_onehot_9bit(
			input  logic [8:0] M0,  M1,  M2,  M3,  M4,  M5,  M6,  M7,
			input  logic [8:0] M8,  M9,  M10,  M11,  M12,  M13,  M14,  M15,
			input  logic [15:0] Sel,
			output logic [8:0] OUT
);

Mux_16X1_onehot	Mux_0 (.Sel(Sel[15:0]), .Output(OUT[0]),
								 .In0(M0[0]),    .In1(M1[0]),    .In2(M2[0]),    .In3(M3[0]), 
								 .In4(M4[0]),    .In5(M5[0]),    .In6(M6[0]),    .In7(M7[0]),
								 .In8(M8[0]),    .In9(M9[0]),    .In10(M10[0]),  .In11(M11[0]), 
								 .In12(M12[0]),  .In13(M13[0]),  .In14(M14[0]),  .In15(M15[0])   ); 

Mux_16X1_onehot	Mux_1 (.Sel(Sel[15:0]), .Output(OUT[1]),
								 .In0(M0[1]),    .In1(M1[1]),    .In2(M2[1]),    .In3(M3[1]), 
								 .In4(M4[1]),    .In5(M5[1]),    .In6(M6[1]),    .In7(M7[1]),
								 .In8(M8[1]),    .In9(M9[1]),    .In10(M10[1]),  .In11(M11[1]), 
								 .In12(M12[1]),  .In13(M13[1]),  .In14(M14[1]),  .In15(M15[1])   ); 


Mux_16X1_onehot	Mux_2 (.Sel(Sel[15:0]), .Output(OUT[2]),
								 .In0(M0[2]),    .In1(M1[2]),    .In2(M2[2]),    .In3(M3[2]), 
								 .In4(M4[2]),    .In5(M5[2]),    .In6(M6[2]),    .In7(M7[2]),
								 .In8(M8[2]),    .In9(M9[2]),    .In10(M10[2]),  .In11(M11[2]), 
								 .In12(M12[2]),  .In13(M13[2]),  .In14(M14[2]),  .In15(M15[2])   ); 


Mux_16X1_onehot	Mux_3 (.Sel(Sel[15:0]), .Output(OUT[3]),
								 .In0(M0[3]),    .In1(M1[3]),    .In2(M2[3]),    .In3(M3[3]), 
								 .In4(M4[3]),    .In5(M5[3]),    .In6(M6[3]),    .In7(M7[3]),
								 .In8(M8[3]),    .In9(M9[3]),    .In10(M10[3]),  .In11(M11[3]), 
								 .In12(M12[3]),  .In13(M13[3]),  .In14(M14[3]),  .In15(M15[3])   ); 


Mux_16X1_onehot	Mux_4 (.Sel(Sel[15:0]), .Output(OUT[4]),
								 .In0(M0[4]),    .In1(M1[4]),    .In2(M2[4]),    .In3(M3[4]), 
								 .In4(M4[4]),    .In5(M5[4]),    .In6(M6[4]),    .In7(M7[4]),
								 .In8(M8[4]),    .In9(M9[4]),    .In10(M10[4]),  .In11(M11[4]), 
								 .In12(M12[4]),  .In13(M13[4]),  .In14(M14[4]),  .In15(M15[4])   ); 


Mux_16X1_onehot	Mux_5 (.Sel(Sel[15:0]), .Output(OUT[5]),
								 .In0(M0[5]),    .In1(M1[5]),    .In2(M2[5]),    .In3(M3[5]), 
								 .In4(M4[5]),    .In5(M5[5]),    .In6(M6[5]),    .In7(M7[5]),
								 .In8(M8[5]),    .In9(M9[5]),    .In10(M10[5]),  .In11(M11[5]), 
								 .In12(M12[5]),  .In13(M13[5]),  .In14(M14[5]),  .In15(M15[5])   ); 


Mux_16X1_onehot	Mux_6 (.Sel(Sel[15:0]), .Output(OUT[6]),
								 .In0(M0[6]),    .In1(M1[6]),    .In2(M2[6]),    .In3(M3[6]), 
								 .In4(M4[6]),    .In5(M5[6]),    .In6(M6[6]),    .In7(M7[6]),
								 .In8(M8[6]),    .In9(M9[6]),    .In10(M10[6]),  .In11(M11[6]), 
								 .In12(M12[6]),  .In13(M13[6]),  .In14(M14[6]),  .In15(M15[6])   ); 


Mux_16X1_onehot	Mux_7 (.Sel(Sel[15:0]), .Output(OUT[7]),
								 .In0(M0[7]),    .In1(M1[7]),    .In2(M2[7]),    .In3(M3[7]), 
								 .In4(M4[7]),    .In5(M5[7]),    .In6(M6[7]),    .In7(M7[7]),
								 .In8(M8[7]),    .In9(M9[7]),    .In10(M10[7]),  .In11(M11[7]), 
								 .In12(M12[7]),  .In13(M13[7]),  .In14(M14[7]),  .In15(M15[7])   ); 


Mux_16X1_onehot	Mux_8 (.Sel(Sel[15:0]), .Output(OUT[8]),
								 .In0(M0[8]),    .In1(M1[8]),    .In2(M2[8]),    .In3(M3[8]), 
								 .In4(M4[8]),    .In5(M5[8]),    .In6(M6[8]),    .In7(M7[8]),
								 .In8(M8[8]),    .In9(M9[8]),    .In10(M10[8]),  .In11(M11[8]), 
								 .In12(M12[8]),  .In13(M13[8]),  .In14(M14[8]),  .In15(M15[8])   ); 

endmodule


