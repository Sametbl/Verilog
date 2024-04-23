
	module  pulse_500ms( 
			input  logic clk_50, enable, rst,
			output logic pulse
	);
	int i = 0;
	always@(posedge clk_50) begin
			if(rst) begin
					i 			<= 0;
					pulse		<= 0; 		end
			else if(enable) begin
					i 			<= i +1;
					if (i == 25000000) begin
						i 				<= 0;
						pulse  		<= 1;
					end
					else	pulse	   <= 0;
			end
	end
	endmodule





	/*

	module  two_Hz( 
			input  logic clk_50, enable, rst,
			output logic clk_out
	);
	wire logic [23:0] Q;
	logic toggle;

	D_flip_flop  	Q_0 (.clk(clk_50 & enable), .clear(rst | ~toggle), .preset(0), .D(~Q[0]), .Q(Q[0]) );
	D_flip_flop  	Q_1 (.clk(~Q[0]), .clear(rst | ~toggle), .preset(0), .D(~Q[1]), .Q(Q[1]) );
	D_flip_flop  	Q_2 (.clk(~Q[1]), .clear(rst | ~toggle), .preset(0), .D(~Q[2]), .Q(Q[2]) );
	D_flip_flop  	Q_3 (.clk(~Q[2]), .clear(rst | ~toggle), .preset(0), .D(~Q[3]), .Q(Q[3]) );
	D_flip_flop  	Q_4 (.clk(~Q[3]), .clear(rst | ~toggle), .preset(0), .D(~Q[4]), .Q(Q[4]) );
	D_flip_flop  	Q_5 (.clk(~Q[4]), .clear(rst | ~toggle), .preset(0), .D(~Q[5]), .Q(Q[5]) );
	D_flip_flop  	Q_6 (.clk(~Q[5]), .clear(rst | ~toggle), .preset(0), .D(~Q[6]), .Q(Q[6]) );
	D_flip_flop  	Q_7 (.clk(~Q[6]), .clear(rst | ~toggle), .preset(0), .D(~Q[7]), .Q(Q[7]) );
	D_flip_flop  	Q_8 (.clk(~Q[7]), .clear(rst | ~toggle), .preset(0), .D(~Q[8]), .Q(Q[8]) );
	D_flip_flop  	Q_9 (.clk(~Q[8]), .clear(rst | ~toggle), .preset(0), .D(~Q[9]), .Q(Q[9]) );
	D_flip_flop  	Q_10(.clk(~Q[9]),  .clear(rst | ~toggle), .preset(0), .D(~Q[10]), .Q(Q[10]) );
	D_flip_flop  	Q_11(.clk(~Q[10]), .clear(rst | ~toggle), .preset(0), .D(~Q[11]), .Q(Q[11]) );
	D_flip_flop  	Q_12(.clk(~Q[11]), .clear(rst | ~toggle), .preset(0), .D(~Q[12]), .Q(Q[12]) );
	D_flip_flop  	Q_13(.clk(~Q[12]), .clear(rst | ~toggle), .preset(0), .D(~Q[13]), .Q(Q[13]) );
	D_flip_flop  	Q_14(.clk(~Q[13]), .clear(rst | ~toggle), .preset(0), .D(~Q[14]), .Q(Q[14]) );
	D_flip_flop  	Q_15(.clk(~Q[14]), .clear(rst | ~toggle), .preset(0), .D(~Q[15]), .Q(Q[15]) );
	D_flip_flop  	Q_16(.clk(~Q[15]), .clear(rst | ~toggle), .preset(0), .D(~Q[16]), .Q(Q[16]) );
	D_flip_flop  	Q_17(.clk(~Q[16]), .clear(rst | ~toggle), .preset(0), .D(~Q[17]), .Q(Q[17]) );
	D_flip_flop  	Q_18(.clk(~Q[17]), .clear(rst | ~toggle), .preset(0), .D(~Q[18]), .Q(Q[18]) );
	D_flip_flop  	Q_19(.clk(~Q[18]), .clear(rst | ~toggle), .preset(0), .D(~Q[19]), .Q(Q[19]) );
	D_flip_flop  	Q_20(.clk(~Q[19]), .clear(rst | ~toggle), .preset(0), .D(~Q[20]), .Q(Q[20]) );
	D_flip_flop  	Q_21(.clk(~Q[20]), .clear(rst | ~toggle), .preset(0), .D(~Q[21]), .Q(Q[21]) );
	D_flip_flop  	Q_22(.clk(~Q[21]), .clear(rst | ~toggle), .preset(0), .D(~Q[22]), .Q(Q[22]) );
	D_flip_flop  	Q_23(.clk(~Q[22]), .clear(rst | ~toggle), .preset(0), .D(~Q[23]), .Q(Q[23]) );


	// 12 500 000 = 24'b1011 1110 1011 1100 0010 0000;
	assign toggle = Q[23]&Q[21]&Q[20]&  Q[19]&Q[18]&Q[17]&  Q[15]&Q[13]&Q[12]&  Q[11]&Q[10]&  Q[5]; 
	D_flip_flop   pulse(.clk(toggle), .clear(0), .preset(rst), .D(~clk_out), .Q(clk_out) );
	endmodule


	*/


