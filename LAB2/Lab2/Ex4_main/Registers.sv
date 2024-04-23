 
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module Shift_Right_4bit(
			input  logic [3:0] data_in,
			input  logic reset, clk, load,
			output logic [3:0] data_out
	);
	wire [3:0] Q, rst; 
	assign rst[0] = reset | (load & ~data_in[3]); // used to Reset, or Load the bit '0' to register 
	assign rst[1] = reset | (load & ~data_in[2]);
	assign rst[2] = reset | (load & ~data_in[1]); 
	assign rst[3] = reset | (load & ~data_in[0]); 

	// Q represents the left-shifted binary number of the REVERSED data_in
	D_flip_flop  	shift1 (.clk(clk), .clear(rst[0]), .preset(data_in[3]&load), .D(0),	  .Q(Q[0]) );
	D_flip_flop  	shift2 (.clk(clk), .clear(rst[1]), .preset(data_in[2]&load), .D(Q[0]), .Q(Q[1]) );
	D_flip_flop  	shift3 (.clk(clk), .clear(rst[2]), .preset(data_in[1]&load), .D(Q[1]), .Q(Q[2]) );
	D_flip_flop  	shift4 (.clk(clk), .clear(rst[3]), .preset(data_in[0]&load), .D(Q[2]), .Q(Q[3]) );
   
	// data_out is obtained by REVERSING Q, resulting in an effect of Right shift of data_in
	assign data_out = {Q[0], Q[1], Q[2], Q[3]};
	endmodule


	
   // Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module down_counter(
			input  logic [2:0] length_in,
			input  logic load, reset, clk,
			output logic [2:0] counter
	);
	wire [2:0] Q, rst;
	assign rst[0] = reset | (load & ~length_in[0]);  // used to Reset, or Load the bit '0' to register
	assign rst[1] = reset | (load & ~length_in[1]);
	assign rst[2] = reset | (load & ~length_in[2]); 

	D_flip_flop  	Q_0(.clk(clk),  .clear(rst[0]), .preset(load & length_in[0]), .D(~Q[0]), .Q(Q[0]) );
	D_flip_flop  	Q_1(.clk(Q[0]), .clear(rst[1]), .preset(load & length_in[1]), .D(~Q[1]), .Q(Q[1]) );
	D_flip_flop  	Q_2(.clk(Q[1]), .clear(rst[2]), .preset(load & length_in[2]), .D(~Q[2]), .Q(Q[2]) );
	assign counter = Q;
	endmodule

