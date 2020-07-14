/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [31:0] 	instr_i,
	output          ALUSrc,
	output          MemtoReg,
	output          RegWrite,
	output          MemRead,
	output          MemWrite,
	output          Branch,
	output [1:0]	ALUOp,
	output [1:0]	Jump
	);

/* Write your code HERE */
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[10-1:0]		Ctrl_o;
assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];

assign Ctrl_o = (opcode==7'b0110011)?10'b0010000000: //rtype
					 (opcode==7'b0010011)?10'b1010000100: //itype
					 (opcode==7'b0000011)?10'b1111001100: //lw
					 (opcode==7'b1100111)?10'bxx000xxx10: //jalr
					 (opcode==7'b1100011)?10'b0x00011000: //btype
					 (opcode==7'b0100011)?10'b1110101100: //stype
					 (opcode==7'b1101111)?10'bxx100xxx01: //jal
					 (opcode==7'b0010011)?10'bxx00000000:
					 0;

assign ALUSrc = Ctrl_o[9];
assign MemtoReg = Ctrl_o[8];
assign RegWrite = Ctrl_o[7];
assign MemRead = Ctrl_o[6];
assign MemWrite = Ctrl_o[5];
assign Branch = Ctrl_o[4];
assign ALUOp = Ctrl_o[3:2];
assign Jump = Ctrl_o[1:0];


endmodule





                    
                    