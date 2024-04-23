
		module D_flip_flop(
				input  logic D, clk, rst,
				output logic Q
		);

		always_ff@(posedge clk or posedge rst) begin
				if (rst) 	Q		<= 0;
				else			Q 		<=  D;
		end
		endmodule