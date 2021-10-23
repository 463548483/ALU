module control_logic(
Opcode, BR, JP,ALUinB, ALUop, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw);
	
	input [4:0] Opcode;
	output BR, JP,ALUinB, ALUop, DMwe, Rwe, Rdst, Rwd,i_R, i_addi, i_sw, i_lw;

	assign i_R=(Opcode==5'b00000)?1:0;//00000
	assign i_addi=(Opcode==5'b00101)?1:0; //00101
	assign i_sw=(Opcode==5'b00111)?1:0; //00111
	assign i_lw=(Opcode==5'b01000)?1:0; //01000

	assign BR=0;
	assign JP=0; 
	assign ALUinB=i_addi|i_lw|i_sw; 
	assign ALUop=0;
	assign DMwe=i_sw; 
	assign Rwe=i_R|i_lw|i_addi;
	assign Rdst=i_R;
	assign Rwd=i_lw;
	
endmodule
