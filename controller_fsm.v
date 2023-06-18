`timescale 1ns / 1ps

// Description
//! Model that uses a known set of inputs to define several combinations of outputs and states.
module controller_fsm(
    output reg LoadIR,          //! Load instruction register with next instruction - (Should be checked before update)
    output reg IncPC,           //! Program counter which is incremented only to next instruction
    output reg SelPC,           //! Used to increment PC by immediate or val in reg
    output reg LoadPC,          //! Signal to update PC value - (Should be checked before JUMP ONLY)
    output reg LoadReg,         //! Signal to update register - (Should be checked before update)
    output reg LoadAcc,         //! Signal to update accumulator - (Should be checked before update)
    output reg [1:0] SelAcc,    //! Select signal for ACC muxes - (SelAcc[1] = SelAcc1, SelAcc[0] = SelAcc0)
    output reg [3:0] SelALU,    //! Select signal for ALU operation (opcode)
    input wire [3:0] Opcode,     //! Opcode from instruction register
    input wire Clk,              //! Clock signal
    input wire Z,                //! Zero bit
    input wire C,                //! Carry bit
    input wire CLB               //! TODO: WHAT IS THIS? - Replace with reset
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
    
    
    //! Case statement for setting control signals
    always@(Clk) begin
    
	// Signals vary by opcode
        case(Opcode)
        
	// ALU Related Opcodes
        ADD, SUB, NOR, SHFR, SHFL : begin
		LoadIR  <= 1'b1;  // Load next instruction from IMem to IR        	
		IncPC   <= 1'b1;  // Increment to next instruction only
		SelPC   <= 1'bx;  // Mux output does not matter for this case
		LoadPC  <= 1'b0;  // Do not load PC from mux wire. Increment only, do not jump
		LoadReg <= 1'b0;  // Do not update register file.
		LoadAcc <= 1'b1;  // Update value stored in ACC
		SelAcc  <= 2'b11; // Load output of ALU into ACC
		SelALU  <= Opcode; 
        end
        
	// Put value from Reg in ACC
        REG_TO_ACC : begin
		LoadIR  <= 1'b1;  // Load next instruction from IMem to IR          	
		IncPC   <= 1'b1;  // Increment to next instruction only
		SelPC   <= 1'bx;  // Mux output does not matter for this case
		LoadPC  <= 1'b0;  // Do not load PC from mux wire. Increment only, do not jump
		LoadReg <= 1'b0;  // Do not update register file.
		LoadAcc <= 1'b1;  // Update value stored in ACC
		SelAcc  <= 2'b01; // SecAcc0 = 1 (B), SelAcc1 = 0 (A)
		SelALU  <= Opcode;
        end
        
	// Put value from ACC into a Reg
        ACC_TO_REG : begin
		LoadIR  <= 1'b1;  // Load next instruction from IMem to IR       	
		IncPC   <= 1'b1;  // Increment to next instruction only
		SelPC   <= 1'bx;  // Mux output does not matter for this case
		LoadPC  <= 1'b0;  // Do not load PC from mux wire. Increment only, do not jump
		LoadReg <= 1'b1;  // Update register value!
		LoadAcc <= 1'b0;  // Do not update ACC
		SelAcc  <= 2'bxx; // SelAcc only matters if LoadAcc is set
		SelALU  <= ACC_TO_REG;
        end
        
	// Load immediate into ACC
        IMM_TO_ACC : begin
		LoadIR  <= 1'b1;  // Load next instruction from IMem to IR        	
		IncPC   <= 1'b1;  // Increment to next instruction only
		SelPC   <= 1'bx;  // Mux output does not matter for this case
		LoadPC  <= 1'b0;  // Do not load PC from mux wire. Increment only, do not jump
		LoadReg <= 1'b0;  // Do not update register file.
		LoadAcc <= 1'b1;  // Update ACC
		SelAcc  <= 2'b00; // SecAcc0 = 0 (A), SelAcc1 = 0 (A)
		SelALU  <= IMM_TO_ACC;
        end      
        
	// Jump to address in REG if zero is set
        JMPZ_REG : begin
		LoadIR  <= 1'b1;   // Load next instruction from IMem to IR         	
		IncPC   <= 1'b0;   // Jump instruction, use LoadPC signal to use value from mux
		SelPC   <= 1'b0;   // Load address to jump to from register
		LoadPC  <= 1'b1;   // Load value from register instead of basic increment
		LoadReg <= 1'b0;   // Do not update register file.
		LoadAcc <= 1'b0;   // Do not update ACC
		SelAcc  <= 2'bxx;  // SelAcc only matters if LoadAcc is set
		SelALU  <= JMPZ_REG;
        end
        
	// Jump to address of immediate if zero is set
        JMPZ_IMM : begin
		LoadIR  <= 1'b1;  // Load next instruction from IMem to IR       	
		IncPC   <= 1'b0;  // Jump instruction, use LoadPC signal to use value from mux
		SelPC   <= 1'b1;  // Load immediate to jump to
		LoadPC  <= 1'b1;  // Load immediate value instead of basic increment
		LoadReg <= 1'b0;  // Do not update register file.
		LoadAcc <= 1'b0;  // Do not update ACC
		SelAcc  <= 2'bxx; // SelAcc only matters if LoadAcc is set
		SelALU  <= JMPZ_IMM;
        end
        
	// Jump to address in register if carry is set
        JMPC_REG : begin
		LoadIR  <= 1'b1;   // Load next instruction from IMem to IR         	
		IncPC   <= 1'b0;   // Jump instruction, use LoadPC signal to use value from mux
		SelPC   <= 1'b0;   // Load value from register instead of basic increment
		LoadPC  <= 1'b1;   // Jump, load based on mux
		LoadReg <= 1'b0;   // Do not update register file.
		LoadAcc <= 1'b0;   // Do not update ACC 
		SelAcc  <= 2'bxx;  // SelAcc only matters if LoadAcc is set
		SelALU  <= JMPC_REG;
        end
           
	// Jump to address of immediate if carry is set
        JMPC_IMM : begin
		LoadIR  <= 1'b1;   // Load next instruction from IMem to IR      	
		IncPC   <= 1'b0;   // Jump instruction, use LoadPC signal to use value from mux
		SelPC   <= 1'b1;   // Load immediate to jump to
		LoadPC  <= 1'b1;   // Load immediate value instead of basic increment
		LoadReg <= 1'b0;   // Do not update register file.
		LoadAcc <= 1'b0;   // Do not update ACC
		SelAcc  <= 2'bxx;  // SelAcc only matters if LoadAcc is set
		SelALU  <= JMPC_IMM;       
        end
        
	// No operation, empty cycle
        NOP : begin
		LoadIR  <= 1'b1;    // Load next instruction from IMem to IR  
		IncPC   <= 1'b1;    // Increment to next instruction only
		SelPC   <= 1'bx;    // Mux output does not matter for this case
		LoadPC  <= 1'b0;    // Do not load PC from mux wire. Increment only, do not jump
		LoadReg <= 1'b0;    // Do not update register file.
		LoadAcc <= 1'b0;    // Do not update ACC
		SelAcc  <= 2'bxx;   // SelAcc only matters if LoadAcc is set
		SelALU  <= NOP; 
        end
        
	// Stop processor, do not load another instruction
        HALT : begin
        LoadIR  <= 1'b0;  // DO NOT LOAD ANOTHER INSTRUCTION
		IncPC   <= 1'b0;  // Do not update PC
		SelPC   <= 1'bx;  // Mux output does not matter for this case
		LoadPC  <= 1'b0;  // Do not load PC from mux wire, PC should not change
		LoadReg <= 1'b0;  // Do not update anything in register file
		LoadAcc <= 1'b0;  // Do not update ACC
		SelAcc  <= 2'bxx; // SelAcc only matters if LoadAcc is set
		SelALU  <= HALT; 
        end
        
	// Unrecognized instruction
        default : begin
        LoadIR  <= 1'bx;       	
		IncPC   <= 1'bx; 
		SelPC   <= 1'bx;
		LoadPC  <= 1'bx;
		LoadReg <= 1'bx;
		LoadAcc <= 1'bx;
		SelAcc  <= 2'bxx; 
		SelALU  <= 4'bxxxx; 
        end
        
        endcase
    
    end // End of always
    
    
    
    
endmodule
