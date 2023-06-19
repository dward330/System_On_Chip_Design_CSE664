`timescale 1ns / 1ps

// Description
//! A combinational digital circuit that performs arithmetic and bitwise operations 
//! on integer binary numbers.

module ALU_8bit(
	output reg [7:0]alu_out,	//! 8 bit result (connected to mux that is connected to ACC)
	output reg alu_zero_flag,	//! Set if result is zero (connected to controller)
	output reg alu_carry_out,	//! Set if carry bit is needed (connected to controller)
	input [3:0] alu_select,		//! Select ALU operation (received from controller) 
	input [7:0] alu_a_in,		//! ACC ALU input
	input [7:0] alu_b_in		//! REG ALU input
    );
    
// Opcodes - THESE SHOULD ALWAYS MATCH PROCESSOR OPCODES FOR ALU OPERATIONS
parameter [3:0] 	NOP 	= 4'b0000, // No-operation
			ADD 	= 4'b0001, // A+B
			SUB 	= 4'b0010, // A - B
			NOR 	= 4'b0011, // A NOR B
			SHFL 	= 4'b1100, // Bitwise shift A left
			SHFR 	= 4'b1011; // Bitwise shift A right
				
				
	//! The ALU outputs change anytime the inputs change (combinational logic).
	always@(alu_a_in or alu_b_in or alu_select)
	begin
	
		/* Each case performs an arithmetic or bitwise operation
		 * based on the instruction opcode (SelALU) passed from the controller fsm.
		 * The output is a 9 bit reg to account for carry.
		 * The result is checked every operation to determine zero flag value
		 */
		case(alu_select)

			// Add both inputs
			ADD : begin
				// {1'b,8'b} concatenates results into 9 bit bus
				// This inherently accounts for the carry bit
				{alu_carry_out, alu_out} = alu_a_in + alu_b_in;
				alu_zero_flag = ({alu_carry_out, alu_out} == 8'b0);
			end
			
			// Subtraction (A-B)
			SUB : begin
                		{alu_carry_out, alu_out} = alu_a_in - alu_b_in;
                		alu_zero_flag = ({alu_carry_out, alu_out} == 8'b0);
			end
			
			// NOR gate logic
			NOR : begin 
                		alu_out = ~(alu_a_in | alu_b_in);
                		alu_carry_out = 1'b0;
                		alu_zero_flag = ({alu_carry_out, alu_out} == 8'b0);
			end
			
			// Shift input A one bit left
			SHFL : begin
                		{alu_carry_out, alu_out} = alu_a_in << 1'b1;
                		alu_zero_flag = ({alu_carry_out, alu_out} == 8'b0);
			end
			
			// Shift input A one bit right
			SHFR : begin
                		{alu_carry_out, alu_out} = alu_a_in >> 1'b1;
                		alu_zero_flag = ({alu_carry_out, alu_out} == 8'b0);
			end
			
			default : begin 
				// Do nothing to preserve result / bits
				// Should only update on ALU based instruction
			end
		endcase
	
	end // Always block end
	
	
endmodule
