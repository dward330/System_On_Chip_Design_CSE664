// Description
// Program Counter - Register that contains the adress of the instruction bieng executed
// It counts the ALU instructions opcode from 0000 to 1111 and it signals the memory address of next instruction to be fetched and executed

module program_counter(clk, reset, increment, set, new_count, count);
	
	input clk;
 	input reset; //synchronous reset when active low
 	input increment; //only increment the counter when this signal is high
	input set; //when this signal is high, the counter loads new_count
	input [7:0] new_count; //new value to set the counter
	output reg [7:0] count; //output address of the program counter

	//clocked operation
	always @ (posedge clk) begin
		if(~reset) begin //if the reset line is low, zero the counter
			count <= 0;
		end
		else if(set) begin //if the set is high, load a new value into the counter
			count <= new_count;
		end
		else if(increment) begin // if increment is high, add one to the counter
			count <= count + 1;
		end
	end

endmodule



