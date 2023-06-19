// Module: program_counter.v 

//set timescale to nanoseconds
`timescale 1ns / 1ps

// Description
//! Register that contains the address of the instruction to be executed. Counts the instructions opcodes from 0000 to 1111 and it signals the memory address of next instruction to be fetched and executed.
module program_counter(
	input clk, //! cLock signal.
	input reset, //! Signal to clear and set address back to 8'b00000000.
	input LoadPC, //! Signal to manually set program address. 
	input IncPC, //! Signal to automatically increment program address by 1 (2'b10)
	input [7:0] new_count, //! Address to manually set program address to.
	output reg [7:0] count //! Current address of the program
	);

	//clocked operation
	always @ (posedge clk or posedge reset) begin
		if(reset==1) begin //if the reset line is high, zero the counter
			count <= 0;
		end
		
		else if(IncPC) begin // if increment is high, add one to the counter
			count <= count + 2'b10;
		end
	end
	
	// always to load new PC
	always @ (posedge clk) begin
	#5 // Wait for control signals to update new PC
	   if(LoadPC) begin //if the set is high, load a new value into the counter
			count <= new_count;
		end
	end

endmodule
