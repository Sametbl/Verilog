module ex4_3_Pre(
		input  logic [9:0] SW,
		output logic [9:0] LEDR
);

Normalize   		test(.Temp_Frac(SW[5:0]), .Final_exp(SW[8:6]), 
							  .Result_frac(LEDR[4:0]), .Result_exp(LEDR[8:6]), .Overflow(LEDR[9]) );

endmodule 