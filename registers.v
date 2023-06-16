module register_unit (reset, clock, load, store, load_addr, store_addr, data_out, data_in);

//register size
parameter register_count = 16;
parameter register_size = 8;

//loop variable
integer i;

// 16, 8 bit registers
reg [register_size-1:0] registers [0:register_count-1];
reg [register_size-1:0] datatogoout;


output [register_size-1:0] data_out;

input [register_size-1:0] data_in;

input clock, reset, load, store;

input wire [3:0] load_addr;

input wire [3:0] store_addr;


always @(posedge clock or negedge reset) begin

if (reset==0) begin

	
	for (i = 0; i < register_count; i = i+1) begin

	registers[i] <= 0;

	end


end

end

always @(posedge clock) begin

if (reset == 1 && load == 1 && store == 0) begin

		datatogoout <= registers[load_addr];

end

if (reset == 1 && store == 1 && load == 0) begin

		registers[store_addr] = data_in;

end

end

assign data_out = datatogoout;

endmodule

