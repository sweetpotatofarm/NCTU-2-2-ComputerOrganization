/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
wire [7-1:0] opcode;
assign opcode=instr_i[7-1:0];
wire [32-1:0] rtype;
wire [32-1:0] itype;
wire [32-1:0] btype;
wire [32-1:0] stype;
wire [32-1:0] jtype;
wire [2:0]type;

//itype=0 btype=1 stype=2 jtype=3
assign type=(opcode==7'b0010011)?0:
				(opcode==7'b0000011)?0:
				(opcode==7'b1100111)?0:
				(opcode==7'b1100011)?1:
				(opcode==7'b0100011)?2:
				3;
assign itype[12-1:0]=instr_i[31:20];
assign itype[31:12]={20{instr_i[31]}};

assign btype[11]=instr_i[31];
assign btype[10]=instr_i[7];
assign btype[9:4]=instr_i[30:25];
assign btype[3:0]=instr_i[11:8];
assign btype[31:12]={20{instr_i[31]}};

assign stype[11:5]=instr_i[31:25];
assign stype[4:0]=instr_i[11:7];
assign stype[31:12]={20{instr_i[31]}};

assign jtype[9:0]=instr_i[30:21];
assign jtype[10]=instr_i[20];
assign jtype[18:11]=instr_i[19:12];
assign jtype[19]=instr_i[31];
assign jtype[31:20]={12{instr_i[31]}};

assign Imm_Gen_o=(type==0)?itype:
					  (type==1)?btype:
					  (type==2)?stype:
					  jtype;

endmodule