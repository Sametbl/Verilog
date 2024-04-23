module processor (
		input  logic [8:0] DIN,
		input  logic Resetn, clk_50, Run,    // All modules have Active LOW reset pins
		output logic Done, get_DIN,
		output logic [8:0] Bus,
		output logic [8:0] R0, R1, R2, R3, R4, R5, R6, R7, regA, regG, IR,
		output logic [1:0] State
); 
wire logic [15:0] Sum_Diff;
wire logic [7:0]  R_in, R_out; 		
wire logic [7:0]  Xreg, Yreg;
wire logic [2:0]  Ins;
wire logic [1:0]  Sel_in, Sel_out;
wire logic [0:0]  AddSub, IR_in, A_in, G_in, G_out, DIN_out;


Full_Adder_16bit 	Adder (.A(regA), .B(Bus), .En(AddSub), .S(Sum_Diff) );  		
Controller     	CRTL (.IR(IR),     .clk_50(clk_50), .Run(Run),     .Resetn(Resetn),
								.Done(Done), .AddSub(AddSub), .State(State), .DIN_out(DIN_out),
								.R_in(R_in), .R_out(R_out),   .G_in(G_in),   .G_out(G_out), 
								.A_in(A_in), .IR_in(IR_in),   .get_DIN(get_DIN)	);

			
