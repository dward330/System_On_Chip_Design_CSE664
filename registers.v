// Module to store up to 16 numbers that are 8 bits long
module register_unit (reset, clock, load, addr, data_out, data_in);

//register size
parameter register_count = 16;
parameter register_size = 8;

//loop variable
integer i;

// 16, 8 bit registers
reg [register_size-1:0] registers [0:register_count-1];
reg [register_size-1:0] datatogoout;


output [register_size-1:0] data_out;

input wire [register_size-1:0] data_in;

input wire clock, reset, load;

input wire[3:0] addr;

//Only run when we detect a positive clock edge rise
always @(posedge clock or posedge reset) begin

	// Reset all register slots back to 0 as well as output value being returned to the outside
	if (reset==1) begin
		for (i = 0; i < register_count; i = i+1) begin
			registers[i] <= 0;
		end
		datatogoout <= 0;
	end

	// Store data from the outside into an internal register slot
	else if (load == 1) begin
		registers[addr] <= data_in;
	end

	// Fetch data stored from internal register slot and return it to the outside
	datatogoout <= registers[addr];
end

assign data_out = datatogoout;

endmodule