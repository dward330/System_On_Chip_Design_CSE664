`timescale 1ns / 1ps

// Description
// ! Register Module to transfrom instruction into opcode (sent to controller) and data components. 
module instruction_register(
    input clock, //! Clock signal (Positive edge triggered).
    input reset, //! Signal to clear and set opcode and data out back to 0.
    input [7:0] instruction, //! Instruction received from memory.
    output [3:0] opcode, //! Opcode from the instruction.
    output [3:0] data_out, //! Data component from the instruction.
    input LoadIR //! Signal to load and transform instruction into opcode and data components.
    );

    reg [3:0] tmp_data;
    reg [3:0] tmp_opcode;

    // if a new instruction is sent to the register 
    always @(posedge clock or posedge reset)
    begin

		// asynchronous active high reset to noop
        if (reset) begin
            tmp_opcode <= 4'b0000;
            tmp_data <= 4'b0000; 

        // if reset is low
        // send opcode to controller
        // send data to instruction registers / immediate
        end
        else if (LoadIR) begin
            tmp_opcode <= instruction[7:4];
            tmp_data <= instruction[3:0];
        end
        
    end

    assign opcode = tmp_opcode;
    assign data_out = tmp_data;


endmodule
