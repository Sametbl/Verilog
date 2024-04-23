module Display (
	  input  logic [7:0] binary, INPUT,
	  output logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5
);
	
wire logic [3:0] don_vi, hang_chuc, hang_tram, digit1, digit2, digit3;

assign don_vi    =  binary % 10;
assign hang_chuc = (binary % 100) / 10;
assign hang_tram =  binary /100;

assign digit1 =  INPUT % 10;
assign digit2 = (INPUT % 100) / 10;
assign digit3 =  INPUT / 100;

always@(*) begin
	 case (don_vi[3:0])
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
		default: hex0 <= 7'b1111111; // Error = off
	 endcase	
	 
	 case (hang_chuc[3:0])
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
		default: hex1 <= 7'b1111111; // Error = off
	 endcase	
	 
	 case (hang_tram[3:0])
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
		default: hex2 <= 7'b1111111; // Error = off
	 endcase	
	 
	 
	 	 case (digit1[3:0])
		4'b0000: hex3 <= 7'b1000000; 
		4'b0001: hex3 <= 7'b1111001;
		4'b0010: hex3 <= 7'b0100100; 
		4'b0011: hex3 <= 7'b0110000; 
		4'b0100: hex3 <= 7'b0011001; 
		4'b0101: hex3 <= 7'b0010010; 
		4'b0110: hex3<= 7'b0000010; 
		4'b0111: hex3 <= 7'b1111000; 
		4'b1000: hex3 <= 7'b0000000; 
		4'b1001: hex3 <= 7'b0010000; 
		default: hex3 <= 7'b1111111; // Error = off
	 endcase	
	 	 case (digit2[3:0])
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
		default: hex4 <= 7'b1111111; // Error = off
	 endcase	
	 	 	 case (digit3[3:0])
		4'b0000: hex5 <= 7'b1000000; 
		4'b0001: hex5 <= 7'b1111001;
		4'b0010: hex5 <= 7'b0100100; 
		4'b0011: hex5 <= 7'b0110000; 
		4'b0100: hex5 <= 7'b0011001; 
		4'b0101: hex5 <= 7'b0010010; 
		4'b0110: hex5 <= 7'b0000010; 
		4'b0111: hex5 <= 7'b1111000; 
		4'b1000: hex5 <= 7'b0000000; 
		4'b1001: hex5 <= 7'b0010000; 
		default: hex5 <= 7'b1111111; // Error = off
	 endcase	
	 
end
endmodule