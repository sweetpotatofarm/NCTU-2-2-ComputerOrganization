/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)	
	);
wire   [32-1:0] carryOut; 	// for carry out through 1 bit ALU
wire   [32-1:0] resultTmp; 	// temporary store for result
wire			less; 	 	// check if slt is set



reg [3:0]fuck0;
reg [31:0]fuck1;
reg [31:0]fuck2;
reg [31:0]fuck3;
reg fuck4;

always@(*)begin
	fuck0 = ALU_control;
	fuck1 = src1;
	fuck2 = src2;
	fuck3 = result;
	fuck4 = zero;
	$display("%d, %d, %d",fuck0,fuck1,fuck2);
	$display("%d, %d",fuck3,fuck4);
end

always@(*)

begin
	
	if(rst_n)
	begin
		
		case(ALU_control)
			4'b0000:
			begin
				result=src1+src2;
			end
			4'b0001:
			begin
				result=src1-src2;
			end
			4'b0010:
			begin
				result=src1&src2;
			end
			4'b0011:
			begin
				result=src1|src2;
			end
			4'b0100:
			begin
				result=src1^src2;
			end
			4'b0101:
			begin
				if(src1<src2)
					result=1;
				else
					result=0;
			end
			4'b0110:
			begin
				result=src1<<src2;
			end
			4'b0111:
			begin
				result=src1>>>src2;
			end
			4'b1110:
			begin
				if(src1==src2)
					zero=1;
				else
					zero=0;
			end
			4'b1111:
			begin
				if(src1==src2)
					zero=0;
				else
					zero=1;
			end
			4'b1011:
			begin
				result=src1>>src2;
			end
		endcase
	end
	else
		begin
		result=0;
		zero=0;
		cout=0;
		overflow=0;
		end
end
endmodule
