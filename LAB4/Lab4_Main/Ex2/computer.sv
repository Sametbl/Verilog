module computer(
		input  logic clk_50, Reset, Run,
		output logic Done, 
		output logic [1:0] State,
		output logic [8:0] R0, R1, R2, R3, R4, R5, R6, R7, regA, regG, IR,
		output logic [8:0] Bus, data,
		output logic [4:0] addr,
		output logic get_DIN
);



processor			CPU(.clk_50(clk_50), .Resetn(Reset), .Run(Run), .Done(Done), .DIN(data), .Bus(Bus),
						    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7),
							 .regA(regA), .regG(regG), .IR(IR), .State(State), .get_DIN(get_DIN) );

// IR is enabled when PreStep returns to T0 after finished excecuting an instruction
// Return to T0 when Done transition to LOW
MyROM			      Memory(.CLK(Done | get_DIN), .ADDRESS(addr), .DATAOUT(data));
Up_counter_5bit	    PC(.clk(Done | get_DIN), .reset(Reset),  .counter(addr));
endmodule