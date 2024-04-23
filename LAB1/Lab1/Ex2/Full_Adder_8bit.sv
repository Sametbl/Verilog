
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module Full_Adder_Subtractor_8bit (
			input  logic [7:0] a,
			input  logic [7:0] b,
			input  logic En,
			output logic [7:0] Sum,
			output logic [0:0] C_out, V
	);
	logic [7:0] Cout, tmp;  // To wiring C_out of a Full adder to C_in of other
	assign	tmp[0] = b[0] ^ En;
	assign	tmp[1] = b[1] ^ En;
	assign	tmp[2] = b[2] ^ En;
	assign	tmp[3] = b[3] ^ En;
	assign	tmp[4] = b[4] ^ En;
	assign	tmp[5] = b[5] ^ En;
	assign	tmp[6] = b[6] ^ En;
	assign	tmp[7] = b[7] ^ En;

	Full_Adder 	digit1 (.A(a[0]), .B(tmp[0]), .Sum(Sum[0]), .C_in(En),      .C_out(Cout[0]));
	Full_Adder	digit2 (.A(a[1]), .B(tmp[1]), .Sum(Sum[1]), .C_in(Cout[0]), .C_out(Cout[1]));
	Full_Adder 	digit3 (.A(a[2]), .B(tmp[2]), .Sum(Sum[2]), .C_in(Cout[1]), .C_out(Cout[2]));
	Full_Adder 	digit4 (.A(a[3]), .B(tmp[3]), .Sum(Sum[3]), .C_in(Cout[2]), .C_out(Cout[3]));
	Full_Adder 	digit5 (.A(a[4]), .B(tmp[4]), .Sum(Sum[4]), .C_in(Cout[3]), .C_out(Cout[4]));
	Full_Adder 	digit6 (.A(a[5]), .B(tmp[5]), .Sum(Sum[5]), .C_in(Cout[4]), .C_out(Cout[5]));
	Full_Adder 	digit7 (.A(a[6]), .B(tmp[6]), .Sum(Sum[6]), .C_in(Cout[5]), .C_out(Cout[6]));
	Full_Adder 	digit8 (.A(a[7]), .B(tmp[7]), .Sum(Sum[7]), .C_in(Cout[6]), .C_out(Cout[7]));

	assign C_out = Cout[7];
	//overflow = sign of 2 Registers are the same, and not equal to sign of S 
	assign V = ~(a[7] ^ tmp[7]) & (a[7] ^ Sum[7]);      
	endmodule
