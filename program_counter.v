// Description
// Program Counter - Register that contains the adress of the instruction bieng executed
// It counts the instructions opcodes from 0000 to 1111 and it signals the memory address of next instruction to be fetched and executed

`timescale 1ns / 1ps
module program_counter(clk, reset, IncPC, LoadPC, new_count, count);
	
	input clk;
 	input reset; //synchronous reset when active low
 	input LoadPC; //only increment the counter when this signal is high
	input IncPC; //when this signal is high, the counter loads new_count
	input [7:0] new_count; //new value to set the counter
	output reg [7:0] count; //output address of the program counter

	//clocked operation
	always @ (posedge clk, negedge reset) begin
		if(reset==0) begin //if the reset line is low, zero the counter
			count <= 0;
		end
		else if(LoadPC) begin //if the set is high, load a new value into the counter
			count <= new_count;
		end
		else if(IncPC) begin // if increment is high, add one to the counter
			count <= count + 1'b1;
		end
	end

endmodule



