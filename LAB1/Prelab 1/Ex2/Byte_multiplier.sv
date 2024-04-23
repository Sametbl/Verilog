module Byte_multiplier(
		input  logic [7:0] A, B,
		output logic [15:0] Result
);


wire logic [7:1][7:0] sum;         // matrix of seven 8-bit "sum"
wire logic [7:1] cout;

assign Result[0]    = A[0] & B[0];     // 1st digit
assign Result[1]    = sum[1][0];
assign Result[2]    = sum[2][0];
assign Result[3]    = sum[3][0];
assign Result[4]    = sum[4][0];
assign Result[5]    = sum[5][0];
assign Result[6]    = sum[6][0];
assign Result[14:7] = sum[7];            // Sum of the last Full-Adder
assign Result[15]   = cout[7];           // Last (7th) digit					

generate
	genvar i;
			Full_Adder_8bit  first (.a0(B[0]&A[1]), .a1(B[0]&A[2]), .a2(B[0]&A[3]), .a3(B[0]&A[4]),
											.a4(B[0]&A[5]), .a5(B[0]&A[6]), .a6(B[0]&A[7]), .a7(0),
											.b0(B[1]&A[0]), .b1(B[1]&A[1]), .b2(B[1]&A[2]), .b3(B[1]&A[3]),
											.b4(B[1]&A[4]), .b5(B[1]&A[5]), .b6(B[1]&A[6]), .b7(B[1]&A[7]),
											.Sum(sum[1]),   .C_out(cout[1]) );
											
	for (i = 2; i < 8; i++) begin
	
			Full_Adder_8bit  shift (.a0(sum[i-1][1]), .a1(sum[i-1][2]), .a2(sum[i-1][3]), .a3(sum[i-1][4]),
											.a4(sum[i-1][5]), .a5(sum[i-1][6]), .a6(sum[i-1][7]), .a7(cout[i-1]),
                                 .b0(B[i]&A[0]),   .b1(B[i]&A[1]),   .b2(B[i]&A[2]),   .b3(B[i]&A[3]),
											.b4(B[i]&A[4]),   .b5(B[i]&A[5]),   .b6(B[i]&A[6]),   .b7(B[i]&A[7]),
											.Sum(sum[i]),   .C_out(cout[i])  );			
						 					
	end
endgenerate
endmodule							
							
								 