Mux_16X1_onehot_9bit		Big_Mux(.Sel({6'b000000, DIN_out, G_out ,R_out}), .OUT(Bus),
										  .M0(R0), .M1(R1), .M2(R2), .M3(R3)  , .M4(R4) ,
										  .M5(R5), .M6(R6), .M7(R7), .M8(regG), .M9(DIN),
										  .M10(0), .M11(0), .M12(0), .M13(0)  , .M14(0) , .M15(0));
		
Register_9bit 		reg_IR(.En(IR_in),   .clk(clk_50), .reset(Resetn), .D(DIN), .Q(IR));
Register_9bit 		reg_0 (.En(R_in[0]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R0));
Register_9bit 		reg_1 (.En(R_in[1]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R1));
Register_9bit 		reg_2 (.En(R_in[2]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R2));
Register_9bit 		reg_3 (.En(R_in[3]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R3));
Register_9bit 		reg_4 (.En(R_in[4]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R4));
Register_9bit 		reg_5 (.En(R_in[5]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R5));
Register_9bit 		reg_6 (.En(R_in[6]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R6));
Register_9bit 		reg_7 (.En(R_in[7]), .clk(clk_50), .reset(Resetn), .D(Bus), .Q(R7));
Register_9bit 		reg_A (.En(A_in),    .clk(clk_50), .reset(Resetn), .D(Bus), .Q(regA));
Register_9bit 		reg_G (.En(G_in),    .clk(clk_50), .reset(Resetn), .D({Sum_Diff[15], Sum_Diff[7:0]}), .Q(regG));
endmodule



//-------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------

module Controller(
		input  logic [8:0] IR,
		input  logic clk_50, Resetn, Run,
		output logic Done, IR_in, A_in, G_in, G_out, AddSub, DIN_out, get_DIN,
		output logic [1:0] State,
		output logic [7:0] R_in, R_out
		
);
typedef enum bit [1:0] {T0 = 2'b00, T1 = 2'b01, T2 = 2'b10, T3 = 2'b11} states;		  
states   PreStep, NextStep;

assign State = PreStep;		
wire logic [7:0]  Xreg, Yreg;
wire logic [2:0]  Opcode;
wire logic [1:0]  Sel_in, Sel_out;
wire logic MV, MVI, ADD, SUB, Reserved;

assign Opcode   = IR[8:6];


decoder_3to8 		regX   (.W(IR[5:3]), .En(1), .Y(Xreg)); 
decoder_3to8 		regY   (.W(IR[2:0]), .En(1), .Y(Yreg));
Mux_2X1_8bit_OH	Reg_in (.Sel(Sel_in),  .X(Xreg), .Y(Yreg), .I_out(R_in));
Mux_2X1_8bit_OH	Reg_out(.Sel(Sel_out), .X(Xreg), .Y(Yreg), .I_out(R_out));
// Control FSM flip-flops 
always_ff @(posedge clk_50, negedge Resetn) 		// if-else = one statement
		if (!Resetn) 	PreStep		<= T0;
		else 				PreStep		<= NextStep;


// Control FSM state table
always_ff @(posedge clk_50, posedge Run)			// case = one statement
		case (PreStep) 
			T0: 	if (Run)   NextStep <= T1;		else NextStep <= T0; 		
			T1: 	if (Done)  NextStep <= T0;		else NextStep <= T2;
			T2: 	if (Done)  NextStep <= T0;		else NextStep <= T3;
			T3: 				  NextStep <= T0;				
		endcase 


//Control FSM outputs 
// The following output signals respond to only 4 given instructions
assign MV  = ~Opcode[2] & ~Opcode[1] & ~Opcode[0];
assign MVI = ~Opcode[2] & ~Opcode[1] &  Opcode[0];
assign ADD = ~Opcode[2] &  Opcode[1] & ~Opcode[0];
assign SUB = ~Opcode[2] &  Opcode[1] &  Opcode[0];

// Unknown intructions if Opcode > 3, or Opcode[2] = 1
assign Reserved = Opcode[2]; 

 // Sel_in = 2'b01: regX = Bus
assign Sel_in[1]  = 0; 
assign Sel_in[0]  = (PreStep == T1) & (MV|MVI)  ||  (PreStep == T3) & (ADD|SUB);         

 // Sel_out = 2'b01: Bus = regX
 // Sel_out = 2'b10: Bus = regY
assign Sel_out[0] = (PreStep == T1) & (ADD|SUB);
assign Sel_out[1] = (PreStep == T1) &  MV  ||   (PreStep == T2) & (ADD|SUB);

assign get_DIN =  DIN_out;
assign IR_in   = (PreStep == T0); 
assign DIN_out = (PreStep == T1) &  MVI;
assign AddSub  = (PreStep == T2) &  SUB;		
assign A_in    = (PreStep == T1) & (ADD|SUB);						  // When Ins = 01X 
assign G_in    = (PreStep == T2) & (ADD|SUB);						  // When Ins = 01X
assign G_out   = (PreStep == T3) & (ADD|SUB);						  // When INs = 01X		
assign Done    = (PreStep == T1) &  MV |  
					  (PreStep == T3) &  MVI|                         // MVI has 3 steps to (load DIN)
					  (PreStep == T3) & (ADD|SUB) | Reserved;    			  
endmodule



















/*
//Control FSM outputs 
// The following output signals respond to only 4 given instructions

assign Sel_in[0]  =  (~Ins[1] & ~Ins[2] & (PreStep == T1)) |   		  // when Ins = 00X
						   ( Ins[1] & ~Ins[2] & (PreStep == T3));     	     // when Ins = 01X
assign Sel_in[1]  = 0; 

assign Sel_out[0] = Ins[1] & ~Ins[2] & (PreStep == T1); 					  // When Ins = 01X
assign Sel_out[1] = (~Ins[0] & ~Ins[1] & ~Ins[2] & (PreStep == T1)) |  // when Ins = 000
						  ( Ins[1] & ~Ins[2] & (PreStep == T2)); 		  		  // When Ins = 01X

assign DIN_out = Ins[0] & ~Ins[1] & ~Ins[2] & (PreStep == T1); 		  // When Ins = 001
assign A_in    = Ins[1] & ~Ins[2] & (PreStep == T1);						  // When Ins = 01X 
assign G_in    = Ins[1] & ~Ins[2] & (PreStep == T2);						  // When Ins = 01X
assign G_out   = Ins[1] & ~Ins[2] & (PreStep == T3);						  // When INs = 01X
assign AddSub  = Ins[0] & Ins[1] & ~Ins[2] & (PreStep == T2);			  // When INs = 011
assign IR_in   = (PreStep == T0) ? 1 : 0; 

// Done also assert when unknowned instruction is encountered (Ins = 4 -> 7, or Ins[2] = 1)
//assign Done    =   Ins[2] |
//					    ((PreStep == T1) & ~Ins[1] & ~Ins[2]) |                // When Ins = 00X and T1
//				       ((PreStep == T3) &  Ins[1] & ~Ins[2]);                 // Or Ins = 01X and T3
				  
assign Done    =   Ins[2] | ((PreStep == T1) & ~Ins[1]) |                 // When Ins = 00X and T1
									 ((PreStep == T3) &  Ins[1]); 					  // Or Ins = 01X and T3
				  
*/










