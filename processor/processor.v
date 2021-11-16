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
    data_readRegB							 // I: Data from port B of regfile
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
	 wire [31:0] pc, next_pc;
	 
	 //instruction fetch
	 dffe_32 pc_dffe_32(pc, next_pc, clock, 1'b1, reset);
	
	 assign address_imem = pc[11:0];  //imem
	 
	 /*control signal*/
	 wire [4:0] Opcode, Aluop;
	 wire BR, JP,ALUinB, ALUop_ctrl, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw, R_add, R_sub;
	 wire i_jal, i_setx, i_j, i_bne, i_jr, i_blt, i_bex;  //new
	 wire [4:0] a_rd,a_rs,a_rt, shamt;
	 wire [1:0] zeros;
	 wire [16:0] Imme_17;
	 wire [31:0] Imme_32,alu_out,rstatus;
	 wire overflow;
	 wire [26:0] address_T_27; //new
	 wire [31:0] address_T_32; //new
	 wire [31:0] next_pc_1; //new
	 
	 //assign q_im=q_imem[26:22];
	
	 //instruction decode, instruction=q_imem
	 assign Opcode=q_imem[31:27];
	   
	 //control_logic control_1(Opcode, BR, JP,ALUinB, ALUop_ctrl, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw);
	 control_logic control_1(Opcode, BR, JP,ALUinB, ALUop_ctrl, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw, i_jal, i_setx, i_j, i_bne, i_jr, i_blt, i_bex);  //new
	 
	 
	 assign Aluop=i_R?q_imem[6:2]:ALUop_ctrl;
	 assign R_add=(Aluop==5'b00000)?1:0; //00000 (00000)
	 assign R_sub=(Aluop==5'b00001)?1:0; //00000 (00001)
//	 assign R_and=(Aluop==5b'00010)?1:0; //00000 (00010)
//	 assign R_or=(Aluop==5b'00011)?1:0; //00000 (00011)
//	 assign R_sll=(Aluop==5b'00100)?1:0; //00000 (00100)
//	 assign R_sra=(Aluop==5b'00101)?1:0; //00000 (00101)

	 
	 assign a_rd=i_setx?5'd30:(i_jal?5'd31:((R_add|R_sub|i_addi)?(overflow?5'd30:q_imem[26:22]):q_imem[26:22]));  //new
	 assign a_rs=i_bex?5'd30:q_imem[21:17];  //new
	 //assign a_rt=i_sw?q_imem[26:22]:q_imem[16:12];//?
	 assign a_rt=i_bex?5'd0:q_imem[16:12];  //new
	 assign shamt=q_imem[11:7];
	 //assign zeros=q_imem[1:0];
	 
	 //sign extend 16bit to 32bit
	 assign Imme_17=q_imem[16:0];
	 SignExten SignExten_I(Imme_17,Imme_32);
	 
	 //assign regfile input
	 assign ctrl_writeEnable=Rwe;
	 assign ctrl_writeReg=a_rd;                  
    assign ctrl_readRegA=i_jr? q_imem[26:22]:a_rs;//newz                  
    assign ctrl_readRegB=a_rt
	 assign ctrl_pc_JI=i_jal| i_j|(i_bex&isNotEqual); // JI type contro PC = T
	 assign ctrl_pc_I=(i_blt&~isLessThan&isNotEqual)|(i_bne&isNotEqual); // I type control PC = PC+N+1
	 
	 //assign data_writeReg=Rwd?Imme_32:alu_out;
	 
	 assign address_T_27 = q_imem[26:0];    //new
	 assign address_T_32 = {5'd0, address_T_27};    //new
	 assign next_pc_1 = pc+32'd1;  //new
	 
	 //overflow
	 assign rstatus=overflow?(R_add?32'd1:(i_addi?32'd2:(R_sub?32'd3:32'd0))):32'd0;
	 //assign data_writeReg=i_lw? q_dmem:((R_add|R_sub|i_addi)?(overflow?rstatus:alu_out):alu_out);
	 assign data_writeReg=i_setx? address_T_32: (i_jal?next_pc_1:(i_lw? q_dmem:((R_add|R_sub|i_addi)?(overflow?rstatus:alu_out):alu_out))); //new
	 
	 //alu calculation
	 wire [31:0]Alu_dataB;
	 wire isNotEqual, isLessThan;
	 assign Alu_dataB=ALUinB? Imme_32:data_readRegB;
	 alu alu_1(data_readRegA, Alu_dataB, Aluop, shamt, alu_out, isNotEqual, isLessThan, overflow);
	
	 //result store
	 assign address_dmem = alu_out[11:0]; //dmem
	 assign data = data_readRegB;
	 assign wren = i_sw;
	
	 //Put this code at the end of all codes!
	 //update next instruction
	 //assign next_pc = i_jr?data_readRegA:((i_j|i_jal|i_bex)?q_imem[26:0]:((i_bne|i_blt)?(pc + 32'b1 +Imme_32):(pc + 32'b1 )));//new
	 
	 //assign next_pc=pc+32'b1;
	 
	  assign next_pc = i_jr? data_readRegA : (ctrl_pc_JI? address_T_32 : (ctrl_pc_I? pc+32'b1+Imme_32 : pc+32'd1));//newz
	 
	 

endmodule

module SignExten(s_17, s_32);

input [16:0] s_17; // 16-bit input
output [31:0] s_32; // 32-bit output

assign s_32 = { {15{s_17[16]}}, s_17 };

endmodule

module dffe_32(q, d, clk, en, rst);
   
   //Inputs
   input [31:0]d; 
	input clk, en, rst;
   
   //Internal wire
   wire rst;

   //Output
   output [31:0]q;
   
   //Register
   reg [31:0]q;

   //Intialize q to 0
   initial
   begin
       q = 32'h00000000;
   end

   //Set value of q on positive edge of the clock or clear
   always @(posedge clk or posedge rst) begin
       //If clear is high, set q to 0
       if (rst) begin
           q <= 32'h00000000;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
   end
endmodule

/*module control_logic(
Opcode, BR, JP,ALUinB, ALUop, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw);*/
module control_logic(
Opcode, BR, JP,ALUinB, ALUop, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw, i_jal, i_setx, i_j, i_bne, i_jr, i_blt, i_bex);  //new

	input [4:0] Opcode;
	output BR, JP,ALUinB, ALUop, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw;
	output i_jal, i_setx, i_j, i_bne, i_jr, i_blt, i_bex;  //new

	assign i_R=(Opcode==5'b00000)?1:0;//00000
	assign i_addi=(Opcode==5'b00101)?1:0; //00101
	assign i_sw=(Opcode==5'b00111)?1:0; //00111
	assign i_lw=(Opcode==5'b01000)?1:0; //01000
	assign i_jal=(Opcode==5'b00011)?1:0; //00011   //new
	assign i_setx=(Opcode==5'b10101)?1:0;  //10101   //new
	assign i_j=(Opcode==5'b00001)?1:0; //00001  //new
	assign i_bne=(Opcode==5'b00010)?1:0; //00010  //new
	assign i_jr=(Opcode==5'b00100)?1:0; //00100  //new
	assign i_blt=(Opcode==5'b00110)?1:0; //00110  //new
	assign i_bex=(Opcode==5'b10110)?1:0; //10110  //new

	assign BR=0;
	assign JP=i_j?1:0;  //new
	assign ALUinB=i_addi|i_lw|i_sw; 
	assign ALUop=0;
	assign DMwe=i_sw; 
	assign Rwe=i_R|i_lw|i_addi|i_jal|i_setx;  //new
	assign Rdst=i_R;
	assign Rwd=i_lw;
	//assign i_jI=(Opcode==(5'b00001 || 5'b00011 || 5'b10110 || 5'b10101))?1:0;  //new
	//assign i_jII=(Opcode==5'b00100)?1:0;  //new
	
endmodule
