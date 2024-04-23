module Display (
	  input  logic [15:0] dec_in,
	  input  logic [1:0] mode,
	  output logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5
);
	
wire  [3:0] digit1, digit2, digit3, digit4, digit5;

assign digit1    =  dec_in % 10;
assign digit2    = (dec_in % 100)   / 10;
assign digit3    = (dec_in % 1000)  / 100; 
assign digit4    = (dec_in % 10000) / 1000;
assign digit5    =  dec_in / 10000;


always@(*) begin
	 case (digit1[3:0])
		4'b0000: hex0 <= 7'b1000000; 
		4'b0001: hex0 <= 7'b1111001;
		4'b0010: hex0 <= 7'b0100100; 
		4'b0011: hex0 <= 7'b0110000; 
		4'b0100: hex0 <= 7'b0011001; 
		4'b0101: hex0 <= 7'b0010010; 
		4'b0110: hex0 <= 7'b0000010; 
		4'b0111: hex0 <= 7'b1111000; 
		4'b1000: hex0 <= 7'b0000000; 
		4'b1001: hex0 <= 7'b0010000; 
	 endcase	
	 
	 case (digit2[3:0])
		4'b0000: hex1 <= 7'b1000000; 
		4'b0001: hex1 <= 7'b1111001;
		4'b0010: hex1 <= 7'b0100100; 
		4'b0011: hex1 <= 7'b0110000; 
		4'b0100: hex1 <= 7'b0011001; 
		4'b0101: hex1 <= 7'b0010010; 
		4'b0110: hex1 <= 7'b0000010; 
		4'b0111: hex1 <= 7'b1111000; 
		4'b1000: hex1 <= 7'b0000000; 
		4'b1001: hex1 <= 7'b0010000; 
	 endcase	
	 
	
	 case (digit3[3:0])
		4'b0000: hex2 <= 7'b1000000; 
		4'b0001: hex2 <= 7'b1111001;
		4'b0010: hex2 <= 7'b0100100; 
		4'b0011: hex2 <= 7'b0110000; 
		4'b0100: hex2 <= 7'b0011001; 
		4'b0101: hex2 <= 7'b0010010; 
		4'b0110: hex2 <= 7'b0000010; 
		4'b0111: hex2 <= 7'b1111000; 
		4'b1000: hex2 <= 7'b0000000; 
		4'b1001: hex2 <= 7'b0010000; 
	 endcase	
	 
	 case (digit4[3:0])
		4'b0000: hex3 <= 7'b1000000; 
		4'b0001: hex3 <= 7'b1111001;
		4'b0010: hex3 <= 7'b0100100; 
		4'b0011: hex3 <= 7'b0110000; 
		4'b0100: hex3 <= 7'b0011001; 
		4'b0101: hex3 <= 7'b0010010; 
		4'b0110: hex3 <= 7'b0000010; 
		4'b0111: hex3 <= 7'b1111000; 
		4'b1000: hex3 <= 7'b0000000; 
		4'b1001: hex3 <= 7'b0010000; 
	 endcase	
	 
	 case (digit5[3:0])
		4'b0000: hex4 <= 7'b1000000; 
		4'b0001: hex4 <= 7'b1111001;
		4'b0010: hex4 <= 7'b0100100; 
		4'b0011: hex4 <= 7'b0110000; 
		4'b0100: hex4 <= 7'b0011001; 
		4'b0101: hex4 <= 7'b0010010; 
		4'b0110: hex4 <= 7'b0000010; 
		4'b0111: hex4 <= 7'b1111000; 
		4'b1000: hex4 <= 7'b0000000; 
		4'b1001: hex4 <= 7'b0010000; 
	 endcase	

	 case(mode)
		2'b00: hex5 <= 7'b1000000; 
		2'b01: hex5 <= 7'b1111001;
		2'b10: hex5 <= 7'b0100100; 
		2'b11: hex5 <= 7'b0110000; 
	 endcase
end
endmodule