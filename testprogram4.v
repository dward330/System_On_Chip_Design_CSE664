//Sub: Subtract register from accumulator

case(count)

8'b00000000: out = 8'b10101100; //000 Branch to IMM 12 if ACC != 0 (line 008) (should not branch)

8'b00000010: out = 8'b01110110; //002 Branch to IMM 6 if ACC = 0 (line 008) 

8'b00000100: out = 8'b01111000; //004 Branch to IMM 8 if ACC = 0 (line 010) 

8'b00000110: out = 8'b01111010; //006 Branch to IMM 10 if ACC = 0 (line 012)

8'b00001000: out = 8'b01111100; //008 Branch to IMM 12 if ACC = 0 (line 014)

8'b00001010: out = 8'b01110100; //010 Branch to IMM 4 if ACC = 0 (line 006)

8'b00001100: out = 8'b10001110; //012 Branch to value of REG 0 if ACC != 0 (line 008) (should not branch)

8'b00001110: out = 8'b11011010; //014 IMM 10 to ACC (ACC = 10)

8'b00010000: out = 8'b01010000; //016 ACC to reg 0 (Reg 0 = 10)

8'b00010010: out = 8'b11111111; //018 HALT; end of program

default: out = 8'b00000000; //default NOP

endcase
