`timescale 1ns/1ps
`include "./src/execute_stage_1cycle.v"

module tb_execute_1cycle;
    reg es_i_clk;
    reg es_i_rst;
    reg es_i_ce;
    reg es_i_jal;
    reg es_i_alu_src;
    reg [`OPCODE_WIDTH - 1 : 0] es_i_opcode;
    reg [`FUNCT3_WIDTH - 1 : 0] es_i_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] es_i_funct7;
    reg [`SHAMT_WIDTH - 1 : 0] es_i_shamt;
    reg [`DWIDTH - 1 : 0] es_i_data_rs;
    reg [`DWIDTH - 1 : 0] es_i_data_rt;
    reg [`IMM_WIDTH - 1 : 0] es_i_imm;
    reg [`PC_WIDTH - 1 : 0] es_i_pc;
    reg [`ROB_IDX_W - 1 : 0] es_i_rob_idx;
    reg [`ROB_IDX_W - 1 : 0] es_i_sq_idx;
    reg [`RAT_SIZE - 1 : 0] es_i_tag;
    reg es_i_memwrite;
    reg es_i_memtoreg;
    reg es_i_regwrite;

    wire es_o_change_pc;
    wire [`PC_WIDTH - 1 : 0] es_o_alu_pc;
    wire [`DWIDTH - 1 : 0] es_o_alu_value;
    wire es_o_ce;
    wire es_o_done;
    wire [`OPCODE_WIDTH - 1 : 0] es_o_opcode;
    wire [`ROB_IDX_W - 1 : 0] es_o_rob_idx;
    wire [`ROB_IDX_W - 1 : 0] es_o_sq_idx;
    wire [`RAT_SIZE - 1 : 0] es_o_tag;
    wire es_o_memwrite;
    wire es_o_memtoreg;
    wire es_o_regwrite;
    wire [`FUNCT3_WIDTH - 1 : 0] es_o_funct3;
    wire es_o_ready;

    integer pass_count;
    integer fail_count;

    execute_stage dut (
        .es_i_clk(es_i_clk),
        .es_i_rst(es_i_rst),
        .es_i_ce(es_i_ce),
        .es_i_jal(es_i_jal),
        .es_i_alu_src(es_i_alu_src),
        .es_i_opcode(es_i_opcode),
        .es_i_funct3(es_i_funct3),
        .es_i_funct7(es_i_funct7),
        .es_i_shamt(es_i_shamt),
        .es_i_data_rs(es_i_data_rs),
        .es_i_data_rt(es_i_data_rt),
        .es_i_imm(es_i_imm),
        .es_i_pc(es_i_pc),
        .es_i_rob_idx(es_i_rob_idx),
        .es_i_sq_idx(es_i_sq_idx),
        .es_i_tag(es_i_tag),
        .es_i_memwrite(es_i_memwrite),
        .es_i_memtoreg(es_i_memtoreg),
        .es_i_regwrite(es_i_regwrite),
        .es_o_change_pc(es_o_change_pc),
        .es_o_alu_pc(es_o_alu_pc),
        .es_o_alu_value(es_o_alu_value),
        .es_o_ce(es_o_ce),
        .es_o_done(es_o_done),
        .es_o_opcode(es_o_opcode),
        .es_o_rob_idx(es_o_rob_idx),
        .es_o_sq_idx(es_o_sq_idx),
        .es_o_tag(es_o_tag),
        .es_o_memwrite(es_o_memwrite),
        .es_o_memtoreg(es_o_memtoreg),
        .es_o_regwrite(es_o_regwrite),
        .es_o_funct3(es_o_funct3),
        .es_o_ready(es_o_ready)
    );

    always #5 es_i_clk = ~es_i_clk;

    task clear_inputs;
        begin
            es_i_ce = 1'b0;
            es_i_jal = 1'b0;
            es_i_alu_src = 1'b0;
            es_i_opcode = {`OPCODE_WIDTH{1'b0}};
            es_i_funct3 = {`FUNCT3_WIDTH{1'b0}};
            es_i_funct7 = {`FUNCT7_WIDTH{1'b0}};
            es_i_shamt = {`SHAMT_WIDTH{1'b0}};
            es_i_data_rs = {`DWIDTH{1'b0}};
            es_i_data_rt = {`DWIDTH{1'b0}};
            es_i_imm = {`IMM_WIDTH{1'b0}};
            es_i_pc = {`PC_WIDTH{1'b0}};
            es_i_rob_idx = {`ROB_IDX_W{1'b0}};
            es_i_sq_idx = {`ROB_IDX_W{1'b0}};
            es_i_tag = {`RAT_SIZE{1'b0}};
            es_i_memwrite = 1'b0;
            es_i_memtoreg = 1'b0;
            es_i_regwrite = 1'b0;
        end
    endtask

    task apply_case;
        input [8*32 - 1 : 0] name;
        input [`OPCODE_WIDTH - 1 : 0] opcode;
        input [`FUNCT3_WIDTH - 1 : 0] funct3;
        input [`FUNCT7_WIDTH - 1 : 0] funct7;
        input alu_src;
        input jal;
        input [`DWIDTH - 1 : 0] rs_val;
        input [`DWIDTH - 1 : 0] rt_val;
        input [`IMM_WIDTH - 1 : 0] imm_val;
        input [`SHAMT_WIDTH - 1 : 0] shamt_val;
        input memwrite;
        input memtoreg;
        input regwrite;
        input [`DWIDTH - 1 : 0] expected_value;
        input expected_change_pc;
        input [`PC_WIDTH - 1 : 0] expected_pc;
        begin
            es_i_ce = 1'b1;
            es_i_jal = jal;
            es_i_alu_src = alu_src;
            es_i_opcode = opcode;
            es_i_funct3 = funct3;
            es_i_funct7 = funct7;
            es_i_shamt = shamt_val;
            es_i_data_rs = rs_val;
            es_i_data_rt = rt_val;
            es_i_imm = imm_val;
            es_i_pc = 32'h00000100;
            es_i_rob_idx = 6'd7;
            es_i_sq_idx = 6'd3;
            es_i_tag = 7'd21;
            es_i_memwrite = memwrite;
            es_i_memtoreg = memtoreg;
            es_i_regwrite = regwrite;
            #1;

            if (es_o_ce !== 1'b1 ||
                es_o_ready !== 1'b1 ||
                es_o_done !== 1'b1 ||
                es_o_alu_value !== expected_value ||
                es_o_change_pc !== expected_change_pc ||
                es_o_alu_pc !== expected_pc ||
                es_o_opcode !== opcode ||
                es_o_rob_idx !== 6'd7 ||
                es_o_sq_idx !== 6'd3 ||
                es_o_tag !== 7'd21 ||
                es_o_memwrite !== memwrite ||
                es_o_memtoreg !== memtoreg ||
                es_o_regwrite !== regwrite ||
                es_o_funct3 !== funct3) begin
                fail_count = fail_count + 1;
                $display("FAIL %-32s value=%h exp=%h done=%b change_pc=%b exp_change=%b pc=%h exp_pc=%h",
                         name, es_o_alu_value, expected_value, es_o_done,
                         es_o_change_pc, expected_change_pc, es_o_alu_pc, expected_pc);
            end
            else begin
                pass_count = pass_count + 1;
                $display("PASS %-32s value=%h", name, es_o_alu_value);
            end

            clear_inputs();
            #9;
        end
    endtask

    initial begin
        $dumpfile("sim/execute_1cycle.vcd");
        $dumpvars(0, tb_execute_1cycle);

        pass_count = 0;
        fail_count = 0;
        es_i_clk = 1'b0;
        es_i_rst = 1'b0;
        clear_inputs();

        #10;
        es_i_rst = 1'b1;

        apply_case("R ADD", `RTYPE, `ADD, `ZERO, 1'b0, 1'b0,
                   32'd11, 32'd22, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd33, 1'b0, 32'd0);

        apply_case("R SUB", `RTYPE, `ADD, `SUB, 1'b0, 1'b0,
                   32'd50, 32'd8, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd42, 1'b0, 32'd0);

        apply_case("R AND", `RTYPE, `AND, `ZERO, 1'b0, 1'b0,
                   32'hf0f0_00ff, 32'h0ff0_0f0f, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'h00f0_000f, 1'b0, 32'd0);

        apply_case("I ADDI", `ITYPE, `ADD, `ZERO, 1'b1, 1'b0,
                   32'd100, 32'd0, 32'd23, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd123, 1'b0, 32'd0);

        apply_case("I SRAI", `ITYPE, `SRL, `SRA, 1'b1, 1'b0,
                   32'hffff_ff80, 32'd0, 32'd0, 5'd4, 1'b0, 1'b0, 1'b1,
                   32'hffff_fff8, 1'b0, 32'd0);

        apply_case("LOAD address", `LOAD, `LW, `ZERO, 1'b1, 1'b0,
                   32'd64, 32'd0, 32'd12, 5'd0, 1'b0, 1'b1, 1'b1,
                   32'd76, 1'b0, 32'd0);

        apply_case("STORE address", `STORE, `SW, `ZERO, 1'b1, 1'b0,
                   32'd128, 32'd0, 32'd16, 5'd0, 1'b1, 1'b0, 1'b0,
                   32'd144, 1'b0, 32'd0);

        apply_case("BRANCH BEQ taken", `BTYPE, `BEQ, `ZERO, 1'b0, 1'b0,
                   32'd9, 32'd9, 32'd24, 5'd0, 1'b0, 1'b0, 1'b0,
                   32'd1, 1'b1, 32'h00000118);

        apply_case("M MUL", `RTYPE, `MUL, `MUL_7, 1'b0, 1'b0,
                   32'd7, 32'd6, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd42, 1'b0, 32'd0);

        apply_case("M MULH", `RTYPE, `MULH, `MUL_7, 1'b0, 1'b0,
                   32'h8000_0000, 32'd2, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'hffff_ffff, 1'b0, 32'd0);

        apply_case("M DIV", `RTYPE, `DIV, `MUL_7, 1'b0, 1'b0,
                   32'd100, 32'd7, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd14, 1'b0, 32'd0);

        apply_case("M REMU", `RTYPE, `REMU, `MUL_7, 1'b0, 1'b0,
                   32'd100, 32'd7, 32'd0, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd2, 1'b0, 32'd0);

        apply_case("JAL target", `JAL, `BEQ, `ZERO, 1'b0, 1'b1,
                   32'd0, 32'd1, 32'd32, 5'd0, 1'b0, 1'b0, 1'b1,
                   32'd0, 1'b1, 32'h00000120);

        clear_inputs();
        #10;

        $display("==========================================");
        $display("execute_stage_1cycle test summary: PASS=%0d FAIL=%0d", pass_count, fail_count);
        $display("==========================================");

        if (fail_count != 0) begin
            $finish;
        end
        $finish;
    end
endmodule
