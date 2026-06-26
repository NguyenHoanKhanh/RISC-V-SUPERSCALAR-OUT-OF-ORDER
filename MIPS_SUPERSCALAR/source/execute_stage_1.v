`ifndef EXECUTE_STAGE_1_V
`define EXECUTE_STAGE_V
`include "./source/alu_1.v"
`include "./source/header.vh"
`include "./source/alu_control.v"
`include "./source/treat_jal.v"

module execute_stage (
    es_i_ce, es_i_fetch_queue, es_i_jr, es_i_jal, es_i_jal_addr, es_i_pc, es_i_alu_src, es_i_imm, es_i_alu_op, es_i_funct3, es_i_funct7,
    es_i_data_rs, es_i_data_rt, es_o_alu_value, es_o_ce, es_o_change_pc, es_o_alu_pc, es_o_opcode, es_o_fetch_queue, es_o_busy
);  
    input es_i_ce;
    input es_i_jr;
    input es_i_jal;
    input es_i_alu_src;
    input es_i_fetch_queue;
    input [`PC_WIDTH - 1 : 0] es_i_pc;
    input [`IMM_WIDTH - 1 : 0] es_i_imm;
    input [`JUMP_WIDTH - 1 : 0] es_i_jal_addr;
    input [`OPCODE_WIDTH - 1 : 0] es_i_alu_op;
    input [`FUNCT3_WIDTH - 1 : 0]  es_i_funct3;
    input [`FUNCT7_WIDTH - 1 : 0]  es_i_funct7;
    input [`DWIDTH - 1 : 0] es_i_data_rs, es_i_data_rt;
    output es_o_busy;
    output reg es_o_ce;
    output es_o_change_pc;
    output es_o_fetch_queue;
    output [`PC_WIDTH - 1 : 0] es_o_alu_pc;
    output reg [`DWIDTH - 1 : 0] es_o_alu_value;
    output reg [`OPCODE_WIDTH - 1 : 0] es_o_opcode;

    // alu_control computed combinationally from opcode/funct
    wire [4 : 0] alu_control;
    alucontrol ac (
        .ac_i_opcode(es_i_alu_op), 
        .ac_i_funct3(es_i_funct3),
        .ac_i_funct7(es_i_funct7),
        .ac_o_control(alu_control)
    );

    // instantiate combinational ALU
    wire done;
    wire change_pc;
    wire check_queue;
    wire [`PC_WIDTH - 1 : 0] alu_pc;
    wire [`DWIDTH - 1 : 0] alu_value;
    alu_1 a (
        .a_i_pc(es_i_pc), 
        .a_i_imm(es_i_imm), 
        .a_i_funct(alu_control), 
        .a_i_data_rs(es_i_data_rs), 
        .a_i_data_rt(es_i_data_rt), 
        .a_i_alu_src(es_i_alu_src), 
        .done(done),
        .alu_pc(alu_pc), 
        .alu_value(alu_value), 
        .a_o_change_pc(change_pc),
        .a_o_check_queue(check_queue)
    );

    wire [`PC_WIDTH - 1 : 0] temp_pc;
    wire [`PC_WIDTH - 1 : 0] temp_ra;
    wire temp_jal_change_pc;
    treat_jal tj (
        .tj_i_pc(es_i_pc), 
        .tj_i_jal(es_i_jal), 
        .tj_i_jal_addr(es_i_jal_addr), 
        .tj_o_ra(temp_ra),
        .tj_o_pc(temp_pc), 
        .tj_o_change_pc(temp_jal_change_pc)
    );

    wire take_jr = es_i_jr;
    wire take_jal = es_i_jal;
    assign es_o_busy = (done && es_i_ce) ? 1'b1 : 1'b0;
    assign es_o_fetch_queue = (es_i_ce && es_i_fetch_queue) ? check_queue : 1'b0;
    assign es_o_change_pc = (take_jal & temp_jal_change_pc) 
                            || (take_jr && change_pc);
    assign es_o_alu_pc = (take_jr && change_pc) ? alu_pc 
                        : (take_jal && temp_jal_change_pc) ? temp_pc : {`PC_WIDTH{1'b0}};
    wire [`DWIDTH - 1 : 0] temp_alu_value;
    assign temp_alu_value = (take_jal) ? temp_ra : alu_value;
    // register outputs on clock
    always @(*) begin
        es_o_ce = 1'b0 ;
        es_o_alu_value = {`DWIDTH{1'b0}};
        es_o_opcode = {`OPCODE_WIDTH{1'b0}};
        if (es_i_ce) begin
            es_o_ce = 1'b1;
            es_o_opcode = es_i_alu_op;
            es_o_alu_value = temp_alu_value;
        end
        else begin
            es_o_ce = 1'b0;
            es_o_alu_value = {`DWIDTH{1'b0}};
            es_o_opcode = {`OPCODE_WIDTH{1'b0}};
        end
    end
endmodule
`endif
