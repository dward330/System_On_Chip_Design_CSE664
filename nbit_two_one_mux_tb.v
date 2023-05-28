`timescale 1ns / 1ps 
`define STRLEN 32

/* This module is the testbench for the 
 "nbit_two_one_mux" */
module nbit_two_one_mux_tb;

	/*This task checks the output of our circuit against a 
     known answer and prints a message based on the outcome. Additionally, 
     this task increments the variable we are using to keep track of the 
     number of tests successfully passed.*/
   task passTest;
		input actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
    /*this task informs the user of the final outcome of the test
	 in the console (transcript window in ModelSim */
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs to UUT
	reg [3:0] A;
	reg [7:0] B;
	reg S;
    reg [7:0] passed;

	// Outputs ot UUT
	wire [7:0] Y;

	// Instantiate the Unit Under Test (UUT)
	// 4-bit A, 8-bit B, 8-bit Y
	nbit_two_one_mux
	#(.A_WIDTH(4), 
	.B_WIDTH(8),
	.OUT_WIDTH(8))
	uut (
		.bus_out(Y), 
		.bus_a(A), 
		.bus_b(B), 
		.select(S)
	);
	
	// Stimulate test inputs against expected responses
	initial begin
	passed = 0;
	A = 0;
	B = 0;
	S = 0;
	
	// First test, lets B pass
	A = 4'b0110;
	B = 8'b11111111;
	S = 1'b1;
	#10
	passTest(Y, B, "Mux Test 1", passed);
	
	// Second test, lets A pass
	A = 4'b0110;
	B = 8'b11111111;
	S = 1'b0;
	#10
	passTest(Y, A, "Mux Test 2", passed);
	
	
	// Third test, different B passes
	A = 4'b1111;
	B = 8'b00000001;
	S = 1'b1;
	#10
	passTest(Y, B, "Mux Test 4", passed);
	
	// Fourth test, different A passes
	A = 4'b1111;
	B = 8'b00000001;
	S = 1'b0;
	#10
	passTest(Y, A, "Mux Test 4", passed);
	
	allPassed(passed, 4);
    $stop;
	end

endmodule
