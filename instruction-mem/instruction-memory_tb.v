

module ins_mem_tb;
reg [7:0] in_data;
wire [7:0] out_data; 
reg [3:0] pc;
reg [3:0] in_addr; 

integer x; 

instruction_memory uut
	(
		.in_data(in_data),
		.addr(in_addr),
        .pc(pc),
        .out_data(out_data)
	);

    

initial begin 
	
        #5 x = 0;
        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 
        
        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 
        
        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 
        
        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1;

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 
        
        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1; 

        #5 in_addr = x;
        #5 in_data = x;
        #5 x = x+1;
        #5 x = 0; 
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
       
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1; 
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;

        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;

        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
       
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1; 
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;

        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;

        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
       
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1; 
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;

        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
       
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1; 
        
        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;

        #5 pc = x;
        $display("out_data: ", out_data);
        #5 x = x + 1;
end 

endmodule