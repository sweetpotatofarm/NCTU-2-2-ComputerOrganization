/***************************************************
Student Name:
Student ID: 0716026
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

wire ainvert;
wire binvert;
wire [1:0] oper;
wire [31:0] R;
wire [31:0] c;
wire set;

assign set = (src1[31])^(~src2[31])^(c[30]);

assign ainvert = ALU_control[3];
assign binvert = ALU_control[2];
assign oper = ALU_control[1:0];

ALU_1bit alu0(
	.src1(src1[0]),
	.src2(src2[0]),
	.Ainvert(ainvert),
	.Binvert(binvert),
	.Cin(binvert),
	.operation(oper),
	.less(set),
	.result(R[0]),
	.cout(c[0])
);

genvar i;

generate
	for(i=1; i<32; i=i+1)begin
		ALU_1bit
		alu(
			.src1(src1[i]),
			.src2(src2[i]),
			.Ainvert(ainvert),
			.Binvert(binvert),
			.Cin(c[i-1]),
			.operation(oper),
			.less(1'b0),
			.result(R[i]),
			.cout(c[i])
		);
	end
endgenerate


always@(*)begin
	if(rst_n == 1'b1)begin
		result= R;
		zero = ~(|result);
		cout = c[31];
	end
end

endmodule
