/*module();

module processor (
		input  logic [8:0] DIN,
		input  logic Resetn, clk_50, Run, 
		output logic Done,
		output logic [8:0] Bus
); 
wire logic [15:0] Sum_Diff;
wire logic [7:0]  R_in, R_out; 		
wire logic [7:0]  R0, R1, R2, R3, R4, R5, R6, R7, regA, regG;	
wire logic [7:0]  IR, Xreg, Yreg;
wire logic [2:0]  Ins;
wire logic [1:0]  Sel_in, Sel_out;
wire logic [0:0]  AddSub, IR_in, A_in, G_in, G_out, DIN_out;


Full_Adder_16bit 	Adder (.A(regA), .B(Bus), .En(AddSub), .S(Sum_Diff) );  		
Controller     	CRTL (.IR(IR), .clk_50(clk_50), .Run(Run), .Resetn(Resetn),
								.DIN_out(DIN_out), .A_in(A_in), .G_in(G_in), .G_out(G_out),
								.AddSub(AddSub), .IR_in(IR_in), .Done(Done),
								.R_in(R_in), .R_out(R_out) );

			
Mux_16X1_onehot_9bit		Big_Mux(.Sel({6'b000000, DIN_out, G_out ,R_out}), .OUT(Bus),
										  .M0(R0), .M1(R1), .M2(R2),  .M3(R3),  .M4(R4),  .M5(R5),  .M6(R6),  .M7(R7), 
										  .M8(regG), .M9(DIN), .M10(0), .M11(0), .M12(0), .M13(0), .M14(0), .M15(0)   );
		

Register_9bit 		reg_0 (.En(R_in[0]), .clk(clk_50), .D(Bus), .Q(R0));
Register_9bit 		reg_1 (.En(R_in[1]), .clk(clk_50), .D(Bus), .Q(R1));
Register_9bit 		reg_2 (.En(R_in[2]), .clk(clk_50), .D(Bus), .Q(R2));
Register_9bit 		reg_3 (.En(R_in[3]), .clk(clk_50), .D(Bus), .Q(R3));
Register_9bit 		reg_4 (.En(R_in[4]), .clk(clk_50), .D(Bus), .Q(R4));
Register_9bit 		reg_5 (.En(R_in[5]), .clk(clk_50), .D(Bus), .Q(R5));
Register_9bit 		reg_6 (.En(R_in[6]), .clk(clk_50), .D(Bus), .Q(R6));
Register_9bit 		reg_7 (.En(R_in[7]), .clk(clk_50), .D(Bus), .Q(R7));
Register_9bit 		reg_A (.En(A_in), .clk(clk_50), .D(Bus), .Q(regA));
Register_9bit 		reg_G (.En(G_in), .clk(clk_50), .D({Sum_Diff[15], Sum_Diff[7:0]}), .Q(regG));
Register_9bit 		reg_IR(.En(IR_in),   .clk(clk_50), .D(DIN), .Q(IR));

endmodule

















module Controller(
		input  logic [8:0] IR,
		input  logic clk_50, Resetn, Run,
		output logic Done, IR_in, A_in, G_in, G_out, AddSub, DIN_out,
		output logic [7:0] R_in, R_out
		
);
typedef enum bit [1:0] {T0 = 2'b00, T1 = 2'b01, T2 = 2'b10, T3 = 2'b11} states;		  
states   PreStep, NextStep;
		
wire logic [7:0]  Xreg, Yreg;
wire logic [2:0]  Ins;
wire logic [1:0]  Sel_in, Sel_out;


assign Ins   = IR[2:0];


dec3to8 				regX   (.W(IR[5:3]), .En(1), .Y(Xreg)); 
dec3to8 				regY   (.W(IR[2:0]), .En(1), .Y(Yreg));
// Control FSM state table 
always_ff @(posedge clk_50, posedge Run) begin 
		case (PreStep) 
			T0: 	if (Run) 					NextStep <= T1;
					else 							NextStep <= T0; 
					
			T1: 	if (Done)					NextStep <= T0;
					else if (clk_50)			NextStep <= T2;
					else							NextStep <= T1;
			
			T2: 	if (Done)					NextStep <= T0;
					else if (clk_50)			NextStep <= T3;
					else 							NextStep <= T2;
			
			T3: 	if (Done)					NextStep <= T0;
			      else if (clk_50) 		   NextStep <= T0;
					else 							NextStep <= T3;
						
		endcase 
end 
		
 Control FSM outputs 
always @(PreStep) begin 
	case (PreStep) 
		T0: 	begin
					Done    = 0;	
					Sel_out = 0;    
					Sel_in  = 0;
					G_in    = 0;
					A_in    = 0;
					IR_in   = 1;
				end
		T1:   case (Ins) // Enable registers to load data
					3'b000: 	begin 
									Sel_in  = 2'b01;				// Enable Register X (to receive data from register Y)
									Sel_out = 2'b10;				// Bus = Register Y
									Done    = 1;
								end
								
					3'b001:	begin
									Sel_in  = 2'b01;				// Enable Register X (to receive data from DIN)
									DIN_out = 1;					// Bus = DIN
									Done    = 1;
								end
								
					3'b010:	begin
									A_in    = 1;					// Enable Register A (to store the 1st operand)
									Sel_out = 2'b01;				// Bus = Register X (Operand 1)	
								end
								
					3'b011:	begin
									A_in    = 1;					// Enable Register A (to store the 1st operand)
									Sel_out = 2'b01;				// Bus = Register X (Operand 1)
								end
					default: Done = 1;
				endcase
		T2: 	case (Ins) 
					3'b010:  begin
									A_in    = 0;
									Sel_out = 2'b10;				// Bus = Register Y (Operand 2)
									G_in    = 1;					// Enable register G (to store result)
									AddSub  = 1'b0;				// Addition mode
								end
								
					3'b011:	begin
									A_in    = 0;
									Sel_out = 2'b10;				// Bus = Register Y (Operand 2)
									G_in    = 1;					// Enable register G (to store result)
									AddSub  = 1'b1;				// Subtraction mode
								end
					default:	Done = 1;			
				endcase
		T3: 	case (Ins) 
					3'b010:	begin
									G_out   = 1;						// Bus = Register G
									Sel_in  = 2'b01;				// Enable Register X (receive data)
									Done    = 1;
								end
								
					3'b011:	begin
									G_out   = 1;						// Bus = Register G
									Sel_in  = 2'b01;				// Enable Register X (receive data)
									Done    = 1;
								end
					default: Done = 1;
				endcase 
		endcase
end 


// Control FSM flip-flops 
always_ff @(posedge clk_50, negedge Resetn) begin
		if (!Resetn) 	PreStep		<= T0;
		else 				PreStep		<= NextStep;
end
	

Mux_2X1_8bit_OH	Reg_in (.Sel(Sel_in),  .X(Xreg), .Y(Yreg), .I_out(R_in));
Mux_2X1_8bit_OH	Reg_out(.Sel(Sel_out), .X(Xreg), .Y(Yreg), .I_out(R_out));
	
	
endmodule















*/






