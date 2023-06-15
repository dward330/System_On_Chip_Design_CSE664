// Accumulator
// A register for temporarily storing ALU results

// Description
//! A register in which intermediate arithmetic logic unit results are stored.
//! This simple 8-bit accumulator's output will continuously grow by increments of
//! the input until reset.
//! 
//! Note - Overflow is not handled

`timescale 1ns / 1ps
module acc_simple (out, in, clock, reset);

// ----- Input Ports -----
	input clock; 		//! Clock. Output is posedge triggered
	input reset; 		//! Clears register value (1 = clear, 0 = hold)
	input [7 : 0] in;	//! Input from ALU

// ----- Output Port -----
	output [7 : 0] out;	//! Output return to ALU

// ----- Accumulator -----
	reg [7 : 0] accumulator = 8'b00000000;	//! Temporary storage for accumulator output


//! Increments output by input at rising edge of clock.
//! If reset is high then clear output. 
//!
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
