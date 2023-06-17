
module instruction_memory(in_data, addr, pc, out_data);
    // 16, 8 bit registers
    reg [7:0] ins_mem [0:15];

    // prgram counter 
    input [3:0] pc;

    // instruction memory address 
    input [3:0] addr;

    // data to place in memory 
    input [7:0] in_data;

    // instruction to send to instruction register 
    output reg [7:0] out_data;

    // test counter 
    //integer i = 0;

    // if a new instruction is sent to the register 
    always @(in_data) begin

        // assign data to addr in ins_mem
        ins_mem[addr] = in_data;


        
        // dump memory:
        // uncomment the "test counter" above to 
        // dump the memory for testing 
        /* 
        for(i=0; i < 15; i = i+1) begin 
            $display("mem[%d]: %d", i, ins_mem[i]);
        end
        */
    end

    // if program counter changes 
    always @(pc) begin

        // send data at ins program counter to memory 
        out_data <= ins_mem[pc % 15];
    end

endmodule