`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:05 06/04/2020 
// Design Name: 
// Module Name:    IFID 
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
module IFID(
	input clk_i,
	input rst_i,
	input [31:0] pc_i,
	input [31:0] instr_i,
	output reg [31:0] pc_o,
	output reg [31:0] instr_o
    );
always@(posedge clk_i)begin
	if (rst_i) begin
		pc_o=pc_i;
		instr_o=instr_i;
	end
	else begin
		pc_o=0;
		instr_o=0;
	end
end

endmodule
