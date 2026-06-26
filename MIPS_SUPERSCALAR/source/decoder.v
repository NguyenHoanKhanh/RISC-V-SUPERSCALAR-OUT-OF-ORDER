`ifndef DECODER_V
`define DECODER_V
`include "./source/header.vh"

module decoder (
    d_i_ce, d_i_instr, d_o_opcode, d_o_funct3, d_o_funct7, d_o_addr_rs, d_o_addr_rt,
    d_o_addr_rd, d_o_imm, d_o_ce, d_o_alu_src, d_o_reg_wr, d_o_memwrite, 
    d_o_memtoreg, d_o_jal, d_o_jal_addr, d_o_jr, d_o_branch, d_o_reg_dst
);
    input d_i_ce;
    input [`IWIDTH - 1 : 0] d_i_instr;
    output reg d_o_ce;
    output reg d_o_jr;
    output reg d_o_jal;
    output reg d_o_reg_wr;
    output reg d_o_branch;
    output reg d_o_alu_src;
    output reg d_o_reg_dst;
    output reg d_o_memtoreg;
    output reg d_o_memwrite;
    output reg [`IMM_WIDTH - 1 : 0] d_o_imm;
    output reg [`FUNCT3_WIDTH - 1 : 0] d_o_funct3;
    output reg [`FUNCT7_WIDTH - 1 : 0] d_o_funct7;
    output reg [`OPCODE_WIDTH - 1 : 0] d_o_opcode;
    output reg [`JUMP_WIDTH - 1 : 0] d_o_jal_addr;
    output reg [`AWIDTH - 1 : 0] d_o_addr_rs, d_o_addr_rt, d_o_addr_rd;

    wire [`OPCODE_WIDTH - 1 : 0] opcode = d_i_instr[6 : 0];
    wire [`AWIDTH - 1 : 0] rd = d_i_instr[11 : 7];
    wire [`FUNCT3_WIDTH - 1 : 0] funct3 = d_i_instr[14 : 12];
    wire [`AWIDTH - 1 : 0] rs1 = d_i_instr[19 : 15];
    wire [`AWIDTH - 1 : 0] rs2 = d_i_instr[24 : 20];
    wire [`FUNCT7_WIDTH - 1 : 0] funct7 = d_i_instr[31 : 25];
    wire [`IMM_WIDTH - 1 : 0] imm_i = {{20{d_i_instr[31]}}, d_i_instr[31 : 20]};
    wire [`IMM_WIDTH - 1 : 0] imm_s = {{20{d_i_instr[31]}}, d_i_instr[31 : 25], d_i_instr[11 : 7]};
    wire [`IMM_WIDTH - 1 : 0] imm_b = {{19{d_i_instr[31]}}, d_i_instr[31], d_i_instr[7], d_i_instr[30 : 25], d_i_instr[11 : 8], 1'b0};
    wire [`IMM_WIDTH - 1 : 0] imm_j = {{11{d_i_instr[31]}}, d_i_instr[31], d_i_instr[19 : 12], d_i_instr[20], d_i_instr[30 : 21], 1'b0};

    wire op_rtype = opcode == `RTYPE;
    wire op_itype = opcode == `ITYPE;
    wire op_load = opcode == `LOAD;
    wire op_store = opcode == `STORE;
    wire op_btype = opcode == `BTYPE;
    wire op_jal = opcode == `JAL;

    always @(*) begin
        d_o_ce = 1'b0;
        d_o_jr = 1'b0;
        d_o_jal = 1'b0;
        d_o_reg_wr = 1'b0;
        d_o_branch = 1'b0;
        d_o_alu_src = 1'b0;
        d_o_reg_dst = 1'b0;
        d_o_memwrite = 1'b0;
        d_o_memtoreg = 1'b0;
        d_o_imm = {`IMM_WIDTH{1'b0}};
        d_o_addr_rs = {`AWIDTH{1'b0}};
        d_o_addr_rt = {`AWIDTH{1'b0}};
        d_o_addr_rd = {`AWIDTH{1'b0}};
        d_o_funct3 = {`FUNCT3_WIDTH{1'b0}};
        d_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
        d_o_opcode = {`OPCODE_WIDTH{1'b0}};
        d_o_jal_addr = {`JUMP_WIDTH{1'b0}};

        if (d_i_ce) begin
            if (op_rtype) begin
                d_o_ce = 1'b1;
                d_o_addr_rs = rs1;
                d_o_addr_rt = rs2;
                d_o_addr_rd = rd;
                d_o_reg_wr = 1'b1;
                d_o_reg_dst = 1'b1;
                d_o_opcode = opcode;
                d_o_funct3 = funct3;
                d_o_funct7 = funct7;
            end
            else if (op_itype) begin
                d_o_ce = 1'b1;
                d_o_addr_rs = rs1;
                d_o_addr_rd = rd;
                d_o_reg_wr = 1'b1;
                d_o_reg_dst = 1'b1;
                d_o_alu_src = 1'b1;
                d_o_opcode = opcode;
                d_o_funct3 = funct3;
                d_o_funct7 = funct7;
                d_o_imm = imm_i;
            end
            else if (op_load) begin
                d_o_ce = 1'b1;
                d_o_addr_rs = rs1;
                d_o_addr_rd = rd;
                d_o_reg_wr = 1'b1;
                d_o_reg_dst = 1'b1;
                d_o_alu_src = 1'b1;
                d_o_memtoreg = 1'b1;
                d_o_opcode = opcode;
                d_o_funct3 = funct3;
                d_o_funct7 = funct7;
                d_o_imm = imm_i;
            end
            else if (op_store) begin
                d_o_ce = 1'b1;
                d_o_addr_rs = rs1;
                d_o_addr_rt = rs2;
                d_o_alu_src = 1'b1;
                d_o_memwrite = 1'b1;
                d_o_opcode = opcode;
                d_o_funct3 = funct3;
                d_o_funct7 = funct7;
                d_o_imm = imm_s;
            end
            else if (op_btype) begin
                d_o_ce = 1'b1;
                d_o_addr_rs = rs1;
                d_o_addr_rt = rs2;
                d_o_branch = 1'b1;
                d_o_opcode = {4'b0, funct3};
                d_o_funct3 = funct3;
                d_o_funct7 = funct7;
                d_o_imm = imm_b;
            end
            else if (op_jal) begin
                d_o_ce = 1'b1;
                d_o_jal = 1'b1;
                d_o_reg_wr = 1'b1;
                d_o_reg_dst = 1'b1;
                d_o_addr_rd = rd;
                d_o_opcode = opcode;
                d_o_funct3 = funct3;
                d_o_funct7 = funct7;
                d_o_imm = imm_j;
                d_o_jal_addr = imm_j;
            end
        end
    end
endmodule
`endif
