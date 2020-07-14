`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:01 06/08/2020 
// Design Name: 
// Module Name:    IDMUX 
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
module IDMUX(
	input [31:0] ID_RS,
	input [31:0] ID_RT,
	input [31:0] WB_data,
	input [4:0] Rs1,
	input [4:0] Rs2,
	input [4:0] MEM_Rd,
	input MEM_regWrite,
	output [31:0] IDMUX_RS,
	output [31:0] IDMUX_RT
    );

assign IDMUX_RS=(Rs1==MEM_Rd && MEM_regWrite==1)?WB_data:
			ID_RS;
			
assign IDMUX_RT=(Rs2==MEM_Rd && MEM_regWrite==1)?WB_data:
			ID_RT;



endmodule
