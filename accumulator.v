// Accumulator
// A register for temporarily storing ALU results


// Simple 8-bit Accumulator
// Doesn't take into account overflow if reset!=1
`timescale 1ns / 1ps
module acc_simple (out, in, clock, reset);

// ----- Input Ports -----
	input clock; 		// clock. output only changes on posedge
	input reset; 		// for clearing register value
	input [7 : 0] in;	// input from ALU

// ----- Output Port -----
	output [7 : 0] out;	// output return to ALU

// ----- Accumulator -----
	reg [7 : 0] accumulator = 8'b00000000;	// accumulator for ALU temporary storage

// Process
always @(posedge clock or posedge reset)	// at posedge of clock or reset=1
begin
	if (reset)				// if reset = 1
		accumulator <= 0;		// reset accumulator to 0
	else
		accumulator <= accumulator + in; // otherwise, store value in accumulator
end
	assign out = accumulator; 		// send value back to ALU
endmodule



// Accumulator Testbench
`timescale 1ns / 1ps
module acc_simple_tb;

	reg clock;
	reg reset;
	reg [7 : 0] in;
	wire [7 : 0] out;

	acc_simple acc(.out(out), .in(in), .clock(clock), .reset(reset));

	initial 
		begin	// simulate clock
		clock = 1'b0;
		forever begin
			#1 clock = ~clock;
		end
	end
	
	initial
		begin
		#0 reset <= 0;
		in <= 8'b10110010;
		#2 reset <= 0;
		in <= 8'b00000010;
		#2 reset <= 0;
		in <= 8'b00001111;
		#2 reset <= 1;
		in <= 8'b11100010;
		#2 reset <= 0;
		in <= 8'b00011010;
		#2 reset <= 0;
		in <= 8'b00000011;
		#2 reset <= 1;
		in <= 8'b10101010;
		#2 reset <= 0;
		in <= 8'b01010101;
		#2 $finish;
	end
endmodule
