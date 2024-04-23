module Full_Adder_8bit(
		input  logic [7:0] a,
		input  logic [7:0] b,
		input  logic En, C_in,        
		output logic [7:0] Sum,
		output logic C_out
);
wire logic Connect;
Full_Adder_4bit   fisrt (.A(a[3:0]), .B(b[3:0]), .En(En), .C_in(C_in),    .Sum(Sum[3:0]), .C_out(Connect) );
Full_Adder_4bit   second(.A(a[7:4]), .B(b[7:4]), .En(En), .C_in(Connect), .Sum(Sum[7:4]), .C_out(C_out) );

endmodule



module Full_Adder_4bit(
		input  logic [3:0] A,
		input  logic [3:0] B,
		input  logic En, C_in,        
		output logic [3:0] Sum,
		output logic [0:0] C_out
);
wire logic [3:0] cout;  
Full_Adder 	digit1 (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(C_in),    .C_out(cout[0]));
Full_Adder	digit2 (.A(A[1]), .B(B[1] ^ En), .Sum(Sum[1]), .C_in(cout[0]), .C_out(cout[1]));
Full_Adder 	digit3 (.A(A[2]), .B(B[2] ^ En), .Sum(Sum[2]), .C_in(cout[1]), .C_out(cout[2]));
Full_Adder 	digit4 (.A(A[3]), .B(B[3] ^ En), .Sum(Sum[3]), .C_in(cout[2]), .C_out(cout[3]));
assign C_out = cout[3];
endmodule






module Full_Adder(
		input  logic A, B, C_in,
		output logic Sum, C_out
);
// Sum   = [A] XOR [B] XOR [C_in]
// C_out = A.B + (  [C_in].([A] XOR [B])  ) 

assign Sum   =  A ^ B ^ C_in;
assign C_out = (A & B) | ( C_in & (A ^ B) );
endmodule