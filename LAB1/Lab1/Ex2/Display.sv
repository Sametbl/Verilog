// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
module Display (
	  input  logic [7:0] hex_in_A, hex_in_S,
	  output logic [6:0] hex0, hex1, hex2, hex3
);
	
reg [3:0] digitS1, digitS2, digitA1, digitA2;

assign digitS1    = hex_in_S % 16;
assign digitS2    = hex_in_S / 16;
assign digitA1    = hex_in_A % 16;
assign digitA2    = hex_in_A / 16;


always@(*) begin
	 case (digitS1[3:0])
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
		4'b1010: hex0 <= 7'b0001000;
		4'b1011: hex0 <= 7'b0000011;
		4'b1100: hex0 <= 7'b1000110;
		4'b1101: hex0 <= 7'b0100001;
		4'b1110: hex0 <= 7'b0000110;
		4'b1111: hex0 <= 7'b0001110;
	 endcase	
	 
	 case (digitS2[3:0])
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
		4'b1010: hex1 <= 7'b0001000;
		4'b1011: hex1 <= 7'b0000011;
		4'b1100: hex1 <= 7'b1000110;
		4'b1101: hex1 <= 7'b0100001;
		4'b1110: hex1 <= 7'b0000110;
		4'b1111: hex1 <= 7'b0001110;
	 endcase	
	 
	
	 case (digitA1[3:0])
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
		4'b1010: hex2 <= 7'b0001000;
		4'b1011: hex2 <= 7'b0000011;
		4'b1100: hex2 <= 7'b1000110;
		4'b1101: hex2 <= 7'b0100001;
		4'b1110: hex2 <= 7'b0000110;
		4'b1111: hex2 <= 7'b0001110;
	 endcase	
	 	 case (digitA2[3:0])
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
		4'b1010: hex3 <= 7'b0001000;
		4'b1011: hex3 <= 7'b0000011;
		4'b1100: hex3 <= 7'b1000110;
		4'b1101: hex3 <= 7'b0100001;
		4'b1110: hex3 <= 7'b0000110;
		4'b1111: hex3 <= 7'b0001110;
	 endcase	
	 
end
endmodule