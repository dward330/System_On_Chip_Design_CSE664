`timescale 1ns / 1ps
module program_counter_tb;

	reg clk;
	reg reset;
	reg LoadPC;
	reg IncPC;

	wire [7:0] count;

	program_counteruut (
		.clk(clk),
		.reset(reset),
		.LoadPC(LoadPC),
		.IncPC(IncPC),
		.new_count(new_count),
		.count(count)
	);

	initial clk = 0;
	always #5 clk = ~clk;
    
	initial begin
		reset = 0;
		  
	end    
endmodule
