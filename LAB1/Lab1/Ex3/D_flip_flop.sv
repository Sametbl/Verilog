
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module Register_16bit(
				input  logic [15:0] R,
				input  logic clk, reset, enable,
				output logic [15:0] Q
	);
	Register_8bit  temp1( .clk(clk), .reset(reset), .enable(1), .R(R[7:0]),  .Q(Q[7:0])  );
	Register_8bit  temp2( .clk(clk), .reset(reset), .enable(1), .R(R[15:8]), .Q(Q[15:8]) );
	endmodule


	module Register_8bit(
				input  logic [7:0] R,
				input  logic clk, reset, enable,
				output logic [7:0] Q
	);
	D_flip_flop   q0( .clk(clk), .rst(reset), .en(enable), .D(R[0]), .Q(Q[0]) );
	D_flip_flop   q1( .clk(clk), .rst(reset), .en(enable), .D(R[1]), .Q(Q[1]) );
	D_flip_flop   q2( .clk(clk), .rst(reset), .en(enable), .D(R[2]), .Q(Q[2]) );
	D_flip_flop   q3( .clk(clk), .rst(reset), .en(enable), .D(R[3]), .Q(Q[3]) );
	D_flip_flop   q4( .clk(clk), .rst(reset), .en(enable), .D(R[4]), .Q(Q[4]) );
	D_flip_flop   q5( .clk(clk), .rst(reset), .en(enable), .D(R[5]), .Q(Q[5]) );
	D_flip_flop   q6( .clk(clk), .rst(reset), .en(enable), .D(R[6]), .Q(Q[6]) );
	D_flip_flop   q7( .clk(clk), .rst(reset), .en(enable), .D(R[7]), .Q(Q[7]) );
	endmodule




		module D_flip_flop(
				input  logic D, clk, rst, en,
				output logic Q
		);

		always_ff@(posedge clk or posedge rst) begin
				if (rst)		Q <= 0;
				else if(en)	Q <= D;
		end

		endmodule
		
		
		