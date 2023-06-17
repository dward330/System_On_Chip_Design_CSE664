//set timescale to nanoseconds
`timescale 1ns / 1ps

module program_counter_tb;
	
	//declare input variables
	reg clk;
	reg reset;
	reg LoadPC;
	reg IncPC;
	reg [7:0] new_count;

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

	//parameters
	    //ADD         = 4'b0001;      //A + B
            //SUB         = 4'b0010;      //A - B 
            //NOR         = 4'b0011;      //A NOR B
            //SHFR        = 4'b1100;      //bitwise shift A left
            //SHFL        = 4'b1011;      //bitwise shift A right

	//set period to 10ns
	initial clk = 0;
	always #5 clk = ~clk;
    	
	//test stimulus 
	initial begin
		//testing if new adress is loaded
		reset = 0;
		LoadPC = 1;
		IncPC = 0;
		new_count = 8'b00010001;
		$display("PC = ",count);

		//testing if value is not loaded when reset is high
		#10
		reset = 1;
		LoadPC = 1;
		IncPC = 0;
		new_count = 8'b00010001;
		$display("PC = ",count);

		//testing if value is not loaded when set is low
		#10
		reset = 0;
		LoadPC = 0;
		IncPC = 1;
		new_count = 8'b00010001;
		$display("PC = ",count);

		//testing if current address is incremented
		#10
		reset = 0;
		LoadPC = 0;
		IncPC = 1;
		new_count = 8'b00000000;
		$display("PC = ",count);

		// testing if new adress is loaded
		#10
		reset = 0;
		LoadPC = 1;
		IncPC = 0;
		new_count = 8'b00010001;
		$display("PC = ",count);	

		// testing if new adress is loaded and incremented
		#10
		reset = 0;
		LoadPC = 1;
		IncPC = 1;
		new_count = 8'b00010001;
		$display("PC = ",count);		
		
	$stop;  
	end  
  
endmodule
