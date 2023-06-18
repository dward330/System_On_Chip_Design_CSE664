`timescale 1ns / 1ps

module mcu_8bit(Clk, Reset, currentPC, resetPC);
	
	// Input / Output nets of module
	input Clk;
	input Reset;
	input resetPC;
	output currentPC;
	
	/* Internal nets:
	 * These are all of the connections between different
	 * modules in the 8 bit MCU. It is how information gets 
	 * from IR to controller, controller to dependent components,
	 * data to alu, data to regs, data to acc, etc.
	 */
	 
	// 1. Control signals
	wire LoadIR, IncPC, SelPC, LoadPC, LoadReg, LoadAcc, CLB;
	wire [1:0] SelAcc;
	wire [3:0] SelALU;
	
	// 2. ALU output wires
	wire alu_zero_flag;
	wire alu_carry_out;
	wire [7:0] alu_out;
	
	// 3. Reg out wire. Goes to MUX2_PC, ALU and MUX2_A0
	wire [7:0] reg_out;
	
	// 4. Wires around accumulator register
	wire [7:0] acc_out; 
	wire acc_in;
	
	// 5. MUX2_A0 to MUX2_A1
	wire a0_to_a1;
	
	// 6. MUX2_PC to PC wire
	wire pc_jump;

	// 7. IR Reg Wires
	wire [3:0] ir_data; // maps to both immediate and regAddress
	wire [3:0] Opcode;
	wire [7:0] instruction; // From IM to IR
	 
	 
	/* end of internal nets */
	
	
	/* Internal Module Instantiation:
	* This section instantiates and connects internal modules
	* of the 8 bit MCU. The order followed is the logical order
	* which an instruction would be executed by the processor.
	* The always block is clock driven to load an instruction
	* to execute, and supports an asynchronous reset.
	*/
	  
	// 1. Instruction memory (TODO)

	
	// 1.1 Instruction Reg 
	instruction_register instr_reg
	(
		.clock(Clk), 
		.reset(Reset), 
		.instruction(instruction), 
		.opcode(Opcode), 
		.data_out(ir_data), 
		.LoadIR(LoadIR)
	);

	// 2. MUX2_PC:
	// Passes jump address to PC from register file or immediate
	nbit_two_one_mux
	#(.A_WIDTH(8), 
	.B_WIDTH(4),
	.OUT_WIDTH(8))
	MUX2_PC (
		.bus_out(pc_jump), 
		.bus_a(reg_out), 
		.bus_b(ir_data), 
		.select(SelPC)
	);

	// 3. Program Counter 
	program_counter pc_module
	(
		.clk(Clk),
		.reset(Reset),
		.LoadPC(LoadPC),
		.IncPC(IncPC),
		.new_count(pc_jump),
		.count(currentPC)
	);

	// 4. Control Unit FSM 
	controller_fsm controller_fsm(
        .LoadIR(LoadIR),
        .IncPC(IncPC),
        .SelPC(SelPC),
        .LoadPC(LoadPC),
        .LoadReg(LoadReg),
        .LoadAcc(LoadAcc),
        .SelAcc(SelAcc),
        .SelALU(SelALU),
        .Opcode(Opcode),
        .Clk(Clk),
        .Z(alu_zero_flag),
        .C(alu_carry_out),
        .CLB(CLB)
    );


	// 5. Register File
	// Takes in reset and clock
	// LoadReg to update stored values
	// Takes in address of register
	// Can read data out or write to register
	// Data being read out will either be used or 
	// dropped, so there is no need for read control
	register_unit register_file
	(
		.reset(Reset),
		.clock(Clk),
		.load(LoadReg),
		.addr(ir_data),
		.data_out(reg_out),
		.data_in(acc_out)
	);

	// 6. ALU 
	// Instantiation of the ALU that takes
	// the ACC into input A, the Reg_Out into
	// input B, and passes output to
	// input B of MUX2_A1
	ALU_8bit ALU
	(
		.alu_out(alu_out),
		.alu_carry_out(alu_carry_out),
		.alu_zero_flag(alu_zero_flag),
		.alu_select(SelALU),
		.alu_a_in(acc_out),
		.alu_b_in(reg_out)
	);

	// 7. MUX2_A0 
	// First step of determining what to write to ACC
	// Takes immediate or output of register file and
	// 	passes selected value to MUX2_A1
	nbit_two_one_mux
	#(.A_WIDTH(4), 
	.B_WIDTH(8),
	.OUT_WIDTH(8))
	MUX2_A0 (
		.bus_out(a0_to_a1), 
		.bus_a(ir_data), 
		.bus_b(reg_out), 
		.select(SelAcc[0])
	);

	// 8. MUX2_A1 
	// Second step of determining what to write to ACC
	// Takes output of MUX2_A0 and ALU and passes to ACC
	nbit_two_one_mux
	#(.A_WIDTH(8), 
	.B_WIDTH(8),
	.OUT_WIDTH(8))
	MUX2_A1 (
		.bus_out(acc_in), 
		.bus_a(a0_to_a1), 
		.bus_b(alu_out), 
		.select(SelAcc[1])
	);


	// 9. Accumulator 
	acc accumulator(
		.out(acc_out),
		.in(acc_in),
		.update(LoadAcc),
		.clock(Clk),
		.reset(Reset)
	);
 	 
endmodule // end of mcu_8bit
	
	