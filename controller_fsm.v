`timescale 1ns / 1ps

module controller_fsm(
    output reg LoadIR,          // Load instruction register TODO: How to handle this?
    output reg IncPC,           // Increment program counter
    output reg SelPC,           // Increment PC by immediate or val in reg
    output reg LoadPC,          // Signal to update PC value TODO: How to handle this?
    output reg LoadReg,         // Signal to update register
    output reg LoadAcc,         // Signal to update accumulator
    output reg [1:0] SelAcc,    // Select signal for ACC muxes
    output reg [3:0] SelALU,    // Select signal for ALU operation (opcode)
    input wire [3:0] Opcode,     // Opcode from instruction register
    input wire Clk,              // Clock signal
    input wire Z,                // Zero bit
    input wire C,                // Carry bit
    input wire CLB               // TODO: WHAT IS THIS?
    );
    
parameter   ADD         = 4'b0001,      // ACC = REG + ACC
            SUB         = 4'b0010,      // ACC = REG - ACC
            NOR         = 4'b0011,      // ACC = !(REG | ACC)
            SHFR        = 4'b1100,      // SHIFT ACC
            SHFL        = 4'b1011,      // SHIFT ACC
            REG_TO_ACC  = 4'b0100,      // MOVE VALUE FROM REG TO ACC
            ACC_TO_REG  = 4'b0101,      // MOVE VALUE FROM ACC TO REG
            IMM_TO_ACC  = 4'b1101,      // STORE IMM IN ACC
            JMPZ_REG    = 4'b0110,      // IF ACC IS 0, SET PC TO VALUE IN REG
            JMPZ_IMM    = 4'b0111,      // IF ACC IS 0, SET PC TO VALUE OF IMM
            JMPC_REG    = 4'b1000,      // IF ACC < 0 (CARRY IS SET), SET PC TO VALUE IN REG
            JMPC_IMM    = 4'b1010,      // IF ACC < 0 (CARRY IS SET), SET PC TO VALUE OF IMM
            NOP         = 4'b0000,      // NO OP (PC = PC + 1)
            HALT        = 4'b1111;      // HALT PC (PC = PC)
    
    
    always@(Clk) begin
    
        case(Opcode)
        
	// ALU Related Opcodes
        ADD, SUB, NOR, SHFR, SHFL : begin
		LoadIR  <= 1'b1; // TODO?        	
		IncPC   <= 1'b1; 
		SelPC   <= 1'b0;
		LoadPC  <= 1'b0;
		LoadReg <= 1'b1;
		LoadAcc <= 1'b1;
		SelAcc  <= 2'b11; // Load output of ALU into ACC
		SelALU  <= Opcode; 
        end
        
        REG_TO_ACC : begin
        // TODO:
        end
        
        ACC_TO_REG : begin
        // TODO:
        end
        
        IMM_TO_ACC : begin
        // TODO:
        end      
        
        JMPZ_REG : begin
        // TODO:
        end
        
        JMPZ_IMM : begin
        // TODO:
        end
        
        JMPC_REG : begin
        // TODO:
        end
           
        JMPC_IMM : begin
        // TODO:
        end
        
        NOP : begin
        // TODO:
        end
        
        HALT : begin
        // TODO:
        end
        
        default : begin
        // TODO:
        end
        
        endcase
    
    end // End of always
    
    
    
    
endmodule
