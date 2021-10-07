module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;
	
	//write start
	wire [31:0] decoder_write;
	wire [31:0] register_output[31:0];

   decoder decoder_w(ctrl_writeReg,decoder_write);
	
	//output enable
	wire [31:0] en;
	genvar i;
	generate
		for(i=0;i<=31;i=i+1) begin: write_out
			and(en[i],ctrl_writeEnable,decoder_write[i]);
		end
	endgenerate
	
	//write to register
	genvar j;
	generate
		for(j=0;j<=31;j=j+1) begin: write_reg
			dffe_32 dffe_n(register_output[j], data_writeReg, clock, en[j], ctrl_reset);
		end
	endgenerate
	//write end
	
	//read
	//read register A
	regfile_read regfile_read_A(
	register_output[0],
	register_output[1],
	register_output[2],
	register_output[3],
	register_output[4],
	register_output[5],
	register_output[6],
	register_output[7],
	register_output[8],
	register_output[9],
	register_output[10],
	register_output[11],
	register_output[12],
	register_output[13],
	register_output[14],
	register_output[15],
	register_output[16],
	register_output[17],
	register_output[18],
	register_output[19],
	register_output[20],
	register_output[21],
	register_output[22],
	register_output[23],
	register_output[24],
	register_output[25],
	register_output[26],
	register_output[27],
	register_output[28],
	register_output[29],
	register_output[30],
	register_output[31],
	ctrl_readRegA,
	data_readRegA
);

//read register B
	regfile_read regfile_read_B(
	register_output[0],
	register_output[1],
	register_output[2],
	register_output[3],
	register_output[4],
	register_output[5],
	register_output[6],
	register_output[7],
	register_output[8],
	register_output[9],
	register_output[10],
	register_output[11],
	register_output[12],
	register_output[13],
	register_output[14],
	register_output[15],
	register_output[16],
	register_output[17],
	register_output[18],
	register_output[19],
	register_output[20],
	register_output[21],
	register_output[22],
	register_output[23],
	register_output[24],
	register_output[25],
	register_output[26],
	register_output[27],
	register_output[28],
	register_output[29],
	register_output[30],
	register_output[31],
	ctrl_readRegB,
	data_readRegB
);
	
endmodule


module regfile_read(
	register_output_0,
	register_output_1,
	register_output_2,
	register_output_3,
	register_output_4,
	register_output_5,
	register_output_6,
	register_output_7,
	register_output_8,
	register_output_9,
	register_output_10,
	register_output_11,
	register_output_12,
	register_output_13,
	register_output_14,
	register_output_15,
	register_output_16,
	register_output_17,
	register_output_18,
	register_output_19,
	register_output_20,
	register_output_21,
	register_output_22,
	register_output_23,
	register_output_24,
	register_output_25,
	register_output_26,
	register_output_27,
	register_output_28,
	register_output_29,
	register_output_30,
	register_output_31,
	ctrl_readRegA,
	data_readRegA
);

input [31:0] register_output_0,
				 register_output_1,
				 register_output_2,
				 register_output_3,
				 register_output_4,
				 register_output_5,
				 register_output_6,
				 register_output_7,
				 register_output_8,
				 register_output_9,
				 register_output_10,
				 register_output_11,
				 register_output_12,
				 register_output_13,
				 register_output_14,
				 register_output_15,
				 register_output_16,
				 register_output_17,
				 register_output_18,
				 register_output_19,
				 register_output_20,
				 register_output_21,
				 register_output_22,
				 register_output_23,
				 register_output_24,
				 register_output_25,
				 register_output_26,
				 register_output_27,
				 register_output_28,
				 register_output_29,
				 register_output_30,
				 register_output_31; 
input [4:0] ctrl_readRegA;
output [31:0] data_readRegA;
wire [31:0] read_select;
wire [31:0] read_data[31:0];

decoder decoder2(ctrl_readRegA, read_select);

assign read_data[0] = 32'h00000000;

