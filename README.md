# ECE-550_ALU


Author:
=======
Lijing Yin(ly161) & Zoe Wang(zw255)

Design Implementation:
=======
We used 16 1-bit full adders (from the module fa_1bit) to build one 16-bit RCA (from the module fa_16bit) first, and applied three 16-bit RCAs to build one 32-bit CSA(from the module fa_32bit). Then not gate and muxs are used to translate ctrl_ALUopcode to be either addition or subtraction, which combined with CSA forms the basis of our ALU’s add and subtraction (from the module addorsub). And 3 nor gates are used to calculate the overflow through the relationship between whether carry out equal or not equal to carry in.

We built bitwise AND and OR functions for two 32-bit inputs by performing bitwise and gate and or gate respectively.(from the module andor)

We constructed 32-bit barrel shifter with SLL (Logical Left Shift) and SRA (Arithmetic Right Shift) in the modules alu_sll and alu_sra, where we used five layers of shifting to make the shift amoun called ctrl_shiftamt, with the maximum shift amount of 31 bits. And we combine these two shifting functions in the module datashift, and ctrl_ALUopcode can decide which shifting behavior should be applied.

We created the functions isNotEqual and isLessThan, by performing subtraction on two input numbers and comparing their sign bits.

The file alu_tb.v is the testbench for alu.v.
 
