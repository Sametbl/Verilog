// Can inputs be zero ? (A = X 000 0000 vs A = X 000 XXXX)
// What if input is X 111 XXXX?
// Overflow = Infinity ?


module Lab3_Main(
		input  logic [9:0] SW,
		input  logic [1:0] KEY,
		output logic [9:0] LEDR,
		output logic [6:0] HEX0
);
wire logic [7:0] A, B, temp, Result; 
wire logic zero;
assign temp = SW[7:0];
assign A = ~SW[8] && ~KEY[0] ? temp : A;   // Press KEY[0] to load SW[7:0] to A when SW[8] turns OFF
assign B =  SW[8] && ~KEY[0] ? temp : B;	 // Press KEY[0] to load SW[7:0] to B when SW[8] turns ON

assign LEDR[7:0] = ~KEY[1] ? Result :      // Display value of A on LEDR[7:0] when SW[8] turns OFF
						   SW[8] ? B : A;        // Display value of B on LEDR[7:0] when SW[8] turns ON
						
assign HEX0 = zero ? 7'b1000000 : 7'b1111111; // Display zero on HEX when result is literally ZERO
															 // Else turn off HEX

AU_f	         	test(.A(A), .B(B), .Mode(SW[9]), .Result(Result),
				      	  .Overflow(LEDR[9]), .Underflow(LEDR[8]), .Zero(zero) );

endmodule