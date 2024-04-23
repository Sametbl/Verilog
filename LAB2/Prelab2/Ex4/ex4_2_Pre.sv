module ex4_2_Pre (
		input  logic CLOCK_50,
		output logic [0:0] LEDR
);

periodic		test(.clk_50(CLOCK_50), .En(LEDR[0:0]) );

endmodule