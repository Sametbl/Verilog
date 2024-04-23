
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module Full_Adder_4bit(
			input  logic [3:0] A,
			input  logic [3:0] B,
			input  logic Cin, En,    // Cin and En is seperated so that we can connect 2 of this module
			output logic [3:0] Sum,
			output logic [0:0] C_out
	);
	wire logic [3:0] cout;  // Stores Carry out of each Full adder
	Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(Cin),     .C_out(cout[0]));
	Full_Adder	digit2 (.A(A[1]), .B(B[1] ^ En), .Sum(Sum[1]), .C_in(cout[0]), .C_out(cout[1]));
	Full_Adder 	digit3 (.A(A[2]), .B(B[2] ^ En), .Sum(Sum[2]), .C_in(cout[1]), .C_out(cout[2]));
	Full_Adder 	digit4 (.A(A[3]), .B(B[3] ^ En), .Sum(Sum[3]), .C_in(cout[2]), .C_out(cout[3]));
	assign C_out = cout[3];
	endmodule

	
	module Full_Adder_8bit (
			input  logic [7:0] a,
			input  logic [7:0] b,
			input  logic En,
			output logic [7:0] Sum,
			output logic [0:0] C_out, V
	);
	wire logic cout_M1, cout_M2;  // Stores Carry out of each Full adder
	Full_Adder_4bit 	adder1(.A(a[3:0]), .B(b[3:0]), .En(En),
									 .Sum(Sum[3:0]), .Cin(En), .C_out(cout_M1));
									 
	Full_Adder_4bit 	adder2(.A(a[7:4]), .B(b[7:4]), .En(En),
									 .Sum(Sum[7:4]), .Cin(cout_M1), .C_out(cout_M2));

	assign C_out = cout_M2;
	//overflow = sign of 2 Registers are the same, and not equal to sign of S 
	assign V = ~(a[7] ^ b[7]) & (a[7] ^ Sum[7]);
	endmodule
