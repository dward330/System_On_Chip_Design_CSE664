//Sub: Subtract register from accumulator

case(count)

8'b00000000: out = 8'b00000000; //000 NOP (beginning)

8'b00000010: out = 8'b11010011; //002 IMM 3 to ACC (ACC = 3)

8'b00000100: out = 8'b01010011; //004 IMM 0 to ACC (ACC = 0)

8'b00000110: out = 8'b01111010; //006 Branch to IMM 10 if ACC = 0 (line 010) (should be taken)

8'b00001000: out = 8'b11111111; //008 HALT; end of program (should be skipped by program)

8'b00001010: out = 8'b11011000; //010 IMM 8 to ACC (ACC = 8)

8'b00001100: out = 8'b01111000; //012 Branch to IMM 8 if ACC = 0 (line 008) (should not be taken)

8'b00001110: out = 8'b01010000; //014 ACC to reg 0 (Reg 0 = 8)

8'b00010000: out = 8'b11111111; //016 HALT; end of program


endcase
