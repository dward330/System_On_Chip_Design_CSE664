/*******************************************************************************
** PROJECT:
** Final Project
** CSE 664 CSE 664 Introduction to System-on-Chip Design, Spring 2023
** Section M401, Dr. Mohammad Abdallah
**
** NAME: Accumulator Testbench
**
** DESCRIPTION:
** A register in which intermediate arithmetic logic unit results are stored.
** This simple 8-bit accumulator's output will continuously grow by increments of
** the input until reset.
**
********************************************************************************
** VERSION HISTORY
**
**    Rev         Author              		Date
** -----------------------------------------------------------------------------
**    1.1         M. Peña           		17-June-2023
**                Input/memory control
**
**    1.0         M. Peña           		01-June-2023
**                Initial version, no input control or overflow logic
**
*******************************************************************************/

/*******************************************************************************
**
** v1.0
**
*******************************************************************************/

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

/*******************************************************************************
**
** v1.1
**
*******************************************************************************/

`timescale 1ns / 1ps
module acc_v1_tb;

	reg clock;
	reg reset;
	reg update;
	reg [7 : 0] in;
	wire [7 : 0] out;

	acc acc1_1(
		.out(out), 
		.in(in), 
		.update(update),
		.clock(clock),
		.reset(reset));

	initial 
		begin	// simulate clock
		clock = 1'b0;
		forever begin
			#1 clock = ~clock;
		end
	end
	
	initial
		begin
		#0 reset <= 1;
		update <= 1;
		in <= 8'b10110010;
		
		#2 reset <= 0;
		update <= 1;
		in <= 8'b00000010;
		
		#2 reset <= 0;
		update <= 1;
		in <= 8'b00001111;
		
		#2 reset <= 0;
		update <= 0;
		in <= 8'b01010101;
		
		#2 reset <= 1;
		update <= 0;
		in <= 8'b11100010;
		
		#2 reset <= 1;
		update <= 1;
		in <= 8'b00011010;

		#2 reset <= 0;
		update <= 1;
		in <= 8'b00000011;

		#2 reset <= 0;
		update <= 0;
		in <= 8'b10101010;

		#2 reset <= 0;
		update <= 1;
		in <= 8'b01010101;
	
		#2 reset <= 0;
		update <= 1;
		in <= 8'b01010101;

		#2 reset <= 0;
		update <= 1;
		in <= 8'b01010101;

		#2 reset <= 1;
		update <= 1;
		in <= 8'b01010101;
		#2 $finish;
	end
endmodule