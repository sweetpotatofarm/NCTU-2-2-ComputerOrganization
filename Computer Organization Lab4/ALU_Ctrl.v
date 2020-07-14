/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[3:0]	instr,
	input		[1:0]	ALUOp,
	output wire	[3:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
assign ALU_Ctrl_o=(ALUOp==2'b00)? //rtype
							(instr==4'b0000)?4'b0000:
							(instr==4'b1000)?4'b0001:
							(instr[2:0]==3'b111)?4'b0010:
							(instr[2:0]==3'b110)?4'b0011:
							(instr[2:0]==3'b100)?4'b0100:
							(instr[2:0]==3'b010)?4'b0101:
							(instr[2:0]==3'b001)?4'b0110:
							4'b0111
						:(ALUOp==2'b01)?//elif itype
							(instr[2:0]==3'b000)?4'b0000:
							(instr[2:0]==3'b010)?4'b0101:
							(instr[2:0]==3'b001)?4'b0110:
							(instr[2:0]==3'b101)?4'b1011:
							(instr[2:0]==3'b111)?4'b0010:
							(instr[2:0]==3'b110)?4'b0011:
							4'b0100 //xori
						:(ALUOp==2'b10)?
							(instr[2:0]==3'b000)?4'b1110:
							(instr[2:0]==3'b001)?4'b1111: //bne
							(instr[2:0]==3'b100)?4'b1000://blt
							1001//bge
						:(ALUOp==2'b11)?
						4'b0000:0;
 
endmodule