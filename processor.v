/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 /*control signal*/
	 wire [4:0] Opcode, Aluop;
	 wire BR, JP,ALUinB, ALUop_ctrl, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw, R_add, R_sub;
	 wire a_rd,a_rs,a_rt,a_rt,shamt,zeros,Imme_16,Imme_32;
	 
	 assign Opcode=instr[31:27];
	 control_logic control_1(Opcode, BR, JP,ALUinB, ALUop_ctrl, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw);
	 
	 assign Aluop=i_R?instru[6:2]:ALUop_ctrl;
	 assign R_add=(Aluop==5b'00000)?1:0; //00000 (00000)
	 assign R_sub=(Aluop==5b'00001)?1:0; //00000 (00001)
//	 assign R_and=(Aluop==5b'00010)?1:0; //00000 (00010)
//	 assign R_or=(Aluop==5b'00011)?1:0; //00000 (00011)
//	 assign R_sll=(Aluop==5b'00100)?1:0; //00000 (00100)
//	 assign R_sra=(Aluop==5b'00101)?1:0; //00000 (00101)

	 
	 assign a_rd=instr[26:22];
	 assign a_rs=instr[21:17];
	 assign a_rt=i_sw?instr[21:17]:instr[16:12];//?
	 assign shamt=instr[11:7];
	 assign zeros=instr[1:0];
	 assign Imme_16=instr[16:0]
	 SignExten SignExten_I(Imme_16,Imme_32);
	 
	 assign ctrl_writeEnable=Rwe;
	 assign ctrl_writeReg=a_rd;                  
    assign ctrl_readRegA=a_rs;                  
    assign ctrl_readRegB=a_rt;
	 
	 assign data_writeReg=Rwd?dmem_out:alu_out;
	 
	 //overflow
	 assign rstatus=is_ovf?(R_add?32d'1:(i_addi?32d'2:(R_sub?32d'3:32d'0))):32d'0;
	 assign data_writeReg=overflow? :aluout;
	 
	 //sign extend 16bit to 32bit
	 
	 
	 /*alu*/
	 //if (ALUop_ctrl==1)
	 assign Alu_dataB=ALUinB? signex?data_readRegB;
	 alu alu_1(data_readRegA, Alu_dataB, ALUop_ctrl,
			shamt, alu_out, isNotEqual, isLessThan, overflow);
	 
	 
	 

endmodule

module SignExten(s_16, s_32);

input [15:0] s_16; // 16-bit input
output [31:0] s_32; // 32-bit output

assign s_32 = { 16{s_16[15]}, s_16 };

endmodule