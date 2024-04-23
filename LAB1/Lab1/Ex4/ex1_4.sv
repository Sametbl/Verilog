// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
module ex1_4(
		input  logic [9:0] SW,
		input  logic [2:0] KEY,
		output logic [9:0] LEDR,
		output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

wire logic [7:0] X, OUT;
wire logic [15:0] P;
wire logic [1:0] mode;
assign X = SW[7:0];
assign LEDR[7:0] = OUT;

always@(negedge KEY[2]) begin
		mode = mode +1;
		if (mode == 3) mode = 0;
end


ALU   text(.INPUT(X), .EA(SW[9]), .EB(SW[8]), .Sel(mode), .Product(P),  
           .clk(~KEY[1]), .reset(~KEY[0]), .current_value(OUT) );		  
						
Display  out(.dec_in(P), .mode(mode),
				 .hex0(HEX0), .hex1(HEX1), .hex2(HEX2), .hex3(HEX3), .hex4(HEX4), .hex5(HEX5) );
endmodule






