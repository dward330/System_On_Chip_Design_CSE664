
// Description
//! Instruction memory to execute a program based on a program couunter
//! Assumption: Program is precompiled
module instruction_memory(
    input [7:0] pc_address, //! Address of the Instruction
    output reg [7:0] out //! Instruction value at the address location
    );

    // if a new instruction is sent to the register 
    always @(pc_address) begin

        case(pc_address)

        8'b00000000: out = 8'b00000000; //000 NOP (beginning)

        8'b00000010: out = 8'b11010011; //002 IMM 3 to ACC (ACC = 3)

        8'b00000100: out = 8'b01010000; //004 ACC to reg 0 (Reg 0 = 3)

        8'b00000110: out = 8'b11010001; //006 IMM 1 to ACC (ACC = 1)

        8'b00001000: out = 8'b01010001; //008 ACC to reg 1 (Reg 1 = 1)

        8'b00001010: out = 8'b00010000; //010 Add reg 0 to ACC (Reg 1 + ACC 3 = ACC 4)

        default: out = 8'b00000000; // Default to no-op

        endcase

    end



endmodule
