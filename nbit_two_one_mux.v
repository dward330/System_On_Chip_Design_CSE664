`timescale 1ns / 1ps

/* This module is a parameterized two one mux.
 It can be instantiated with varying widths for input A bus,
 input B bus, and output bus.
 
 Example 1: 4-bit A bus, 8-bit B Bus, 8-bit OUT bus:
 nbit_two_one_mux
	#(.A_WIDTH(4), 
	.B_WIDTH(8),
	.OUT_WIDTH(8))
	uut (
		.bus_out(Y), 
		.bus_a(A), 
		.bus_b(B), 
		.select(S)
	);
	
 Example 2: 8-bit A bus, 8-bit B Bus, 8-bit OUT bus:
 nbit_two_one_mux
	#(.A_WIDTH(8), 
	.B_WIDTH(8),
	.OUT_WIDTH(8))
	uut (
		.bus_out(Y), 
		.bus_a(A), 
		.bus_b(B), 
		.select(S)
	);
	
 Example 3: 8-bit A bus, 4-bit B Bus, 8-bit OUT bus:
 nbit_two_one_mux
	#(.A_WIDTH(8), 
	.B_WIDTH(4),
	.OUT_WIDTH(8))
	uut (
		.bus_out(Y), 
		.bus_a(A), 
		.bus_b(B), 
		.select(S)
	);
	
 */
module nbit_two_one_mux 
#(parameter 
	A_WIDTH=1,  // Width of INPUT BUS A
	B_WIDTH=1,  // Width of INPUT BUS B
	OUT_WIDTH=1	// Width of output
)
(	bus_out,	// Output bus
	bus_a,		// Input bus A
	bus_b, 		// Input bus B
	select		// Select Signal
);
	
	// Set up wire buses with parameterized widths
	output wire [OUT_WIDTH-1:0] bus_out;
	input wire  [A_WIDTH-1:0] 	bus_a;
	input wire  [B_WIDTH-1:0] 	bus_b;
	input wire  select;

	// Ternary operator to cover mux logic, needs "assign"
	assign bus_out = select ? bus_b : bus_a;
	
endmodule