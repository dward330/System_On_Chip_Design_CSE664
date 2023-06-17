`timescale 1ns / 1ps

module ins_register_tb;

// simulate receiving opcode and data back 
wire [3:0] opcode; 
wire [7:4] data; 

// instruction to opass 
reg [7:0] ins;

// simulate clock 
reg clock;

// simulate reset 
reg reset;


instruction_register uut
	(
                .clock(clock),
                .reset(reset),
		.instruction(ins),
		.opcode(opcode),
        .data(data)
	);

// simulate clock 
initial 
begin	// simulate clock
	clock = 1'b0;
end

	
    always begin 
    #1 clock = ~clock;
    #5 ins <= 8'b01001111;
    $display("data: ", data);
    $display("opcode: ", opcode);
    end 

endmodule


