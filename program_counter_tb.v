// Set timescale to nanoseconds
`timescale 1ns / 1ps

module program_counter_tb;
	
	//declare input variables
	reg clk;
	reg reset;
	reg LoadPC;
	reg IncPC;

	//declare output variables
	wire [7:0] count;

	//instantiate unit under test
	program_counter uut (
		.clk(clk),
		.reset(reset),
		.LoadPC(LoadPC),
		.IncPC(IncPC),
		.new_count(new_count),
		.count(count)
	);

	//set period to 10ns
	initial clk = 0;
	always #5 clk = ~clk;
    	
	//test stimulus 
	initial begin
		reset = 0;
		
	$stop;  
	end    
endmodule
