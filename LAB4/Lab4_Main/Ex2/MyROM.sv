module MyROM #(	parameter int unsigned width = 9,
						parameter int unsigned depth = 32,
						parameter intFile = "program.bin" )
(
	input  logic CLK,
	input  logic [$clog2(depth)-1:0] ADDRESS,
	output logic [width-1:0] DATAOUT
);

logic [width-1:0] rom [0:depth-1];

// initialise ROM contents
initial $readmemb(intFile, rom);

always_ff @ (posedge CLK) begin
		DATAOUT <= rom[ADDRESS];
end
endmodule
