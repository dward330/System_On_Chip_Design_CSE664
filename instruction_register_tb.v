`timescale 1ns / 1ps

module ins_register_tb;

// simulate receiving opcode and data back 
wire [3:0] opcode; 
wire [7:4] data; 

// instruction to opass 
reg [7:0] ins;

// simulate clock 
reg clock;

// simulate reset 
reg reset;

// simulate load signal
reg LoadIR;

// Instantiate IR as unit under test
instruction_register uut
	(
        .clock(clock),
        .reset(reset),
	.instruction(ins),
	.opcode(opcode),
        .data_out(data),
	.LoadIR(LoadIR)
	);
	
	// Oscillating clock
	always #5 clock = ~clock;

// simulate clock 
initial begin
	clock 	= 1;
	reset 	= 0;
	ins 	= 0;
	LoadIR 	= 0;

	// Update instruction without loading IR
	#10
	LoadIR 	= 0;
    ins 	= 8'b01001111;
    $display("data: 	%b", data);
    $display("opcode: 	%b", opcode);
	
	// Update instruction with loading IR
	#10
	LoadIR 	= 1;
    ins 	= 8'b01001110;
    $display("data: 	%b", data);
    $display("opcode: 	%b", opcode);
	
	// Update instruction with loading IR
	#10
	LoadIR 	= 1;
    ins 	= 8'b11000011;
    $display("data: 	%b", data);
    $display("opcode: 	%b", opcode);
	
	// Update instruction without loading IR
	#10
	LoadIR 	= 1;
    ins 	= 8'b00111100;
    $display("data: 	%b", data);
    $display("opcode: 	%b", opcode);
	
	// Test asynchronous active high reset
	#10
	#2
	reset = 1;
	#2 
	reset = 0;
    $display("data: 	%b", data);
    $display("opcode: 	%b", opcode);	
	
	// Load a value after reset on next clock
	LoadIR 	= 1;
    $display("data: 	%b", data);
    $display("opcode: 	%b", opcode);	
	
	// Let a couple clock cycles pass before concluding simulation
	#20
	$stop;
end 

endmodule


