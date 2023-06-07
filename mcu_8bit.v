`timescale 1ns / 1ps

module mcu_8bit(Clk, Reset, currentPC, resetPC);
	
	// Input / Output nets of module
	input Clk;
	input Reset;
	input resetPC;
	output currentPC;
	
	/* Internal nets:
	 * These are all of the connections between different
	 * modules in the 8 bit MCU. It is how information gets 
	 * from IR to controller, controller to dependent components,
	 * data to alu, data to regs, data to acc, etc.
	 */
	 
	 // 1. Control signals
	 wire LoadIR, IncPC, SelPC, LoadPC, LoadReg, LoadAcc;
	 wire [1:0] SelAcc;
	 wire [3:0] SelALU;
	 
	 // 2. ALU output wires
	 wire alu_out_zero;
	 wire alu_out_carry;
	 wire [7:0] alu_out;
	 wire [7:0] alu_a_in;
	 wire [7:0] alu_b_in;
	 
	 // 3. Reg out wire. Goes to MUX2_PC, ALU and MUX2_A0
	 wire [7:0] reg_out;
	 
	 // 4. Wires around accumulator register
	 wire acc_out;
	 wire acc_in;
	 
	 // 5. MUX2_A0 to MUX2_A1
	 wire a0_to_a1;
	 
	 // 6. MUX2_PC to PC wire
	 wire pc_jump;

	 // 7. TODO: IR Reg Wires
	 
	 
	 /* end of internal nets */
	 
	 
	 /* Internal Module Instantiation:
	  * This section instantiates and connects internal modules
	  * of the 8 bit MCU. The order followed is the logical order
	  * which an instruction would be executed by the processor.
	  * The always block is clock driven to load an instruction
	  * to execute, and supports an asynchronous reset.
	  */
	  
	  // 1. Instruction memory
	  // 2. MUX2_PC (passes jump address to PC)
	  // 3. Program Counter
	  // 4. Control Unit FSM
	  // 5. Register File
	  // 6. ALU 
	  // 7. MUX2_A0
	  // 8. MUX2_A1
	  // 9. Accumulator
	  
 	 
	
	
	
	
endmodule // end of mcu_8bit
	
	