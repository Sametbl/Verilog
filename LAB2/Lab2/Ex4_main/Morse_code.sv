module Morse_code(
		input  logic [2:0] switches,
		input  logic clk_50, reset, button,
		output logic dot, dash

);

wire logic [2:0] size, length;	
wire logic [3:0] data, code;
wire logic load_reg, pulse, shift_count, en_signal;
logic	Output, done;

assign dot  = ~data[0] & Output;
assign dash =  data[0] & Output;
assign done = ~(size[0] | size[1] | size[2]);
Letter_select		 alphabet(.Input(switches), .code(code), .length(length) );	

typedef enum logic [1:0] {IDLE = 2'b00, LOAD = 2'b01, READ = 2'b10, WRITE = 2'b11} statecode;
statecode	 	PreState, NextState;
always_comb begin
		case(PreState)
			IDLE:		if(button == 1)		 NextState = LOAD;  // IDLE: [Wait for button] 
						else		 				 NextState = IDLE;
						
			LOAD:		if(load_reg == 1)		 NextState = READ;  // LOAD: [Load datas to registers]
						else						 NextState = LOAD;
				
			READ:		if(done == 1)	       NextState = IDLE;
						else if(pulse ==1)    NextState = WRITE; // READ: [Shift] + [Count] + [wait half_second]
						else 						 NextState = READ;
							
			WRITE:	if(pulse == 1)	       NextState = READ;  // Output = 1
						else					 	 NextState = WRITE;	
		endcase	
end  

always_ff @(posedge clk_50, posedge reset) begin
		if(reset)			PreState <= IDLE;
		else					PreState <= NextState;
end

assign shift_count = (PreState == READ)  ? 1 : 0; 
assign load_reg    = (PreState == LOAD)  ? 1 : 0; 
assign Output		 = (PreState == WRITE) ? 1 : 0;
assign en_signal   = (PreState == READ) || (PreState == WRITE) ? 1 : 0;
								
pulse_500ms       enable (.clk_50(clk_50),   .rst(reset), .pulse(pulse), .enable(en_signal) );	
down_counter		Counter(.clk(shift_count), .reset(reset), .load(load_reg), .length_in(length), .counter(size) );
Shift_Right_4bit	Shifter(.clk(shift_count), .reset(reset), .load(load_reg), .data_in(code), .data_out(data) );
		
endmodule







module Letter_select(
		input  logic [2:0] Input,
		output logic [3:0] code,
		output logic [2:0] length
);
enum logic [2:0] {A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011,
						E = 3'b100,	F = 3'b101,	G = 3'b110, H = 3'b111} letter;	
always_comb begin
		case(Input) 
				A:	code   = 4'b0010;
				B:	code   = 4'b0001;		
				C:	code   = 4'b0101;		
				D:	code   = 4'b0001;		
				E:	code   = 4'b0000;		
				F:	code   = 4'b0100;	
				G:	code   = 4'b0011;	
				H:	code   = 4'b0000;
		endcase
		case(Input) 
				A:	length = 3'b010;		
				B:	length = 3'b100;					
				C:	length = 3'b100;				
				D:	length = 3'b011;					
				E:	length = 3'b001;					
				F:	length = 3'b100;						
				G:	length = 3'b011;		
				H:	length = 3'b100;
		endcase
end
endmodule


