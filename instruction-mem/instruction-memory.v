module instruction_memory(in_data, addr, pc, out_data);
    reg [7:0] ins_mem [0:15];
    input [3:0] pc;
    input [3:0] addr;
    input [7:0] in_data;
    output reg [7:0] out_data;

    integer i = 0;
    always @(in_data) begin
        $display("addr", addr);
        ins_mem[addr] = in_data;
        $display("in_data: ", ins_mem[addr]);
        for(i=0; i < 15; i = i+1) begin 
            $display("mem[%d]: %d", i, ins_mem[i]);
        end
    end

    always @(pc) begin
        out_data <= ins_mem[pc % 15];
    end

endmodule