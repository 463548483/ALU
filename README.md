# ECE-550_ALU


Author:
=======
Lijing Yin(ly161) & Zoe Wang(zw255)

Design Implementation:
=======
We used 16 1-bit full adders (from the module fa_1bit) to build one 16-bit RCA (from the module fa_16bit) first, and applied three 16-bit RCAs to build one 32-bit CSA(from the module fa_32bit). Then not gate and muxs are used to translate ctrl_ALUopcode to be either addition or subtraction, which combined with CSA forms the basis of our ALU (from the module alu). And 3 nor gates are used to calculate the overflow through the relationship between whether carry out equal or not equal to carry in.

The file alu_tb.v is the testbench for alu.v.
 
