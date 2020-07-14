`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:24 06/04/2020 
// Design Name: 
// Module Name:    IDEX 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IDEX(
	input [4:0] Rs1_i,
	input [4:0] Rs2_i,
	input clk_i,
	input rst_i,
	input [31:0] pc_i,
	input MemtoReg_i,
	input [31:0] RSdata_i,
	input [31:0] RTdata_i,
	input [31:0] Imm_Gen_i,
	input [4:0] RDaddr_i,
	input [3:0] alu_ctrl_i,
	input ALUSrc_i,
	input [1:0] ALUOp_i,
	input Branch_i,
	input RegWrite_i,
	input MemRead_i,
	input MemWrite_i,
	output reg RegWrite_o,
	output reg Branch_o,
	output reg [1:0] ALUOp_o,
	output reg ALUSrc_o,
	output reg [31:0] pc_o,
	output reg [31:0] RSdata_o,
	output reg [31:0] RTdata_o,
	output reg [31:0] Imm_Gen_o,
	output reg [3:0] alu_ctrl_o,
	output reg [4:0] RDdata_o,
	output reg MemRead_o,
	output reg MemWrite_o,
	output reg MemtoReg_o,
	output reg [4:0] Rs1_o,
	output reg [4:0] Rs2_o
    );
always@(posedge clk_i)begin
	if (rst_i) begin
		RegWrite_o=RegWrite_i;
		Branch_o=Branch_i;
		ALUOp_o=ALUOp_i;
		ALUSrc_o=ALUSrc_i;
		pc_o=pc_i;
		RSdata_o=RSdata_i;
		RTdata_o=RTdata_i;
		Imm_Gen_o=Imm_Gen_i;
		alu_ctrl_o=alu_ctrl_i;
		RDdata_o=RDaddr_i;
		MemRead_o=MemRead_i;
		MemWrite_o=MemWrite_i;
		MemtoReg_o=MemtoReg_i;
		Rs1_o=Rs1_i;
		Rs2_o=Rs2_i;
	end
	else begin
		RegWrite_o=0;
		Branch_o=0;
		ALUOp_o=0;
		ALUSrc_o=0;
		pc_o=0;
		RSdata_o=0;
		RTdata_o=0;
		Imm_Gen_o=0;
		alu_ctrl_o=0;
		RDdata_o=0;
		MemRead_o=0;
		MemWrite_o=0;
		MemtoReg_o=0;
		Rs1_o=0;
		Rs2_o=0;
	end
end

endmodule
