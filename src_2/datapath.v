`timescale 1ns/1ps
`include "header_nomul.vh"
`include "program_counter.v"
`include "imem.v"
`include "decoder_stage.v"
`include "rename_unit.v"
`include "reservation_station.v"
`include "ROB.v"
`include "execute_stage.v"
`include "load_queue.v"
`include "store_queue.v"
`include "memory.v"
`include "treat_load.v"
`include "treat_store.v"
`include "ARF.v"
// Datapath mới cho kiến trúc My Design RType (2-wide OoO) theo kiểu "nối ảo".
// Mục tiêu của file này là dựng khung kết nối end-to-end để bổ sung logic dần.
// - Buffer3 (is3) separates RS issue selection from Execute timing.
module datapath (
    input dp_clk,
    input dp_rstn,
    input dp_i_ce,

    output [`PC_WIDTH - 1 : 0] dp_o_pc_1,
    output [`PC_WIDTH - 1 : 0] dp_o_pc_2,
    output [`DWIDTH - 1 : 0] dp_o_data_1,
    output [`DWIDTH - 1 : 0] dp_o_data_2,

    input [`AWIDTH - 1 : 0] dp_i_arf_display_addr_1,
    output [`DWIDTH - 1 : 0] dp_o_arf_display_data_1,
    input [`AWIDTH - 1 : 0] dp_i_arf_display_addr_2,
    output [`DWIDTH - 1 : 0] dp_o_arf_display_data_2
);
    integer prd_ready_i;

    // Front-end (PC/IMEM/B1) enable.
    // Important: back-end (ROB/RS/Execute/WB/Commit) must keep running even when
    // we stall fetch, otherwise the machine can deadlock.
    wire fe_ce;

    // -------------------------------------------------------------------------
    // Stage 1: IF/ID (2-wide)
    // -------------------------------------------------------------------------
    wire pc_o_ce;
    wire [`PC_WIDTH - 1 : 0] pc_o_pc_1;
    wire [`PC_WIDTH - 1 : 0] pc_o_pc_2;
	reg pc_im_o_ce;
	reg [`PC_WIDTH - 1 : 0] pc_im_o_pc_1;
	reg [`PC_WIDTH - 1 : 0] pc_im_o_pc_2;

    assign dp_o_pc_1 = pc_o_pc_1;
    assign dp_o_pc_2 = pc_o_pc_2;

    // TODO: recovery/flush path cho branch mispredict sẽ nối vào đây.
    reg es_pc_redirect_1;
    reg es_pc_redirect_2;
    reg [`PC_WIDTH - 1 : 0] es_pc_redirect_target_1;
    reg [`PC_WIDTH - 1 : 0] es_pc_redirect_target_2;
    wire es_pc_flush;
    assign es_pc_flush = es_pc_redirect_1 || es_pc_redirect_2;
    wire pc_ce;
    assign pc_ce = fe_ce || es_pc_flush; 

    program_counter u_pc (
        .pc_clk(dp_clk),
        .pc_rst(dp_rstn),
        .pc_i_ce(pc_ce),
        .pc_i_change_pc_1(es_pc_redirect_1),
        .pc_i_change_pc_2(es_pc_redirect_2),
        .pc_i_pc_1(es_pc_redirect_target_1),
        .pc_i_pc_2(es_pc_redirect_target_2),
        .pc_o_pc_1(pc_o_pc_1),
        .pc_o_pc_2(pc_o_pc_2),
        .pc_o_ce(pc_o_ce)
    );

	always @(posedge dp_clk, negedge dp_rstn) begin
        if (!dp_rstn) begin
            pc_im_o_ce <= 1'b0;
            pc_im_o_pc_1 <= {`PC_WIDTH{1'b0}};
            pc_im_o_pc_2 <= {`PC_WIDTH{1'b0}};
        end
        else begin
            if (fe_ce && ~es_pc_flush) begin
                pc_im_o_ce <= pc_o_ce;
				pc_im_o_pc_1 <= pc_o_pc_1;
				pc_im_o_pc_2 <= pc_o_pc_2;
            end
            else begin
                pc_im_o_ce <= 1'b0;
				pc_im_o_pc_1 <= pc_im_o_pc_1;
				pc_im_o_pc_2 <= pc_im_o_pc_2;
            end
        end
    end


    wire im_o_ce;
    wire [`IWIDTH - 1 : 0] im_o_instr_1;
    wire [`IWIDTH - 1 : 0] im_o_instr_2;

    // NOTE:
    // RS backpressure belongs to dispatch/rename (Buffer2 -> RS).
    // It must NOT directly stall IMEM per-lane while PC continues advancing,
    // otherwise instructions can be effectively skipped (PC changes but IMEM holds old data).
    // Front-end stalling is handled only by `fe_ce` (PC + IMEM enable).
    wire rs_o_can_alloc_1;
    wire rs_o_can_alloc_2;

    imem u_imem (
        .im_clk(dp_clk),
        .im_rst(dp_rstn),
        .im_i_ce(pc_im_o_ce),
        .im_i_addr_1(pc_im_o_pc_1),
        .im_i_addr_2(pc_im_o_pc_2),
        // Do not stall IMEM per-lane; stall the whole front-end via `fe_ce`.
        .im_i_stall_1(1'b0),
        .im_i_stall_2(1'b0),
        .im_o_ce(im_o_ce),
        .im_o_instr_1(im_o_instr_1),
        .im_o_instr_2(im_o_instr_2)
    );

    // Decode lane 1
    wire ds1_o_ce;
    wire ds1_o_jal;
    wire ds1_o_branch;
    wire ds1_o_regdst;
    wire ds1_o_alu_src;
    wire ds1_o_memwrite;
    wire ds1_o_memtoreg;
    wire ds1_o_regwrite;
    wire [`IMM_WIDTH - 1 : 0] ds1_o_imm;
    wire [`SHAMT_WIDTH - 1 : 0] ds1_o_shamt;
    wire [`OPCODE_WIDTH - 1 : 0] ds1_o_opcode;
    wire [`FUNCT3_WIDTH - 1 : 0] ds1_o_funct3;
    wire [`FUNCT7_WIDTH - 1 : 0] ds1_o_funct7;
    wire [`AWIDTH - 1 : 0] ds1_o_addr_rs;
    wire [`AWIDTH - 1 : 0] ds1_o_addr_rt;
    wire [`AWIDTH - 1 : 0] ds1_o_addr_rd;

    // Decode lane 1
    reg ds1_rs_o_ce;
    reg ds1_rs_o_jal;
    reg ds1_rs_o_branch;
    reg ds1_rs_o_regdst;
    reg ds1_rs_o_alu_src;
    reg ds1_rs_o_memwrite;
    reg ds1_rs_o_memtoreg;
    reg ds1_rs_o_regwrite;
    reg [`PC_WIDTH - 1 : 0] ds1_rs_o_pc;
    reg [`IMM_WIDTH - 1 : 0] ds1_rs_o_imm;
    reg [`SHAMT_WIDTH - 1 : 0] ds1_rs_o_shamt;
    reg [`OPCODE_WIDTH - 1 : 0] ds1_rs_o_opcode;
    reg [`FUNCT3_WIDTH - 1 : 0] ds1_rs_o_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] ds1_rs_o_funct7;
    reg [`AWIDTH - 1 : 0] ds1_rs_o_addr_rs;
    reg [`AWIDTH - 1 : 0] ds1_rs_o_addr_rt;
    reg [`AWIDTH - 1 : 0] ds1_rs_o_addr_rd;

    decoder_stage u_ds1 (
        .ds_i_ce(im_o_ce),
        .ds_i_instr(im_o_instr_1),
        .ds_o_opcode(ds1_o_opcode),
        .ds_o_funct3(ds1_o_funct3),
        .ds_o_funct7(ds1_o_funct7),
        .ds_o_shamt(ds1_o_shamt),
        .ds_o_imm(ds1_o_imm),
        .ds_o_alu_src(ds1_o_alu_src),
        .ds_o_branch(ds1_o_branch),
        .ds_o_regdst(ds1_o_regdst),
        .ds_o_memwrite(ds1_o_memwrite),
        .ds_o_memtoreg(ds1_o_memtoreg),
        .ds_o_regwrite(ds1_o_regwrite),
        .ds_o_addr_rs(ds1_o_addr_rs),
        .ds_o_addr_rt(ds1_o_addr_rt),
        .ds_o_addr_rd(ds1_o_addr_rd),
        .ds_o_ce(ds1_o_ce),
        .ds_o_jal(ds1_o_jal)
    );

    // Decode lane 2
    wire ds2_o_ce;
    wire ds2_o_jal;
    wire ds2_o_branch;
    wire ds2_o_regdst;
    wire ds2_o_alu_src;
    wire ds2_o_memwrite;
    wire ds2_o_memtoreg;
    wire ds2_o_regwrite;
    wire [`IMM_WIDTH - 1 : 0] ds2_o_imm;
    wire [`SHAMT_WIDTH - 1 : 0] ds2_o_shamt;
    wire [`OPCODE_WIDTH - 1 : 0] ds2_o_opcode;
    wire [`FUNCT3_WIDTH - 1 : 0] ds2_o_funct3;
    wire [`FUNCT7_WIDTH - 1 : 0] ds2_o_funct7;
    wire [`AWIDTH - 1 : 0] ds2_o_addr_rs;
    wire [`AWIDTH - 1 : 0] ds2_o_addr_rt;
    wire [`AWIDTH - 1 : 0] ds2_o_addr_rd;

    // Decode lane 2
    reg ds2_rs_o_ce;
    reg ds2_rs_o_jal;
    reg ds2_rs_o_branch;
    reg ds2_rs_o_regdst;
    reg ds2_rs_o_alu_src;
    reg ds2_rs_o_memwrite;
    reg ds2_rs_o_memtoreg;
    reg ds2_rs_o_regwrite;
    reg [`PC_WIDTH - 1 : 0] ds2_rs_o_pc;
    reg [`IMM_WIDTH - 1 : 0] ds2_rs_o_imm;
    reg [`SHAMT_WIDTH - 1 : 0] ds2_rs_o_shamt;
    reg [`OPCODE_WIDTH - 1 : 0] ds2_rs_o_opcode;
    reg [`FUNCT3_WIDTH - 1 : 0] ds2_rs_o_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] ds2_rs_o_funct7;
    reg [`AWIDTH - 1 : 0] ds2_rs_o_addr_rs;
    reg [`AWIDTH - 1 : 0] ds2_rs_o_addr_rt;
    reg [`AWIDTH - 1 : 0] ds2_rs_o_addr_rd;

    decoder_stage u_ds2 (
        .ds_i_ce(im_o_ce),
        .ds_i_instr(im_o_instr_2),
        .ds_o_opcode(ds2_o_opcode),
        .ds_o_funct3(ds2_o_funct3),
        .ds_o_funct7(ds2_o_funct7),
        .ds_o_shamt(ds2_o_shamt),
        .ds_o_imm(ds2_o_imm),
        .ds_o_alu_src(ds2_o_alu_src),
        .ds_o_branch(ds2_o_branch),
        .ds_o_regdst(ds2_o_regdst),
        .ds_o_memwrite(ds2_o_memwrite),
        .ds_o_memtoreg(ds2_o_memtoreg),
        .ds_o_regwrite(ds2_o_regwrite),
        .ds_o_addr_rs(ds2_o_addr_rs),
        .ds_o_addr_rt(ds2_o_addr_rt),
        .ds_o_addr_rd(ds2_o_addr_rd),
        .ds_o_ce(ds2_o_ce),
        .ds_o_jal(ds2_o_jal)
    );

    always @(posedge dp_clk, negedge dp_rstn) begin
        if (!dp_rstn) begin
            ds1_rs_o_ce <= 1'b0;
            ds1_rs_o_jal <= 1'b0;
            ds1_rs_o_branch <= 1'b0;
            ds1_rs_o_regdst <= 1'b0;
            ds1_rs_o_alu_src <= 1'b0;
            ds1_rs_o_memwrite <= 1'b0; 
            ds1_rs_o_memtoreg <= 1'b0;
            ds1_rs_o_regwrite <= 1'b0;
            ds1_rs_o_pc <= {`PC_WIDTH{1'b0}};
            ds1_rs_o_imm <= {`IMM_WIDTH{1'b0}};
            ds1_rs_o_shamt <= {`SHAMT_WIDTH{1'b0}};
            ds1_rs_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            ds1_rs_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            ds1_rs_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
            ds1_rs_o_addr_rs <= {`AWIDTH{1'b0}};
            ds1_rs_o_addr_rt <= {`AWIDTH{1'b0}};
            ds1_rs_o_addr_rd <= {`AWIDTH{1'b0}};
        end
        else begin
            if (im_o_ce && ~es_pc_flush) begin
                ds1_rs_o_ce <= ds1_o_ce;
                ds1_rs_o_jal <= ds1_o_jal;
                ds1_rs_o_branch <= ds1_o_branch;
                ds1_rs_o_regdst <= ds1_o_regdst;
                ds1_rs_o_alu_src <= ds1_o_alu_src;
                ds1_rs_o_memwrite <= ds1_o_memwrite;
                ds1_rs_o_memtoreg <= ds1_o_memtoreg;
                ds1_rs_o_regwrite <= ds1_o_regwrite;
                ds1_rs_o_imm <= ds1_o_imm;
                ds1_rs_o_pc <= pc_im_o_pc_1;
                ds1_rs_o_shamt <= ds1_o_shamt;
                ds1_rs_o_opcode <= ds1_o_opcode;
                ds1_rs_o_funct3 <= ds1_o_funct3;
                ds1_rs_o_funct7 <= ds1_o_funct7;
                ds1_rs_o_addr_rs <= ds1_o_addr_rs;
                ds1_rs_o_addr_rt <= ds1_o_addr_rt;
                ds1_rs_o_addr_rd <= ds1_o_addr_rd;
            end
            else if (es_pc_flush) begin
                ds1_rs_o_ce <= 1'b0;
                ds1_rs_o_jal <= 1'b0;
                ds1_rs_o_branch <= 1'b0; 
                ds1_rs_o_regdst <= 1'b0;
                ds1_rs_o_alu_src <= 1'b0;
                ds1_rs_o_memwrite <= 1'b0;
                ds1_rs_o_memtoreg <= 1'b0;
                ds1_rs_o_regwrite <= 1'b0;
                ds1_rs_o_imm <= {`IMM_WIDTH{1'b0}};
                ds1_rs_o_pc <= {`PC_WIDTH{1'b0}};
                ds1_rs_o_shamt <= {`SHAMT_WIDTH{1'b0}};
                ds1_rs_o_opcode <= {`OPCODE_WIDTH{1'b0}};
                ds1_rs_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
                ds1_rs_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
                ds1_rs_o_addr_rs <= {`AWIDTH{1'b0}};
                ds1_rs_o_addr_rt <= {`AWIDTH{1'b0}};
                ds1_rs_o_addr_rd <= {`AWIDTH{1'b0}};
            end
            else begin
                ds1_rs_o_ce <= ds1_rs_o_ce && !fe_lane_done_1;
                ds1_rs_o_jal <= ds1_rs_o_jal;
                ds1_rs_o_branch <= ds1_rs_o_branch;
                ds1_rs_o_regdst <= ds1_rs_o_regdst;
                ds1_rs_o_alu_src <= ds1_rs_o_alu_src;
                ds1_rs_o_memwrite <= ds1_rs_o_memwrite;
                ds1_rs_o_memtoreg <= ds1_rs_o_memtoreg;
                ds1_rs_o_regwrite <= ds1_rs_o_regwrite;
                ds1_rs_o_imm <= ds1_rs_o_imm;
                ds1_rs_o_shamt <= ds1_rs_o_shamt;
                ds1_rs_o_opcode <= ds1_rs_o_opcode;
                ds1_rs_o_funct3 <= ds1_rs_o_funct3;
                ds1_rs_o_funct7 <= ds1_rs_o_funct7;
                ds1_rs_o_addr_rs <= ds1_rs_o_addr_rs;
                ds1_rs_o_addr_rt <= ds1_rs_o_addr_rt;
                ds1_rs_o_addr_rd <= ds1_rs_o_addr_rd;
            end
        end
    end

    always @(posedge dp_clk, negedge dp_rstn) begin
        if (!dp_rstn) begin
            ds2_rs_o_ce <= 1'b0;
            ds2_rs_o_jal <= 1'b0;
            ds2_rs_o_branch <= 1'b0;
            ds2_rs_o_regdst <= 1'b0;
            ds2_rs_o_alu_src <= 1'b0;
            ds2_rs_o_memwrite <= 1'b0;
            ds2_rs_o_memtoreg <= 1'b0;
            ds2_rs_o_regwrite <= 1'b0;
            ds2_rs_o_pc <= {`PC_WIDTH{1'b0}};
            ds2_rs_o_imm <= {`IMM_WIDTH{1'b0}};
            ds2_rs_o_shamt <= {`SHAMT_WIDTH{1'b0}};
            ds2_rs_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            ds2_rs_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            ds2_rs_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
            ds2_rs_o_addr_rs <= {`AWIDTH{1'b0}};
            ds2_rs_o_addr_rt <= {`AWIDTH{1'b0}};
            ds2_rs_o_addr_rd <= {`AWIDTH{1'b0}};
        end
        else begin
            if (im_o_ce && ~es_pc_flush) begin
                ds2_rs_o_ce <= ds2_o_ce;
                ds2_rs_o_jal <= ds2_o_jal;
                ds2_rs_o_branch <= ds2_o_branch;
                ds2_rs_o_regdst <= ds2_o_regdst;
                ds2_rs_o_alu_src <= ds2_o_alu_src;
                ds2_rs_o_memwrite <= ds2_o_memwrite;
                ds2_rs_o_memtoreg <= ds2_o_memtoreg;
                ds2_rs_o_regwrite <= ds2_o_regwrite;
                ds2_rs_o_imm <= ds2_o_imm;
                ds2_rs_o_pc <= pc_im_o_pc_2;
                ds2_rs_o_shamt <= ds2_o_shamt;
                ds2_rs_o_opcode <= ds2_o_opcode;
                ds2_rs_o_funct3 <= ds2_o_funct3;
                ds2_rs_o_funct7 <= ds2_o_funct7;
                ds2_rs_o_addr_rs <= ds2_o_addr_rs;
                ds2_rs_o_addr_rt <= ds2_o_addr_rt;
                ds2_rs_o_addr_rd <= ds2_o_addr_rd;
            end
            else if (es_pc_flush) begin
                ds2_rs_o_ce <= 1'b0; 
                ds2_rs_o_jal <= 1'b0;
                ds2_rs_o_branch <= 1'b0;
                ds2_rs_o_regdst <= 1'b0;
                ds2_rs_o_alu_src <= 1'b0;
                ds2_rs_o_memwrite <= 1'b0;
                ds2_rs_o_memtoreg <= 1'b0;
                ds2_rs_o_regwrite <= 1'b0;
                ds2_rs_o_pc <= {`PC_WIDTH{1'b0}};
                ds2_rs_o_imm <= {`IMM_WIDTH{1'b0}};
                ds2_rs_o_shamt <= {`SHAMT_WIDTH{1'b0}};
                ds2_rs_o_opcode <= {`OPCODE_WIDTH{1'b0}};
                ds2_rs_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
                ds2_rs_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
                ds2_rs_o_addr_rs <= {`AWIDTH{1'b0}};
                ds2_rs_o_addr_rt <= {`AWIDTH{1'b0}};
                ds2_rs_o_addr_rd <= {`AWIDTH{1'b0}}; 
            end
            else begin
                ds2_rs_o_ce <= ds2_rs_o_ce && !fe_lane_done_2;
                ds2_rs_o_jal <= ds2_rs_o_jal;
                ds2_rs_o_branch <= ds2_rs_o_branch;
                ds2_rs_o_regdst <= ds2_rs_o_regdst;
                ds2_rs_o_alu_src <= ds2_rs_o_alu_src;
                ds2_rs_o_memwrite <= ds2_rs_o_memwrite;
                ds2_rs_o_memtoreg <= ds2_rs_o_memtoreg;
                ds2_rs_o_regwrite <= ds2_rs_o_regwrite;
                ds2_rs_o_imm <= ds2_rs_o_imm;
                ds2_rs_o_shamt <= ds2_rs_o_shamt;
                ds2_rs_o_opcode <= ds2_rs_o_opcode;
                ds2_rs_o_funct3 <= ds2_rs_o_funct3;
                ds2_rs_o_funct7 <= ds2_rs_o_funct7;
                ds2_rs_o_addr_rs <= ds2_rs_o_addr_rs;
                ds2_rs_o_addr_rt <= ds2_rs_o_addr_rt;
                ds2_rs_o_addr_rd <= ds2_rs_o_addr_rd;
            end
        end
    end

    // -------------------------------------------------------------------------
    // Stage 2: Rename / Alloc (RAT + FreeList + PRF)
    // -------------------------------------------------------------------------
    // WB/CDB feed về rename_unit (module gộp RAT + PRF của bạn).
    wire wb_valid_1;
    wire wb_valid_2;
    wire [`RAT_SIZE - 1 : 0] wb_tag_1;
    wire [`RAT_SIZE - 1 : 0] wb_tag_2;
    wire [`DWIDTH - 1 : 0] wb_data_1;
    wire [`DWIDTH - 1 : 0] wb_data_2;

    // ROB signals khai báo sớm để dùng xuyên datapath.
    wire rob_o_commit_valid_1;
    wire rob_o_commit_valid_2;
    wire [`ROB_IDX_W - 1 : 0] rob_o_commit_tag_1;
    wire [`ROB_IDX_W - 1 : 0] rob_o_commit_tag_2;
    wire [`AWIDTH - 1 : 0] rob_o_commit_arch_rd_1;
    wire [`AWIDTH - 1 : 0] rob_o_commit_arch_rd_2;
    wire [`RAT_SIZE - 1 : 0] rob_o_rel_prd_1;
    wire [`RAT_SIZE - 1 : 0] rob_o_rel_prd_2;
    wire rob_o_commit_is_store_1;
    wire rob_o_commit_is_store_2;
    wire [`ROB_IDX_W - 1 : 0] rob_o_commit_sq_idx_1;
    wire [`ROB_IDX_W - 1 : 0] rob_o_commit_sq_idx_2;
    wire rob_o_commit_is_load_1;
    wire rob_o_commit_is_load_2;
    wire [`ROB_IDX_W - 1 : 0] rob_o_commit_ld_idx_1;
    wire [`ROB_IDX_W - 1 : 0] rob_o_commit_ld_idx_2;
    wire rob_o_rel_valid_1;
    wire rob_o_rel_valid_2;
    wire rob_o_alloc_fire_1;
    wire rob_o_alloc_fire_2;
    wire rob_o_can_alloc_1;
    wire rob_o_can_alloc_2;
    wire [`ROB_IDX_W - 1 : 0] rob_o_alloc_tag_1;
    wire [`ROB_IDX_W - 1 : 0] rob_o_alloc_tag_2;

    wire [`DWIDTH - 1 : 0] ru_o_data_rs_1;
    wire [`DWIDTH - 1 : 0] ru_o_data_rt_1;
    wire [`DWIDTH - 1 : 0] ru_o_data_rs_2;
    wire [`DWIDTH - 1 : 0] ru_o_data_rt_2;

    wire [`RAT_SIZE - 1 : 0] ru_o_prs_1;
    wire [`RAT_SIZE - 1 : 0] ru_o_prt_1;
    wire [`RAT_SIZE - 1 : 0] ru_o_old_prd_1;
    wire [`RAT_SIZE - 1 : 0] ru_o_new_prd_1;
    wire ru_o_alloc_valid_1;
    wire ru_o_ce_1;

    wire [`RAT_SIZE - 1 : 0] ru_o_prs_2;
    wire [`RAT_SIZE - 1 : 0] ru_o_prt_2;
    wire [`RAT_SIZE - 1 : 0] ru_o_old_prd_2;
    wire [`RAT_SIZE - 1 : 0] ru_o_new_prd_2;
    wire ru_o_alloc_valid_2;
    wire ru_o_ce_2;

    // -------------------------------------------------------------------------
    // Rename/ROB atomic accept (2-wide)
    //
    // Important: rename (RAT/free_list) must NOT advance mappings unless the
    // instruction is guaranteed to enter the machine (ROB alloc + buffered for RS).
    // Otherwise you will see: missing instructions, wrong tags, and 'X' data later.
    //
    // Policy:
    // - Each lane has a 1-entry buffer (ru_rs_*). If that buffer is full, we do not
    //   accept a new rename packet for that lane.
    // - We also gate by ROB free entries so 2-wide alloc cannot partially fail.
    // - free_list exhaustion is handled by ru_o_alloc_valid_* (prd valid bit).
    // -------------------------------------------------------------------------
    // Rename -> RS buffer valid flags are used as backpressure for rename.
    reg ru_rs_valid_1;
    reg ru_rs_valid_2;
    wire ru_rs_dispatch_fire_1;
    wire ru_rs_dispatch_fire_2;
    wire [`ROB_IDX_W : 0] ru_rs_pending_allocs;

    reg [`ROB_IDX_W : 0] rob_used_shadow;
    wire [`ROB_IDX_W : 0] rob_reserved_shadow = rob_used_shadow + ru_rs_pending_allocs;
    wire [`ROB_IDX_W : 0] rob_free_shadow = `ROB_SIZE - rob_reserved_shadow;

    wire ds_need_prd_1 = ds1_rs_o_ce && ds1_rs_o_regwrite && (ds1_rs_o_addr_rd != {`AWIDTH{1'b0}});
    wire ds_need_prd_2 = ds2_rs_o_ce && ds2_rs_o_regwrite && (ds2_rs_o_addr_rd != {`AWIDTH{1'b0}});
    wire ds_store_1 = ds1_rs_o_ce && ds1_rs_o_memwrite;
    wire ds_store_2 = ds2_rs_o_ce && ds2_rs_o_memwrite;
    wire ds_branch_1 = ds1_rs_o_ce && ds1_rs_o_branch;
    wire ds_branch_2 = ds2_rs_o_ce && ds2_rs_o_branch;
    wire ds_req_1 = ds_need_prd_1 || ds_store_1 || ds_branch_1;
    wire ds_req_2 = ds_need_prd_2 || ds_store_2 || ds_branch_2;

    // Elastic Rename -> RS buffer accept:
    // - empty slot can always take a new rename packet
    // - full slot can also take one if RS will consume the current entry this cycle
    // This removes the forced bubble between "drain current b2" and "fill next b2".
    wire ru_rs_can_take_1 = (~ru_rs_valid_1) || ru_rs_dispatch_fire_1;
    wire ru_rs_can_take_2 = (~ru_rs_valid_2) || ru_rs_dispatch_fire_2;

    wire pre_req_1 = ds_req_1 && ru_rs_can_take_1;
    wire pre_req_2 = ds_req_2 && ru_rs_can_take_2;

    // ROB capacity pre-check (match ROB.v alloc_ok_1/2 intent).
    wire pre_ok_1 = pre_req_1 && (rob_free_shadow >= 1);
    wire pre_ok_2 = pre_req_2 &&
                    ((pre_req_1 && (rob_free_shadow >= 2)) ||
                     (!pre_req_1 && (rob_free_shadow >= 1)));

    // Drive rename_unit with masked lanes so RAT/free_list only alloc for lanes we may accept.
    wire ru_i_ce = pre_ok_1 | pre_ok_2;
    wire [`AWIDTH - 1 : 0] ru_i_addr_rs_1 = pre_ok_1 ? ds1_rs_o_addr_rs : {`AWIDTH{1'b0}};
    wire [`AWIDTH - 1 : 0] ru_i_addr_rt_1 = pre_ok_1 ? ds1_rs_o_addr_rt : {`AWIDTH{1'b0}};
    wire [`AWIDTH - 1 : 0] ru_i_addr_rd_1 = (pre_ok_1 && ds_need_prd_1) ? ds1_rs_o_addr_rd : {`AWIDTH{1'b0}};
    wire [`AWIDTH - 1 : 0] ru_i_addr_rs_2 = pre_ok_2 ? ds2_rs_o_addr_rs : {`AWIDTH{1'b0}};
    wire [`AWIDTH - 1 : 0] ru_i_addr_rt_2 = pre_ok_2 ? ds2_rs_o_addr_rt : {`AWIDTH{1'b0}};
    wire [`AWIDTH - 1 : 0] ru_i_addr_rd_2 = (pre_ok_2 && ds_need_prd_2) ? ds2_rs_o_addr_rd : {`AWIDTH{1'b0}};

    rename_unit u_rename (
        .ru_clk(dp_clk),
        .ru_rstn(dp_rstn),
        .ru_i_ce(ru_i_ce),
        .ru_i_addr_rs_1(ru_i_addr_rs_1),
        .ru_i_addr_rt_1(ru_i_addr_rt_1),
        .ru_i_addr_rd_1(ru_i_addr_rd_1),
        .ru_i_addr_rs_2(ru_i_addr_rs_2),
        .ru_i_addr_rt_2(ru_i_addr_rt_2),
        .ru_i_addr_rd_2(ru_i_addr_rd_2),
        .ru_o_data_rs_1(ru_o_data_rs_1),
        .ru_o_data_rt_1(ru_o_data_rt_1),
        .ru_o_data_rs_2(ru_o_data_rs_2),
        .ru_o_data_rt_2(ru_o_data_rt_2),
        .ru_o_prs_1(ru_o_prs_1),
        .ru_o_prt_1(ru_o_prt_1),
        .ru_o_old_prd_1(ru_o_old_prd_1),
        .ru_o_new_prd_1(ru_o_new_prd_1),
        .ru_o_alloc_valid_1(ru_o_alloc_valid_1),
        .ru_o_ce_1(ru_o_ce_1),
        .ru_o_prs_2(ru_o_prs_2),
        .ru_o_prt_2(ru_o_prt_2),
        .ru_o_old_prd_2(ru_o_old_prd_2),
        .ru_o_new_prd_2(ru_o_new_prd_2),
        .ru_o_alloc_valid_2(ru_o_alloc_valid_2),
        .ru_o_ce_2(ru_o_ce_2),
        .ru_i_rel_valid_1(rob_o_rel_valid_1),
        .ru_i_rel_prd_1(rob_o_rel_prd_1),
        .ru_i_wb_valid_1(wb_valid_1),
        .ru_i_wb_prd_1(wb_tag_1),
        .ru_i_wb_data_1(wb_data_1),
        .ru_i_rel_valid_2(rob_o_rel_valid_2),
        .ru_i_rel_prd_2(rob_o_rel_prd_2),
        .ru_i_wb_valid_2(wb_valid_2),
        .ru_i_wb_prd_2(wb_tag_2),
        .ru_i_wb_data_2(wb_data_2)
    );

    // Final accept after free_list availability.
    wire ren_fire_1 = pre_ok_1 & (ds_need_prd_1 ? ru_o_ce_1 : 1'b1);
    wire ren_fire_2 = pre_ok_2 & (ds_need_prd_2 ? ru_o_ce_2 : 1'b1);

    // -------------------------------------------------------------------------
    // Front-end stall: prevent dropping instructions when rename/ROB/buffer2 backpressures.
    //
    // Symptom if missing: some decoded ops (ex: addi/andi) never reach ROB => later RAW uses old PRF init value.
    // Root cause: PC continues advancing while Buffer1 is overwritten before rename alloc succeeds.
    //
    // Policy for this variant:
    // - Do NOT stall fetch just because b2 currently holds data.
    // - Stall only when current Buffer1 packet cannot be consumed into rename/ROB this cycle.
    // With elastic b2, same-cycle drain+refill is legal and does not drop instructions.
    // -------------------------------------------------------------------------
    wire fe_need_alloc_1 = ds1_rs_o_ce && ds_req_1;
    wire fe_need_alloc_2 = ds2_rs_o_ce && ds_req_2;
    // If an op needs alloc, it is consumed once rename/free_list writes a packet into Buffer2.
    wire fe_lane_done_1 = (~fe_need_alloc_1) || ren_fire_1;
    wire fe_lane_done_2 = (~fe_need_alloc_2) || ren_fire_2;
    wire fe_pair_done = fe_lane_done_1 && fe_lane_done_2;
    wire ds_rs_any_valid = ds1_rs_o_ce || ds2_rs_o_ce;
    wire fe_stall = ds_rs_any_valid && ~fe_pair_done;
    assign fe_ce = dp_i_ce && ~fe_stall;

    // Buffer2: Rename -> Dispatch
    reg [`PC_WIDTH - 1 : 0] ru_rs_pc_1;
    reg [`PC_WIDTH - 1 : 0] ru_rs_pc_2;

    reg [`OPCODE_WIDTH - 1 : 0] ru_rs_opcode_1;
    reg [`OPCODE_WIDTH - 1 : 0] ru_rs_opcode_2;
    reg [`FUNCT3_WIDTH - 1 : 0] ru_rs_funct3_1;
    reg [`FUNCT3_WIDTH - 1 : 0] ru_rs_funct3_2;
    reg [`FUNCT7_WIDTH - 1 : 0] ru_rs_funct7_1;
    reg [`FUNCT7_WIDTH - 1 : 0] ru_rs_funct7_2;
    reg [`SHAMT_WIDTH - 1 : 0] ru_rs_shamt_1;
    reg [`SHAMT_WIDTH - 1 : 0] ru_rs_shamt_2;
    reg [`IMM_WIDTH - 1 : 0] ru_rs_imm_1;
    reg [`IMM_WIDTH - 1 : 0] ru_rs_imm_2;
    reg ru_rs_jal_1;
    reg ru_rs_jal_2;
    reg ru_rs_alu_src_1;
    reg ru_rs_alu_src_2;
    reg ru_rs_memwrite_1;
    reg ru_rs_memwrite_2;
    reg ru_rs_memtoreg_1;
    reg ru_rs_memtoreg_2;
    reg ru_rs_regwrite_1;
    reg ru_rs_regwrite_2;

    reg [`AWIDTH - 1 : 0] ru_rs_addr_rs_1;
    reg [`AWIDTH - 1 : 0] ru_rs_addr_rt_1;
    reg [`AWIDTH - 1 : 0] ru_rs_addr_rd_1;
    reg [`AWIDTH - 1 : 0] ru_rs_addr_rs_2;
    reg [`AWIDTH - 1 : 0] ru_rs_addr_rt_2;
    reg [`AWIDTH - 1 : 0] ru_rs_addr_rd_2;

    reg [`RAT_SIZE - 1 : 0] ru_rs_prs_1;
    reg [`RAT_SIZE - 1 : 0] ru_rs_prt_1;
    reg [`RAT_SIZE - 1 : 0] ru_rs_new_prd_1;
    reg [`RAT_SIZE - 1 : 0] ru_rs_old_prd_1;
    reg ru_rs_alloc_valid_1;
    reg [`RAT_SIZE - 1 : 0] ru_rs_prs_2;
    reg [`RAT_SIZE - 1 : 0] ru_rs_prt_2;
    reg [`RAT_SIZE - 1 : 0] ru_rs_new_prd_2;
    reg [`RAT_SIZE - 1 : 0] ru_rs_old_prd_2;
    reg ru_rs_alloc_valid_2;

    reg [`DWIDTH - 1 : 0] ru_rs_data_rs_1;
    reg [`DWIDTH - 1 : 0] ru_rs_data_rt_1;
    reg [`DWIDTH - 1 : 0] ru_rs_data_rs_2;
    reg [`DWIDTH - 1 : 0] ru_rs_data_rt_2;
    reg prd_ready [0 : (2**`RAT_SIZE) - 1];

    // NOTE: We keep control/metadata inside RS entries (triệt để), so we don't need

    always @(posedge dp_clk or negedge dp_rstn) begin
        if (!dp_rstn) begin
            ru_rs_valid_1 <= 1'b0;
            ru_rs_valid_2 <= 1'b0;
            ru_rs_pc_1 <= {`PC_WIDTH{1'b0}};
            ru_rs_pc_2 <= {`PC_WIDTH{1'b0}};
            ru_rs_opcode_1 <= {`OPCODE_WIDTH{1'b0}};
            ru_rs_opcode_2 <= {`OPCODE_WIDTH{1'b0}};
            ru_rs_funct3_1 <= {`FUNCT3_WIDTH{1'b0}};
            ru_rs_funct3_2 <= {`FUNCT3_WIDTH{1'b0}};
            ru_rs_funct7_1 <= {`FUNCT7_WIDTH{1'b0}};
            ru_rs_funct7_2 <= {`FUNCT7_WIDTH{1'b0}};
            ru_rs_shamt_1 <= {`SHAMT_WIDTH{1'b0}};
            ru_rs_shamt_2 <= {`SHAMT_WIDTH{1'b0}};
            ru_rs_imm_1 <= {`IMM_WIDTH{1'b0}};
            ru_rs_imm_2 <= {`IMM_WIDTH{1'b0}};
            ru_rs_jal_1 <= 1'b0;
            ru_rs_jal_2 <= 1'b0;
            ru_rs_alu_src_1 <= 1'b0;
            ru_rs_alu_src_2 <= 1'b0;
            ru_rs_memwrite_1 <= 1'b0;
            ru_rs_memwrite_2 <= 1'b0;
            ru_rs_memtoreg_1 <= 1'b0;
            ru_rs_memtoreg_2 <= 1'b0;
            ru_rs_regwrite_1 <= 1'b0;
            ru_rs_regwrite_2 <= 1'b0;
            ru_rs_addr_rs_1 <= {`AWIDTH{1'b0}};
            ru_rs_addr_rt_1 <= {`AWIDTH{1'b0}};
            ru_rs_addr_rd_1 <= {`AWIDTH{1'b0}};
            ru_rs_addr_rs_2 <= {`AWIDTH{1'b0}};
            ru_rs_addr_rt_2 <= {`AWIDTH{1'b0}};
            ru_rs_addr_rd_2 <= {`AWIDTH{1'b0}};
            ru_rs_prs_1 <= {`RAT_SIZE{1'b0}};
            ru_rs_prt_1 <= {`RAT_SIZE{1'b0}};
            ru_rs_new_prd_1 <= {`RAT_SIZE{1'b0}};
            ru_rs_old_prd_1 <= {`RAT_SIZE{1'b0}};
            ru_rs_alloc_valid_1 <= 1'b0;
            ru_rs_prs_2 <= {`RAT_SIZE{1'b0}};
            ru_rs_prt_2 <= {`RAT_SIZE{1'b0}};
            ru_rs_new_prd_2 <= {`RAT_SIZE{1'b0}};
            ru_rs_old_prd_2 <= {`RAT_SIZE{1'b0}};
            ru_rs_alloc_valid_2 <= 1'b0;
            ru_rs_data_rs_1 <= {`DWIDTH{1'b0}};
            ru_rs_data_rt_1 <= {`DWIDTH{1'b0}};
            ru_rs_data_rs_2 <= {`DWIDTH{1'b0}};
            ru_rs_data_rt_2 <= {`DWIDTH{1'b0}};
            for (prd_ready_i = 0; prd_ready_i < (2**`RAT_SIZE); prd_ready_i = prd_ready_i + 1) begin
                prd_ready[prd_ready_i] <= 1'b1;
            end
            rob_used_shadow <= {(`ROB_IDX_W + 1){1'b0}};
        end
        else begin
            if (es_pc_flush) begin
                ru_rs_valid_1 <= 1'b0;
                ru_rs_valid_2 <= 1'b0;
                ru_rs_alloc_valid_1 <= 1'b0;
                ru_rs_alloc_valid_2 <= 1'b0;
            end
            else begin
                // Shadow ROB used_count for rename/alloc gating (avoid partial-accept corner cases).
                rob_used_shadow <= rob_used_shadow +
                                (rob_o_alloc_fire_1 + rob_o_alloc_fire_2) -
                                (rob_o_commit_valid_1 + rob_o_commit_valid_2);

                // Elastic b2 semantics:
                // - hold current packet until Dispatch allocates ROB and RS accepts it
                // - if Dispatch consumes current packet this cycle, allow immediate refill from Rename
                // - if empty, fill directly from Rename
                if (ru_rs_valid_1 && !ru_rs_dispatch_fire_1) begin
                    ru_rs_valid_1 <= 1'b1;
                end
                else begin
                    ru_rs_valid_1 <= ren_fire_1;
                    if (ren_fire_1) begin
                        ru_rs_pc_1 <= ds1_rs_o_pc;
                        ru_rs_opcode_1 <= ds1_rs_o_opcode;
                        ru_rs_funct3_1 <= ds1_rs_o_funct3;
                        ru_rs_funct7_1 <= ds1_rs_o_funct7;
                        ru_rs_shamt_1 <= ds1_rs_o_shamt;
                        ru_rs_imm_1 <= ds1_rs_o_imm;
                        ru_rs_jal_1 <= ds1_rs_o_jal;
                        ru_rs_alu_src_1 <= ds1_rs_o_alu_src;
                        ru_rs_memwrite_1 <= ds1_rs_o_memwrite;
                        ru_rs_memtoreg_1 <= ds1_rs_o_memtoreg;
                        ru_rs_regwrite_1 <= ds1_rs_o_regwrite;
                        ru_rs_addr_rs_1 <= ds1_rs_o_addr_rs;
                        ru_rs_addr_rt_1 <= ds1_rs_o_addr_rt;
                        ru_rs_addr_rd_1 <= ds1_rs_o_addr_rd;
                        ru_rs_prs_1 <= ru_o_prs_1;
                        ru_rs_prt_1 <= ru_o_prt_1;
                        ru_rs_new_prd_1 <= ru_o_new_prd_1;
                        ru_rs_old_prd_1 <= ru_o_old_prd_1;
                        ru_rs_alloc_valid_1 <= ren_fire_1;
                        ru_rs_data_rs_1 <= ru_o_data_rs_1;
                        ru_rs_data_rt_1 <= ru_o_data_rt_1;
                    end
                    else begin
                        ru_rs_alloc_valid_1 <= 1'b0;
                    end
                end

                if (ru_rs_valid_2 && !ru_rs_dispatch_fire_2) begin
                    ru_rs_valid_2 <= 1'b1;
                end
                else begin
                    ru_rs_valid_2 <= ren_fire_2;
                    if (ren_fire_2) begin
                        ru_rs_pc_2 <= ds2_rs_o_pc;
                        ru_rs_opcode_2 <= ds2_rs_o_opcode;
                        ru_rs_funct3_2 <= ds2_rs_o_funct3;
                        ru_rs_funct7_2 <= ds2_rs_o_funct7;
                        ru_rs_shamt_2 <= ds2_rs_o_shamt;
                        ru_rs_imm_2 <= ds2_rs_o_imm;
                        ru_rs_jal_2 <= ds2_rs_o_jal;
                        ru_rs_alu_src_2 <= ds2_rs_o_alu_src;
                        ru_rs_memwrite_2 <= ds2_rs_o_memwrite;
                        ru_rs_memtoreg_2 <= ds2_rs_o_memtoreg;
                        ru_rs_regwrite_2 <= ds2_rs_o_regwrite;
                        ru_rs_addr_rs_2 <= ds2_rs_o_addr_rs;
                        ru_rs_addr_rt_2 <= ds2_rs_o_addr_rt;
                        ru_rs_addr_rd_2 <= ds2_rs_o_addr_rd;
                        ru_rs_prs_2 <= ru_o_prs_2;
                        ru_rs_prt_2 <= ru_o_prt_2;
                        ru_rs_new_prd_2 <= ru_o_new_prd_2;
                        ru_rs_old_prd_2 <= ru_o_old_prd_2;
                        ru_rs_alloc_valid_2 <= ren_fire_2;
                        ru_rs_data_rs_2 <= ru_o_data_rs_2;
                        ru_rs_data_rt_2 <= ru_o_data_rt_2;
                    end
                    else begin
                        ru_rs_alloc_valid_2 <= 1'b0;
                    end
                end

                // Scoreboard readiness cho PRD:
                // - clear khi alloc producer moi
                // - set khi WB xong (du lieu da co trong PRF de cycle sau doc an toan)
                if (wb_valid_1) begin
                    prd_ready[wb_tag_1] <= 1'b1;
                end
                if (wb_valid_2) begin
                    prd_ready[wb_tag_2] <= 1'b1;
                end
                if (ren_fire_1 && ds_need_prd_1) begin
                    prd_ready[ru_o_new_prd_1] <= 1'b0;
                end
                if (ren_fire_2 && ds_need_prd_2) begin
                    prd_ready[ru_o_new_prd_2] <= 1'b0;
                end
            end
        end
    end

    // -------------------------------------------------------------------------
    // Stage 3/4: Dispatch -> RS -> Issue/Execute
    // -------------------------------------------------------------------------
    wire rs_o_issue_valid_1;
    wire rs_o_issue_valid_2;
    wire [`PC_WIDTH - 1 : 0] rs_o_pc_1;
    wire [`PC_WIDTH - 1 : 0] rs_o_pc_2;
    wire [`OPCODE_WIDTH - 1 : 0] rs_o_opcode_1;
    wire [`OPCODE_WIDTH - 1 : 0] rs_o_opcode_2;
    wire [`FUNCT3_WIDTH - 1 : 0] rs_o_funct3_1;
    wire [`FUNCT3_WIDTH - 1 : 0] rs_o_funct3_2;
    wire [`FUNCT7_WIDTH - 1 : 0] rs_o_funct7_1;
    wire [`FUNCT7_WIDTH - 1 : 0] rs_o_funct7_2;
    wire [`SHAMT_WIDTH - 1 : 0] rs_o_shamt_1;
    wire [`SHAMT_WIDTH - 1 : 0] rs_o_shamt_2;
    wire [`IMM_WIDTH - 1 : 0] rs_o_imm_1;
    wire [`IMM_WIDTH - 1 : 0] rs_o_imm_2;
    wire rs_o_jal_1;
    wire rs_o_jal_2;
    wire rs_o_alu_src_1;
    wire rs_o_alu_src_2;
    wire rs_o_memwrite_1;
    wire rs_o_memwrite_2;
    wire rs_o_memtoreg_1;
    wire rs_o_memtoreg_2;
    wire rs_o_regwrite_1;
    wire rs_o_regwrite_2;
    wire [`RAT_SIZE - 1 : 0] rs_o_prd_1;
    wire [`RAT_SIZE - 1 : 0] rs_o_prd_2;
    wire [`ROB_IDX_W - 1 : 0] rs_o_rob_tag_1;
    wire [`ROB_IDX_W - 1 : 0] rs_o_rob_tag_2;
    wire [`ROB_IDX_W - 1 : 0] rs_o_sq_idx_1;
    wire [`ROB_IDX_W - 1 : 0] rs_o_sq_idx_2;
    wire [`DWIDTH - 1 : 0] rs_o_vrs_1;
    wire [`DWIDTH - 1 : 0] rs_o_vrt_1;
    wire [`DWIDTH - 1 : 0] rs_o_vrs_2;
    wire [`DWIDTH - 1 : 0] rs_o_vrt_2;

    wire rs_wakeup_es_valid_1;
    wire rs_wakeup_es_valid_2;
    wire [`RAT_SIZE - 1 : 0] rs_wakeup_es_prd_1;
    wire [`RAT_SIZE - 1 : 0] rs_wakeup_es_prd_2;
    wire [`DWIDTH - 1 : 0] rs_wakeup_es_data_1;
    wire [`DWIDTH - 1 : 0] rs_wakeup_es_data_2;
    wire [`OPCODE_WIDTH - 1 : 0] rs_wakeup_es_opcode_1;
    wire [`OPCODE_WIDTH - 1 : 0] rs_wakeup_es_opcode_2;

    wire rs_wakeup_mem_valid_1;
    wire rs_wakeup_mem_valid_2;
    wire [`RAT_SIZE - 1 : 0] rs_wakeup_mem_prd_1;
    wire [`RAT_SIZE - 1 : 0] rs_wakeup_mem_prd_2;
    wire [`DWIDTH - 1 : 0] rs_wakeup_mem_data_1;
    wire [`DWIDTH - 1 : 0] rs_wakeup_mem_data_2;
    wire [`OPCODE_WIDTH - 1 : 0] rs_wakeup_mem_opcode_1;
    wire [`OPCODE_WIDTH - 1 : 0] rs_wakeup_mem_opcode_2;

    wire ru_rs_prs_ready_1 = (ru_rs_prs_1 == {`RAT_SIZE{1'b0}}) ? 1'b1 : prd_ready[ru_rs_prs_1];
    wire ru_rs_prt_ready_1 = (ru_rs_prt_1 == {`RAT_SIZE{1'b0}}) ? 1'b1 : prd_ready[ru_rs_prt_1];
    wire ru_rs_prs_ready_2 = (ru_rs_prs_2 == {`RAT_SIZE{1'b0}}) ? 1'b1 : prd_ready[ru_rs_prs_2];
    wire ru_rs_prt_ready_2 = (ru_rs_prt_2 == {`RAT_SIZE{1'b0}}) ? 1'b1 : prd_ready[ru_rs_prt_2];

    wire es1_o_ready;
    wire es2_o_ready;
    wire is3_can_take_1;
    wire is3_can_take_2;
    wire rs_issue_accept_1 = rs_o_issue_valid_1 && is3_can_take_1;
    wire rs_issue_accept_2 = rs_o_issue_valid_2 && is3_can_take_2;
    wire rs_alloc_valid_1 = ru_rs_valid_1 & ru_rs_alloc_valid_1;
    wire rs_alloc_valid_2 = ru_rs_valid_2 & ru_rs_alloc_valid_2;

    // Store Queue allocation/status.
    wire [`ROB_IDX_W - 1 : 0] sq_o_alloc_ptr_1;
    wire [`ROB_IDX_W - 1 : 0] sq_o_alloc_ptr_2;
    wire [`ROB_IDX_W : 0] sq_o_count;
    wire [`ROB_IDX_W - 1 : 0] sq_o_tail_ptr;

    // Load Queue allocation/status.
    wire [`ROB_IDX_W - 1 : 0] lq_o_alloc_ptr_1;
    wire [`ROB_IDX_W - 1 : 0] lq_o_alloc_ptr_2;
    wire [`ROB_IDX_W : 0] lq_o_count;

    assign ru_rs_pending_allocs = {{`ROB_IDX_W{1'b0}}, rs_alloc_valid_1} +
                                  {{`ROB_IDX_W{1'b0}}, rs_alloc_valid_2};

    wire sq_need_1 = rs_alloc_valid_1 & ru_rs_memwrite_1;
    wire sq_need_2 = rs_alloc_valid_2 & ru_rs_memwrite_2;
    wire lq_need_1 = rs_alloc_valid_1 & ru_rs_memtoreg_1;
    wire lq_need_2 = rs_alloc_valid_2 & ru_rs_memtoreg_2;
    wire [`ROB_IDX_W : 0] sq_free_count = `ROB_SIZE - sq_o_count;
    wire [`ROB_IDX_W : 0] lq_free_count = `ROB_SIZE - lq_o_count;
    wire [`ROB_IDX_W : 0] sq_need_pair =
        {{`ROB_IDX_W{1'b0}}, sq_need_1} + {{`ROB_IDX_W{1'b0}}, sq_need_2};
    wire [`ROB_IDX_W : 0] lq_need_pair =
                                        {{`ROB_IDX_W{1'b0}}, lq_need_1} + {{`ROB_IDX_W{1'b0}}, lq_need_2};
    wire sq_lane1_ok = (!sq_need_1) || (sq_free_count >= 1);
    wire lq_lane1_ok = (!lq_need_1) || (lq_free_count >= 1);
    wire sq_pair_ok = (sq_free_count >= sq_need_pair);
    wire lq_pair_ok = (lq_free_count >= lq_need_pair);
    wire sq_lane2_solo_ok = (!sq_need_2) || (sq_free_count >= 1);
    wire lq_lane2_solo_ok = (!lq_need_2) || (lq_free_count >= 1);

    wire dispatch_can_take_1 =
        rob_o_can_alloc_1 & rs_o_can_alloc_1 & sq_lane1_ok & lq_lane1_ok;
    wire dispatch_can_take_2_pair =
        rob_o_can_alloc_2 & rs_o_can_alloc_2 & sq_pair_ok & lq_pair_ok;
    wire dispatch_can_take_2_solo =
        rob_o_can_alloc_1 & rs_o_can_alloc_1 & sq_lane2_solo_ok & lq_lane2_solo_ok;

    assign ru_rs_dispatch_fire_1 = rs_alloc_valid_1 & dispatch_can_take_1;
    assign ru_rs_dispatch_fire_2 = rs_alloc_valid_2 &
                                   (rs_alloc_valid_1 ? (ru_rs_dispatch_fire_1 & dispatch_can_take_2_pair) :
                                                       dispatch_can_take_2_solo);
    wire sq_alloc_req_1 = ru_rs_dispatch_fire_1 & ru_rs_memwrite_1;
    wire sq_alloc_req_2 = ru_rs_dispatch_fire_2 & ru_rs_memwrite_2;
    wire lq_alloc_req_1 = ru_rs_dispatch_fire_1 & ru_rs_memtoreg_1;
    wire lq_alloc_req_2 = ru_rs_dispatch_fire_2 & ru_rs_memtoreg_2;
    wire rob_alloc_req_1 = ru_rs_dispatch_fire_1;
    wire rob_alloc_req_2 = ru_rs_dispatch_fire_2;
    wire lane1_store_dispatch = ru_rs_dispatch_fire_1 & ru_rs_memwrite_1;
    wire [`ROB_IDX_W - 1 : 0] lq_alloc_sq_tail_snapshot_1 = sq_o_tail_ptr;
    wire [`ROB_IDX_W - 1 : 0] lq_alloc_sq_tail_snapshot_2 =
        sq_o_tail_ptr + {{(`ROB_IDX_W - 1){1'b0}}, lane1_store_dispatch};
    wire [`ROB_IDX_W : 0] lq_alloc_older_store_count_1 = sq_o_count;
    wire [`ROB_IDX_W : 0] lq_alloc_older_store_count_2 =
        sq_o_count + {{`ROB_IDX_W{1'b0}}, lane1_store_dispatch};
    wire [`ROB_IDX_W - 1 : 0] dispatch_sq_idx_1 =
        ru_rs_memwrite_1 ? sq_o_alloc_ptr_1 : {`ROB_IDX_W{1'b0}};
    wire [`ROB_IDX_W - 1 : 0] dispatch_sq_idx_2 =
        ru_rs_memwrite_2 ? sq_o_alloc_ptr_2 : {`ROB_IDX_W{1'b0}};
    wire [`ROB_IDX_W - 1 : 0] dispatch_ld_idx_1 =
        ru_rs_memtoreg_1 ? lq_o_alloc_ptr_1 : {`ROB_IDX_W{1'b0}};
    wire [`ROB_IDX_W - 1 : 0] dispatch_ld_idx_2 =
        ru_rs_memtoreg_2 ? lq_o_alloc_ptr_2 : {`ROB_IDX_W{1'b0}};
    wire [`ROB_IDX_W - 1 : 0] dispatch_mem_idx_1 =
        ru_rs_memwrite_1 ? dispatch_sq_idx_1 :
        (ru_rs_memtoreg_1 ? dispatch_ld_idx_1 : {`ROB_IDX_W{1'b0}});
    wire [`ROB_IDX_W - 1 : 0] dispatch_mem_idx_2 =
        ru_rs_memwrite_2 ? dispatch_sq_idx_2 :
        (ru_rs_memtoreg_2 ? dispatch_ld_idx_2 : {`ROB_IDX_W{1'b0}});
    wire rs_o_has_valid;
    wire rs_i_ce_pipe = rs_o_has_valid |
                        ru_rs_dispatch_fire_1 |
                        ru_rs_dispatch_fire_2 |
                        rs_wakeup_es_valid_1 |
                        rs_wakeup_es_valid_2 |
                        rs_wakeup_mem_valid_1 |
                        rs_wakeup_mem_valid_2;
        reservation_station u_rs (
	        .rs_clk(dp_clk),
	        .rs_rstn(dp_rstn),
	        .rs_i_ce(rs_i_ce_pipe),
	        .rs_i_issue_accept_1(rs_issue_accept_1),
	        .rs_i_issue_accept_2(rs_issue_accept_2),

	        .rs_i_alloc_valid_1(ru_rs_dispatch_fire_1),
	        .rs_i_opcode_1(ru_rs_opcode_1),
	        .rs_i_funct3_1(ru_rs_funct3_1),
	        .rs_i_funct7_1(ru_rs_funct7_1),
	        .rs_i_shamt_1(ru_rs_shamt_1),
	        .rs_i_imm_1(ru_rs_imm_1),
	        .rs_i_alu_src_1(ru_rs_alu_src_1),
	        .rs_i_jal_1(ru_rs_jal_1),
	        .rs_i_memwrite_1(ru_rs_memwrite_1),
	        .rs_i_memtoreg_1(ru_rs_memtoreg_1),
	        .rs_i_regwrite_1(ru_rs_regwrite_1),
	        .rs_i_pc_1(ru_rs_pc_1),
	        .rs_i_prs_1(ru_rs_prs_1),
	        .rs_i_prt_1(ru_rs_prt_1),
	        .rs_i_prs_ready_1(ru_rs_prs_ready_1),
	        .rs_i_prt_ready_1(ru_rs_prt_ready_1),
            .rs_i_prd_1(ru_rs_new_prd_1),
            .rs_i_rob_tag_1(rob_o_alloc_tag_1),
            .rs_i_sq_idx_1(dispatch_mem_idx_1),
            .rs_i_data_rs_1(ru_rs_data_rs_1),
            .rs_i_data_rt_1(ru_rs_data_rt_1),

            .rs_i_es_valid_1(rs_wakeup_es_valid_1),
            .rs_i_es_prd_1(rs_wakeup_es_prd_1),
            .rs_i_es_data_1(rs_wakeup_es_data_1),
            .rs_i_es_opcode_1(rs_wakeup_es_opcode_1),
            .rs_i_es_valid_2(rs_wakeup_es_valid_2),
            .rs_i_es_prd_2(rs_wakeup_es_prd_2),
            .rs_i_es_data_2(rs_wakeup_es_data_2),
            .rs_i_es_opcode_2(rs_wakeup_es_opcode_2),
            .rs_i_mem_valid_1(rs_wakeup_mem_valid_1),
            .rs_i_mem_prd_1(rs_wakeup_mem_prd_1),
            .rs_i_mem_data_1(rs_wakeup_mem_data_1),
            .rs_i_mem_opcode_1(rs_wakeup_mem_opcode_1),
            .rs_i_mem_valid_2(rs_wakeup_mem_valid_2),
            .rs_i_mem_prd_2(rs_wakeup_mem_prd_2),
            .rs_i_mem_data_2(rs_wakeup_mem_data_2),
            .rs_i_mem_opcode_2(rs_wakeup_mem_opcode_2),

	        .rs_o_issue_valid_1(rs_o_issue_valid_1),
	        .rs_o_pc_1(rs_o_pc_1),
	        .rs_o_opcode_1(rs_o_opcode_1),
	        .rs_o_funct3_1(rs_o_funct3_1),
	        .rs_o_funct7_1(rs_o_funct7_1),
	        .rs_o_shamt_1(rs_o_shamt_1),
	        .rs_o_imm_1(rs_o_imm_1),
	        .rs_o_alu_src_1(rs_o_alu_src_1),
	        .rs_o_jal_1(rs_o_jal_1),
	        .rs_o_memwrite_1(rs_o_memwrite_1),
	        .rs_o_memtoreg_1(rs_o_memtoreg_1),
	        .rs_o_regwrite_1(rs_o_regwrite_1),
	        .rs_o_prd_1(rs_o_prd_1),
	        .rs_o_rob_tag_1(rs_o_rob_tag_1),
	        .rs_o_sq_idx_1(rs_o_sq_idx_1),
	        .rs_o_vrs_1(rs_o_vrs_1),
	        .rs_o_vrt_1(rs_o_vrt_1),
	        .rs_o_stall_1(),
	        .rs_o_has_valid(rs_o_has_valid),
	        .rs_o_can_alloc_1(rs_o_can_alloc_1),
	        .rs_o_can_alloc_2(rs_o_can_alloc_2),

	        .rs_i_alloc_valid_2(ru_rs_dispatch_fire_2),
	        .rs_i_opcode_2(ru_rs_opcode_2),
	        .rs_i_funct3_2(ru_rs_funct3_2),
            .rs_i_funct7_2(ru_rs_funct7_2),
	        .rs_i_shamt_2(ru_rs_shamt_2),
            .rs_i_imm_2(ru_rs_imm_2),
	        .rs_i_alu_src_2(ru_rs_alu_src_2),
	        .rs_i_jal_2(ru_rs_jal_2),
	        .rs_i_memwrite_2(ru_rs_memwrite_2),
	        .rs_i_memtoreg_2(ru_rs_memtoreg_2),
	        .rs_i_regwrite_2(ru_rs_regwrite_2),
	        .rs_i_pc_2(ru_rs_pc_2),
	        .rs_i_prs_2(ru_rs_prs_2),
	        .rs_i_prt_2(ru_rs_prt_2),
	        .rs_i_prs_ready_2(ru_rs_prs_ready_2),
	        .rs_i_prt_ready_2(ru_rs_prt_ready_2),
            .rs_i_prd_2(ru_rs_new_prd_2),
            .rs_i_rob_tag_2(rob_o_alloc_tag_2),
            .rs_i_sq_idx_2(dispatch_mem_idx_2),
            .rs_i_data_rs_2(ru_rs_data_rs_2),
            .rs_i_data_rt_2(ru_rs_data_rt_2),

	        .rs_o_issue_valid_2(rs_o_issue_valid_2),
	        .rs_o_pc_2(rs_o_pc_2),
	        .rs_o_opcode_2(rs_o_opcode_2),
	        .rs_o_funct3_2(rs_o_funct3_2),
	        .rs_o_funct7_2(rs_o_funct7_2),
	        .rs_o_shamt_2(rs_o_shamt_2),
	        .rs_o_imm_2(rs_o_imm_2),
	        .rs_o_alu_src_2(rs_o_alu_src_2),
	        .rs_o_jal_2(rs_o_jal_2),
	        .rs_o_memwrite_2(rs_o_memwrite_2),
	        .rs_o_memtoreg_2(rs_o_memtoreg_2),
	        .rs_o_regwrite_2(rs_o_regwrite_2),
	        .rs_o_prd_2(rs_o_prd_2),
	        .rs_o_rob_tag_2(rs_o_rob_tag_2),
	        .rs_o_sq_idx_2(rs_o_sq_idx_2),
	        .rs_o_vrs_2(rs_o_vrs_2),
	        .rs_o_vrt_2(rs_o_vrt_2),
	        .rs_o_stall_2()
	    );

    // Buffer3: RS issue -> Execute.
    // This breaks the long RS scheduler -> Execute combinational path.
    reg is3_valid_1;
    reg is3_valid_2;
    reg [`PC_WIDTH - 1 : 0] is3_pc_1;
    reg [`PC_WIDTH - 1 : 0] is3_pc_2;
    reg [`OPCODE_WIDTH - 1 : 0] is3_opcode_1;
    reg [`OPCODE_WIDTH - 1 : 0] is3_opcode_2;
    reg [`FUNCT3_WIDTH - 1 : 0] is3_funct3_1;
    reg [`FUNCT3_WIDTH - 1 : 0] is3_funct3_2;
    reg [`FUNCT7_WIDTH - 1 : 0] is3_funct7_1;
    reg [`FUNCT7_WIDTH - 1 : 0] is3_funct7_2;
    reg [`SHAMT_WIDTH - 1 : 0] is3_shamt_1;
    reg [`SHAMT_WIDTH - 1 : 0] is3_shamt_2;
    reg [`IMM_WIDTH - 1 : 0] is3_imm_1;
    reg [`IMM_WIDTH - 1 : 0] is3_imm_2;
    reg is3_alu_src_1;
    reg is3_alu_src_2;
    reg is3_jal_1;
    reg is3_jal_2;
    reg is3_memwrite_1;
    reg is3_memwrite_2;
    reg is3_memtoreg_1;
    reg is3_memtoreg_2;
    reg is3_regwrite_1;
    reg is3_regwrite_2;
    reg [`RAT_SIZE - 1 : 0] is3_prd_1;
    reg [`RAT_SIZE - 1 : 0] is3_prd_2;
    reg [`ROB_IDX_W - 1 : 0] is3_rob_tag_1;
    reg [`ROB_IDX_W - 1 : 0] is3_rob_tag_2;
    reg [`ROB_IDX_W - 1 : 0] is3_sq_idx_1;
    reg [`ROB_IDX_W - 1 : 0] is3_sq_idx_2;
    reg [`DWIDTH - 1 : 0] is3_vrs_1;
    reg [`DWIDTH - 1 : 0] is3_vrs_2;
    reg [`DWIDTH - 1 : 0] is3_vrt_1;
    reg [`DWIDTH - 1 : 0] is3_vrt_2;

    assign is3_can_take_1 = !is3_valid_1 || es1_o_ready;
    assign is3_can_take_2 = !is3_valid_2 || es2_o_ready;

    always @(posedge dp_clk or negedge dp_rstn) begin
        if (!dp_rstn) begin
            is3_valid_1 <= 1'b0;
            is3_valid_2 <= 1'b0;
            is3_pc_1 <= {`PC_WIDTH{1'b0}};
            is3_pc_2 <= {`PC_WIDTH{1'b0}};
            is3_opcode_1 <= {`OPCODE_WIDTH{1'b0}};
            is3_opcode_2 <= {`OPCODE_WIDTH{1'b0}};
            is3_funct3_1 <= {`FUNCT3_WIDTH{1'b0}};
            is3_funct3_2 <= {`FUNCT3_WIDTH{1'b0}};
            is3_funct7_1 <= {`FUNCT7_WIDTH{1'b0}};
            is3_funct7_2 <= {`FUNCT7_WIDTH{1'b0}};
            is3_shamt_1 <= {`SHAMT_WIDTH{1'b0}};
            is3_shamt_2 <= {`SHAMT_WIDTH{1'b0}};
            is3_imm_1 <= {`IMM_WIDTH{1'b0}};
            is3_imm_2 <= {`IMM_WIDTH{1'b0}};
            is3_alu_src_1 <= 1'b0;
            is3_alu_src_2 <= 1'b0;
            is3_jal_1 <= 1'b0;
            is3_jal_2 <= 1'b0;
            is3_memwrite_1 <= 1'b0;
            is3_memwrite_2 <= 1'b0;
            is3_memtoreg_1 <= 1'b0;
            is3_memtoreg_2 <= 1'b0;
            is3_regwrite_1 <= 1'b0;
            is3_regwrite_2 <= 1'b0;
            is3_prd_1 <= {`RAT_SIZE{1'b0}};
            is3_prd_2 <= {`RAT_SIZE{1'b0}};
            is3_rob_tag_1 <= {`ROB_IDX_W{1'b0}};
            is3_rob_tag_2 <= {`ROB_IDX_W{1'b0}};
            is3_sq_idx_1 <= {`ROB_IDX_W{1'b0}};
            is3_sq_idx_2 <= {`ROB_IDX_W{1'b0}};
            is3_vrs_1 <= {`DWIDTH{1'b0}};
            is3_vrs_2 <= {`DWIDTH{1'b0}};
            is3_vrt_1 <= {`DWIDTH{1'b0}};
            is3_vrt_2 <= {`DWIDTH{1'b0}};
        end
        else begin
            if (is3_can_take_1) begin
                is3_valid_1 <= rs_o_issue_valid_1;
                if (rs_o_issue_valid_1) begin
                    is3_pc_1 <= rs_o_pc_1;
                    is3_opcode_1 <= rs_o_opcode_1;
                    is3_funct3_1 <= rs_o_funct3_1;
                    is3_funct7_1 <= rs_o_funct7_1;
                    is3_shamt_1 <= rs_o_shamt_1;
                    is3_imm_1 <= rs_o_imm_1;
                    is3_alu_src_1 <= rs_o_alu_src_1;
                    is3_jal_1 <= rs_o_jal_1;
                    is3_memwrite_1 <= rs_o_memwrite_1;
                    is3_memtoreg_1 <= rs_o_memtoreg_1;
                    is3_regwrite_1 <= rs_o_regwrite_1;
                    is3_prd_1 <= rs_o_prd_1;
                    is3_rob_tag_1 <= rs_o_rob_tag_1;
                    is3_sq_idx_1 <= rs_o_sq_idx_1;
                    is3_vrs_1 <= rs_o_vrs_1;
                    is3_vrt_1 <= rs_o_vrt_1;
                end
            end

            if (is3_can_take_2) begin
                is3_valid_2 <= rs_o_issue_valid_2;
                if (rs_o_issue_valid_2) begin
                    is3_pc_2 <= rs_o_pc_2;
                    is3_opcode_2 <= rs_o_opcode_2;
                    is3_funct3_2 <= rs_o_funct3_2;
                    is3_funct7_2 <= rs_o_funct7_2;
                    is3_shamt_2 <= rs_o_shamt_2;
                    is3_imm_2 <= rs_o_imm_2;
                    is3_alu_src_2 <= rs_o_alu_src_2;
                    is3_jal_2 <= rs_o_jal_2;
                    is3_memwrite_2 <= rs_o_memwrite_2;
                    is3_memtoreg_2 <= rs_o_memtoreg_2;
                    is3_regwrite_2 <= rs_o_regwrite_2;
                    is3_prd_2 <= rs_o_prd_2;
                    is3_rob_tag_2 <= rs_o_rob_tag_2;
                    is3_sq_idx_2 <= rs_o_sq_idx_2;
                    is3_vrs_2 <= rs_o_vrs_2;
                    is3_vrt_2 <= rs_o_vrt_2;
                end
            end
        end
    end

    wire es1_o_ce;
    wire es2_o_ce;
    wire es1_o_done;
    wire es2_o_done;
    wire es1_o_change_pc;
    wire es2_o_change_pc;
    wire [`PC_WIDTH - 1 : 0] es1_o_alu_pc;
    wire [`PC_WIDTH - 1 : 0] es2_o_alu_pc;
    wire [`DWIDTH - 1 : 0] es1_o_alu_value;
    wire [`DWIDTH - 1 : 0] es2_o_alu_value;
    wire [`OPCODE_WIDTH - 1 : 0] es1_o_opcode;
    wire [`OPCODE_WIDTH - 1 : 0] es2_o_opcode;
    wire [`ROB_IDX_W - 1 : 0] es1_o_rob_idx;
    wire [`ROB_IDX_W - 1 : 0] es2_o_rob_idx;
    wire [`ROB_IDX_W - 1 : 0] es1_o_sq_idx;
    wire [`ROB_IDX_W - 1 : 0] es2_o_sq_idx;
    wire [`RAT_SIZE - 1 : 0] es1_o_tag;
    wire [`RAT_SIZE - 1 : 0] es2_o_tag;
    wire es1_o_memwrite;
    wire es2_o_memwrite;
    wire es1_o_memtoreg;
    wire es2_o_memtoreg;
    wire es1_o_regwrite;
    wire es2_o_regwrite;
	wire [`FUNCT3_WIDTH - 1 : 0] es1_o_funct3;
	wire [`FUNCT3_WIDTH - 1 : 0] es2_o_funct3;

    execute_stage u_es1 (
        .es_i_clk(dp_clk),
        .es_i_rst(dp_rstn),
        .es_i_ce(is3_valid_1),
        .es_i_jal(is3_jal_1),
        .es_i_alu_src(is3_alu_src_1),
        .es_i_opcode(is3_opcode_1),
        .es_i_funct3(is3_funct3_1),
        .es_i_funct7(is3_funct7_1),
        .es_i_shamt(is3_shamt_1),
        .es_i_data_rs(is3_vrs_1),
        .es_i_data_rt(is3_vrt_1),
        .es_i_imm(is3_imm_1),
        .es_i_pc(is3_pc_1),
        .es_i_rob_idx(is3_rob_tag_1),
        .es_i_sq_idx(is3_sq_idx_1),
        .es_i_tag(is3_prd_1),
        .es_i_memwrite(is3_memwrite_1),
        .es_i_memtoreg(is3_memtoreg_1),
        .es_i_regwrite(is3_regwrite_1),
        .es_o_change_pc(es1_o_change_pc),
        .es_o_alu_pc(es1_o_alu_pc),
        .es_o_alu_value(es1_o_alu_value),
        .es_o_ce(es1_o_ce),
        .es_o_done(es1_o_done),
        .es_o_opcode(es1_o_opcode),
        .es_o_rob_idx(es1_o_rob_idx),
        .es_o_sq_idx(es1_o_sq_idx),
        .es_o_tag(es1_o_tag),
        .es_o_memwrite(es1_o_memwrite),
        .es_o_memtoreg(es1_o_memtoreg),
        .es_o_regwrite(es1_o_regwrite),
        .es_o_funct3(es1_o_funct3),
        .es_o_ready(es1_o_ready)
    );

    execute_stage u_es2 (
        .es_i_clk(dp_clk),
        .es_i_rst(dp_rstn),
        .es_i_ce(is3_valid_2),
        .es_i_jal(is3_jal_2),
        .es_i_alu_src(is3_alu_src_2),
        .es_i_opcode(is3_opcode_2),
        .es_i_funct3(is3_funct3_2),
        .es_i_funct7(is3_funct7_2),
        .es_i_shamt(is3_shamt_2),
        .es_i_data_rs(is3_vrs_2),
        .es_i_data_rt(is3_vrt_2),
        .es_i_imm(is3_imm_2),
        .es_i_pc(is3_pc_2),
        .es_i_rob_idx(is3_rob_tag_2),
        .es_i_sq_idx(is3_sq_idx_2),
        .es_i_tag(is3_prd_2),
        .es_i_memwrite(is3_memwrite_2),
        .es_i_memtoreg(is3_memtoreg_2),
        .es_i_regwrite(is3_regwrite_2),
        .es_o_change_pc(es2_o_change_pc),
        .es_o_alu_pc(es2_o_alu_pc),
        .es_o_alu_value(es2_o_alu_value),
        .es_o_ce(es2_o_ce),
        .es_o_done(es2_o_done),
        .es_o_opcode(es2_o_opcode),
        .es_o_rob_idx(es2_o_rob_idx),
        .es_o_sq_idx(es2_o_sq_idx),
        .es_o_tag(es2_o_tag),
        .es_o_memwrite(es2_o_memwrite),
        .es_o_memtoreg(es2_o_memtoreg),
        .es_o_regwrite(es2_o_regwrite),
        .es_o_funct3(es2_o_funct3),
        .es_o_ready(es2_o_ready)
    );

    // -------------------------------------------------------------------------
    // Stage 5: EX -> SQ/LQ/MEM -> WB / CDB
    // - STORE: payload duoc giu trong store_queue theo sq_idx, chi ghi memory khi commit.
    // - LOAD: address goes through load_queue, checks older stores, then memory/forward.
    // - ALU/STORE completion still goes through MWB.
    // -------------------------------------------------------------------------
    wire [3 : 0] ts1_o_store_mask;
    wire [3 : 0] ts2_o_store_mask;
    wire [`DWIDTH - 1 : 0] ts1_o_store_data;
    wire [`DWIDTH - 1 : 0] ts2_o_store_data;

    treat_store u_ts1 (
        .ts_i_store_data(is3_vrt_1),
        .ts_i_opcode(es1_o_opcode),
        .ts_i_funct_3(is3_funct3_1),
        .ts_o_store_data(ts1_o_store_data),
        .ts_o_store_mask(ts1_o_store_mask)
    );

    treat_store u_ts2 (
        .ts_i_store_data(is3_vrt_2),
        .ts_i_opcode(es2_o_opcode),
        .ts_i_funct_3(is3_funct3_2),
        .ts_o_store_data(ts2_o_store_data),
        .ts_o_store_mask(ts2_o_store_mask)
    );

    reg exm_valid_1;
    reg exm_valid_2;
    reg exm_memwrite_1;
    reg exm_memwrite_2;
    reg exm_memtoreg_1;
    reg exm_memtoreg_2;
    reg exm_regwrite_1;
    reg exm_regwrite_2;
    reg [`ROB_IDX_W - 1 : 0] exm_rob_idx_1;
    reg [`ROB_IDX_W - 1 : 0] exm_rob_idx_2;
    reg [`ROB_IDX_W - 1 : 0] exm_sq_idx_1;
    reg [`ROB_IDX_W - 1 : 0] exm_sq_idx_2;
    reg [`RAT_SIZE - 1 : 0] exm_tag_1;
    reg [`RAT_SIZE - 1 : 0] exm_tag_2;
    reg [`OPCODE_WIDTH - 1 : 0] exm_opcode_1;
    reg [`OPCODE_WIDTH - 1 : 0] exm_opcode_2;
    reg [`FUNCT3_WIDTH - 1 : 0] exm_funct3_1;
    reg [`FUNCT3_WIDTH - 1 : 0] exm_funct3_2;
    reg [`DWIDTH - 1 : 0] exm_alu_value_1;
    reg [`DWIDTH - 1 : 0] exm_alu_value_2;
    reg [`DWIDTH - 1 : 0] exm_store_data_1;
    reg [`DWIDTH - 1 : 0] exm_store_data_2;
    reg [3 : 0] exm_store_mask_1;
    reg [3 : 0] exm_store_mask_2;

    always @(posedge dp_clk or negedge dp_rstn) begin
        if (!dp_rstn) begin
            exm_valid_1 <= 1'b0;
            exm_valid_2 <= 1'b0;
            exm_memwrite_1 <= 1'b0;
            exm_memwrite_2 <= 1'b0;
            exm_memtoreg_1 <= 1'b0;
            exm_memtoreg_2 <= 1'b0;
            exm_regwrite_1 <= 1'b0;
            exm_regwrite_2 <= 1'b0;
            exm_rob_idx_1 <= {`ROB_IDX_W{1'b0}};
            exm_rob_idx_2 <= {`ROB_IDX_W{1'b0}};
            exm_sq_idx_1 <= {`ROB_IDX_W{1'b0}};
            exm_sq_idx_2 <= {`ROB_IDX_W{1'b0}};
            exm_tag_1 <= {`RAT_SIZE{1'b0}};
            exm_tag_2 <= {`RAT_SIZE{1'b0}};
            exm_opcode_1 <= {`OPCODE_WIDTH{1'b0}};
            exm_opcode_2 <= {`OPCODE_WIDTH{1'b0}};
            exm_funct3_1 <= {`FUNCT3_WIDTH{1'b0}};
            exm_funct3_2 <= {`FUNCT3_WIDTH{1'b0}};
            exm_alu_value_1 <= {`DWIDTH{1'b0}};
            exm_alu_value_2 <= {`DWIDTH{1'b0}};
            exm_store_data_1 <= {`DWIDTH{1'b0}};
            exm_store_data_2 <= {`DWIDTH{1'b0}};
            exm_store_mask_1 <= 4'b0;
            exm_store_mask_2 <= 4'b0;
            es_pc_redirect_1 <= 1'b0;
            es_pc_redirect_2 <= 1'b0;
            es_pc_redirect_target_1 <= {`PC_WIDTH{1'b0}};
            es_pc_redirect_target_2 <= {`PC_WIDTH{1'b0}};
        end
        else begin
            exm_valid_1 <= es1_o_ce;
            exm_valid_2 <= es2_o_ce;
            exm_memwrite_1 <= es1_o_memwrite;
            exm_memwrite_2 <= es2_o_memwrite;
            exm_memtoreg_1 <= es1_o_memtoreg;
            exm_memtoreg_2 <= es2_o_memtoreg;
            exm_regwrite_1 <= es1_o_regwrite;
            exm_regwrite_2 <= es2_o_regwrite;
            exm_rob_idx_1 <= es1_o_rob_idx;
            exm_rob_idx_2 <= es2_o_rob_idx;
            exm_sq_idx_1 <= es1_o_sq_idx;
            exm_sq_idx_2 <= es2_o_sq_idx;
            exm_tag_1 <= es1_o_tag;
            exm_tag_2 <= es2_o_tag;
            exm_opcode_1 <= es1_o_opcode;
            exm_opcode_2 <= es2_o_opcode;
            exm_funct3_1 <= es1_o_funct3;
            exm_funct3_2 <= es2_o_funct3;
            exm_alu_value_1 <= es1_o_alu_value;
            exm_alu_value_2 <= es2_o_alu_value;
            exm_store_data_1 <= ts1_o_store_data;
            exm_store_data_2 <= ts2_o_store_data;
            exm_store_mask_1 <= ts1_o_store_mask;
            exm_store_mask_2 <= ts2_o_store_mask;
            // Redirect path (tạm): lane1 ưu tiên lane2.
            es_pc_redirect_1 <= es1_o_change_pc;
            es_pc_redirect_2 <= (~es1_o_change_pc) & es2_o_change_pc;
            es_pc_redirect_target_1 <= es1_o_alu_pc;
            es_pc_redirect_target_2 <= es2_o_alu_pc;
        end
    end

    wire [`DWIDTH - 1 : 0] m_o_load_data_1;
    wire [`DWIDTH - 1 : 0] m_o_load_data_2;
    wire sq_o_mem_ce_1;
    wire sq_o_mem_ce_2;
    wire sq_o_mem_wr_en_1;
    wire sq_o_mem_wr_en_2;
    wire [`DWIDTH - 1 : 0] sq_o_mem_addr_1;
    wire [`DWIDTH - 1 : 0] sq_o_mem_addr_2;
    wire [`DWIDTH - 1 : 0] sq_o_mem_data_1;
    wire [`DWIDTH - 1 : 0] sq_o_mem_data_2;
    wire [3 : 0] sq_o_mem_mask_1;
    wire [3 : 0] sq_o_mem_mask_2;

    wire lq_o_sq_query_valid_1;
    wire lq_o_sq_query_valid_2;
    wire [`ROB_IDX_W - 1 : 0] lq_o_sq_query_ptr_1;
    wire [`ROB_IDX_W - 1 : 0] lq_o_sq_query_ptr_2;
    wire [`DWIDTH - 1 : 0] lq_o_sq_query_addr_1;
    wire [`DWIDTH - 1 : 0] lq_o_sq_query_addr_2;
    wire [3 : 0] lq_o_sq_query_mask_1;
    wire [3 : 0] lq_o_sq_query_mask_2;
    wire [`ROB_IDX_W - 1 : 0] lq_o_sq_query_tail_snapshot_1;
    wire [`ROB_IDX_W - 1 : 0] lq_o_sq_query_tail_snapshot_2;
    wire [`ROB_IDX_W : 0] lq_o_sq_query_older_store_count_1;
    wire [`ROB_IDX_W : 0] lq_o_sq_query_older_store_count_2;
    wire sq_o_load_resp_valid_1;
    wire sq_o_load_resp_valid_2;
    wire [`ROB_IDX_W - 1 : 0] sq_o_load_resp_ptr_1;
    wire [`ROB_IDX_W - 1 : 0] sq_o_load_resp_ptr_2;
    wire sq_o_load_resp_read_mem_1;
    wire sq_o_load_resp_read_mem_2;
    wire sq_o_load_resp_forward_valid_1;
    wire sq_o_load_resp_forward_valid_2;
    wire sq_o_load_resp_wait_1;
    wire sq_o_load_resp_wait_2;
    wire [`DWIDTH - 1 : 0] sq_o_load_resp_forward_data_1;
    wire [`DWIDTH - 1 : 0] sq_o_load_resp_forward_data_2;

    wire lq_o_mem_req_valid_1;
    wire lq_o_mem_req_valid_2;
    wire [`ROB_IDX_W - 1 : 0] lq_o_mem_req_ptr_1;
    wire [`ROB_IDX_W - 1 : 0] lq_o_mem_req_ptr_2;
    wire [`DWIDTH - 1 : 0] lq_o_mem_req_addr_1;
    wire [`DWIDTH - 1 : 0] lq_o_mem_req_addr_2;
    wire lq_i_mem_resp_valid_1;
    wire lq_i_mem_resp_valid_2;
    wire [`ROB_IDX_W - 1 : 0] lq_i_mem_resp_ptr_1;
    wire [`ROB_IDX_W - 1 : 0] lq_i_mem_resp_ptr_2;
    wire [`DWIDTH - 1 : 0] lq_i_mem_resp_data_1;
    wire [`DWIDTH - 1 : 0] lq_i_mem_resp_data_2;

    wire lq_i_complete_accept_1;
    wire lq_i_complete_accept_2;
    wire lq_o_complete_valid_1;
    wire lq_o_complete_valid_2;
    wire [`ROB_IDX_W - 1 : 0] lq_o_complete_rob_tag_1;
    wire [`ROB_IDX_W - 1 : 0] lq_o_complete_rob_tag_2;
    wire [`RAT_SIZE - 1 : 0] lq_o_complete_prd_1;
    wire [`RAT_SIZE - 1 : 0] lq_o_complete_prd_2;
    wire [`FUNCT3_WIDTH - 1 : 0] lq_o_complete_funct3_1;
    wire [`FUNCT3_WIDTH - 1 : 0] lq_o_complete_funct3_2;
    wire [`DWIDTH - 1 : 0] lq_o_complete_raw_data_1;
    wire [`DWIDTH - 1 : 0] lq_o_complete_raw_data_2;

    store_queue u_store_queue (
        .sq_clk(dp_clk),
        .sq_rstn(dp_rstn),
        .sq_i_ce(1'b1),

        .sq_i_alloc_valid_1(sq_alloc_req_1),
        .sq_o_alloc_ptr_1(sq_o_alloc_ptr_1),
        .sq_i_alloc_valid_2(sq_alloc_req_2),
        .sq_o_alloc_ptr_2(sq_o_alloc_ptr_2),

        .sq_i_fill_valid_1(exm_valid_1 && exm_memwrite_1),
        .sq_i_fill_ptr_1(exm_sq_idx_1),
        .sq_i_fill_addr_1(exm_alu_value_1),
        .sq_i_fill_data_1(exm_store_data_1),
        .sq_i_fill_mask_1(exm_store_mask_1),
        .sq_i_fill_valid_2(exm_valid_2 && exm_memwrite_2),
        .sq_i_fill_ptr_2(exm_sq_idx_2),
        .sq_i_fill_addr_2(exm_alu_value_2),
        .sq_i_fill_data_2(exm_store_data_2),
        .sq_i_fill_mask_2(exm_store_mask_2),

        .sq_i_commit_valid_1(rob_o_commit_valid_1 && rob_o_commit_is_store_1),
        .sq_i_commit_ptr_1(rob_o_commit_sq_idx_1),
        .sq_i_commit_valid_2(rob_o_commit_valid_2 && rob_o_commit_is_store_2),
        .sq_i_commit_ptr_2(rob_o_commit_sq_idx_2),

        .sq_o_mem_ce_1(sq_o_mem_ce_1),
        .sq_o_mem_wr_en_1(sq_o_mem_wr_en_1),
        .sq_o_mem_addr_1(sq_o_mem_addr_1),
        .sq_o_mem_data_1(sq_o_mem_data_1),
        .sq_o_mem_mask_1(sq_o_mem_mask_1),
        .sq_o_mem_ce_2(sq_o_mem_ce_2),
        .sq_o_mem_wr_en_2(sq_o_mem_wr_en_2),
        .sq_o_mem_addr_2(sq_o_mem_addr_2),
        .sq_o_mem_data_2(sq_o_mem_data_2),
        .sq_o_mem_mask_2(sq_o_mem_mask_2),

        .sq_i_load_query_valid_1(lq_o_sq_query_valid_1),
        .sq_i_load_query_ptr_1(lq_o_sq_query_ptr_1),
        .sq_i_load_query_addr_1(lq_o_sq_query_addr_1),
        .sq_i_load_query_mask_1(lq_o_sq_query_mask_1),
        .sq_i_load_query_tail_snapshot_1(lq_o_sq_query_tail_snapshot_1),
        .sq_i_load_query_older_store_count_1(lq_o_sq_query_older_store_count_1),
        .sq_o_load_resp_valid_1(sq_o_load_resp_valid_1),
        .sq_o_load_resp_ptr_1(sq_o_load_resp_ptr_1),
        .sq_o_load_resp_read_mem_1(sq_o_load_resp_read_mem_1),
        .sq_o_load_resp_forward_valid_1(sq_o_load_resp_forward_valid_1),
        .sq_o_load_resp_wait_1(sq_o_load_resp_wait_1),
        .sq_o_load_resp_forward_data_1(sq_o_load_resp_forward_data_1),
        .sq_i_load_query_valid_2(lq_o_sq_query_valid_2),
        .sq_i_load_query_ptr_2(lq_o_sq_query_ptr_2),
        .sq_i_load_query_addr_2(lq_o_sq_query_addr_2),
        .sq_i_load_query_mask_2(lq_o_sq_query_mask_2),
        .sq_i_load_query_tail_snapshot_2(lq_o_sq_query_tail_snapshot_2),
        .sq_i_load_query_older_store_count_2(lq_o_sq_query_older_store_count_2),
        .sq_o_load_resp_valid_2(sq_o_load_resp_valid_2),
        .sq_o_load_resp_ptr_2(sq_o_load_resp_ptr_2),
        .sq_o_load_resp_read_mem_2(sq_o_load_resp_read_mem_2),
        .sq_o_load_resp_forward_valid_2(sq_o_load_resp_forward_valid_2),
        .sq_o_load_resp_wait_2(sq_o_load_resp_wait_2),
        .sq_o_load_resp_forward_data_2(sq_o_load_resp_forward_data_2),

        .sq_o_count(sq_o_count),
        .sq_o_tail_ptr(sq_o_tail_ptr)
    );

    load_queue u_load_queue (
        .lq_clk(dp_clk),
        .lq_rstn(dp_rstn),
        .lq_i_ce(1'b1),

        .lq_i_alloc_valid_1(lq_alloc_req_1),
        .lq_i_alloc_sq_tail_snapshot_1(lq_alloc_sq_tail_snapshot_1),
        .lq_i_alloc_older_store_count_1(lq_alloc_older_store_count_1),
        .lq_o_alloc_ptr_1(lq_o_alloc_ptr_1),
        .lq_i_alloc_valid_2(lq_alloc_req_2),
        .lq_i_alloc_sq_tail_snapshot_2(lq_alloc_sq_tail_snapshot_2),
        .lq_i_alloc_older_store_count_2(lq_alloc_older_store_count_2),
        .lq_o_alloc_ptr_2(lq_o_alloc_ptr_2),

        .lq_i_exec_valid_1(exm_valid_1 && exm_memtoreg_1),
        .lq_i_exec_ptr_1(exm_sq_idx_1),
        .lq_i_exec_rob_tag_1(exm_rob_idx_1),
        .lq_i_exec_prd_1(exm_tag_1),
        .lq_i_exec_funct3_1(exm_funct3_1),
        .lq_i_exec_addr_1(exm_alu_value_1),
        .lq_i_exec_valid_2(exm_valid_2 && exm_memtoreg_2),
        .lq_i_exec_ptr_2(exm_sq_idx_2),
        .lq_i_exec_rob_tag_2(exm_rob_idx_2),
        .lq_i_exec_prd_2(exm_tag_2),
        .lq_i_exec_funct3_2(exm_funct3_2),
        .lq_i_exec_addr_2(exm_alu_value_2),

        .lq_o_sq_query_valid_1(lq_o_sq_query_valid_1),
        .lq_o_sq_query_ptr_1(lq_o_sq_query_ptr_1),
        .lq_o_sq_query_addr_1(lq_o_sq_query_addr_1),
        .lq_o_sq_query_mask_1(lq_o_sq_query_mask_1),
        .lq_o_sq_query_tail_snapshot_1(lq_o_sq_query_tail_snapshot_1),
        .lq_o_sq_query_older_store_count_1(lq_o_sq_query_older_store_count_1),
        .lq_o_sq_query_valid_2(lq_o_sq_query_valid_2),
        .lq_o_sq_query_ptr_2(lq_o_sq_query_ptr_2),
        .lq_o_sq_query_addr_2(lq_o_sq_query_addr_2),
        .lq_o_sq_query_mask_2(lq_o_sq_query_mask_2),
        .lq_o_sq_query_tail_snapshot_2(lq_o_sq_query_tail_snapshot_2),
        .lq_o_sq_query_older_store_count_2(lq_o_sq_query_older_store_count_2),

        .lq_i_sq_resp_valid_1(sq_o_load_resp_valid_1),
        .lq_i_sq_resp_ptr_1(sq_o_load_resp_ptr_1),
        .lq_i_sq_resp_read_mem_1(sq_o_load_resp_read_mem_1),
        .lq_i_sq_resp_forward_valid_1(sq_o_load_resp_forward_valid_1),
        .lq_i_sq_resp_wait_1(sq_o_load_resp_wait_1),
        .lq_i_sq_resp_forward_data_1(sq_o_load_resp_forward_data_1),
        .lq_i_sq_resp_valid_2(sq_o_load_resp_valid_2),
        .lq_i_sq_resp_ptr_2(sq_o_load_resp_ptr_2),
        .lq_i_sq_resp_read_mem_2(sq_o_load_resp_read_mem_2),
        .lq_i_sq_resp_forward_valid_2(sq_o_load_resp_forward_valid_2),
        .lq_i_sq_resp_wait_2(sq_o_load_resp_wait_2),
        .lq_i_sq_resp_forward_data_2(sq_o_load_resp_forward_data_2),

        .lq_o_mem_req_valid_1(lq_o_mem_req_valid_1),
        .lq_o_mem_req_ptr_1(lq_o_mem_req_ptr_1),
        .lq_o_mem_req_addr_1(lq_o_mem_req_addr_1),
        .lq_o_mem_req_valid_2(lq_o_mem_req_valid_2),
        .lq_o_mem_req_ptr_2(lq_o_mem_req_ptr_2),
        .lq_o_mem_req_addr_2(lq_o_mem_req_addr_2),
        .lq_i_mem_resp_valid_1(lq_i_mem_resp_valid_1),
        .lq_i_mem_resp_ptr_1(lq_i_mem_resp_ptr_1),
        .lq_i_mem_resp_data_1(lq_i_mem_resp_data_1),
        .lq_i_mem_resp_valid_2(lq_i_mem_resp_valid_2),
        .lq_i_mem_resp_ptr_2(lq_i_mem_resp_ptr_2),
        .lq_i_mem_resp_data_2(lq_i_mem_resp_data_2),

        .lq_i_complete_accept_1(lq_i_complete_accept_1),
        .lq_o_complete_valid_1(lq_o_complete_valid_1),
        .lq_o_complete_rob_tag_1(lq_o_complete_rob_tag_1),
        .lq_o_complete_prd_1(lq_o_complete_prd_1),
        .lq_o_complete_funct3_1(lq_o_complete_funct3_1),
        .lq_o_complete_raw_data_1(lq_o_complete_raw_data_1),
        .lq_i_complete_accept_2(lq_i_complete_accept_2),
        .lq_o_complete_valid_2(lq_o_complete_valid_2),
        .lq_o_complete_rob_tag_2(lq_o_complete_rob_tag_2),
        .lq_o_complete_prd_2(lq_o_complete_prd_2),
        .lq_o_complete_funct3_2(lq_o_complete_funct3_2),
        .lq_o_complete_raw_data_2(lq_o_complete_raw_data_2),

        .lq_i_commit_valid_1(rob_o_commit_valid_1 && rob_o_commit_is_load_1),
        .lq_i_commit_ptr_1(rob_o_commit_ld_idx_1),
        .lq_i_commit_valid_2(rob_o_commit_valid_2 && rob_o_commit_is_load_2),
        .lq_i_commit_ptr_2(rob_o_commit_ld_idx_2),

        .lq_o_count(lq_o_count)
    );
    wire lq_mem_req_fire_1 = lq_o_mem_req_valid_1 && !sq_o_mem_ce_1;
    wire lq_mem_req_fire_2 = lq_o_mem_req_valid_2 && !sq_o_mem_ce_2;
    assign lq_i_mem_resp_valid_1 = lq_mem_req_fire_1;
    assign lq_i_mem_resp_valid_2 = lq_mem_req_fire_2;
    assign lq_i_mem_resp_ptr_1 = lq_o_mem_req_ptr_1;
    assign lq_i_mem_resp_ptr_2 = lq_o_mem_req_ptr_2;
    assign lq_i_mem_resp_data_1 = m_o_load_data_1;
    assign lq_i_mem_resp_data_2 = m_o_load_data_2;

    wire mem_i_ce_1 = sq_o_mem_ce_1 || lq_mem_req_fire_1;
    wire mem_i_wr_en_1 = sq_o_mem_wr_en_1;
    wire [`DWIDTH - 1 : 0] mem_i_addr_1 =
        sq_o_mem_ce_1 ? sq_o_mem_addr_1 : lq_o_mem_req_addr_1;
    wire [`DWIDTH - 1 : 0] mem_i_store_data_1 =
        sq_o_mem_ce_1 ? sq_o_mem_data_1 : {`DWIDTH{1'b0}};
    wire [3 : 0] mem_i_store_mask_1 =
        sq_o_mem_ce_1 ? sq_o_mem_mask_1 : 4'b0;

    wire mem_i_ce_2 = sq_o_mem_ce_2 || lq_mem_req_fire_2;
    wire mem_i_wr_en_2 = sq_o_mem_wr_en_2;
    wire [`DWIDTH - 1 : 0] mem_i_addr_2 =
        sq_o_mem_ce_2 ? sq_o_mem_addr_2 : lq_o_mem_req_addr_2;
    wire [`DWIDTH - 1 : 0] mem_i_store_data_2 =
        sq_o_mem_ce_2 ? sq_o_mem_data_2 : {`DWIDTH{1'b0}};
    wire [3 : 0] mem_i_store_mask_2 =
        sq_o_mem_ce_2 ? sq_o_mem_mask_2 : 4'b0;

    memory u_mem (
        .m_clk(dp_clk),
        .m_rst(dp_rstn),
        .m_i_ce_1(mem_i_ce_1),
        .m_i_wr_en_1(mem_i_wr_en_1),
        .m_i_store_data_1(mem_i_store_data_1),
        .m_i_store_mask_1(mem_i_store_mask_1),
        .m_i_alu_value_1(mem_i_addr_1),
        .m_o_load_data_1(m_o_load_data_1),
        .m_i_ce_2(mem_i_ce_2),
        .m_i_wr_en_2(mem_i_wr_en_2),
        .m_i_store_data_2(mem_i_store_data_2),
        .m_i_store_mask_2(mem_i_store_mask_2),
        .m_i_alu_value_2(mem_i_addr_2),
        .m_o_load_data_2(m_o_load_data_2)
    );

    wire [`DWIDTH - 1 : 0] tl1_o_load_data;
    wire [`DWIDTH - 1 : 0] tl2_o_load_data;

    treat_load u_tl1 (
        .tl_i_load_data(lq_o_complete_raw_data_1),
        .tl_i_opcode(`LOAD),
        .tl_i_funct_3(lq_o_complete_funct3_1),
        .tl_o_load_data(tl1_o_load_data)
    );

    treat_load u_tl2 (
        .tl_i_load_data(lq_o_complete_raw_data_2),
        .tl_i_opcode(`LOAD),
        .tl_i_funct_3(lq_o_complete_funct3_2),
        .tl_o_load_data(tl2_o_load_data)
    );

    reg mwb_valid_1;
    reg mwb_valid_2;
    reg mwb_regwrite_1;
    reg mwb_regwrite_2;
    reg [`ROB_IDX_W - 1 : 0] mwb_rob_idx_1;
    reg [`ROB_IDX_W - 1 : 0] mwb_rob_idx_2;
    reg [`RAT_SIZE - 1 : 0] mwb_tag_1;
    reg [`RAT_SIZE - 1 : 0] mwb_tag_2;
    reg [`OPCODE_WIDTH - 1 : 0] mwb_opcode_1;
    reg [`OPCODE_WIDTH - 1 : 0] mwb_opcode_2;
    reg [`DWIDTH - 1 : 0] mwb_alu_value_1;
    reg [`DWIDTH - 1 : 0] mwb_alu_value_2;

    always @(posedge dp_clk or negedge dp_rstn) begin
        if (!dp_rstn) begin
            mwb_valid_1 <= 1'b0;
            mwb_valid_2 <= 1'b0;
            mwb_regwrite_1 <= 1'b0;
            mwb_regwrite_2 <= 1'b0;
            mwb_rob_idx_1 <= {`ROB_IDX_W{1'b0}};
            mwb_rob_idx_2 <= {`ROB_IDX_W{1'b0}};
            mwb_tag_1 <= {`RAT_SIZE{1'b0}};
            mwb_tag_2 <= {`RAT_SIZE{1'b0}};
            mwb_opcode_1 <= {`OPCODE_WIDTH{1'b0}};
            mwb_opcode_2 <= {`OPCODE_WIDTH{1'b0}};
            mwb_alu_value_1 <= {`DWIDTH{1'b0}};
            mwb_alu_value_2 <= {`DWIDTH{1'b0}};
        end
        else begin
            mwb_valid_1 <= exm_valid_1 && !exm_memtoreg_1;
            mwb_valid_2 <= exm_valid_2 && !exm_memtoreg_2;
            mwb_regwrite_1 <= exm_regwrite_1 && !exm_memtoreg_1;
            mwb_regwrite_2 <= exm_regwrite_2 && !exm_memtoreg_2;
            mwb_rob_idx_1 <= exm_rob_idx_1;
            mwb_rob_idx_2 <= exm_rob_idx_2;
            mwb_tag_1 <= exm_tag_1;
            mwb_tag_2 <= exm_tag_2;
            mwb_opcode_1 <= exm_opcode_1;
            mwb_opcode_2 <= exm_opcode_2;
            mwb_alu_value_1 <= exm_alu_value_1;
            mwb_alu_value_2 <= exm_alu_value_2;
        end
    end

    // Wakeup policy:
    // Use registered EXM wakeup for non-load register producers. This is early
    // enough for RAW forwarding, but still avoids a direct execute -> RS path.
    assign rs_wakeup_es_valid_1 = exm_valid_1 && exm_regwrite_1 && !exm_memtoreg_1 &&
                                  (exm_tag_1 != {`RAT_SIZE{1'b0}});
    assign rs_wakeup_es_valid_2 = exm_valid_2 && exm_regwrite_2 && !exm_memtoreg_2 &&
                                  (exm_tag_2 != {`RAT_SIZE{1'b0}});
    assign rs_wakeup_es_prd_1 = exm_tag_1;
    assign rs_wakeup_es_prd_2 = exm_tag_2;
    assign rs_wakeup_es_data_1 = exm_alu_value_1;
    assign rs_wakeup_es_data_2 = exm_alu_value_2;
    assign rs_wakeup_es_opcode_1 = exm_opcode_1;
    assign rs_wakeup_es_opcode_2 = exm_opcode_2;

    // Completion arbitration:
    // - MWB carries ALU/STORE completions.
    // - Load Queue carries LOAD completions after SQ check + memory/forward.
    // Keep two ROB completion ports and let LQ retry if both ports are busy.
    wire cpl1_from_pipe1 = mwb_valid_1;
    wire cpl1_from_pipe2 = !mwb_valid_1 && mwb_valid_2;
    wire cpl1_from_lq1 = !mwb_valid_1 && !mwb_valid_2 && lq_o_complete_valid_1;
    wire cpl1_from_lq2 = !mwb_valid_1 && !mwb_valid_2 &&
                         !lq_o_complete_valid_1 && lq_o_complete_valid_2;

    wire one_pipe_cpl = mwb_valid_1 ^ mwb_valid_2;
    wire cpl2_from_pipe2 = mwb_valid_1 && mwb_valid_2;
    wire cpl2_from_lq1 = one_pipe_cpl && lq_o_complete_valid_1;
    wire cpl2_from_lq2 = (one_pipe_cpl && !lq_o_complete_valid_1 &&
                          lq_o_complete_valid_2) ||
                         (!mwb_valid_1 && !mwb_valid_2 &&
                          lq_o_complete_valid_1 && lq_o_complete_valid_2);

    assign lq_i_complete_accept_1 = cpl1_from_lq1 || cpl2_from_lq1;
    assign lq_i_complete_accept_2 = cpl1_from_lq2 || cpl2_from_lq2;

    wire cpl_valid_1 = cpl1_from_pipe1 || cpl1_from_pipe2 ||
                        cpl1_from_lq1 || cpl1_from_lq2;
    wire cpl_valid_2 = cpl2_from_pipe2 || cpl2_from_lq1 || cpl2_from_lq2;

    wire [`ROB_IDX_W - 1 : 0] cpl_tag_1 =
        cpl1_from_pipe1 ? mwb_rob_idx_1 :
        cpl1_from_pipe2 ? mwb_rob_idx_2 :
        cpl1_from_lq1   ? lq_o_complete_rob_tag_1 :
        cpl1_from_lq2   ? lq_o_complete_rob_tag_2 : {`ROB_IDX_W{1'b0}};

    wire [`ROB_IDX_W - 1 : 0] cpl_tag_2 =
        cpl2_from_pipe2 ? mwb_rob_idx_2 :
        cpl2_from_lq1   ? lq_o_complete_rob_tag_1 :
        cpl2_from_lq2   ? lq_o_complete_rob_tag_2 : {`ROB_IDX_W{1'b0}};

    wire [`RAT_SIZE - 1 : 0] cpl_prd_1 =
        cpl1_from_pipe1 ? mwb_tag_1 :
        cpl1_from_pipe2 ? mwb_tag_2 :
        cpl1_from_lq1   ? lq_o_complete_prd_1 :
        cpl1_from_lq2   ? lq_o_complete_prd_2 : {`RAT_SIZE{1'b0}};

    wire [`RAT_SIZE - 1 : 0] cpl_prd_2 =
        cpl2_from_pipe2 ? mwb_tag_2 :
        cpl2_from_lq1   ? lq_o_complete_prd_1 :
        cpl2_from_lq2   ? lq_o_complete_prd_2 : {`RAT_SIZE{1'b0}};

    wire [`DWIDTH - 1 : 0] cpl_data_1 =
        cpl1_from_pipe1 ? mwb_alu_value_1 :
        cpl1_from_pipe2 ? mwb_alu_value_2 :
        cpl1_from_lq1   ? tl1_o_load_data :
        cpl1_from_lq2   ? tl2_o_load_data : {`DWIDTH{1'b0}};

    wire [`DWIDTH - 1 : 0] cpl_data_2 =
        cpl2_from_pipe2 ? mwb_alu_value_2 :
        cpl2_from_lq1   ? tl1_o_load_data :
        cpl2_from_lq2   ? tl2_o_load_data : {`DWIDTH{1'b0}};

    wire cpl_regwrite_1 =
        cpl1_from_pipe1 ? mwb_regwrite_1 :
        cpl1_from_pipe2 ? mwb_regwrite_2 :
        (cpl1_from_lq1 || cpl1_from_lq2);

    wire cpl_regwrite_2 =
        cpl2_from_pipe2 ? mwb_regwrite_2 :
        (cpl2_from_lq1 || cpl2_from_lq2);

    wire [`OPCODE_WIDTH - 1 : 0] cpl_opcode_1 =
        cpl1_from_pipe1 ? mwb_opcode_1 :
        cpl1_from_pipe2 ? mwb_opcode_2 :
        (cpl1_from_lq1 || cpl1_from_lq2) ? `LOAD : {`OPCODE_WIDTH{1'b0}};

    wire [`OPCODE_WIDTH - 1 : 0] cpl_opcode_2 =
        cpl2_from_pipe2 ? mwb_opcode_2 :
        (cpl2_from_lq1 || cpl2_from_lq2) ? `LOAD : {`OPCODE_WIDTH{1'b0}};

    assign dp_o_data_1 = cpl_data_1;
    assign dp_o_data_2 = cpl_data_2;

    // Completion wakeup is the later fallback path. LOAD data arrives here after
    // Load Queue/treat_load, while ALU/MUL/DIV may also repeat here harmlessly.
    assign rs_wakeup_mem_valid_1 = cpl_valid_1 && cpl_regwrite_1 &&
                                   (cpl_prd_1 != {`RAT_SIZE{1'b0}});
    assign rs_wakeup_mem_valid_2 = cpl_valid_2 && cpl_regwrite_2 &&
                                   (cpl_prd_2 != {`RAT_SIZE{1'b0}});
    assign rs_wakeup_mem_prd_1 = cpl_prd_1;
    assign rs_wakeup_mem_prd_2 = cpl_prd_2;
    assign rs_wakeup_mem_data_1 = cpl_data_1;
    assign rs_wakeup_mem_data_2 = cpl_data_2;
    assign rs_wakeup_mem_opcode_1 = cpl_opcode_1;
    assign rs_wakeup_mem_opcode_2 = cpl_opcode_2;

    // -------------------------------------------------------------------------
    // Stage 6: ROB + Commit (ảo)
    // -------------------------------------------------------------------------
    wire [`DWIDTH - 1 : 0] rob_o_commit_data_1;
    wire [`DWIDTH - 1 : 0] rob_o_commit_data_2;
    wire rob_o_wb_valid_1;
    wire rob_o_wb_valid_2;
    wire [`RAT_SIZE - 1 : 0] rob_o_wb_prd_1;
    wire [`RAT_SIZE - 1 : 0] rob_o_wb_prd_2;
    wire [`DWIDTH - 1 : 0] rob_o_wb_data_1;
    wire [`DWIDTH - 1 : 0] rob_o_wb_data_2;
	ROB u_rob (
		.rob_clk(dp_clk),
		.rob_rstn(dp_rstn),
		.rob_i_ce(1'b1),

		.rob_i_alloc_valid_1(rob_alloc_req_1),
		.rob_i_alloc_arch_rd_1(ru_rs_memwrite_1 ? {`AWIDTH{1'b0}} : ru_rs_addr_rd_1),
		.rob_i_alloc_new_prd_1(ru_rs_new_prd_1),
		.rob_i_alloc_old_prd_1(ru_rs_old_prd_1),
		.rob_i_alloc_is_store_1(ru_rs_memwrite_1),
		.rob_i_alloc_sq_idx_1(dispatch_sq_idx_1),
		.rob_i_alloc_is_load_1(ru_rs_memtoreg_1),
		.rob_i_alloc_ld_idx_1(dispatch_ld_idx_1),
		.rob_o_alloc_fire_1(rob_o_alloc_fire_1),
		.rob_o_alloc_tag_1(rob_o_alloc_tag_1),

		.rob_i_alloc_valid_2(rob_alloc_req_2),
		.rob_i_alloc_arch_rd_2(ru_rs_memwrite_2 ? {`AWIDTH{1'b0}} : ru_rs_addr_rd_2),
		.rob_i_alloc_new_prd_2(ru_rs_new_prd_2),
		.rob_i_alloc_old_prd_2(ru_rs_old_prd_2),
		.rob_i_alloc_is_store_2(ru_rs_memwrite_2),
		.rob_i_alloc_sq_idx_2(dispatch_sq_idx_2),
		.rob_i_alloc_is_load_2(ru_rs_memtoreg_2),
		.rob_i_alloc_ld_idx_2(dispatch_ld_idx_2),
		.rob_o_alloc_fire_2(rob_o_alloc_fire_2),
		.rob_o_alloc_tag_2(rob_o_alloc_tag_2),

        // ROB complete/update đi theo rob_idx xuyên pipeline.
        .rob_i_cpl_valid_1(cpl_valid_1),
        .rob_i_cpl_tag_1(cpl_tag_1),
        .rob_i_cpl_data_1(cpl_data_1),
        .rob_i_cpl_valid_2(cpl_valid_2),
        .rob_i_cpl_tag_2(cpl_tag_2),
        .rob_i_cpl_data_2(cpl_data_2),

        .rob_o_wb_valid_1(rob_o_wb_valid_1),
        .rob_o_wb_prd_1(rob_o_wb_prd_1),
        .rob_o_wb_data_1(rob_o_wb_data_1),
        .rob_o_wb_valid_2(rob_o_wb_valid_2),
        .rob_o_wb_prd_2(rob_o_wb_prd_2),
        .rob_o_wb_data_2(rob_o_wb_data_2),

        .rob_o_commit_valid_1(rob_o_commit_valid_1),
        .rob_o_commit_tag_1(rob_o_commit_tag_1),
        .rob_o_commit_arch_rd_1(rob_o_commit_arch_rd_1),
        .rob_o_commit_is_store_1(rob_o_commit_is_store_1),
        .rob_o_commit_sq_idx_1(rob_o_commit_sq_idx_1),
        .rob_o_commit_is_load_1(rob_o_commit_is_load_1),
        .rob_o_commit_ld_idx_1(rob_o_commit_ld_idx_1),
        .rob_o_rel_prd_1(rob_o_rel_prd_1),
        .rob_o_commit_data_1(rob_o_commit_data_1),
        .rob_o_commit_valid_2(rob_o_commit_valid_2),
        .rob_o_commit_tag_2(rob_o_commit_tag_2),
        .rob_o_commit_arch_rd_2(rob_o_commit_arch_rd_2),
        .rob_o_commit_is_store_2(rob_o_commit_is_store_2),
        .rob_o_commit_sq_idx_2(rob_o_commit_sq_idx_2),
        .rob_o_commit_is_load_2(rob_o_commit_is_load_2),
        .rob_o_commit_ld_idx_2(rob_o_commit_ld_idx_2),
        .rob_o_rel_prd_2(rob_o_rel_prd_2),
        .rob_o_commit_data_2(rob_o_commit_data_2),
        .rob_o_rel_valid_1(rob_o_rel_valid_1),
        .rob_o_rel_valid_2(rob_o_rel_valid_2),
        .rob_o_full(),
        .rob_o_can_alloc_1(rob_o_can_alloc_1),
        .rob_o_can_alloc_2(rob_o_can_alloc_2)
    );

    // WB mirror tu ROB:
    // ROB cung cap dung new_prd cua entry da complete de PRF writeback chinh xac.
    assign wb_valid_1 = rob_o_wb_valid_1 & cpl_regwrite_1;
    assign wb_valid_2 = rob_o_wb_valid_2 & cpl_regwrite_2;
    assign wb_tag_1 = rob_o_wb_prd_1;
    assign wb_tag_2 = rob_o_wb_prd_2;
    assign wb_data_1 = rob_o_wb_data_1;
    assign wb_data_2 = rob_o_wb_data_2;

    // ARF committed view (addr/data đến trực tiếp từ ROB commit).
    ARF u_arf (
        .ar_clk(dp_clk),
        .ar_rstn(dp_rstn),
        .ar_display_addr_1(dp_i_arf_display_addr_1),
        .ar_display_data_1(dp_o_arf_display_data_1),
        .ar_display_addr_2(dp_i_arf_display_addr_2),
        .ar_display_data_2(dp_o_arf_display_data_2),
        .ar_commit_we_1(rob_o_commit_valid_1),
        .ar_commit_addr_1(rob_o_commit_arch_rd_1),
        .ar_commit_data_1(rob_o_commit_data_1),
        .ar_commit_we_2(rob_o_commit_valid_2),
        .ar_commit_addr_2(rob_o_commit_arch_rd_2),
        .ar_commit_data_2(rob_o_commit_data_2)
    );
endmodule