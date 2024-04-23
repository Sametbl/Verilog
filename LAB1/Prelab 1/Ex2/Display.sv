module Display (
	  input  logic [15:0] binary,
	  output logic [6:0] hex0, hex1, hex2, hex3, hex4
);
	
wire logic [3:0] unit, tens, hundreds, thousands, vanj;
assign unit      =  binary % 10;
assign tens      = (binary %100)   /10;
assign hundreds  = (binary %1000)  /100;
assign thousands = (binary %10000) /1000;
assign vanj      =  binary /10000;

always@(*) begin
	 case (unit[3:0])
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
	 
	 case (tens[3:0])
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
	 
	 case (hundreds[3:0])
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
	 
	 case (thousands[3:0])
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
		default: hex3 <= 7'b1111111; // Error = off
	 endcase	
	 
	 case (vanj[3:0])
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
	 
	 
end
endmodule