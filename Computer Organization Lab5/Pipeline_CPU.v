/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps
module Pipeline_CPU(
	input clk_i,
	input rst_i
	);
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] pc_add4;
wire [31:0] pc_IF_o;
wire [31:0] instr_IF_o;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] imm_o;
wire [3:0] ins_alu;
assign ins_alu[3]=instr_IF_o[30];
assign ins_alu[2:0]=instr_IF_o[14:12];
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire MemtoReg;
wire [1:0] ALUOp;
wire ALUSrc;
wire [1:0] Jump;
wire RegWrite_ID_o;
wire MemRead_ID_o;
wire MemWrite_ID_o;
wire Branch_ID_o;
wire MemtoReg_ID_o;
wire ALUSrc_ID_o;
wire [1:0] ALUOp_ID_o;
wire RegWrite_EX_o;
wire MemRead_EX_o;
wire MemWrite_EX_o;
wire Branch_EX_o;
wire MemtoReg_EX_o;
wire RegWrite_MEM_o;
wire MemtoReg_MEM_o;
wire [31:0] ALUresult_MEM_o;
wire [31:0] pc_ID_o;
wire [31:0] RSdata_ID_o;
wire [31:0] RTdata_ID_o;
wire [31:0] RTdata_EX_o;
wire [31:0] imm_ID_o;
wire [3:0] alu_ctrl_ID_o;
wire [5-1:0] RDdata_ID_o;
wire [31:0] ALUresult;
wire [31:0] ALUresult_EX_o;
wire [31:0] sl_o;
wire [31:0] pc_addsum;
wire [31:0] ALUsrc_o;
wire [4-1:0] ALU_Ctrl_o;
wire [31:0] MemData_MEM_o;
wire [31:0] pc_addsum_EX_o;
wire [31:0] DM_o;
wire [4:0] RDdata_EX_o;
wire [5-1:0] RDdata_MEM_o;
wire zero;
wire zero_EX_o;
wire cout;
wire overflow;
wire PCSrc;
assign PCSrc = Branch_EX_o & zero_EX_o;
wire [31:0] final_o;
wire [31:0] PCSrc_o;
wire [4:0] Rs1_ID_o;
wire [4:0] Rs2_ID_o;
wire [1:0] Rs1Ctrl;
wire [1:0] Rs2Ctrl;
wire [31:0] Rs1_MUX_o;
wire [31:0] Rs2_MUX_o;
wire [31:0] IDMUX_RS;
wire [31:0] IDMUX_RT;

IDMUX ID1(
	.ID_RS(RSdata_o),
	.ID_RT(RTdata_o),
	.WB_data(final_o),
	.Rs1(instr_IF_o[19:15]),
	.Rs2(instr_IF_o[24:20]),
	.MEM_Rd(RDdata_MEM_o),
	.MEM_regWrite(RegWrite_MEM_o),
	.IDMUX_RS(IDMUX_RS),
	.IDMUX_RT(IDMUX_RT)
);


MUX_3to1 RS1MUX(
	.data0_i(RSdata_ID_o),       
	.data1_i(final_o),
	.data2_i(ALUresult_EX_o),
	.select_i(Rs1Ctrl),
	.data_o(Rs1_MUX_o)
	);


MUX_3to1 RS2MUX(
	.data0_i(RTdata_ID_o),       
	.data1_i(final_o),
	.data2_i(ALUresult_EX_o),
	.select_i(Rs2Ctrl),
	.data_o(Rs2_MUX_o)
	);

ForwardingUnit FU(
		.Rs1(Rs1_ID_o),
		.Rs2(Rs2_ID_o),
		.EXMEM_Rd(RDdata_EX_o),
		.MEMWB_Rd(RDdata_MEM_o),
		.EXMEM_regWrite(RegWrite_EX_o),
		.MEMWB_regWrite(RegWrite_MEM_o),
		.Rs1Ctrl(Rs1Ctrl),
		.Rs2Ctrl(Rs2Ctrl)
	);

ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(PCSrc_o) ,   
	    .pc_o(pc_o) 
	    );
		 
Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		 
IFID IFID(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.pc_i(pc_o),
	.instr_i(instr),
	.pc_o(pc_IF_o),
	.instr_o(instr_IF_o)
	);
	
