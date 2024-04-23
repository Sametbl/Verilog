
	module periodic #(parameter Hz = 1)( 
			input  logic clk_50,
			output logic En
	);
	int i = 0;
	always@(posedge clk_50) begin
			i <= i + 1;
			if (i == 50000000/(2*Hz) || i > 50000000/(2*Hz) ) begin
					i 	<= 0;
					En <= ~En;
			end
	end
	endmodule


