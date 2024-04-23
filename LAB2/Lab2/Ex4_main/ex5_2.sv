
	module ex5_2(
			input  logic [2:0] SW, KEY,
			input  logic CLOCK_50,
			output logic [9:0] LEDR
	);
	wire logic dash;
	assign LEDR[8:7] = {2{dash}};
	assign LEDR[2:0] = SW[2:0]; 
	Morse_code	test(.clk_50(CLOCK_50), .switches(SW[2:0]), .reset(~KEY[0]), .button(~KEY[1]),
						  .dot(LEDR[9]), .dash(dash) );
						  
						  
	endmodule
	
	