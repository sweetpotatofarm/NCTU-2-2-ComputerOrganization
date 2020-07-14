/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	output	[4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
//reg [3:0]test;
//always@(*)
//begin
//	test=instr;
//	$display("%d", test);
//end
/*
if(ALUOp==2'b00)
	begin
		if(instr[2:0]==3'b000)
			begin
				if(instr[3]==1'b0)
					assign ALU_Ctrl_o = 4'b0000;
				else
					assign ALU_Ctrl_o = 4'b0001;
			end
		if(instr[2:0]==3'b111)
			assign ALU_Ctrl_o = 4'b0010;
		if(instr[2:0]==3'b110)
			assign ALU_Ctrl_o = 4'b0011;
		if(instr[2:0]==3'b100)
			assign ALU_Ctrl_o = 4'b0100;
		if(instr[2:0]==3'b010)
			assign ALU_Ctrl_o = 4'b0101;
		if(instr[2:0]==3'b001)
			assign ALU_Ctrl_o = 4'b0110;
		if(instr[2:0]==3'b101)
			assign ALU_Ctrl_o = 4'b0111;
	end

if(ALUOp==2'b01)
	begin
		if(instr[2:0]==3'b000)
			assign ALU_Ctrl_o = 4'b1000;
		if(instr[2:0]==3'b010)
			assign ALU_Ctrl_o = 4'b1001;
		if(instr[2:0]==3'b001)
			assign ALU_Ctrl_o = 4'b1010;
		if(instr[2:0]==3'b101)
			assign ALU_Ctrl_o = 4'b1011;
		if(instr[2:0]==3'b111)
			assign ALU_Ctrl_o = 4'b1100;
		if(instr[2:0]==3'b110)
			assign ALU_Ctrl_o = 4'b1101;
	end

if(ALUOp==3'b11)
	begin
		if(instr[2:0]==3'b000)
			assign ALU_Ctrl_o = 4'b1110;
		if(instr[2:0]==3'b001)
			assign ALU_Ctrl_o = 4'b1111;
	end
	*/
assign ALU_Ctrl_o=(ALUOp==2'b10)? //rtype
							(instr==4'b0000)?4'b0000:
							(instr==4'b1000)?4'b0001:
							(instr[2:0]==3'b111)?4'b0010:
							(instr[2:0]==3'b110)?4'b0011:
							(instr[2:0]==3'b100)?4'b0100:
							(instr[2:0]==3'b010)?4'b0101:
							(instr[2:0]==3'b001)?4'b0110:
								4'b0111
						:(ALUOp==2'b11)?//elif itype
							(instr[2:0]==3'b000)?4'b0000:
							(instr[2:0]==3'b010)?4'b0101:
							(instr[2:0]==3'b001)?4'b0110:
							(instr[2:0]==3'b101)?4'b1011:
							(instr[2:0]==3'b111)?4'b0010:
								4'b0011
						:(instr[2:0]==3'b000)?4'b1110:
								4'b1111;

endmodule