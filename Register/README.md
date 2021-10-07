# ECE-550_ALU


Author:
=======
Lijing Yin(ly161) & Zoe Wang(zw255)

Design Implementation:
=======
1. We built 32bit DFFE based on the 1 bit DFFE in the module dffe_32
2. We used AND and NOT gate to build 5 to 32 Decocder in the module decoder
3. The write port is realized by first decoding the ctrl_writeReg to be 32bit, then enabling the register to write, calling the module dffe_32 to store the data.
4. We built a 32-bit tristate buffer to decide whether the output is equal to the input or 32-bit z (high impedance) in the module tristate_buffer_32bit.
5. We constructed the module regfile_read to read the value from a register. We first used decoder to decode 5-bit ctrl_readRegA to 32-bit read_select. The result of 32 32-bit registers’ values after going through tristate buffer was stored in the 2D array read_data. And we obtained the selected register’s value based on ctrl_readRegA.
