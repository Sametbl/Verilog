
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module ALU(
			input  logic [7:0] INPUT,
			input  logic [1:0] Sel,					// Sel is 2-bit vector
			input  logic EA, EB, clk, reset,
			output logic [7:0] current_value,
			output logic [15:0] Product
	);
	wire logic [7:0] A, B, sum;
	wire logic [15:0] Sum_Diff;
	wire logic [15:0] OUT, Multi;

	// If Sel = 2'b11, then OUT = 0
	// If Sel[1]  = 1'b1, then OUT = Result of Multiplication
   // If Sel[1]  = 1'b0, then OUT = Output of 16-bit Full adder
	assign  OUT = ~{16{(Sel[1] & Sel[0])}} & ((Sum_Diff & {16{~Sel[1]}}) | (Multi & {16{Sel[1]}} ));
	
	Register_8bit    Input_A ( .clk(clk), .reset(reset), .enable(EA), .R(INPUT), .Q(A) );
	Register_8bit    Input_B ( .clk(clk), .reset(reset), .enable(EB), .R(INPUT), .Q(B) );
	Register_16bit   R_output( .clk(clk), .reset(reset), .R(OUT), .Q(Product));
	Byte_multiplier  Au2(.A(A), .B(B), .Result(Multi) );
	Full_Adder_16bit Au1(.A(A), .B(B), .En(Sel[0] & ~Sel[1]),  // Eliminate the case where Sel = 2'b11
								.S(Sum_Diff) );  
	// Since we store the addtion and subtraction results of 8-bit to a 16-bit signal,
	// There is no need for Carry out and oveflow check  								
	endmodule




	module Full_Adder_16bit (
			input  logic [15:0] A, B,    // A and B are positive values 
			input  logic En,   
			output logic [15:0] S,
			output logic C_out
	);
	wire logic Cout_1;	// Carry out of first 8-bit Full Adder to connect 2 8-bit full adders
	Full_Adder_8bit  First (.a0(A[0]), .a1(A[1]), .a2(A[2]), .a3(A[3]), .a4(A[4]), .a5(A[5]), .a6(A[6]), .a7(A[7]), 
									.b0(B[0]), .b1(B[1]), .b2(B[2]), .b3(B[3]), .b4(B[4]), .b5(B[5]), .b6(B[6]), .b7(B[7]), 
									.Sum(S[7:0]), .C_out(Cout_1), .Invert_B(En), .C_in(En) );  // En= 0 => Addition
	 
	Full_Adder_8bit  Second(.a0(A[8]), .a1(A[9]), .a2(A[10]), .a3(A[11]), .a4(A[12]), .a5(A[13]), .a6(A[14]), .a7(A[15]), 
									.b0(B[8]), .b1(B[9]), .b2(B[10]), .b3(B[11]), .b4(B[12]), .b5(B[13]), .b6(B[14]), .b7(B[15]), 
									.Sum(S[15:8]), .C_out(C_out), .Invert_B(En), .C_in(Cout_1)   );  
	endmodule							