tristate_buffer_32bit triBuffer_1(register_output_1,read_select[1],read_data[1]);
tristate_buffer_32bit triBuffer_2(register_output_2,read_select[2],read_data[2]);
tristate_buffer_32bit triBuffer_3(register_output_3,read_select[3],read_data[3]);
tristate_buffer_32bit triBuffer_4(register_output_4,read_select[4],read_data[4]);
tristate_buffer_32bit triBuffer_5(register_output_5,read_select[5],read_data[5]);
tristate_buffer_32bit triBuffer_6(register_output_6,read_select[6],read_data[6]);
tristate_buffer_32bit triBuffer_7(register_output_7,read_select[7],read_data[7]);
tristate_buffer_32bit triBuffer_8(register_output_8,read_select[8],read_data[8]);
tristate_buffer_32bit triBuffer_9(register_output_9,read_select[9],read_data[9]);
tristate_buffer_32bit triBuffer_10(register_output_10,read_select[10],read_data[10]);
tristate_buffer_32bit triBuffer_11(register_output_11,read_select[11],read_data[11]);
tristate_buffer_32bit triBuffer_12(register_output_12,read_select[12],read_data[12]);
tristate_buffer_32bit triBuffer_13(register_output_13,read_select[13],read_data[13]);
tristate_buffer_32bit triBuffer_14(register_output_14,read_select[14],read_data[14]);
tristate_buffer_32bit triBuffer_15(register_output_15,read_select[15],read_data[15]);
tristate_buffer_32bit triBuffer_16(register_output_16,read_select[16],read_data[16]);
tristate_buffer_32bit triBuffer_17(register_output_17,read_select[17],read_data[17]);
tristate_buffer_32bit triBuffer_18(register_output_18,read_select[18],read_data[18]);
tristate_buffer_32bit triBuffer_19(register_output_19,read_select[19],read_data[19]);
tristate_buffer_32bit triBuffer_20(register_output_20,read_select[20],read_data[20]);
tristate_buffer_32bit triBuffer_21(register_output_21,read_select[21],read_data[21]);
tristate_buffer_32bit triBuffer_22(register_output_22,read_select[22],read_data[22]);
tristate_buffer_32bit triBuffer_23(register_output_23,read_select[23],read_data[23]);
tristate_buffer_32bit triBuffer_24(register_output_24,read_select[24],read_data[24]);
tristate_buffer_32bit triBuffer_25(register_output_25,read_select[25],read_data[25]);
tristate_buffer_32bit triBuffer_26(register_output_26,read_select[26],read_data[26]);
tristate_buffer_32bit triBuffer_27(register_output_27,read_select[27],read_data[27]);
tristate_buffer_32bit triBuffer_28(register_output_28,read_select[28],read_data[28]);
tristate_buffer_32bit triBuffer_29(register_output_29,read_select[29],read_data[29]);
tristate_buffer_32bit triBuffer_30(register_output_30,read_select[30],read_data[30]);
tristate_buffer_32bit triBuffer_31(register_output_31,read_select[31],read_data[31]);
	
assign data_readRegA = read_data[ctrl_readRegA];

endmodule


module tristate_buffer_32bit(
	buffer_input,
	buffer_select,
	buffer_output
);

input [31:0] buffer_input;
input buffer_select;
output [31:0] buffer_output;

assign buffer_output = buffer_select? buffer_input: 32'bz;

endmodule

module dffe_32(q, d, clk, en, clr);
   
   //Inputs
   input [31:0]d; 
	input clk, en, clr;
   
   //Internal wire
   wire clr;

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
   always @(posedge clk or posedge clr) begin
       //If clear is high, set q to 0
       if (clr) begin
           q <= 32'h00000000;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
   end
endmodule

module decoder(ctrl_Reg,decode_out);
	input [4:0]ctrl_Reg;
	output [31:0]decode_out;

	wire [4:0]not_ctrl;
	
	genvar j;
	generate
		for(j=0;j<=4;j=j+1) begin: not_c
			not (not_ctrl[j],ctrl_Reg[j]);
		end
	endgenerate

