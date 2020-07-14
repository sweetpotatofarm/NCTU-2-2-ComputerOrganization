`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:53 06/08/2020 
// Design Name: 
// Module Name:    ForwardingUnit 
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
module ForwardingUnit(
	input [4:0] Rs1,
	input [4:0] Rs2,
	input [4:0] EXMEM_Rd,
	input [4:0] MEMWB_Rd,
	input EXMEM_regWrite,
	input MEMWB_regWrite,
	output [1:0] Rs1Ctrl,
	output [1:0] Rs2Ctrl
    );
assign Rs1Ctrl = (Rs1==EXMEM_Rd && EXMEM_regWrite==1 && Rs1!=0)? 2'b10:
						(Rs1==MEMWB_Rd && MEMWB_regWrite==1 && Rs1!=0)?2'b01:
						0;

assign Rs2Ctrl = (Rs2==EXMEM_Rd && EXMEM_regWrite==1 && Rs2!=0)? 2'b10:
						(Rs2==MEMWB_Rd && MEMWB_regWrite==1 && Rs2!=0)?2'b01:
						0;

endmodule
