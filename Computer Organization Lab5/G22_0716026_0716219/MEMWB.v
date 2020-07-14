`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:58 06/04/2020 
// Design Name: 
// Module Name:    MEMWB 
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
module MEMWB(
	input clk_i,
	input rst_i,
	input RegWrite_i,
	input [31:0] MemData_i,
	input [31:0] ALU_result_i,
	input [4:0] RDdata_i,
	input MemtoReg_i,
	output reg RegWrite_o,
	output reg MemtoReg_o,
	output reg [31:0] MemData_o,
	output reg [31:0] ALU_result_o,
	output reg [4:0] RDdata_o
    );
always@(posedge clk_i)begin
	if (rst_i) begin
		RegWrite_o=RegWrite_i;
		MemtoReg_o=MemtoReg_i;
		MemData_o=MemData_i;
		ALU_result_o=ALU_result_i;
		RDdata_o=RDdata_i;
	end
	else begin
		RegWrite_o=0;
		MemtoReg_o=0;
		MemData_o=0;
		ALU_result_o=0;
		RDdata_o=0;
	end
end

endmodule
