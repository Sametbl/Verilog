module Register_8bit(
			input  logic [7:0] R,
			input  logic clk, reset,
			output logic [7:0] Q
);

D_flip_flop   q0( .clk(clk), .rst(reset), .D(R[0]), .Q(Q[0]) );
D_flip_flop   q1( .clk(clk), .rst(reset), .D(R[1]), .Q(Q[1]) );
D_flip_flop   q2( .clk(clk), .rst(reset), .D(R[2]), .Q(Q[2]) );
D_flip_flop   q3( .clk(clk), .rst(reset), .D(R[3]), .Q(Q[3]) );
D_flip_flop   q4( .clk(clk), .rst(reset), .D(R[4]), .Q(Q[4]) );
D_flip_flop   q5( .clk(clk), .rst(reset), .D(R[5]), .Q(Q[5]) );
D_flip_flop   q6( .clk(clk), .rst(reset), .D(R[6]), .Q(Q[6]) );
D_flip_flop   q7( .clk(clk), .rst(reset), .D(R[7]), .Q(Q[7]) );
endmodule


module D_flip_flop(
		input  logic D, clk, rst,
		output logic Q
);

always_ff@(posedge clk or posedge rst) begin
	if (rst)		Q <= 0;
	else 			Q <= D;
end

endmodule