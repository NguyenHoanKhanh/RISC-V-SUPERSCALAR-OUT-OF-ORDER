`ifndef DECODER_STAGE_V
`define DECODER_STAGE_V
`include "./source/decoder.v"

module decoder_stage (
    ds_i_clk, ds_i_rst, ds_i_ce, ds_i_instr, ds_o_addr_rd, ds_o_addr_rt, ds_o_addr_rs, ds_o_opcode, ds_o_funct3, ds_o_funct7,
    ds_o_jal_addr, ds_o_jal, ds_o_jr, ds_o_branch, ds_o_reg_dst, ds_o_alu_src, ds_o_memwrite, ds_o_memtoreg, 
    ds_o_imm, ds_o_ce, ds_o_reg_write
);
    input ds_i_ce;
    input ds_i_clk, ds_i_rst;
    input [`IWIDTH - 1 : 0] ds_i_instr;
    output ds_o_ce;
    output ds_o_jr;
    output ds_o_jal;
    output ds_o_branch;
    output ds_o_alu_src;
    output ds_o_reg_dst;
    output ds_o_memtoreg;
    output ds_o_memwrite;
    output ds_o_reg_write;
    output [`IMM_WIDTH - 1 : 0] ds_o_imm;
    output [`FUNCT3_WIDTH - 1 : 0] ds_o_funct3;
    output [`FUNCT7_WIDTH - 1 : 0] ds_o_funct7;
    output [`OPCODE_WIDTH - 1 : 0] ds_o_opcode;
    output [`JUMP_WIDTH - 1 : 0] ds_o_jal_addr;
    output [`AWIDTH - 1 : 0] ds_o_addr_rd, ds_o_addr_rs, ds_o_addr_rt;

    decoder d (
        .d_i_ce(ds_i_ce), 
        .d_i_instr(ds_i_instr), 
        .d_o_ce(ds_o_ce), 
        .d_o_jr(ds_o_jr), 
        .d_o_imm(ds_o_imm), 
        .d_o_jal(ds_o_jal), 
        .d_o_funct3(ds_o_funct3),
        .d_o_funct7(ds_o_funct7),
        .d_o_opcode(ds_o_opcode), 
        .d_o_branch(ds_o_branch), 
        .d_o_addr_rs(ds_o_addr_rs), 
        .d_o_addr_rt(ds_o_addr_rt),
        .d_o_addr_rd(ds_o_addr_rd), 
        .d_o_alu_src(ds_o_alu_src), 
        .d_o_reg_dst(ds_o_reg_dst),
        .d_o_reg_wr(ds_o_reg_write), 
        .d_o_memwrite(ds_o_memwrite), 
        .d_o_memtoreg(ds_o_memtoreg), 
        .d_o_jal_addr(ds_o_jal_addr)
    );
endmodule
`endif 
