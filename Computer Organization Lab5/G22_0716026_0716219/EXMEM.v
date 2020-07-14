`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:40 06/04/2020 
// Design Name: 
// Module Name:    EXMEM 
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
module EXMEM(
	input clk_i,
	input rst_i,
	input RegWrite_i,
	input MemtoReg_i,
	input Branch_i,
	input [32-1:0]PCadd_sum_i,
	input ALU_zero_i,
	input [32-1:0] ALU_result_i,
	input [32-1:0] RTdata_i,
	input [5-1:0] RDdata_i,
	input MemRead_i,
	input MemWrite_i,
	output reg RegWrite_o,
	output reg Branch_o,
	output reg MemRead_o,
	output reg MemWrite_o,
	output reg [32-1:0]PCadd_sum_o,
	output reg ALU_zero_o,
	output reg [32-1:0] ALU_result_o,
	output reg [32-1:0] RTdata_o,
	output reg [5-1:0] RDdata_o,
	output reg MemtoReg_o
	);
    always@(clk_i)begin
		if (rst_i)begin
			RegWrite_o = RegWrite_i;
			MemtoReg_o = MemtoReg_i;
			Branch_o = Branch_i;
			PCadd_sum_o = PCadd_sum_i;
			ALU_zero_o = ALU_zero_i;
			ALU_result_o = ALU_result_i;
			RTdata_o = RTdata_i;
			RDdata_o = RDdata_i;
			MemRead_o = MemRead_i;
			MemWrite_o = MemWrite_i;
		end
		else begin
			RegWrite_o = 0;
			MemtoReg_o = 0;
			Branch_o = 0;
			PCadd_sum_o = 0;
			ALU_zero_o = 0;
			ALU_result_o = 0;
			RTdata_o = 0;
			RDdata_o = 0;
			MemRead_o = 0;
			MemWrite_o = 0;
		end
    end
endmodule
