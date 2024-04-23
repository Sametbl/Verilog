module S_frac_shift( 
		input  logic [3:0] S_fract,
		input  logic [2:0] Ikura,  
		output logic [5:0] Shifted_fract
);
// Number of shift is expected range: 0 -> 6 (max exp difference = -3 to 3)
// temp = Leading 1 ++ Fractional part ++ Extra bit 
wire logic [5:0] temp;
assign temp  = {1'b1, S_fract, 1'b0};

Mux_8X1    Right_a0(.Sel(Ikura), .In0(temp[0]), .In1(temp[1]), .In2(temp[2]), .In3(temp[3]), .In4(temp[4]),
											.In5(temp[5]), .In6(0), .In7(0), .Output(Shifted_fract[0]));

Mux_8X1    Right_a2(.Sel(Ikura), .In0(temp[1]), .In1(temp[2]), .In2(temp[3]), .In3(temp[4]), .In4(temp[5]),
										   .In5(0), .In6(0), .In7(0), .Output(Shifted_fract[1]));

Mux_8X1    Right_a3(.Sel(Ikura), .In0(temp[2]), .In1(temp[3]), .In2(temp[4]), .In3(temp[5]), .In4(0),
											.In5(0), .In6(0), .In7(0), .Output(Shifted_fract[2]));

Mux_8X1    Right_a4(.Sel(Ikura), .In0(temp[3]), .In1(temp[4]), .In2(temp[5]), .In3(0), .In4(0),
											.In5(0), .In6(0), .In7(0), .Output(Shifted_fract[3]));

Mux_8X1    Right_a5(.Sel(Ikura), .In0(temp[4]), .In1(temp[5]), .In2(0), .In3(0), .In4(0),
											.In5(0), .In6(0), .In7(0), .Output(Shifted_fract[4]));

Mux_8X1    Right_a6(.Sel(Ikura), .In0(temp[5]), .In1(0), .In2(0), .In3(0), .In4(0),
											.In5(0), .In6(0), .In7(0), .Output(Shifted_fract[5]));
									 				 

endmodule 

