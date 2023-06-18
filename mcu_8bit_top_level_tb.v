/*******************************************************************************
** PROJECT:
** Final Project
** CSE 664 CSE 664 Introduction to System-on-Chip Design, Spring 2023
** Section M401, Dr. Mohammad Abdallah
**
** NAME: mcu_8bit_top_level_tb.v
**
** DESCRIPTION:
** This file contains a test bench for the controlncy_8bit_top_level.v Module.
**
** DESIGN STANDARDS:
** Prefixes
** r_ = Register
** wire_ = Signal Direct Connection/Wire
** g_ = generic
** c_ = constant
** s_ = state   
** i_ = input 
** o_ = output
** Suffixes
** _count = Counter
** _data = Data signal
** _valid = Valid Signal
** _out = output registers
**
********************************************************************************
** VERSION HISTORY
**
**    Rev         Author              		Date
** -----------------------------------------------------------------------------
**    1.0         N. Lyons            		17-June-2023
**                Initial delivery
**
*******************************************************************************/

// Set timescale to nanoseconds
`timescale 1ns / 1ps
`default_nettype none

module mcu_8bit_top_level_tb(); 

    // Declare testbench input variables 
    reg r_Clk, r_Reset;
    reg [7:0] r_resetPC;

    // Declare testbench output variables
    wire [7:0] wire_currentPC;

    // Set period to 10ns
    always #5 r_Clk =~ r_Clk;


    // Instantiate unit under test
    mcu_8bit DUT(
        .Clk(r_Clk),
        .Reset(r_Reset),
        .resetPC(r_resetPC),
        .currentPC(wire_currentPC)
    );

    // Test stimulus
    initial begin
        r_Clk = 0;
        r_Reset = 1;
        r_resetPC = 1;
        #100                                       

		// Test storing register in acc opcode for 100 cycles
        r_Reset = 0;
        r_resetPC = 0;    
		#1000;

	$stop;
    end
endmodule