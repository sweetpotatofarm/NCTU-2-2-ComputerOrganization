/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	input				less,
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */
reg newSrc1;
reg newSrc2;
always@(*)
begin
	newSrc1 = src1;
	if(Ainvert)
	   newSrc1 = ~src1;
  	newSrc2 = src2;  
	if(Binvert)
	   newSrc2 = ~src2;
	case(operation)
	   2'b00: result = (newSrc1 & newSrc2);
	   2'b01: result = (newSrc1 | newSrc2);
	   2'b10:{cout, result} = (newSrc1 + newSrc2 + Cin);
	   2'b11:
	   begin
	      result = less;
	      cout = (newSrc1 & newSrc2) | (newSrc1 & Cin) | (newSrc2 & Cin); 
	   end 
	endcase
end
endmodule
