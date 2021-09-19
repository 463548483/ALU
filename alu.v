module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	
	wire [31:0]data_result1;
	wire [31:0]data_result2;
	wire [31:0]data_result3;

	addorsub addorsub1(data_operandA, data_operandB, ctrl_ALUopcode[0], data_result1, isNotEqual, isLessThan, overflow);
	andor andor1(data_operandA, data_operandB, ctrl_ALUopcode[0], data_result2);
	datashift datashift1(data_operandA,ctrl_ALUopcode[0],ctrl_shiftamt,data_result3);
	assign data_result=ctrl_ALUopcode[2]?data_result3:(ctrl_ALUopcode[1]?data_result2:data_result1);

endmodule

module datashift(A, ctrl_ALUopcode3,shiftamt, S);
	input [31:0] A;
	input [4:0] shiftamt;
	input ctrl_ALUopcode3;
	output [31:0] S;
	
	wire [31:0]S1;
	wire [31:0]S2;
	
	alu_sll alu_sll1(A, shiftamt, S1);
	alu_sra alu_sra1(A, shiftamt, S2);
	
	assign S=ctrl_ALUopcode3?S2:S1;

endmodule
	
module alu_sll(A, shiftamt, S);
	input [31:0] A;
	input [4:0] shiftamt;
	output [31:0] S;
	wire [31:0] s_shift_0, s_shift_1, s_shift_2, s_shift_3, s_shift_4;
	
	//shiftamt[0]
	assign s_shift_0[0] = shiftamt[0]? 1'b0: A[0];	
	genvar i;
	generate
		for(i=1;i<32;i=i+1) begin: shiftamout0
			assign s_shift_0[i] = shiftamt[0]? A[i-1]: A[i];
		end
	endgenerate
	
	
	//shiftamt[1]
	assign s_shift_1[0] = shiftamt[1]? 1'b0: s_shift_0[0];
	assign s_shift_1[1] = shiftamt[1]? 1'b0: s_shift_0[1];
	genvar j;
	generate
		for(j=2;j<32;j=j+1) begin: shiftamout1
			assign s_shift_1[j] = shiftamt[1]? s_shift_0[j-2]: s_shift_0[j];
		end
	endgenerate
	
	
	//shiftamt[2]
	genvar k;
	generate
		for(k=0;k<4;k=k+1) begin: shiftamout2
			assign s_shift_2[k] = shiftamt[2]? 1'b0: s_shift_1[k];
		end
	endgenerate
	
	genvar p;
	generate
		for(p=4;p<32;p=p+1) begin:	shiftamout_2
			assign s_shift_2[p] = shiftamt[2]? s_shift_1[p-4]: s_shift_1[p];
		end
	endgenerate
	
	
	//shiftamt[3]
	genvar q;
	generate
		for(q=0;q<8;q=q+1) begin: shiftamout3
			assign s_shift_3[q] = shiftamt[3]? 1'b0: s_shift_2[q];
		end
	endgenerate
	
	genvar m;
	generate
		for(m=8;m<32;m=m+1) begin: shiftamout_3
			assign s_shift_3[m] = shiftamt[3]? s_shift_2[m-8]: s_shift_2[m];
		end
	endgenerate
	
	//shiftamt[4]
	genvar n;
	generate
		for(n=0;n<16;n=n+1) begin: shiftamout4
			assign s_shift_4[n] = shiftamt[4]? 1'b0: s_shift_3[n];
		end
	endgenerate
	
	genvar x;
	generate
		for(x=16;x<32;x=x+1) begin: shiftamout_4
			assign s_shift_4[x] = shiftamt[4]? s_shift_3[x-16]: s_shift_3[x];
		end
	endgenerate
	
	
	assign S = s_shift_4;
	
	
endmodule 

