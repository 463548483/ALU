# ECE-550_ALU


Author:
=======
Lijing Yin(ly161) & Zijing Wang(zw255)

Design Implementation:
=======
We used 16 1-bit full adders (from the module fa_1bit) to build one 16-bit RCA (from the module fa_16bit) first, and applied three 16-bit RCAs to build one 32-bit CSA(from the module fa_32bit), which is the basis of our ALU (from the module alu). The input ctrl_ALUopcode in the CSA can decide whether the alu performs addition or subtraction.

The file alu_tb.v is the testbench for alu.v.
 
