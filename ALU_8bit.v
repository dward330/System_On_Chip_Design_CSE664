`timescale 1ns / 1ps


module ALU_8bit(
	output reg [7:0]alu_out,
	output reg alu_zero_flag,
	output reg alu_carry_out,
	input [3:0] alu_select,
	input [7:0] alu_a_in,
	input [7:0] alu_b_in
    );
    
parameter [3:0] 	NOP 	= 4'b0000, // No-operation
					ADD 	= 4'b0001, // A+B
					SUB 	= 4'b0010, // A - B
					NOR 	= 4'b0011, // A NOR B
					SHFL 	= 4'b1100, // Bitwise shift A left
					SHFR 	= 4'b1011; // Bitwise shift A right
				
				
	
	// Internal nets
	wire[8:0] result;
	
	always@(alu_a_in or alu_b_in or alu_select)
	begin
	
		case(alu_select)

			// Add both inputs
			ADD : begin
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
				alu_out = 0;
				alu_carry_out = 1'b0;
				alu_zero_flag = 1'b0;
			end
		endcase
	
	end // Always block end
	
	
endmodule
