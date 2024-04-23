
	module ex3_4_Pre(
			input  logic clk,
			input  logic [4:0] Address,
			output logic [8:0] Data
	);
	wire logic [4:0] Address_Q;
	D_FF_5bit 		Addr(.clk(clk), .D(Address), .Q(Address_Q) );
	MyROM 			U0  (.CLK(clk), .ADDRESS (Address_Q), .DATAOUT (Data)  );
	endmodule 


	module D_FF_5bit(
			input  logic [4:0] D, reset, clk,
			output logic [4:0] Q
	);

	D_flip_flop			D1(.clk(clk), .reset(reset), .D(D[0]), .Q(Q[0]) );
	D_flip_flop			D2(.clk(clk), .reset(reset), .D(D[1]), .Q(Q[1]) );
	D_flip_flop			D3(.clk(clk), .reset(reset), .D(D[2]), .Q(Q[2]) );
	D_flip_flop			D4(.clk(clk), .reset(reset), .D(D[3]), .Q(Q[3]) );
	D_flip_flop			D5(.clk(clk), .reset(reset), .D(D[4]), .Q(Q[4]) );
	endmodule


	module D_flip_flop(
			input  logic D, clk, reset,
			output logic Q
	);
	always_ff@(posedge clk) begin
			if (reset) 		Q <= 0;
			else 				Q <= D;
	end
	endmodule