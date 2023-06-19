//Sub: Subtract register from accumulator

case(count)

8'b00000000: out = 8'b00000000; //000 NOP (beginning)

8'b00000010: out = 8'b11010011; //002 IMM 3 to ACC (ACC = 3)

8'b00000100: out = 8'b01010000; //004 ACC to reg 0 (Reg 0 = 3)

8'b00000110: out = 8'b11010001; //006 IMM 1 to ACC (ACC = 1)

8'b00001000: out = 8'b01010001; //008 ACC to reg 1 (Reg 1 = 1)

8'b00001010: out = 8'b00010000; //010 Add reg 0 to ACC (Reg 3 + ACC 1 = ACC 4)

8'b00001100: out = 8'b01010010; //012 ACC to reg 2 (Reg 2 = 4)

8'b00001110: out = 8'b11000000; //014 Shift right ACC (ACC 4/2 = 2)

8'b00010000: out = 8'b01010011; //016 ACC to reg 3 (reg 3 = 2)

8'b00010010: out = 8'b00110000; //018 NOR reg 1 to ACC (Nor 1, 3 = 252; 11111100)

8'b00010100: out = 8'b01010100; //020 ACC to reg 4 (reg 4 = 252)

8'b00010110: out = 8'b01000010; //022 Register 2 to ACC (ACC = 4)

8'b00011000: out = 8'b10110000; //024 Shift left ACC (4*2 = 8)

8'b00011010: out = 8'b01010101; //026 ACC to register 5 (reg 5 = 8)

8'b00011100: out = 8'b10110000; //028 Shift left ACC (8 * 2 = 16)

8'b00011110: out = 8'b10110000; //030 Shift left ACC (16 * 2 = 32)

8'b00100000: out = 8'b10110000; //032 Shift left ACC (32 * 2 = 64)

8'b00100010: out = 8'b01010110; //034 ACC to reg 6 (reg 6 = 64)

8'b00100100: out = 8'b11010000; //036 IMM 1 to ACC (ACC = 1)

8'b00100110: out = 8'b10000110; //038 Branch to value of reg 6 (64) if ACC < 0 (should not branch)

8'b00101000: out = 8'b01100110; //040 Branch to value of reg 6 if ACC = 0 (should not branch)

8'b00101010: out = 8'b00000000; //042 NOP

8'b00101100: out = 8'010000100; //044 Register 4 to ACC (ACC = 252)

8'b00101110: out = 8'b00100110; //046 Sub ACC (252) - Reg 6 (64) = 188

8'b00110000: out = 8'b01011000; //048 ACC to reg 8 (reg 8 = 188)

8'b00110010: out = 8'b11010000; //050 IMM 0 to ACC (ACC = 0)

8'b00110100: out = 8'b01100110; //052 Branch to value of reg 6 (64) if ACC = 0 (should branch)

8'b00110110: out = 8'b11110000; //054 HALT; end of program, skipped if previous branch is taken 





8'b01000000: out = 8'b00000000; //064 NOP (branch destination)

8'b01000010: out = 8'b11011111; //066 IMM 15 to ACC

8'b01000100: out = 8'b01011111; //068 ACC to reg 15 (Reg 15 = 15)

8'b01000110: out = 8'b11010000; //070 IMM 0 to ACC (ACC = 0)

8'b01001000: out = 8'b00000000; //072 NOP

8'b01001010: out = 8'b10000110; //074 Branch to value of reg 8 (188) if ACC = 0 (should branch)

8'b01001100: out = 8'b11110000; //076 HALT, skipped if previous branch is taken 






8'b10111100: out = 8'b00000000; //188 NOP (branch destination)

8'b10111110: out = 8'b11011100; //190 IMM 12 to ACC

8'b11000000: out = 8'b01011100; //192 ACC to reg 12 (Reg 12 = 12)

8'b11000010: out = 8'b11110000; //194 HALT, skipped if previous branch is taken

default: out = 8'b00000000; // NOP by default

endcase
