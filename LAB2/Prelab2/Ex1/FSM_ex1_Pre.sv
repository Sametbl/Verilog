
	module ex1_Pre_FF(
			input  logic clk, reset, W,
			output logic Output,
			output logic [8:0] PreState
	);

	reg [8:0] NextState;
	wire logic inA, inB, inC, inD, inE, inF, inG, inH, inI;
	assign {inI, inH, inG, inF, inE, inD, inC, inB, inA} = PreState;
	assign NextState[0] = reset;
	assign NextState[1] = ~W & (inA | inF | inG | inH | inI);
	assign NextState[2] = ~W & inB;
	assign NextState[3] = ~W & inC;
	assign NextState[4] = ~W & (inD | inE);						 //Output = 1
	assign NextState[5] =  W & (inA | inB | inC | inD | inE);
	assign NextState[6] =  W & inF;
	assign NextState[7] =  W & inG;
	assign NextState[8] =  W & (inH | inI);	 					 //Output = 1

	D_flip_flop	 A_y0(.clk(clk), .clear(0), .preset(reset), .D(NextState[0]), .Q(PreState[0]) );
	D_flip_flop	 B_y1(.clk(clk), .clear(reset), .preset(0), .D(NextState[1]), .Q(PreState[1]) );
	D_flip_flop	 C_y2(.clk(clk), .clear(reset), .preset(0), .D(NextState[2]), .Q(PreState[2]) );
	D_flip_flop	 D_y3(.clk(clk), .clear(reset), .preset(0), .D(NextState[3]), .Q(PreState[3]) );
	D_flip_flop	 E_y4(.clk(clk), .clear(reset), .preset(0), .D(NextState[4]), .Q(PreState[4]) );
	D_flip_flop	 F_y5(.clk(clk), .clear(reset), .preset(0), .D(NextState[5]), .Q(PreState[5]) );
	D_flip_flop	 G_y6(.clk(clk), .clear(reset), .preset(0), .D(NextState[6]), .Q(PreState[6]) );
	D_flip_flop	 H_y7(.clk(clk), .clear(reset), .preset(0), .D(NextState[7]), .Q(PreState[7]) );
	D_flip_flop	 I_y8(.clk(clk), .clear(reset), .preset(0), .D(NextState[8]), .Q(PreState[8]) );

	assign Output = PreState[4] | PreState[8];
	endmodule





