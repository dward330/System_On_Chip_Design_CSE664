/*******************************************************************************
** PROJECT:
** Final Project
** CSE 664 CSE 664 Introduction to System-on-Chip Design, Spring 2023
** Section M401, Dr. Mohammad Abdallah
**
** NAME: controller_fsm_tb.v
**
** DESCRIPTION:
** This file contains a test bench for the controller_fsm.v Module.
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
**    1.1         A. Benedetti, N. Lyons         6-4-2023
**                Fixed default nets, cleanup
**
**    1.0         N. Lyons            		23-May-2023
**                Initial delivery
**
*******************************************************************************/

// Set timescale to nanoseconds
`timescale 1ns / 1ps
`default_nettype none

module controller_fsm_tb(); 

    // Declare testbench input variables 
    reg r_Clk, r_Z, r_C, r_CLB;
    reg [3:0] r_Opcode;

    // Declare testbench output variables
    wire wire_LoadIR, wire_IncPC, wire_SelPC, wire_LoadPC, wire_LoadReg, wire_LoadAcc;
    wire [1:0] wire_SelAcc;
    wire [3:0] wire_SelALU;

    // Define parameters
    parameter   c_ADD         = 4'b0001,      // ACC = REG + ACC
                c_SUB         = 4'b0010,      // ACC = REG - ACC
                c_NOR         = 4'b0011,      // ACC = !(REG | ACC)
                c_SHFR        = 4'b1100,      // SHIFT ACC
                c_SHFL        = 4'b1011,      // SHIFT ACC
                c_REG_TO_ACC  = 4'b0100,      // MOVE VALUE FROM REG TO ACC
                c_ACC_TO_REG  = 4'b0101,      // MOVE VALUE FROM ACC TO REG
                c_IMM_TO_ACC  = 4'b1101,      // STORE IMM IN ACC
                c_JMPZ_REG    = 4'b0110,      // IF ACC IS 0, SET PC TO VALUE IN REG
                c_JMPZ_IMM    = 4'b0111,      // IF ACC IS 0, SET PC TO VALUE OF IMM
                c_JMPC_REG    = 4'b1000,      // IF ACC < 0 (CARRY IS SET), SET PC TO VALUE IN REG
                c_JMPC_IMM    = 4'b1010,      // IF ACC < 0 (CARRY IS SET), SET PC TO VALUE OF IMM
                c_NOP         = 4'b0000,      // NO OP (PC = PC + 1)
                c_HALT        = 4'b1111;      // HALT PC (PC = PC)

    // Instantiate unit under test
    controller_fsm DUT(
        .LoadIR(wire_LoadIR),
        .IncPC(wire_IncPC),
        .SelPC(wire_SelPC),
        .LoadPC(wire_LoadPC),
        .LoadReg(wire_LoadReg),
        .LoadAcc(wire_LoadAcc),
        .SelAcc(wire_SelAcc),
        .SelALU(wire_SelALU),
        .Opcode(r_Opcode),
        .Clk(r_Clk),
        .Z(r_Z),
        .C(r_C),
        .CLB(r_CLB)
    );


    // Set period to 10ns
    always #5 r_Clk =~ r_Clk;

    // Test stimulus
    initial begin
        r_Clk = 0;
        r_Z = 0;
        r_C = 0;
        r_CLB = 0;
        r_Opcode = c_ADD; 


		// Test ALU related opcodes for 10 cycles
		r_Opcode = c_ADD;      
		#100;
		r_Opcode = c_SUB;      
		#100;
		r_Opcode = c_NOR;      
		#100;
		r_Opcode = c_SHFR;      
		#100;
		r_Opcode = c_SHFL;      
		#100;                                                

		// Test storing register in acc opcode for 10 cycles
		r_Opcode = c_REG_TO_ACC;      
		#100;

		// Test storing acc in register opcode for 10 cycles
		r_Opcode = c_ACC_TO_REG;      
		#100;

		// Test storing immediate in acc opcode for 10 cycles
		r_Opcode = c_IMM_TO_ACC;      
		#100;

		// Test jump register opcode for 10 cycles
		r_Opcode = c_JMPZ_REG;      
		#100;
		
		// Test jump immediate opcode for 10 cycles
		r_Opcode = c_JMPZ_IMM;      
		#100;

		// Test jump register opcode for 10 cycles
		r_Opcode = c_JMPC_REG;      
		#100;
		
		// Test jump immediate opcode for 10 cycles
		r_Opcode = c_JMPC_IMM;      
		#100;

		// Test nop opcode for 10 cycles
		r_Opcode = c_NOP;      
		#100;

		// Test hault pc opcode for 10 cycles
		r_Opcode = c_HALT;      
		#100;

		// Test default case for 10 cycles
		r_Opcode = 4'b1001;      
		#100;

	$stop;
    end
endmodule