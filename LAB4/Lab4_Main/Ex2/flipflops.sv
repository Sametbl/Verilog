module Up_counter_5bit(
		input  logic clk, reset,
		output logic [4:0] counter
);
wire logic [4:0] Q;
D_flip_flop       C1(.clk(clk),   .rst(reset), .En(1), .D(~Q[0]), .Q(Q[0]) );
D_flip_flop       C2(.clk(~Q[0]), .rst(reset), .En(1), .D(~Q[1]), .Q(Q[1]) );
D_flip_flop       C3(.clk(~Q[1]), .rst(reset), .En(1), .D(~Q[2]), .Q(Q[2]) );
D_flip_flop       C4(.clk(~Q[2]), .rst(reset), .En(1), .D(~Q[3]), .Q(Q[3]) );
D_flip_flop       C5(.clk(~Q[3]), .rst(reset), .En(1), .D(~Q[4]), .Q(Q[4]) );
assign counter = Q;
endmodule


