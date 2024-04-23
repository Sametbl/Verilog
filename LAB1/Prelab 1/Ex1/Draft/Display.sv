module Display (
	  input  logic [7:0] binary,
	  output logic [6:0] hex0, hex1, hex2
);
	
wire  [3:0] don_vi, hang_chuc, hang_tram;

assign don_vi    =  binary % 10;
assign hang_chuc = (binary % 100) / 10;
assign hang_tram =  binary /100;

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
end
endmodule