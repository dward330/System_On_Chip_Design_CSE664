/*******************************************************************************
** PROJECT:
** Final Project
** CSE 664 CSE 664 Introduction to System-on-Chip Design, Spring 2023
** Section M401, Dr. Mohammad Abdallah
**
** NAME: Accumulator
**
** DESCRIPTION:
** A register in which intermediate arithmetic logic unit results are stored.
** The 8-bit accumulator's output will grow when directed to update or
** the input receives the reset signal.
**
********************************************************************************
** VERSION HISTORY
**
**    Rev         Author              		Date
** -----------------------------------------------------------------------------
**    1.1         M. Pe�a           		17-June-2023
**                Input/memory control
**
**    1.0         M. Pe�a           		01-June-2023
**                Initial version, no input control or overflow logic
**
*******************************************************************************/

`timescale 1ns / 1ps

/*******************************************************************************
**
** v1.1
**
*******************************************************************************/

module acc (
	output [7 : 0] out, //! Value stored in the register, to be returned to ALU.
	input [7 : 0] in, //! Value (from ALU) to increment current register value by.
	input update, //! Signal (active high) to update the register value by "in"'s value.
	input clock, //! Clock signal and posedge triggered.
	input reset //! Signal (active high) to clear register value and set value stored back to 0.
	);

// ----- Accumulator -----
	reg [7 : 0] accumulator = 8'b00000000;	// Temporary storage for accumulator output


// Increments output by input at rising edge of clock.
// If reset is high then clear output. 

always @(posedge clock or posedge reset)	// at posedge of clock or reset=1
begin
	if (reset)				// if reset = 1
		accumulator <= 0;		// reset accumulator to 0
	else if (update)
		accumulator <= accumulator + in; // store value in accumulator if change bit = 1
end
	assign out = accumulator; 		// send value back to ALU
endmodule

/*******************************************************************************
**
** v1.0
**
*******************************************************************************/

module acc_simple (
	output [7 : 0] out, //! Value stored in the register, to be returned to ALU.
	input [7 : 0] in, //! Value (from ALU) to increment current register value by.
	input clock, //! Clock signal (posedge triggered).
	input reset //! Signal (active high) to clear register value and set value stored back to 0.
	);

// ----- Accumulator -----
	reg [7 : 0] accumulator = 8'b00000000;	// Temporary storage for accumulator output


// Increments output by input at rising edge of clock.
// If reset is high then clear output. 

always @(posedge clock or posedge reset)	// at posedge of clock or reset=1

begin

#15 // delay to let ctrl signal propagate / write ALU result to ACC
	if (reset)				// if reset = 1
		accumulator <= 0;		// reset accumulator to 0
	else if (update)
		accumulator <= in; // store value in accumulator if change bit = 1
end


	assign #3 out = accumulator; 		// send value back to ALU, delay 3 ns to read
	
	
endmodule




