module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

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

	
	assign outputB=ctrl_ALUopcode?notB:data_operandB;
   fa_32bit fa_32bit1(data_operandA,outputB,ctrl_ALUopcode,overflow,data_result);

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