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
wire [1:0]type;
// I type
assign type=(opcode==7'b0010011)?2'b01:2'b10;


assign itype[12-1:0]=instr_i[31:20];
//genvar i;
//for (i=12;i<=31;i=i+1)
//	begin
//		assign itype[i]=itype[11];
//	end
assign itype[31:12]={20{instr_i[31]}};
//reg [31:0]test;
//
//always@(*)
//begin
//test=itype

//end

//B type
assign btype[11]=instr_i[31];
assign btype[10]=instr_i[7];
assign btype[9:4]=instr_i[30:25];
assign btype[3:0]=instr_i[11:8];


assign btype[31:12]={20{instr_i[31]}};
	
assign Imm_Gen_o=(type==2'b01)?itype:btype;
				
//$display("t: %d",instr_i);
endmodule