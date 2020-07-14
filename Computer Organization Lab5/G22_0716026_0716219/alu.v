/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input	       rst_n,         // Reset                     (input)
	input	[31:0] src1,          // 32 bits source 1          (input)
	input	[31:0] src2,          // 32 bits source 2          (input)
	input 	[ 3:0] ALU_control,   // 4 bits ALU control input  (input)
	output  [31:0] result,        // 32 bits result            (output)
	output         zero,          // 1 bit when the output is 0, zero must be set (output)
	output         cout,          // 1 bit carry out           (output)
	output         overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

assign result=(rst_n==0)?0:
				  (ALU_control==4'b0000)?src1+src2:
				  (ALU_control==4'b0001)?src1-src2:
				  (ALU_control==4'b0010)?src1&src2:
				  (ALU_control==4'b0011)?src1|src2:
				  (ALU_control==4'b0100)?src1^src2:
				  (ALU_control==4'b0101)?((src1<src2)?1:0):
				  (ALU_control==4'b0110)?src1<<src2:
				  (ALU_control==4'b0111)?src1>>>src2:
				  (ALU_control==4'b1011)?src1>>src2:
			     0;

assign zero=(ALU_control==4'b1110)?((src1==src2)?1:0):
				(ALU_control==4'b1111)?((src1==src2)?0:1):
				(ALU_control==4'b1000)?((src1<src2)?1:0):
				(ALU_control==4'b1001)?((src1>=src2)?1:0):
				0;
				
assign cout=0;
assign overflow=0;


endmodule