module alu_sra(A, shiftamt, S);
	input [31:0] A;
	input [4:0] shiftamt;
	output [31:0] S;
	wire sign_bit;
	wire [31:0] s_shift_0, s_shift_1, s_shift_2, s_shift_3, s_shift_4;
	
	assign sign_bit = A[31];
	
	//shiftamt[0]
	assign s_shift_0[31] = shiftamt[0]? sign_bit: A[31];	
	genvar i;
	generate
		for(i=30;i>=0;i=i-1) begin: shiftamout0
			assign s_shift_0[i] = shiftamt[0]? A[i+1]: A[i];
		end
	endgenerate
	
	
	//shiftamt[1]
	assign s_shift_1[31] = shiftamt[1]? sign_bit: s_shift_0[31];
	assign s_shift_1[30] = shiftamt[1]? sign_bit: s_shift_0[30];
	genvar j;
	generate
		for(j=29;j>=0;j=j-1) begin: shiftamout1
			assign s_shift_1[j] = shiftamt[1]? s_shift_0[j+2]: s_shift_0[j];
		end
	endgenerate
	
	
	//shiftamt[2]
	genvar k;
	generate
		for(k=31;k>=28;k=k-1) begin: shiftamout2
			assign s_shift_2[k] = shiftamt[2]? sign_bit: s_shift_1[k];
		end
	endgenerate
	
	genvar p;
	generate
		for(p=27;p>=0;p=p-1) begin:	shiftamout_2
			assign s_shift_2[p] = shiftamt[2]? s_shift_1[p+4]: s_shift_1[p];
		end
	endgenerate
	
	
	//shiftamt[3]
	genvar q;
	generate
		for(q=31;q>=24;q=q-1) begin: shiftamout3
			assign s_shift_3[q] = shiftamt[3]? sign_bit: s_shift_2[q];
		end
	endgenerate
	
	genvar m;
	generate
		for(m=23;m>=0;m=m-1) begin: shiftamout_3
			assign s_shift_3[m] = shiftamt[3]? s_shift_2[m+8]: s_shift_2[m];
		end
	endgenerate
	
	//shiftamt[4]
	genvar n;
	generate
		for(n=31;n>=16;n=n-1) begin: shiftamout4
			assign s_shift_4[n] = shiftamt[4]? sign_bit: s_shift_3[n];
		end
	endgenerate
	
	genvar x;
	generate
		for(x=15;x>=0;x=x-1) begin: shiftamout_4
			assign s_shift_4[x] = shiftamt[4]? s_shift_3[x+16]: s_shift_3[x];
		end
	endgenerate
	
	
	assign S = s_shift_4;
	
	
endmodule 

module andor(A,B, ctrl_ALUopcode2, data_result);
	input[31:0] A;
	input[31:0] B;
	input ctrl_ALUopcode2;
	output[31:0] data_result;
	
	wire [31:0] data_result1;
	wire [31:0] data_result2;

	genvar i;
	generate
		for (i=0;i<32;i=i+1) begin: andgate
			and(data_result1[i],A[i],B[i]);
			or(data_result2[i],A[i],B[i]);
		end
	endgenerate	
	
	assign data_result=ctrl_ALUopcode2?data_result2:data_result1;
	
	
endmodule

