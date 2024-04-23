module D_flip_flop(
		input  logic D, clk, clear, preset,
		output logic Q
);

always_ff@(posedge clk, posedge clear, posedge preset) begin
		if (clear)			Q <= 0;  
		else if (preset)	Q <= 1;
		else					Q <= D;
end

endmodule