/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire Branch;
wire [1:0] ALUOp;

wire [31:0] pc_add4;
wire [31:0] pc_addsum;
wire [31:0] immout;
wire [31:0] ALUsrcout;
wire [4-1:0] ALUcontrolout;
wire zero;
wire PCSrc;
assign PCSrc = Branch & zero;
wire [31:0]slout;
wire [3:0] insalu;
assign insalu[3]=instr[30];
assign insalu[2:0]=instr[14:12];
assign PCSrc=zero&Branch;
wire cout;
wire overflow;

reg [32-1:0] fuck;
reg [32-1:0] fuck3;


always@(*)begin
//	fuck = pc_o;
//	fuck3 = instr;
//	$display("pc: %h",fuck);
//	$display("instr: %h",fuck3);

end


ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
	    .RegWrite(RegWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp)      
	    );	

Adder Adder1(
        .src1_i(pc_o),     
	    .src2_i(4),     
	    .sum_o(pc_add4)    
	    );
		
Imm_Gen ImmGen(
		.instr_i(instr),
		.Imm_Gen_o(immout)
		);
	
Shift_Left_1 SL1(
		.data_i(immout),
		.data_o(slout)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(immout),
		.select_i(ALUSrc),
		.data_o(ALUsrcout)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(insalu),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALUcontrolout)
		);
		
Adder Adder2(
        .src1_i(pc_o),     
	    .src2_i(slout),     
	    .sum_o(pc_addsum)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(ALUsrcout),
		.ALU_control(ALUcontrolout),
		.zero(zero),
		.result(ALUresult),
		.cout(cout),
		.overflow(overflow)
		);
	
MUX_2to1 Mux_PCSrc(
		.data0_i(pc_add4),       
		.data1_i(pc_addsum),
		.select_i(PCSrc),
		.data_o(pc_i)
		);
		
endmodule
		  