module addorsub(data_operandA, data_operandB, ctrl_ALUopcode1, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input ctrl_ALUopcode1;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;


	wire cout;
	wire [31:0] outputB;
	wire [31:0] notB;
	genvar i;

	generate
		for (i=0;i<32;i=i+1) begin: notgate
			not(notB[i], data_operandB[i]);
		end
	endgenerate	

	
	assign outputB=ctrl_ALUopcode1?notB:data_operandB;
   fa_32bit fa_32bit1(data_operandA,outputB,ctrl_ALUopcode1,overflow,data_result);
	assign isNotEqual=data_result?(ctrl_ALUopcode1?1:0):0;
	assign isLessThan=data_result[31]?(ctrl_ALUopcode1?1:0):0;

	
endmodule

module fa_32bit(a,b,ctrl_ALUopcode,ovf,sum);
	input [31:0] a,b;
	input [4:0]ctrl_ALUopcode;
	
	output ovf;
	output[31:0] sum;
	
	wire cin;
	assign cin=ctrl_ALUopcode?1:0;
	wire cout16;
	wire cout;
	wire [15:0] sum1;
	wire cout1;
	wire cout2;
	wire [15:0] sum2;
	
	fa_16bit fa_16bit1(a[15:0],b[15:0],cin,cout16,sum[15:0]);
	fa_16bit fa_16bit2(a[31:16],b[31:16],0,cout1,sum1);
	fa_16bit fa_16bit3(a[31:16],b[31:16],1,cout2,sum2);
	assign sum[31:16]=cout16?sum2:sum1;
	assign cout=cout16?cout2:cout1;
	
	wire sum31;
	wire cin31;
	xor xor_gate1(sum31,a[31],b[31]);
	xor xor_gate2(cin31,sum[31],sum31);
	xor xor_gate3(ovf,cin31,cout);
	
endmodule	


module fa_16bit(A,B,Cin,Cout,S);

	input [15:0] A,B;
	input Cin;
	output [15:0] S;
	output Cout;
	
	wire [14:0] Carry;
	
	fa_1bit fa0(
		.A(A[0]),
		.B(B[0]),
		.Cin(Cin),
		.S(S[0]),
		.Cout(Carry[0])
	);
	
	fa_1bit fa1(
		.A(A[1]),
		.B(B[1]),
		.Cin(Carry[0]),
		.S(S[1]),
		.Cout(Carry[1])
	);
	
	fa_1bit fa2(
		.A(A[2]),
		.B(B[2]),
		.Cin(Carry[1]),
		.S(S[2]),
		.Cout(Carry[2])
	);
	
	fa_1bit fa3(
		.A(A[3]),
		.B(B[3]),
		.Cin(Carry[2]),
		.S(S[3]),
		.Cout(Carry[3])
	);

	fa_1bit fa4(
		.A(A[4]),
		.B(B[4]),
		.Cin(Carry[3]),
		.S(S[4]),
		.Cout(Carry[4])
	);

	fa_1bit fa5(
		.A(A[5]),
		.B(B[5]),
		.Cin(Carry[4]),
		.S(S[5]),
		.Cout(Carry[5])
	);

	fa_1bit fa6(
		.A(A[6]),
		.B(B[6]),
		.Cin(Carry[5]),
		.S(S[6]),
		.Cout(Carry[6])
	);

	fa_1bit fa7(
		.A(A[7]),
		.B(B[7]),
		.Cin(Carry[6]),
		.S(S[7]),
		.Cout(Carry[7])
	);

	fa_1bit fa8(
		.A(A[8]),
		.B(B[8]),
		.Cin(Carry[7]),
		.S(S[8]),
		.Cout(Carry[8])
	);

	fa_1bit fa9(
		.A(A[9]),
		.B(B[9]),
		.Cin(Carry[8]),
		.S(S[9]),
		.Cout(Carry[9])
	);

	fa_1bit fa10(
		.A(A[10]),
		.B(B[10]),
		.Cin(Carry[9]),
		.S(S[10]),
		.Cout(Carry[10])
	);

	fa_1bit fa11(
		.A(A[11]),
		.B(B[11]),
		.Cin(Carry[10]),
		.S(S[11]),
		.Cout(Carry[11])
	);

	fa_1bit fa12(
		.A(A[12]),
		.B(B[12]),
		.Cin(Carry[11]),
		.S(S[12]),
		.Cout(Carry[12])
	);

	fa_1bit fa13(
		.A(A[13]),
		.B(B[13]),
		.Cin(Carry[12]),
		.S(S[13]),
		.Cout(Carry[13])
	);

	fa_1bit fa14(
		.A(A[14]),
		.B(B[14]),
		.Cin(Carry[13]),
		.S(S[14]),
		.Cout(Carry[14])
	);

	fa_1bit fa15(
		.A(A[15]),
		.B(B[15]),
		.Cin(Carry[14]),
		.S(S[15]),
		.Cout(Cout)
	);

endmodule

module fa_1bit(A, B, Cin, S, Cout);
	input A, B, Cin;
	output S, Cout;
	wire X1, X2, X3;
	
	xor xor1(S, A, B, Cin);
	and and1(X1, A, B);
	and and2(X2, A, Cin);
	and and3(X3, B, Cin);
	or or1(Cout, X1, X2, X3);

endmodule 