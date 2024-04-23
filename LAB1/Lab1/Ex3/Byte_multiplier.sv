
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module Multiplier(
			input  logic [7:0] INPUT,
			input  logic EA, EB, clk, reset,
			output logic [7:0] current_value,
			output logic [15:0] Product
	);
	wire logic [7:0] A, B;
	wire logic [15:0] OUT;

	// current_value is used for displaying content of A and B when EA or EB is ON
	assign current_value = ( A & {8{EA}} ) | ( B &{8{EB}} );

	Byte_multiplier  Au(.A(A), .B(B), .Result(OUT) );
	Register_8bit   Input_A ( .clk(clk), .reset(reset), .enable(EA), .R(INPUT), .Q(A) );
	Register_8bit   Input_B ( .clk(clk), .reset(reset), .enable(EB), .R(INPUT), .Q(B) );
	Register_16bit  R_output( .clk(clk), .reset(reset), .R(OUT), .Q(Product));
	endmodule

	
	
	


	module Byte_multiplier(
			input  logic [7:0] A, B,
			output logic [15:0] Result
	);

	wire logic [7:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7;      
	wire logic [7:1] cout;

	assign Result[0]    = A[0] & B[0];    
	assign Result[1]    = sum1[0];
	assign Result[2]    = sum2[0];
	assign Result[3]    = sum3[0];
	assign Result[4]    = sum4[0];
	assign Result[5]    = sum5[0];
	assign Result[6]    = sum6[0];
	assign Result[14:7] = sum7;        
	assign Result[15]   = cout[7];        			

	Full_Adder_8bit  first (.a0(B[0]&A[1]), .a1(B[0]&A[2]), .a2(B[0]&A[3]), .a3(B[0]&A[4]),
									.a4(B[0]&A[5]), .a5(B[0]&A[6]), .a6(B[0]&A[7]), .a7(0),
									.b0(B[1]&A[0]), .b1(B[1]&A[1]), .b2(B[1]&A[2]), .b3(B[1]&A[3]),
									.b4(B[1]&A[4]), .b5(B[1]&A[5]), .b6(B[1]&A[6]), .b7(B[1]&A[7]),
									.Sum(sum1), .Cin(0), .C_out(cout[1]) );
									
	Full_Adder_8bit  shift1(.a0(sum1[1]),   .a1(sum1[2]),   .a2(sum1[3]),   .a3(sum1[4]),
									.a4(sum1[5]),   .a5(sum1[6]),   .a6(sum1[7]),   .a7(cout[1]),
									.b0(B[2]&A[0]), .b1(B[2]&A[1]), .b2(B[2]&A[2]), .b3(B[2]&A[3]),
									.b4(B[2]&A[4]), .b5(B[2]&A[5]), .b6(B[2]&A[6]), .b7(B[2]&A[7]),
									.Sum(sum2), .Cin(0), .C_out(cout[2])  );									 					
						
	Full_Adder_8bit  shift2(.a0(sum2[1]),   .a1(sum2[2]),   .a2(sum2[3]),   .a3(sum2[4]),
									.a4(sum2[5]),   .a5(sum2[6]),   .a6(sum2[7]),   .a7(cout[2]),
									.b0(B[3]&A[0]), .b1(B[3]&A[1]), .b2(B[3]&A[2]), .b3(B[3]&A[3]),
									.b4(B[3]&A[4]), .b5(B[3]&A[5]), .b6(B[3]&A[6]), .b7(B[3]&A[7]),
									.Sum(sum3), .Cin(0), .C_out(cout[3])  );									 					
						
	Full_Adder_8bit  shift3(.a0(sum3[1]),   .a1(sum3[2]),   .a2(sum3[3]),   .a3(sum3[4]),
									.a4(sum3[5]),   .a5(sum3[6]),   .a6(sum3[7]),   .a7(cout[3]),
									.b0(B[4]&A[0]), .b1(B[4]&A[1]), .b2(B[4]&A[2]), .b3(B[4]&A[3]),
									.b4(B[4]&A[4]), .b5(B[4]&A[5]), .b6(B[4]&A[6]), .b7(B[4]&A[7]),
									.Sum(sum4), .Cin(0), .C_out(cout[4])  );									 					
						
	Full_Adder_8bit  shift4(.a0(sum4[1]),   .a1(sum4[2]),   .a2(sum4[3]),   .a3(sum4[4]),
									.a4(sum4[5]),   .a5(sum4[6]),   .a6(sum4[7]),   .a7(cout[4]),
									.b0(B[5]&A[0]), .b1(B[5]&A[1]), .b2(B[5]&A[2]), .b3(B[5]&A[3]),
									.b4(B[5]&A[4]), .b5(B[5]&A[5]), .b6(B[5]&A[6]), .b7(B[5]&A[7]),
									.Sum(sum5), .Cin(0), .C_out(cout[5])  );									 					
						
	Full_Adder_8bit  shift5(.a0(sum5[1]),   .a1(sum5[2]),   .a2(sum5[3]),   .a3(sum5[4]),
									.a4(sum5[5]),   .a5(sum5[6]),   .a6(sum5[7]),   .a7(cout[5]),
									.b0(B[6]&A[0]), .b1(B[6]&A[1]), .b2(B[6]&A[2]), .b3(B[6]&A[3]),
									.b4(B[6]&A[4]), .b5(B[6]&A[5]), .b6(B[6]&A[6]), .b7(B[6]&A[7]),
									.Sum(sum6), .Cin(0), .C_out(cout[6])  );									 					
						
	Full_Adder_8bit  shift6(.a0(sum6[1]),   .a1(sum6[2]),   .a2(sum6[3]),   .a3(sum6[4]),
									.a4(sum6[5]),   .a5(sum6[6]),   .a6(sum6[7]),   .a7(cout[6]),
									.b0(B[7]&A[0]), .b1(B[7]&A[1]), .b2(B[7]&A[2]), .b3(B[7]&A[3]),
									.b4(B[7]&A[4]), .b5(B[7]&A[5]), .b6(B[7]&A[6]), .b7(B[7]&A[7]),
									.Sum(sum7), .Cin(0), .C_out(cout[7])  );									 					
															
	endmodule							
							
								 