// Set timescale to nanoseconds
`timescale 1ns / 1ps

module instruction_memory_tb();

    // Testbench input variables
    reg [7:0] r_address;

    // Testbench output variables
    wire [7:0] wire_instruction;

    // Instantiate unit under test 
    instruction_memory imem
    (
        .pc_address(r_address),
        .out(wire_instruction)    
    );

    // Test stimulus
    initial begin
        r_address = 0;
        #10
        r_address = 2;
        #10
        r_address = 4;
        #10
        r_address = 6;
        #10
        r_address = 8;
        #10
        r_address = 10;
        #10
        r_address = 12;
        #10
        r_address = 13; // Should default    
        #10  
	$stop;
    end

endmodule