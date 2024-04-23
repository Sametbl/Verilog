
	module Shift_register_4bit(
			input  logic reset, clk, IN,
			output logic [4:1] L
	);

	D_flip_flop  	shift1 (.clk(clk), .clear(reset), .preset(0), .D(IN),   .Q(L[1]) );
	D_flip_flop  	shift2 (.clk(clk), .clear(reset), .preset(0), .D(L[1]), .Q(L[2]) );
	D_flip_flop  	shift3 (.clk(clk), .clear(reset), .preset(0), .D(L[2]), .Q(L[3]) );
	D_flip_flop  	shift4 (.clk(clk), .clear(reset), .preset(0), .D(L[3]), .Q(L[4]) );

	endmodule	