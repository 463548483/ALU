# ECE-550_Processor


Author:
=======
Lijing Yin(ly161) & Zoe Wang(zw255)

Design Implementation:
=======

# Clock divider
Set different clocks for 4 elements. imem and dmem have clocks 4 times faster than processor and regfile.

# PC
For JI type: assign next_PC=T.
For JII type: assign next_PC=$rd
For I type, if branched: assign next_PC=PC+1+N
For other type, assign next_PC=PC+1

# Instruction Decode to be signal control
take q_imem as input
1. Take Opcode=q_imem[31:27] to decide the R type or I type instruction and output other control signal.
2. Divided q_imem[26:0] as rd, rt, rs, immediate or shamt
3. Sign extend for immediate instruction
4. Assign input for dmem or regfile write
5. Sign extend for J type instruction's target
6. Compare consponding two registers' data to determine the next pc

# Overflow 
$rstatus = 1 for add overflow, $rstatus = 2 for addi overflow, $rstatus = 3 for sub overflow

# ALU design
ALU is used to calculate for add/sub/sll/sra operation and output from dmem address or register data write
ALU is used to compare registerA and register B to see if equal or less than

# Memory
Design imem as a 1-port ROM. And design dmem as a 1-port RAM. Both come with the corresponding memorization initialization files imem.mif and dmem.mif to test for the working.

# testing
We ran both functionional simulation and runtime simulation. The results are same as expected. 
