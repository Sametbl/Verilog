module sequence_detect_1Register(
			input  logic W, clk, reset,
			output logic Z,
			output [3:0] one, zero // To show to sequence of 0's and 1's
);
Shift_register_4bit_ONE   countONE (.clk(clk), .reset(reset), .IN(W), .L(one)  );
Shift_register_4bit_ZERO  countZERO(.clk(clk), .reset(reset), .IN(W), .L(zero) );

// The Combinational Circuit to detect four 0's or 1's: 
assign Z = ~(zero[0] | zero[1] | zero[2] | zero[3]) | (one[0]& one[1]& one[2]& one[3]); 

endmodule





module Shift_register_4bit(
		input  logic reset, clk, IN,
		output logic [4:1] L
);

D_flip_flop  	shift1 (.clk(clk), .rst(reset), .D(IN),   .Q(L[1]) );
D_flip_flop  	shift2 (.clk(clk), .rst(reset), .D(L[1]), .Q(L[2]) );
D_flip_flop  	shift3 (.clk(clk), .rst(reset), .D(L[2]), .Q(L[3]) );
D_flip_flop  	shift4 (.clk(clk), .rst(reset), .D(L[3]), .Q(L[4]) );
endmodule