IDEX IDEX(
	.Rs1_i(instr_IF_o[19:15]),
	.Rs2_i(instr_IF_o[24:20]),
	.clk_i(clk_i),
	.rst_i(rst_i),
	.pc_i(pc_IF_o),
	.MemtoReg_i(MemtoReg),
	.RSdata_i(IDMUX_RS),
	.RTdata_i(IDMUX_RT),
	.Imm_Gen_i(imm_o),
	.RDaddr_i(instr_IF_o[11:7]),
	.alu_ctrl_i(ins_alu),
	.ALUSrc_i(ALUSrc),
	.ALUOp_i(ALUOp),
	.Branch_i(Branch),
	.RegWrite_i(RegWrite),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.RegWrite_o(RegWrite_ID_o),
	.Branch_o(Branch_ID_o),
	.ALUOp_o(ALUOp_ID_o),
	.ALUSrc_o(ALUSrc_ID_o),
	.pc_o(pc_ID_o),
	.RSdata_o(RSdata_ID_o),
	.RTdata_o(RTdata_ID_o),
	.Imm_Gen_o(imm_ID_o),
	.alu_ctrl_o(alu_ctrl_ID_o),
	.RDdata_o(RDdata_ID_o),
	.MemRead_o(MemRead_ID_o),
	.MemWrite_o(MemWrite_ID_o),
	.MemtoReg_o(MemtoReg_ID_o),
	.Rs1_o(Rs1_ID_o),
	.Rs2_o(Rs2_ID_o)
	);
EXMEM EXMEM(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.RegWrite_i(RegWrite_ID_o),
	.MemtoReg_i(MemtoReg_ID_o),
	.Branch_i(Branch_ID_o),
	.PCadd_sum_i(pc_addsum),
	.ALU_zero_i(zero),
	.ALU_result_i(ALUresult),
	.RTdata_i(Rs2_MUX_o),
	.RDdata_i(RDdata_ID_o),
	.MemRead_i(MemRead_ID_o),
	.MemWrite_i(MemWrite_ID_o),
	.RegWrite_o(RegWrite_EX_o),
	.Branch_o(Branch_EX_o),
	.MemRead_o(MemRead_EX_o),
	.MemWrite_o(MemWrite_EX_o),
	.PCadd_sum_o(pc_addsum_EX_o),
	.ALU_zero_o(zero_EX_o),
	.ALU_result_o(ALUresult_EX_o),
	.RTdata_o(RTdata_EX_o),
	.RDdata_o(RDdata_EX_o),
	.MemtoReg_o(MemtoReg_EX_o)
	);
MEMWB MEMWB(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.RegWrite_i(RegWrite_EX_o),
	.MemData_i(DM_o),
	.ALU_result_i(ALUresult_EX_o),
	.RDdata_i(RDdata_EX_o),
	.MemtoReg_i(MemtoReg_EX_o),
	.RegWrite_o(RegWrite_MEM_o),
	.MemtoReg_o(MemtoReg_MEM_o),
	.MemData_o(MemData_MEM_o),
	.ALU_result_o(ALUresult_MEM_o),
	.RDdata_o(RDdata_MEM_o)
	);
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr_IF_o[19:15]) ,  
        .RTaddr_i(instr_IF_o[24:20]) ,  
        .RDaddr_i(RDdata_MEM_o) ,  
        .RDdata_i(final_o)  , 
        .RegWrite_i (RegWrite_MEM_o),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );		
Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUresult_EX_o),
		.data_i(RTdata_EX_o),
		.MemRead_i(MemRead_EX_o),
		.MemWrite_i(MemWrite_EX_o),
		.data_o(DM_o)
		);
Decoder Decoder(
        .instr_i(instr_IF_o), 
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
		.instr_i(instr_IF_o),
		.Imm_Gen_o(imm_o)
		);
Shift_Left_1 SL1(
		.data_i(imm_ID_o),
		.data_o(sl_o)
		);
MUX_2to1 Mux_ALUSrc(
		.data0_i(Rs2_MUX_o),       
		.data1_i(imm_ID_o),
		.select_i(ALUSrc_ID_o),
		.data_o(ALUsrc_o)
		);





ALU_Ctrl ALU_Ctrl(
		.instr(alu_ctrl_ID_o),
		.ALUOp(ALUOp_ID_o),
		.ALU_Ctrl_o(ALU_Ctrl_o)
		);
Adder Adder2(
        .src1_i(pc_ID_o),     
	    .src2_i(sl_o),     
	    .sum_o(pc_addsum)    
	    );
alu alu(
		.rst_n(rst_i),
		.src1(Rs1_MUX_o),
		.src2(ALUsrc_o),
		.ALU_control(ALU_Ctrl_o),
		.zero(zero),
		.result(ALUresult),
		.cout(cout),
		.overflow(overflow)
		);
MUX_2to1 Mux_PCSrc(
		.data0_i(pc_add4),       
		.data1_i(pc_addsum_EX_o),
		.select_i(PCSrc),
		.data_o(PCSrc_o)
		);
MUX_2to1 Mux_MemtoReg(
		.data0_i(ALUresult_MEM_o),       
		.data1_i(MemData_MEM_o),
		.select_i(MemtoReg_MEM_o),
		.data_o(final_o)
		);

endmodule