AND_5_input a0(decode_out[0],not_ctrl[4],not_ctrl[3],not_ctrl[2],not_ctrl[1],not_ctrl[0]); 
AND_5_input a1(decode_out[1],not_ctrl[4],not_ctrl[3],not_ctrl[2],not_ctrl[1],ctrl_Reg[0]); 
AND_5_input a2(decode_out[2],not_ctrl[4],not_ctrl[3],not_ctrl[2],ctrl_Reg[1],not_ctrl[0]); 
AND_5_input a3(decode_out[3],not_ctrl[4],not_ctrl[3],not_ctrl[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a4(decode_out[4],not_ctrl[4],not_ctrl[3],ctrl_Reg[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a5(decode_out[5],not_ctrl[4],not_ctrl[3],ctrl_Reg[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a6(decode_out[6],not_ctrl[4],not_ctrl[3],ctrl_Reg[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a7(decode_out[7],not_ctrl[4],not_ctrl[3],ctrl_Reg[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a8(decode_out[8],not_ctrl[4],ctrl_Reg[3],not_ctrl[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a9(decode_out[9],not_ctrl[4],ctrl_Reg[3],not_ctrl[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a10(decode_out[10],not_ctrl[4],ctrl_Reg[3],not_ctrl[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a11(decode_out[11],not_ctrl[4],ctrl_Reg[3],not_ctrl[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a12(decode_out[12],not_ctrl[4],ctrl_Reg[3],ctrl_Reg[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a13(decode_out[13],not_ctrl[4],ctrl_Reg[3],ctrl_Reg[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a14(decode_out[14],not_ctrl[4],ctrl_Reg[3],ctrl_Reg[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a15(decode_out[15],not_ctrl[4],ctrl_Reg[3],ctrl_Reg[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a16(decode_out[16],ctrl_Reg[4],not_ctrl[3],not_ctrl[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a17(decode_out[17],ctrl_Reg[4],not_ctrl[3],not_ctrl[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a18(decode_out[18],ctrl_Reg[4],not_ctrl[3],not_ctrl[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a19(decode_out[19],ctrl_Reg[4],not_ctrl[3],not_ctrl[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a20(decode_out[20],ctrl_Reg[4],not_ctrl[3],ctrl_Reg[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a21(decode_out[21],ctrl_Reg[4],not_ctrl[3],ctrl_Reg[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a22(decode_out[22],ctrl_Reg[4],not_ctrl[3],ctrl_Reg[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a23(decode_out[23],ctrl_Reg[4],not_ctrl[3],ctrl_Reg[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a24(decode_out[24],ctrl_Reg[4],ctrl_Reg[3],not_ctrl[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a25(decode_out[25],ctrl_Reg[4],ctrl_Reg[3],not_ctrl[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a26(decode_out[26],ctrl_Reg[4],ctrl_Reg[3],not_ctrl[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a27(decode_out[27],ctrl_Reg[4],ctrl_Reg[3],not_ctrl[2],ctrl_Reg[1],ctrl_Reg[0]);
AND_5_input a28(decode_out[28],ctrl_Reg[4],ctrl_Reg[3],ctrl_Reg[2],not_ctrl[1],not_ctrl[0]);
AND_5_input a29(decode_out[29],ctrl_Reg[4],ctrl_Reg[3],ctrl_Reg[2],not_ctrl[1],ctrl_Reg[0]);
AND_5_input a30(decode_out[30],ctrl_Reg[4],ctrl_Reg[3],ctrl_Reg[2],ctrl_Reg[1],not_ctrl[0]);
AND_5_input a31(decode_out[31],ctrl_Reg[4],ctrl_Reg[3],ctrl_Reg[2],ctrl_Reg[1],ctrl_Reg[0]); 
endmodule	

module AND_5_input(out,a,b,c,d,e);
  output out;
  input a,b,c,d,e;
  wire and1;
  and(and1,a,b,c);
  and(out,and1,d,e);
endmodule