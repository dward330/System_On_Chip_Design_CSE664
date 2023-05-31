`timescale 1ns / 1ps
`define STRLEN 32

module ALU_8bit_tb;

// TODO: refactor to params file and include
parameter [3:0] NOP 	= 4'b0000, // No-operation
				ADD 	= 4'b0001, // A+B
				SUB 	= 4'b0010, // A - B
				NOR 	= 4'b0011, // A / B
				SHFL 	= 4'b1100, // Bitwise shift A left
				SHFR 	= 4'b1011, // Bitwise shift A right
				
				RES1    = 4'b0101, // Reserved Opcodes
				RES2    = 4'b0110,
				RES3    = 4'b0111,
				RES4    = 4'b1000,
				RES5    = 4'b1001,
				RES6    = 4'b1010,
				RES7    = 4'b1101,
				RES8    = 4'b1110,
				RES9    = 4'b1111,
				RES10 	= 4'b0100;

   /*This particular task checks the output of our circuit against a 
     known answer and prints a message based on the outcome. Additionally, 
     this task increments the variable we are using to keep track of the 
     number of tests successfully passed.*/
   task passTest;
		input [4:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut === expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
    /*this task informs the user of the final outcome of the test*/
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs for UUT
	reg [7:0] A;
	reg [7:0] B;
	reg [3:0] alu_select;

	// Outputs of UUT
	wire [7:0] alu_out;
	wire alu_carry_out;
	wire alu_zero_flag;

	// Internal nets
	reg [7:0] passed;
	reg [7:0] num_tests;

	// Instantiate uut
	ALU_8bit uut
	(
		.alu_out(alu_out),
		.alu_carry_out(alu_carry_out),
		.alu_zero_flag(alu_zero_flag),
		.alu_select(alu_select),
		.alu_a_in(A),
		.alu_b_in(B)
	);

	initial begin

		// Initialize inputs
		A = 8'b11111111;
		B = 8'b11111111;
		alu_select = 4'b0000;
		passed = 0;
		num_tests = 0;
		
		// Test Default cases ( 10 tests)
		alu_select = NOP;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b0000", passed);
		alu_select = RES1;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b0101", passed);
		alu_select = RES2;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b0110", passed);
		alu_select = RES3;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b0111", passed);
		alu_select = RES4;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b1000", passed);
		alu_select = RES5;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b1001", passed);
		alu_select = RES6;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b1010", passed);
		alu_select = RES7;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b1011", passed);
		alu_select = RES8;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b1110", passed);
		alu_select = RES9;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b1111", passed);
		alu_select = RES10;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000000, "Default ALU Select = b0100", passed);
		num_tests = num_tests + 11;
		
		// Long wait between tests to easily view waveform
		#100
		
		// Test ADD cases
		// 1. Adding zeros (make sure zero flag is set)
		// 2. Add with carry out
		// 3. Add without carry out
		alu_select = ADD;
		A = 0; B = 0;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b1000000000, "ADD Test - Zero Flag", passed);
		A = 8'b11111111; B = 8'b00000010;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0100000001, "ADD Test - Carry Set", passed);
		A = 8'b00100000; B = 8'b00001111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000101111, "ADD Test - No Carry Set", passed);

		num_tests = num_tests + 3;
		
		// Long wait between tests to easily view waveform
		#100
		
		// Test SUB cases
		// 1. SUB with result zero (make sure zero flag is set)
		// 2. SUB with A bigger
		// 3. SUB with B bigger
		alu_select = SUB;
		A = 8'b11111111; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b1000000000, "SUB Test - Zero Flag", passed);
		A = 8'b11111111; B = 8'b00001111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0011110000, "SUB Test - BIG A", passed);
		A = 8'b00001111; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0111110000, "SUB Test - BIG B", passed);
		num_tests = num_tests + 3;
		
		// Long wait between tests to easily view waveform
		#100
		
		// Test NOR cases 
		// 1. NOR with all 1's 
		// 2. NOR with all 0's (make sure zero flag is set)
		// 3. NOR with varying bits in A
		alu_select = NOR;
		A = 8'b11111111; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b1000000000, "NOR Test - All 1's", passed);
		A = 8'b00000000; B = 8'b00000000;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0011111111, "NOR Test - All 0's", passed);
		A = 8'b00101100; B = 8'b11111110;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000000001, "NOR Test - Varying", passed);
		num_tests = num_tests + 3;
		
		// Long wait between tests to easily view waveform
		#100
		
		// Test SHFL cases
		// 1. SHFL with A=0 
		// 2. SHFL with carry out
		// 3. SHFL with varying bits in A
		alu_select = SHFL;
		A = 8'b00000000; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b1000000000, "SHFL Test - A = 0", passed);
		A = 8'b11111111; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0111111110, "SHFL Test - Carry Out", passed);
		A = 8'b00101101; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0001011010, "SHFL Test - General Case", passed);
		num_tests = num_tests + 3;
		
		// Long wait between tests to easily view waveform
		#100
		
		// Test SHFR cases
		// 1. SHFR with A=0 
		// 2. SHFR with all 1's
		// 3. SHFR with varying bits in A
		alu_select = SHFR;
		A = 8'b00000000; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b1000000000, "SHFR Test - A = 0", passed);
		A = 8'b11111111; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0001111111, "SHFR Test - All 1's", passed);
		A = 8'b00101101; B = 8'b11111111;
		#10 passTest({alu_zero_flag, alu_carry_out, alu_out}, 10'b0000010110, "SHFR Test - General Case", passed);
		num_tests = num_tests + 3;
		
		
		// check if all tests passed
		allPassed(passed, num_tests);
	end

endmodule
