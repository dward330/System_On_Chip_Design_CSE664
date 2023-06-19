/*
* Authors: Derrick Ward, Trent
*/

// Description
//! A register module that allows users to store up to 16 numbers that are 8-bits long.
module register_unit (
	reset, //! Signal to clear all 16 register values and set value to 0.
	clock, //! Clock Signal.
	load, //! Signal to update register.
	addr, //! Address of the register slot to update or read from.
	data_out, //! Value stored in register slot, addressed by the "addr" 4-bit wires.
	data_in //! Value to update register slot to, addressed by the "addr" 4-bit wires. Requires load and clock signal to be high.
	);

//register size
parameter register_count = 16;
parameter register_size = 8;

//loop variable
integer i;

// 16 -> 8 bit registers
reg [register_size-1:0] registers [0:register_count-1];

// Temporary variable to hold data value stored in addressed register slot
reg [register_size-1:0] datatogoout;

// Value stored in the addressed register slot
output [register_size-1:0] data_out;

// Value to update register slot too
input wire [register_size-1:0] data_in;
input wire clock, reset, load;

// Address(Register Slot) to read or update
input wire[3:0] addr;

//Only run when we detect a positive clock edge rise or a positive reset edge rise
always @(posedge clock or posedge reset) begin

	// Reset all register slots back to 0 as well as output value being sent to the outside
	if (reset==1) begin
		for (i = 0; i < register_count; i = i+1) begin
			registers[i] <= 0;
		end
		datatogoout <= 0;
	end

	// Store data provide from the outside into an internal register slot
	else if (load == 1) begin
		registers[addr] <= data_in;
	end

	// Fetch data stored from internal register slot and return it to the outside
	datatogoout <= registers[addr];
end

// Send out the addressed register slot's value
assign data_out = datatogoout;

endmodule