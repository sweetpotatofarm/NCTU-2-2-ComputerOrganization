/***************************************************
Student Name: 
Student ID: 0716026
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	input          less,
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */
xor g1(temp1, src1, Ainvert);
xor g2(temp2, src2, Binvert);

always@(*)begin
	case(operation)
		2'b00:
			result = (temp1 & temp2);
		2'b01:
			result = (temp1 | temp2);
		2'b10:begin
			result = temp1^temp2^Cin;
			cout = ((temp1^temp2)&Cin)|(temp1&temp2);
		end
		2'b11:begin
			result = less;
			cout = ((temp1^temp2)&Cin)|(temp1&temp2);
		end
	endcase
end

endmodule
