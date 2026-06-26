`timescale 1ns/1ps
`include "./src/alu_mul_div.v"
`include "./src/alu_control.v"
`include "./src/treat_jal.v"

module execute_stage (
    es_i_clk, es_i_rst, es_i_ce, es_i_jal, es_i_alu_src, es_i_opcode,
    es_i_funct3, es_i_funct7, es_i_shamt, es_i_data_rs, es_i_data_rt, es_i_imm, es_i_pc,
    es_i_rob_idx, es_i_sq_idx, es_i_tag, es_i_memwrite, es_i_memtoreg, es_i_regwrite,
    es_o_change_pc, es_o_alu_pc, es_o_alu_value, es_o_ce, es_o_done,
    es_o_opcode, es_o_rob_idx, es_o_sq_idx, es_o_tag, es_o_memwrite, es_o_memtoreg, es_o_regwrite, es_o_funct3,
    es_o_ready
);

    input es_i_clk;
    input es_i_rst;
    input es_i_ce;
    input es_i_jal;
    input es_i_alu_src;
    input [`OPCODE_WIDTH - 1 : 0] es_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] es_i_funct3;
    input [`FUNCT7_WIDTH - 1 : 0] es_i_funct7;
    input [`SHAMT_WIDTH - 1 : 0] es_i_shamt;
    input [`IMM_WIDTH - 1 : 0] es_i_imm;
    input [`DWIDTH - 1 : 0] es_i_data_rs, es_i_data_rt;
    input [`PC_WIDTH - 1 : 0] es_i_pc;
    input [`ROB_IDX_W - 1 : 0] es_i_rob_idx;
    input [`ROB_IDX_W - 1 : 0] es_i_sq_idx;
    input [`RAT_SIZE - 1 : 0] es_i_tag;
    input es_i_memwrite;
    input es_i_memtoreg;
    input es_i_regwrite;

    output es_o_done;
    output es_o_change_pc;
    output [`PC_WIDTH - 1 : 0] es_o_alu_pc;
    output reg [`DWIDTH - 1 : 0] es_o_alu_value;
    output reg [`OPCODE_WIDTH - 1 : 0] es_o_opcode;
    output reg [`ROB_IDX_W - 1 : 0] es_o_rob_idx;
    output reg [`ROB_IDX_W - 1 : 0] es_o_sq_idx;
    output reg [`RAT_SIZE - 1 : 0] es_o_tag;
    output reg es_o_memwrite;
    output reg es_o_memtoreg;
    output reg es_o_regwrite;
    output reg [`FUNCT3_WIDTH - 1 : 0] es_o_funct3;
    output reg es_o_ce;
    output es_o_ready;

    // ============================================================
    // Decode ALU / MUL
    // ============================================================
    wire is_mul_op;
    wire is_div_op;
    wire [`ALU_CONTROL - 1 : 0] es_o_control;

    alu_control ac (
        .ac_i_opcode(es_i_opcode),
        .ac_i_funct3(es_i_funct3),
        .ac_i_funct7(es_i_funct7),
        .ac_o_control(es_o_control),
        .ac_o_is_mul(is_mul_op),
        .ac_o_is_div(is_div_op)
    );

    // ============================================================
    // Normal ALU
    // ============================================================
    wire done;
    wire [`DWIDTH - 1 : 0] alu_value;
    wire [`DWIDTH - 1 : 0] alu_data_rs;

    assign alu_data_rs = (es_i_opcode == `AUIPC) ? es_i_pc : es_i_data_rs;

    alu a (
        .a_i_pc(es_i_pc),
        .a_i_imm(es_i_imm),
        .a_i_control(es_o_control),
        .a_i_data_rs(alu_data_rs),
        .a_i_data_rt(es_i_data_rt),
        .a_i_alu_src(es_i_alu_src),
        .a_i_shamt(es_i_shamt),
        .a_i_funct3(es_i_funct3),
        .a_i_mul(is_mul_op),
        .a_i_div(is_div_op),
        .done(done),
        .alu_value(alu_value)
    );

    // ============================================================
    // JAL
    // ============================================================
    wire temp_jal_change_pc;
    wire [`PC_WIDTH - 1 : 0] tj_o_pc;
    wire [`PC_WIDTH - 1 : 0] tj_o_ra;

    treat_jal tj (
        .tj_i_pc(es_i_pc),
        .tj_i_jal(es_i_jal),
        .tj_i_imm(es_i_imm),
        .tj_o_pc(tj_o_pc),
        .tj_o_ra(tj_o_ra),
        .tj_o_change_pc(temp_jal_change_pc)
    );

    wire take_jal = es_i_jal;
    wire take_branch = (es_i_opcode == `BTYPE) && (alu_value == 32'd1);
    wire [`PC_WIDTH - 1 : 0] branch_target_pc = es_i_pc + es_i_imm;

    assign es_o_change_pc = (take_jal & temp_jal_change_pc) | take_branch;
    assign es_o_alu_pc =
        (take_jal && temp_jal_change_pc) ? tj_o_pc :
        take_branch ? branch_target_pc :
        {`PC_WIDTH{1'b0}};
    wire [`DWIDTH - 1 : 0] exec_alu_value =
        take_jal ? tj_o_ra : alu_value;

    assign es_o_ready = 1'b1;
    assign es_o_done  = es_i_ce & done;

    always @(*) begin
        es_o_ce = 1'b0;
        es_o_alu_value = {`DWIDTH{1'b0}};
        es_o_opcode   = {`OPCODE_WIDTH{1'b0}};
        es_o_rob_idx  = {`ROB_IDX_W{1'b0}};
        es_o_sq_idx   = {`ROB_IDX_W{1'b0}};
        es_o_tag      = {`RAT_SIZE{1'b0}};
        es_o_memwrite = 1'b0;
        es_o_memtoreg = 1'b0;
        es_o_regwrite = 1'b0;
        es_o_funct3   = {`FUNCT3_WIDTH{1'b0}};
        if (es_i_ce) begin
            es_o_ce = 1'b1;
            es_o_opcode   = es_i_opcode;
            es_o_rob_idx  = es_i_rob_idx;
            es_o_sq_idx   = es_i_sq_idx;
            es_o_tag      = es_i_tag;
            es_o_memwrite = es_i_memwrite;
            es_o_memtoreg = es_i_memtoreg;
            es_o_regwrite = es_i_regwrite;
            es_o_funct3   = es_i_funct3;
            es_o_alu_value = exec_alu_value;
        end
        else begin
            es_o_ce = 1'b0;
            es_o_alu_value = {`DWIDTH{1'b0}};
            es_o_opcode   = {`OPCODE_WIDTH{1'b0}};
            es_o_rob_idx  = {`ROB_IDX_W{1'b0}};
            es_o_sq_idx   = {`ROB_IDX_W{1'b0}};
            es_o_tag      = {`RAT_SIZE{1'b0}};
            es_o_memwrite = 1'b0;
            es_o_memtoreg = 1'b0;
            es_o_regwrite = 1'b0;
            es_o_funct3   = {`FUNCT3_WIDTH{1'b0}};
        end
    end
endmodule
