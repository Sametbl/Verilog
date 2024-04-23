module Full_Adder_Nbit #(parameter N = 8)(
		input  logic [N-1:0] A, B,
		input  logic [0:0]   En,          // En = 1 => Output = A - B
		output logic [N-1:0] Sum,
	   output logic [0:0]   C_out
);

wire logic [N-1:0] Cout;  // To wiring C_out of a Full adder to C_in of other

generate
	genvar i;
		Full_Adder 	init (.A(A[0]), .B(B[0] ^ En), .Sum(Sum[0]), .C_in(En), .C_out(Cout[0]));
		
	for (i = 1; i < N; i = i +1) begin :Nbit
		Full_Adder  digit(.A(A[i]), .B(B[i] ^ En), .Sum(Sum[i]), .C_in(Cout[i-1]), .C_out(Cout[i]) );
	end
endgenerate

assign C_out = Cout[N-1];

endmodule
