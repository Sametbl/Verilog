
	// Luong Thanh Vy, Tran Trung Toan, Nguyen Tran Truc Minh
	module accumulator_ADD_SUB(
			input  logic [7:0] A,
			input  logic clk, reset, add_sub,
			output logic [7:0] S,
			output logic carry, overflow
	);

	wire logic [7:0] Reg_in, Reg_out, out;
	wire logic [0:0] V, Cout;
	assign S = Reg_out;

	Full_Adder_Subtractor_8bit 	 Au(.a(Reg_out), .b(Reg_in),
												 .Sum(out), .C_out(Cout), .En(add_sub), .V(V) );
												 
	Register_8bit 	  R_input ( .clk(clk), .reset(reset), .R(A),   .Q(Reg_in) );
	Register_8bit    R_output( .clk(clk), .reset(reset), .R(out), .Q(Reg_out));
	D_flip_flop	     R_Carry_out(.clk(clk), .rst(reset), .D(Cout), .Q(carry) );
	D_flip_flop      R_overflow (.clk(clk), .rst(reset), .D(V)   , .Q(overflow));  			  
	endmodule