# ECE-550_ALU


Author:
=======
Lijing Yin(ly161) & Zoe Wang(zw255)

Design Implementation:
=======
1. We built 32bit DFFE based on the 1 bit DFFE in the module dffe_32
2. We use AND and NOT gate to build 5 to 32 Decocder in the module decoder
3. The write port is realized by first decoding the ctrl_writeReg to be 32bit, then enabling the register to write, calling the module dffe_32 to store the data.
4. 
