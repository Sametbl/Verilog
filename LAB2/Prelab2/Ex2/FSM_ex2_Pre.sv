
	module ex2_Pre_SV(
			input  logic W, clk, reset,
			output logic Output,
			output logic [3:0] State
	);
	typedef enum bit [3:0] {A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100,
									F = 4'b0110, G = 4'b0111, H = 4'b1000, I = 4'b1001} statecode;
	statecode NextState, PreState;	 
	assign Output = (PreState == E | PreState == I);
	assign State  = PreState;
	always_ff@(posedge clk, posedge reset) begin
			if (reset) 	PreState  <= A;
			else			PreState  <= NextState; 
	end
	always_comb begin
			case(PreState)
				A:		if(W) NextState = F;			else	NextState = B;
						
				B:		if(W) NextState = F;			else	NextState = C;		
						
				C:		if(W) NextState = F;			else	NextState = D;
						
				D:		if(W) NextState = F;			else	NextState = E;
						
				E:		if(W) NextState = F;			else	NextState = E;
						
				F:		if(W) NextState = G;			else	NextState = B;
						
				G:		if(W) NextState = H;			else	NextState = B;
						
				H:		if(W) NextState = I;			else	NextState = B;
						
				I:		if(W) NextState = I;			else	NextState = B;
			endcase
	end
	endmodule
