module decoder_3to8(
		input  logic [2:0] W,
		input  logic En, 
		output logic [7:0] Y
); 
decoder_2to4		Bottom(.En(~W[2]), .In(W[1:0]), .Q(Y[3:0]));
decoder_2to4		Top   (.En(W[2]),  .In(W[1:0]), .Q(Y[7:4]));
endmodule 

//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------

module decoder_2to4(
		input  logic En,
		input  logic [1:0] In,
		output logic [3:0] Q
);
wire logic A, B;
assign A = In[1];
assign B = In[0];

assign Q[0] = En & ~A & ~B;
assign Q[1] = En & ~A &  B;
assign Q[2] = En &  A & ~B;
assign Q[3] = En &  A &  B;
endmodule


//---------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------

module Register_9bit(
		input  logic [8:0] D,
		input  logic En, clk, reset, // reset is active LOW
		output logic [8:0] Q
);

D_flip_flop			Q0(.clk(clk), .En(En), .rst(reset), .D(D[0]), .Q(Q[0]));
D_flip_flop			Q1(.clk(clk), .En(En), .rst(reset), .D(D[1]), .Q(Q[1]));
D_flip_flop			Q2(.clk(clk), .En(En), .rst(reset), .D(D[2]), .Q(Q[2]));
D_flip_flop			Q3(.clk(clk), .En(En), .rst(reset), .D(D[3]), .Q(Q[3]));
D_flip_flop			Q4(.clk(clk), .En(En), .rst(reset), .D(D[4]), .Q(Q[4]));
D_flip_flop			Q5(.clk(clk), .En(En), .rst(reset), .D(D[5]), .Q(Q[5]));
D_flip_flop			Q6(.clk(clk), .En(En), .rst(reset), .D(D[6]), .Q(Q[6]));
D_flip_flop			Q7(.clk(clk), .En(En), .rst(reset), .D(D[7]), .Q(Q[7]));
D_flip_flop			Q8(.clk(clk), .En(En), .rst(reset), .D(D[8]), .Q(Q[8]));
endmodule


module D_flip_flop(
		input  logic D, rst, clk, En,
		output logic Q
);

always_ff@(posedge clk, negedge rst) begin
		if(!rst)			Q  <=  0;
		else if(En)		Q  <=  D;
end
endmodule













/*


module dec3to8(
		input  logic [2:0] W,
		input  logic En, 
		output logic [7:0] Y
); 

always @(W or En) begin 
	if (En == 1) 
		case (W) 
				3'b000: Y = 8'b00000001;
				3'b001: Y = 8'b00000010;
				3'b010: Y = 8'b00000100;
				3'b011: Y = 8'b00001000;
				3'b100: Y = 8'b00010000;
				3'b101: Y = 8'b00100000;
				3'b110: Y = 8'b01000000;
				3'b111: Y = 8'b10000000;
		endcase 
	else Y = 8'b00000000;
end 
endmodule 


module Register_9bit #(parameter n = 9)(
		input  logic [n-1:0] D,
		input  logic En, clk,
		output logic [n-1:0] Q
);

always_ff@(posedge clk) 
		if (En) Q <= D; 
endmodule



*/








