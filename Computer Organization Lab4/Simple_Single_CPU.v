/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

wire [31:0] pc_o;
wire [31:0] instr;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] ALUresult;
wire MemRead,MemWrite;
wire [31:0] DM_o;



wire ALUSrc;
wire Branch;

wire [1:0] ALUOp;
wire MemtoReg;

wire [31:0] pc_i;
wire [1:0] Jump;
wire [31:0] pc_add4;
wire [31:0] pc_addsum;
wire [31:0] imm_o;
wire [31:0] sl_o;
wire [31:0] ALUsrc_o;
wire [3:0] ins_alu;
assign ins_alu[3]=instr[30];
assign ins_alu[2:0]=instr[14:12];
wire zero;
wire cout;
wire overflow;
wire [4-1:0] ALU_Ctr_o;
wire PCSrc;
assign PCSrc = Branch & zero;
wire [31:0] final_o;
wire [31:0] jump_o;
wire [31:0] PCSrc_o;
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
        .RDdata_i(jump_o)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );		

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUresult),
		.data_i(RTdata_o),
		.MemRead_i(MemRead),
		.MemWrite_i(MemWrite),
		.data_o(DM_o)
		);
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
	    .RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp),
		.Jump(Jump)
	    );
		
Adder Adder1(
        .src1_i(pc_o),     
	    .src2_i(4),     
	    .sum_o(pc_add4)    
	    );
		
Imm_Gen ImmGen(
		.instr_i(instr),
		.Imm_Gen_o(imm_o)
		);
	
Shift_Left_1 SL1(
		.data_i(imm_o),
		.data_o(sl_o)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(imm_o),
		.select_i(ALUSrc),
		.data_o(ALUsrc_o)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(ins_alu),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALU_Ctr_o)
		);
		
Adder Adder2(
        .src1_i(pc_o),     
	    .src2_i(sl_o),     
	    .sum_o(pc_addsum)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(ALUsrc_o),
		.ALU_control(ALU_Ctr_o),
		.zero(zero),
		.result(ALUresult),
		.cout(cout),
		.overflow(overflow)
		);
	
MUX_2to1 Mux_PCSrc(
		.data0_i(pc_add4),       
		.data1_i(pc_addsum),
		.select_i(PCSrc),
		.data_o(PCSrc_o)
		);
		
MUX_2to1 Mux_MemtoReg(
		.data0_i(ALUresult),       
		.data1_i(DM_o),
		.select_i(MemtoReg),
		.data_o(final_o)
		);
		
MUX_3to1 Jump_mux(
		.data0_i(final_o),
		.data1_i(pc_add4),
		.data2_i(0),
		.select_i(Jump),
		.data_o(jump_o)
);

MUX_3to1 PC_mux(
		.data0_i(PCSrc_o),
		.data1_i(sl_o),
		.data2_i(RSdata_o),
		.select_i(Jump),
		.data_o(pc_i)
);
endmodule
		  


