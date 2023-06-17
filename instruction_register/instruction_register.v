`timescale 1ns / 1ps

module instruction_register(clock, reset, instruction, opcode, data);


    // necessities 
    input clock;
    input reset;

    // non-opcode 4 bits  
    output [3:0] data;

    // opcode 
    output [3:0] opcode;
    reg [3:0] tmp_data;
    reg [3:0] tmp_opcode;

    // instruction received from memory  
    input [7:0] instruction;

    // if a new instruction is sent to the register 
    always @(posedge clock, negedge reset)
    begin

        if (reset) begin
            tmp_opcode <= 4'b0000;
            tmp_data <= 4'b0000; 

        // if reset is low
        // send opcode to controller
        // send data to instruction registers
        end
        else if (instruction) begin
            tmp_opcode <= instruction[7:4];
            tmp_data <= instruction[3:0];
        end
        
    end

    assign opcode = tmp_opcode;
    assign data = tmp_data;


endmodule
