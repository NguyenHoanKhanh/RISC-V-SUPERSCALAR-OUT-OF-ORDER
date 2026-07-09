`include "header_nomul.vh"
`timescale 1ns/1ps
module reservation_station (
    input rs_clk,
    input rs_rstn,
    input rs_i_ce,
    input rs_i_flush,
    input [`ROB_IDX_W-1:0] rs_i_rob_head_tag,
    output reg rs_o_full,

    input rs_i_issue_accept_1,
    input rs_i_issue_accept_2,

    input                       rs_i_alloc_valid_1,
    input [`PC_WIDTH-1:0]       rs_i_pc_1,
    input [`OPCODE_WIDTH-1:0]   rs_i_opcode_1,
    input [`FUNCT3_WIDTH-1:0]   rs_i_funct3_1,
    input [`FUNCT7_WIDTH-1:0]   rs_i_funct7_1,
    input [`SHAMT_WIDTH-1:0]    rs_i_shamt_1,
    input [`IMM_WIDTH-1:0]      rs_i_imm_1,
    input                       rs_i_alu_src_1,
    input                       rs_i_jal_1,
    input                       rs_i_memwrite_1,
    input                       rs_i_memtoreg_1,
    input                       rs_i_regwrite_1,
    input [`RAT_SIZE-1:0]       rs_i_prs_1,
    input [`RAT_SIZE-1:0]       rs_i_prt_1,
    input                       rs_i_prs_ready_1,
    input                       rs_i_prt_ready_1,
    input [`RAT_SIZE-1:0]       rs_i_prd_1,
    input [`ROB_IDX_W-1:0]      rs_i_rob_tag_1,
    input [`ROB_IDX_W-1:0]      rs_i_sq_idx_1,
    input [`DWIDTH-1:0]         rs_i_data_rs_1,
    input [`DWIDTH-1:0]         rs_i_data_rt_1,

    input                       rs_i_alloc_valid_2,
    input [`PC_WIDTH-1:0]       rs_i_pc_2,
    input [`OPCODE_WIDTH-1:0]   rs_i_opcode_2,
    input [`FUNCT3_WIDTH-1:0]   rs_i_funct3_2,
    input [`FUNCT7_WIDTH-1:0]   rs_i_funct7_2,
    input [`SHAMT_WIDTH-1:0]    rs_i_shamt_2,
    input [`IMM_WIDTH-1:0]      rs_i_imm_2,
    input                       rs_i_alu_src_2,
    input                       rs_i_jal_2,
    input                       rs_i_memwrite_2,
    input                       rs_i_memtoreg_2,
    input                       rs_i_regwrite_2,
    input [`RAT_SIZE-1:0]       rs_i_prs_2,
    input [`RAT_SIZE-1:0]       rs_i_prt_2,
    input                       rs_i_prs_ready_2,
    input                       rs_i_prt_ready_2,
    input [`RAT_SIZE-1:0]       rs_i_prd_2,
    input [`ROB_IDX_W-1:0]      rs_i_rob_tag_2,
    input [`ROB_IDX_W-1:0]      rs_i_sq_idx_2,
    input [`DWIDTH-1:0]         rs_i_data_rs_2,
    input [`DWIDTH-1:0]         rs_i_data_rt_2,

    input                       rs_i_es_valid_1,
    input [`RAT_SIZE-1:0]       rs_i_es_prd_1,
    input [`DWIDTH-1:0]         rs_i_es_data_1,
    input [`OPCODE_WIDTH-1:0]   rs_i_es_opcode_1,
    input                       rs_i_es_valid_2,
    input [`RAT_SIZE-1:0]       rs_i_es_prd_2,
    input [`DWIDTH-1:0]         rs_i_es_data_2,
    input [`OPCODE_WIDTH-1:0]   rs_i_es_opcode_2,

    input                       rs_i_mem_valid_1,
    input [`RAT_SIZE-1:0]       rs_i_mem_prd_1,
    input [`DWIDTH-1:0]         rs_i_mem_data_1,
    input [`OPCODE_WIDTH-1:0]   rs_i_mem_opcode_1,
    input                       rs_i_mem_valid_2,
    input [`RAT_SIZE-1:0]       rs_i_mem_prd_2,
    input [`DWIDTH-1:0]         rs_i_mem_data_2,
    input [`OPCODE_WIDTH-1:0]   rs_i_mem_opcode_2,

    output reg                  rs_o_stall_1,
    output reg                  rs_o_stall_2,
    output reg                  rs_o_has_valid,
    output reg                  rs_o_can_alloc_1,
    output reg                  rs_o_can_alloc_2,

    output reg                  rs_o_issue_valid_1,
    output reg [`PC_WIDTH-1:0]  rs_o_pc_1,
    output reg [`OPCODE_WIDTH-1:0] rs_o_opcode_1,
    output reg [`FUNCT3_WIDTH-1:0] rs_o_funct3_1,
    output reg [`FUNCT7_WIDTH-1:0] rs_o_funct7_1,
    output reg [`SHAMT_WIDTH-1:0]  rs_o_shamt_1,
    output reg [`IMM_WIDTH-1:0]    rs_o_imm_1,
    output reg                     rs_o_alu_src_1,
    output reg                     rs_o_jal_1,
    output reg                     rs_o_memwrite_1,
    output reg                     rs_o_memtoreg_1,
    output reg                     rs_o_regwrite_1,
    output reg [`RAT_SIZE-1:0]     rs_o_prd_1,
    output reg [`ROB_IDX_W-1:0]    rs_o_rob_tag_1,
    output reg [`ROB_IDX_W-1:0]    rs_o_sq_idx_1,
    output reg [`DWIDTH-1:0]       rs_o_vrs_1,
    output reg [`DWIDTH-1:0]       rs_o_vrt_1,

    output reg                  rs_o_issue_valid_2,
    output reg [`PC_WIDTH-1:0]  rs_o_pc_2,
    output reg [`OPCODE_WIDTH-1:0] rs_o_opcode_2,
    output reg [`FUNCT3_WIDTH-1:0] rs_o_funct3_2,
    output reg [`FUNCT7_WIDTH-1:0] rs_o_funct7_2,
    output reg [`SHAMT_WIDTH-1:0]  rs_o_shamt_2,
    output reg [`IMM_WIDTH-1:0]    rs_o_imm_2,
    output reg                     rs_o_alu_src_2,
    output reg                     rs_o_jal_2,
    output reg                     rs_o_memwrite_2,
    output reg                     rs_o_memtoreg_2,
    output reg                     rs_o_regwrite_2,
    output reg [`RAT_SIZE-1:0]     rs_o_prd_2,
    output reg [`ROB_IDX_W-1:0]    rs_o_rob_tag_2,
    output reg [`ROB_IDX_W-1:0]    rs_o_sq_idx_2,
    output reg [`DWIDTH-1:0]       rs_o_vrs_2,
    output reg [`DWIDTH-1:0]       rs_o_vrt_2,

    input [`RAT_SIZE-1:0]          dbg_entry_idx,
    output reg                     dbg_ent_valid,
    output reg [`RAT_SIZE-1:0]     dbg_ent_prs,
    output reg [`RAT_SIZE-1:0]     dbg_ent_prt,
    output reg                     dbg_ent_rs_ready,
    output reg                     dbg_ent_rt_ready,
    output reg [`DWIDTH-1:0]       dbg_ent_vrs,
    output reg [`DWIDTH-1:0]       dbg_ent_vrt,
    output reg                     dbg_ready_vec
);

    localparam rs_idx_w = $clog2(`RS_SIZE);
    localparam [`PC_WIDTH-1:0] debug_pc84 = 32'h00000084;

    integer idx_c;
    integer idx_s;
    integer idx_dbg;

    reg                        ent_valid    [0:`RS_SIZE-1];
    reg [`PC_WIDTH-1:0]        ent_pc       [0:`RS_SIZE-1];
    reg [`OPCODE_WIDTH-1:0]    ent_opcode   [0:`RS_SIZE-1];
    reg [`FUNCT3_WIDTH-1:0]    ent_funct3   [0:`RS_SIZE-1];
    reg [`FUNCT7_WIDTH-1:0]    ent_funct7   [0:`RS_SIZE-1];
    reg [`SHAMT_WIDTH-1:0]     ent_shamt    [0:`RS_SIZE-1];
    reg [`IMM_WIDTH-1:0]       ent_imm      [0:`RS_SIZE-1];
    reg                        ent_alu_src  [0:`RS_SIZE-1];
    reg                        ent_jal      [0:`RS_SIZE-1];
    reg                        ent_memwrite [0:`RS_SIZE-1];
    reg                        ent_memtoreg [0:`RS_SIZE-1];
    reg                        ent_regwrite [0:`RS_SIZE-1];
    reg [`RAT_SIZE-1:0]        ent_prs      [0:`RS_SIZE-1];
    reg [`RAT_SIZE-1:0]        ent_prt      [0:`RS_SIZE-1];
    reg [`RAT_SIZE-1:0]        ent_prd      [0:`RS_SIZE-1];
    reg [`ROB_IDX_W-1:0]       ent_rob_tag  [0:`RS_SIZE-1];
    reg [`ROB_IDX_W-1:0]       ent_sq_idx   [0:`RS_SIZE-1];

    reg                        ent_has_rs   [0:`RS_SIZE-1];
    reg                        ent_has_rt   [0:`RS_SIZE-1];
    reg                        ent_rs_ready [0:`RS_SIZE-1];
    reg                        ent_rt_ready [0:`RS_SIZE-1];

    reg [`DWIDTH-1:0]          ent_vrs      [0:`RS_SIZE-1];
    reg [`DWIDTH-1:0]          ent_vrt      [0:`RS_SIZE-1];

    reg free1_valid, free2_valid;
    reg [rs_idx_w-1:0] free1_idx, free2_idx;
    reg [`RS_SIZE-1:0] free1_sel, free2_sel;
    reg issue1_valid, issue2_valid;
    reg [`RS_SIZE-1:0] issue1_sel, issue2_sel;
    // Debug mirrors kept for the existing testbench. Datapath logic uses
    // issue*_sel one-hot signals to avoid putting binary idx on the clear path.
    reg [rs_idx_w-1:0] issue1_idx, issue2_idx;
    reg                        ent_ready    [0:`RS_SIZE-1];

    reg lane2_dep_rs_on_lane1;
    reg lane2_dep_rt_on_lane1;

    reg free_vec [0:`RS_SIZE-1];
    reg ready_vec [0:`RS_SIZE-1];

    // debug-only mirrors for waveform visibility. these do not drive rs logic.
    reg dbg_pc84_found;
    reg [rs_idx_w-1:0] dbg_pc84_idx;
    reg [`PC_WIDTH-1:0] dbg_pc84_ent_pc;
    reg [`RAT_SIZE-1:0] dbg_pc84_ent_prs;
    reg [`RAT_SIZE-1:0] dbg_pc84_ent_prt;
    reg dbg_pc84_ent_rs_ready;
    reg dbg_pc84_ent_rt_ready;
    reg [`DWIDTH-1:0] dbg_pc84_ent_vrs;
    reg [`DWIDTH-1:0] dbg_pc84_ent_vrt;
    reg dbg_pc84_ent_valid;

    always @(*) begin
        dbg_pc84_found = 1'b0;
        dbg_pc84_idx = {rs_idx_w{1'b0}};
        dbg_pc84_ent_pc = {`PC_WIDTH{1'b0}};
        dbg_pc84_ent_prs = {`RAT_SIZE{1'b0}};
        dbg_pc84_ent_prt = {`RAT_SIZE{1'b0}};
        dbg_pc84_ent_rs_ready = 1'b0;
        dbg_pc84_ent_rt_ready = 1'b0;
        dbg_pc84_ent_vrs = {`DWIDTH{1'b0}};
        dbg_pc84_ent_vrt = {`DWIDTH{1'b0}};
        dbg_pc84_ent_valid = 1'b0;

        for (idx_dbg = 0; idx_dbg < `RS_SIZE; idx_dbg = idx_dbg + 1) begin
            if (!dbg_pc84_found && ent_valid[idx_dbg] && (ent_pc[idx_dbg] == debug_pc84)) begin
                dbg_pc84_found = 1'b1;
                dbg_pc84_idx = idx_dbg[rs_idx_w-1:0];
                dbg_pc84_ent_pc = ent_pc[idx_dbg];
                dbg_pc84_ent_prs = ent_prs[idx_dbg];
                dbg_pc84_ent_prt = ent_prt[idx_dbg];
                dbg_pc84_ent_rs_ready = ent_rs_ready[idx_dbg];
                dbg_pc84_ent_rt_ready = ent_rt_ready[idx_dbg];
                dbg_pc84_ent_vrs = ent_vrs[idx_dbg];
                dbg_pc84_ent_vrt = ent_vrt[idx_dbg];
                dbg_pc84_ent_valid = ent_valid[idx_dbg];
            end
        end
    end

    function opcode_has_rs;
        input [`OPCODE_WIDTH-1:0] opcode;
        begin
            opcode_has_rs =
                (opcode == `RTYPE) ||
                (opcode == `ITYPE) ||
                (opcode == `LOAD ) ||
                (opcode == `STORE) ||
                (opcode == `BTYPE);
        end
    endfunction

    function opcode_has_rt;
        input [`OPCODE_WIDTH-1:0] opcode;
        begin
            opcode_has_rt =
                (opcode == `RTYPE) ||
                (opcode == `STORE) ||
                (opcode == `BTYPE);
        end
    endfunction

    function match_src;
        input [`RAT_SIZE-1:0] src_tag;
        begin
            match_src =
                (rs_i_es_valid_1  && (src_tag == rs_i_es_prd_1))  ||
                (rs_i_es_valid_2  && (src_tag == rs_i_es_prd_2))  ||
                (rs_i_mem_valid_1 && (src_tag == rs_i_mem_prd_1)) ||
                (rs_i_mem_valid_2 && (src_tag == rs_i_mem_prd_2));
        end
    endfunction

    function [`DWIDTH-1:0] match_src_data;
        input [`RAT_SIZE-1:0] src_tag;
        begin
            if (rs_i_es_valid_1 && (src_tag == rs_i_es_prd_1))
                match_src_data = rs_i_es_data_1;
            else if (rs_i_es_valid_2 && (src_tag == rs_i_es_prd_2))
                match_src_data = rs_i_es_data_2;
            else if (rs_i_mem_valid_1 && (src_tag == rs_i_mem_prd_1))
                match_src_data = rs_i_mem_data_1;
            else if (rs_i_mem_valid_2 && (src_tag == rs_i_mem_prd_2))
                match_src_data = rs_i_mem_data_2;
            else
                match_src_data = {`DWIDTH{1'b0}};
        end
    endfunction

    function dep_rs_on_prd;
        input [`RAT_SIZE-1:0] prs;
        input [`RAT_SIZE-1:0] prd;
        input [`OPCODE_WIDTH-1:0] opcode;
        begin
            dep_rs_on_prd =
                opcode_has_rs(opcode) &&
                (prs != {`RAT_SIZE{1'b0}}) &&
                (prd != {`RAT_SIZE{1'b0}}) &&
                (prs == prd);
        end
    endfunction

    function dep_rt_on_prd;
        input [`RAT_SIZE-1:0] prt;
        input [`RAT_SIZE-1:0] prd;
        input [`OPCODE_WIDTH-1:0] opcode;
        begin
            dep_rt_on_prd =
                opcode_has_rt(opcode) &&
                (prt != {`RAT_SIZE{1'b0}}) &&
                (prd != {`RAT_SIZE{1'b0}}) &&
                (prt == prd);
        end
    endfunction

    always @(*) begin
        free1_valid = 1'b0;
        free2_valid = 1'b0;
        free1_idx = {rs_idx_w{1'b0}};
        free2_idx = {rs_idx_w{1'b0}};
        free1_sel = {`RS_SIZE{1'b0}};
        free2_sel = {`RS_SIZE{1'b0}};
        issue1_valid = 1'b0;
        issue2_valid = 1'b0;
        issue1_sel = {`RS_SIZE{1'b0}};
        issue2_sel = {`RS_SIZE{1'b0}};
        issue1_idx = {rs_idx_w{1'b0}};
        issue2_idx = {rs_idx_w{1'b0}};

        rs_o_stall_1 = 1'b0;
        rs_o_stall_2 = 1'b0;
        rs_o_has_valid = 1'b0;
        rs_o_can_alloc_1 = 1'b0;
        rs_o_can_alloc_2 = 1'b0;
        rs_o_full = 1'b0;

        rs_o_issue_valid_1 = 1'b0;
        rs_o_issue_valid_2 = 1'b0;

        rs_o_pc_1 = {`PC_WIDTH{1'b0}};
        rs_o_pc_2 = {`PC_WIDTH{1'b0}};
        rs_o_opcode_1 = {`OPCODE_WIDTH{1'b0}};
        rs_o_opcode_2 = {`OPCODE_WIDTH{1'b0}};
        rs_o_funct3_1 = {`FUNCT3_WIDTH{1'b0}};
        rs_o_funct3_2 = {`FUNCT3_WIDTH{1'b0}};
        rs_o_funct7_1 = {`FUNCT7_WIDTH{1'b0}};
        rs_o_funct7_2 = {`FUNCT7_WIDTH{1'b0}};
        rs_o_shamt_1 = {`SHAMT_WIDTH{1'b0}};
        rs_o_shamt_2 = {`SHAMT_WIDTH{1'b0}};
        rs_o_imm_1 = {`IMM_WIDTH{1'b0}};
        rs_o_imm_2 = {`IMM_WIDTH{1'b0}};
        rs_o_alu_src_1 = 1'b0;
        rs_o_alu_src_2 = 1'b0;
        rs_o_jal_1 = 1'b0;
        rs_o_jal_2 = 1'b0;
        rs_o_memwrite_1 = 1'b0;
        rs_o_memwrite_2 = 1'b0;
        rs_o_memtoreg_1 = 1'b0;
        rs_o_memtoreg_2 = 1'b0;
        rs_o_regwrite_1 = 1'b0;
        rs_o_regwrite_2 = 1'b0;
        rs_o_prd_1 = {`RAT_SIZE{1'b0}};
        rs_o_prd_2 = {`RAT_SIZE{1'b0}};
        rs_o_rob_tag_1 = {`ROB_IDX_W{1'b0}};
        rs_o_rob_tag_2 = {`ROB_IDX_W{1'b0}};
        rs_o_sq_idx_1 = {`ROB_IDX_W{1'b0}};
        rs_o_sq_idx_2 = {`ROB_IDX_W{1'b0}};
        rs_o_vrs_1 = {`DWIDTH{1'b0}};
        rs_o_vrt_1 = {`DWIDTH{1'b0}};
        rs_o_vrs_2 = {`DWIDTH{1'b0}};
        rs_o_vrt_2 = {`DWIDTH{1'b0}};
        dbg_ent_valid = 1'b0;
        dbg_ent_prs = {`RAT_SIZE{1'b0}};
        dbg_ent_prt = {`RAT_SIZE{1'b0}};
        dbg_ent_rs_ready = 1'b0;
        dbg_ent_rt_ready = 1'b0;
        dbg_ent_vrs = {`DWIDTH{1'b0}};
        dbg_ent_vrt = {`DWIDTH{1'b0}};
        dbg_ready_vec = 1'b0;

        lane2_dep_rs_on_lane1 = 1'b0;
        lane2_dep_rt_on_lane1 = 1'b0;

        for (idx_c = 0; idx_c < `RS_SIZE; idx_c = idx_c + 1) begin
            free_vec[idx_c] = !ent_valid[idx_c];
            ready_vec[idx_c] = ent_valid[idx_c] && ent_ready[idx_c];

            if (ent_valid[idx_c])
                rs_o_has_valid = 1'b1;
            if (free_vec[idx_c]) begin
                if (!free1_valid) begin
                    free1_valid = 1'b1;
                    free1_idx = idx_c[rs_idx_w-1:0];
                    free1_sel[idx_c] = 1'b1;
                end
                else if (!free2_valid) begin
                    free2_valid = 1'b1;
                    free2_idx = idx_c[rs_idx_w-1:0];
                    free2_sel[idx_c] = 1'b1;
                end
            end
        end

        rs_o_can_alloc_1 = free1_valid;
        rs_o_can_alloc_2 = free2_valid;
        rs_o_full = ~free1_valid;

        dbg_ent_valid = ent_valid[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ent_prs = ent_prs[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ent_prt = ent_prt[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ent_rs_ready = ent_rs_ready[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ent_rt_ready = ent_rt_ready[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ent_vrs = ent_vrs[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ent_vrt = ent_vrt[dbg_entry_idx[rs_idx_w-1:0]];
        dbg_ready_vec = ready_vec[dbg_entry_idx[rs_idx_w-1:0]];

        if (rs_i_alloc_valid_1 && !free1_valid)
            rs_o_stall_1 = 1'b1;

        if (rs_i_alloc_valid_2) begin
            if (rs_i_alloc_valid_1) begin
                if (!free2_valid)
                    rs_o_stall_2 = 1'b1;
            end
            else begin
                if (!free1_valid)
                    rs_o_stall_2 = 1'b1;
            end
        end

        if (rs_i_alloc_valid_1 && rs_i_alloc_valid_2) begin
            lane2_dep_rs_on_lane1 = dep_rs_on_prd(rs_i_prs_2, rs_i_prd_1, rs_i_opcode_2);
            lane2_dep_rt_on_lane1 = dep_rt_on_prd(rs_i_prt_2, rs_i_prd_1, rs_i_opcode_2);
        end

        if (rs_i_ce) begin
            for (idx_c = 0; idx_c < `RS_SIZE; idx_c = idx_c + 1) begin
                if (!issue1_valid && ready_vec[idx_c]) begin
                    issue1_valid = 1'b1;
                    issue1_sel[idx_c] = 1'b1;
                    issue1_idx = idx_c[rs_idx_w-1:0];
                    rs_o_pc_1 = ent_pc[idx_c];
                    rs_o_opcode_1 = ent_opcode[idx_c];
                    rs_o_funct3_1 = ent_funct3[idx_c];
                    rs_o_funct7_1 = ent_funct7[idx_c];
                    rs_o_shamt_1 = ent_shamt[idx_c];
                    rs_o_imm_1 = ent_imm[idx_c];
                    rs_o_alu_src_1 = ent_alu_src[idx_c];
                    rs_o_jal_1 = ent_jal[idx_c];
                    rs_o_memwrite_1 = ent_memwrite[idx_c];
                    rs_o_memtoreg_1 = ent_memtoreg[idx_c];
                    rs_o_regwrite_1 = ent_regwrite[idx_c];
                    rs_o_prd_1 = ent_prd[idx_c];
                    rs_o_rob_tag_1 = ent_rob_tag[idx_c];
                    rs_o_sq_idx_1 = ent_sq_idx[idx_c];
                    rs_o_vrs_1 = ent_vrs[idx_c];
                    rs_o_vrt_1 = ent_vrt[idx_c];
                end
            end
        end

        if (rs_i_ce) begin
            for (idx_c = 0; idx_c < `RS_SIZE; idx_c = idx_c + 1) begin
                if (!issue2_valid &&
                    !issue1_sel[idx_c] &&
                    ready_vec[idx_c]) begin
                    issue2_valid = 1'b1;
                    issue2_sel[idx_c] = 1'b1;
                    issue2_idx = idx_c[rs_idx_w-1:0];
                    rs_o_pc_2 = ent_pc[idx_c];
                    rs_o_opcode_2 = ent_opcode[idx_c];
                    rs_o_funct3_2 = ent_funct3[idx_c];
                    rs_o_funct7_2 = ent_funct7[idx_c];
                    rs_o_shamt_2 = ent_shamt[idx_c];
                    rs_o_imm_2 = ent_imm[idx_c];
                    rs_o_alu_src_2 = ent_alu_src[idx_c];
                    rs_o_jal_2 = ent_jal[idx_c];
                    rs_o_memwrite_2 = ent_memwrite[idx_c];
                    rs_o_memtoreg_2 = ent_memtoreg[idx_c];
                    rs_o_regwrite_2 = ent_regwrite[idx_c];
                    rs_o_prd_2 = ent_prd[idx_c];
                    rs_o_rob_tag_2 = ent_rob_tag[idx_c];
                    rs_o_sq_idx_2 = ent_sq_idx[idx_c];
                    rs_o_vrs_2 = ent_vrs[idx_c];
                    rs_o_vrt_2 = ent_vrt[idx_c];
                end
            end
        end

        rs_o_issue_valid_1 = issue1_valid;
        rs_o_issue_valid_2 = issue2_valid;
    end

    always @(posedge rs_clk or negedge rs_rstn) begin
        if (!rs_rstn) begin
            for (idx_s = 0; idx_s < `RS_SIZE; idx_s = idx_s + 1) begin
                ent_valid[idx_s]    <= 1'b0;
                ent_pc[idx_s]       <= {`PC_WIDTH{1'b0}};
                ent_opcode[idx_s]   <= {`OPCODE_WIDTH{1'b0}};
                ent_funct3[idx_s]   <= {`FUNCT3_WIDTH{1'b0}};
                ent_funct7[idx_s]   <= {`FUNCT7_WIDTH{1'b0}};
                ent_shamt[idx_s]    <= {`SHAMT_WIDTH{1'b0}};
                ent_imm[idx_s]      <= {`IMM_WIDTH{1'b0}};
                ent_alu_src[idx_s]  <= 1'b0;
                ent_jal[idx_s]      <= 1'b0;
                ent_memwrite[idx_s] <= 1'b0;
                ent_memtoreg[idx_s] <= 1'b0;
                ent_regwrite[idx_s] <= 1'b0;
                ent_prs[idx_s]      <= {`RAT_SIZE{1'b0}};
                ent_prt[idx_s]      <= {`RAT_SIZE{1'b0}};
                ent_prd[idx_s]      <= {`RAT_SIZE{1'b0}};
                ent_rob_tag[idx_s]  <= {`ROB_IDX_W{1'b0}};
                ent_sq_idx[idx_s]   <= {`ROB_IDX_W{1'b0}};
                ent_has_rs[idx_s]   <= 1'b0;
                ent_has_rt[idx_s]   <= 1'b0;
                ent_rs_ready[idx_s] <= 1'b0;
                ent_rt_ready[idx_s] <= 1'b0;
                ent_ready[idx_s]    <= 1'b0;
                ent_vrs[idx_s]      <= {`DWIDTH{1'b0}};
                ent_vrt[idx_s]      <= {`DWIDTH{1'b0}};
            end
        end
        else if (rs_i_flush) begin
            for (idx_s = 0; idx_s < `RS_SIZE; idx_s = idx_s + 1) begin
                ent_valid[idx_s]    <= 1'b0;
                ent_pc[idx_s]       <= {`PC_WIDTH{1'b0}};
                ent_opcode[idx_s]   <= {`OPCODE_WIDTH{1'b0}};
                ent_funct3[idx_s]   <= {`FUNCT3_WIDTH{1'b0}};
                ent_funct7[idx_s]   <= {`FUNCT7_WIDTH{1'b0}};
                ent_shamt[idx_s]    <= {`SHAMT_WIDTH{1'b0}};
                ent_imm[idx_s]      <= {`IMM_WIDTH{1'b0}};
                ent_alu_src[idx_s]  <= 1'b0;
                ent_jal[idx_s]      <= 1'b0;
                ent_memwrite[idx_s] <= 1'b0;
                ent_memtoreg[idx_s] <= 1'b0;
                ent_regwrite[idx_s] <= 1'b0;
                ent_prs[idx_s]      <= {`RAT_SIZE{1'b0}};
                ent_prt[idx_s]      <= {`RAT_SIZE{1'b0}};
                ent_prd[idx_s]      <= {`RAT_SIZE{1'b0}};
                ent_rob_tag[idx_s]  <= {`ROB_IDX_W{1'b0}};
                ent_sq_idx[idx_s]   <= {`ROB_IDX_W{1'b0}};
                ent_has_rs[idx_s]   <= 1'b0;
                ent_has_rt[idx_s]   <= 1'b0;
                ent_rs_ready[idx_s] <= 1'b0;
                ent_rt_ready[idx_s] <= 1'b0;
                ent_ready[idx_s]    <= 1'b0;
                ent_vrs[idx_s]      <= {`DWIDTH{1'b0}};
                ent_vrt[idx_s]      <= {`DWIDTH{1'b0}};
            end
        end
        else if (rs_i_ce) begin
            for (idx_s = 0; idx_s < `RS_SIZE; idx_s = idx_s + 1) begin
                if (ent_valid[idx_s]) begin
                    if (ent_has_rs[idx_s] && !ent_rs_ready[idx_s] && match_src(ent_prs[idx_s])) begin
                        ent_rs_ready[idx_s] <= 1'b1;
                        ent_vrs[idx_s]      <= match_src_data(ent_prs[idx_s]);
                    end
                    if (ent_has_rt[idx_s] && !ent_rt_ready[idx_s] && match_src(ent_prt[idx_s])) begin
                        ent_rt_ready[idx_s] <= 1'b1;
                        ent_vrt[idx_s]      <= match_src_data(ent_prt[idx_s]);
                    end
                    ent_ready[idx_s] <=
                        (!ent_has_rs[idx_s] || ent_rs_ready[idx_s] || match_src(ent_prs[idx_s])) &&
                        (!ent_has_rt[idx_s] || ent_rt_ready[idx_s] || match_src(ent_prt[idx_s]));
                end
            end
            for (idx_s = 0; idx_s < `RS_SIZE; idx_s = idx_s + 1) begin
                if ((issue1_valid && rs_i_issue_accept_1 && issue1_sel[idx_s]) ||
                    (issue2_valid && rs_i_issue_accept_2 && issue2_sel[idx_s])) begin
                    ent_valid[idx_s]    <= 1'b0;
                    ent_has_rs[idx_s]   <= 1'b0;
                    ent_has_rt[idx_s]   <= 1'b0;
                    ent_rs_ready[idx_s] <= 1'b0;
                    ent_rt_ready[idx_s] <= 1'b0;
                    ent_ready[idx_s]    <= 1'b0;
                    ent_sq_idx[idx_s]   <= {`ROB_IDX_W{1'b0}};
                end
            end

            for (idx_s = 0; idx_s < `RS_SIZE; idx_s = idx_s + 1) begin
                if (rs_i_alloc_valid_1 && !rs_o_stall_1 && free1_sel[idx_s]) begin
                    ent_valid[idx_s]    <= 1'b1;
                    ent_pc[idx_s]       <= rs_i_pc_1;
                    ent_opcode[idx_s]   <= rs_i_opcode_1;
                    ent_funct3[idx_s]   <= rs_i_funct3_1;
                    ent_funct7[idx_s]   <= rs_i_funct7_1;
                    ent_shamt[idx_s]    <= rs_i_shamt_1;
                    ent_imm[idx_s]      <= rs_i_imm_1;
                    ent_alu_src[idx_s]  <= rs_i_alu_src_1;
                    ent_jal[idx_s]      <= rs_i_jal_1;
                    ent_memwrite[idx_s] <= rs_i_memwrite_1;
                    ent_memtoreg[idx_s] <= rs_i_memtoreg_1;
                    ent_regwrite[idx_s] <= rs_i_regwrite_1;
                    ent_prs[idx_s]      <= rs_i_prs_1;
                    ent_prt[idx_s]      <= rs_i_prt_1;
                    ent_prd[idx_s]      <= rs_i_prd_1;
                    ent_rob_tag[idx_s]  <= rs_i_rob_tag_1;
                    ent_sq_idx[idx_s]   <= rs_i_sq_idx_1;
                    ent_has_rs[idx_s]   <= opcode_has_rs(rs_i_opcode_1);
                    ent_has_rt[idx_s]   <= opcode_has_rt(rs_i_opcode_1);
                    ent_rs_ready[idx_s] <= !opcode_has_rs(rs_i_opcode_1) ||
                                           rs_i_prs_ready_1 ||
                                           match_src(rs_i_prs_1);
                    ent_rt_ready[idx_s] <= !opcode_has_rt(rs_i_opcode_1) ||
                                           rs_i_prt_ready_1 ||
                                           match_src(rs_i_prt_1);
                    ent_ready[idx_s]    <= (!opcode_has_rs(rs_i_opcode_1) ||
                                            rs_i_prs_ready_1 ||
                                            match_src(rs_i_prs_1)) &&
                                           (!opcode_has_rt(rs_i_opcode_1) ||
                                            rs_i_prt_ready_1 ||
                                            match_src(rs_i_prt_1));
                    ent_vrs[idx_s]      <= match_src(rs_i_prs_1) ?
                                           match_src_data(rs_i_prs_1) : rs_i_data_rs_1;
                    ent_vrt[idx_s]      <= match_src(rs_i_prt_1) ?
                                           match_src_data(rs_i_prt_1) : rs_i_data_rt_1;
                end

                if (rs_i_alloc_valid_2 && !rs_o_stall_2 &&
                    rs_i_alloc_valid_1 && free2_sel[idx_s]) begin
                    ent_valid[idx_s]    <= 1'b1;
                    ent_pc[idx_s]       <= rs_i_pc_2;
                    ent_opcode[idx_s]   <= rs_i_opcode_2;
                    ent_funct3[idx_s]   <= rs_i_funct3_2;
                    ent_funct7[idx_s]   <= rs_i_funct7_2;
                    ent_shamt[idx_s]    <= rs_i_shamt_2;
                    ent_imm[idx_s]      <= rs_i_imm_2;
                    ent_alu_src[idx_s]  <= rs_i_alu_src_2;
                    ent_jal[idx_s]      <= rs_i_jal_2;
                    ent_memwrite[idx_s] <= rs_i_memwrite_2;
                    ent_memtoreg[idx_s] <= rs_i_memtoreg_2;
                    ent_regwrite[idx_s] <= rs_i_regwrite_2;
                    ent_prs[idx_s]      <= rs_i_prs_2;
                    ent_prt[idx_s]      <= rs_i_prt_2;
                    ent_prd[idx_s]      <= rs_i_prd_2;
                    ent_rob_tag[idx_s]  <= rs_i_rob_tag_2;
                    ent_sq_idx[idx_s]   <= rs_i_sq_idx_2;
                    ent_has_rs[idx_s]   <= opcode_has_rs(rs_i_opcode_2);
                    ent_has_rt[idx_s]   <= opcode_has_rt(rs_i_opcode_2);
                    ent_rs_ready[idx_s] <= !opcode_has_rs(rs_i_opcode_2) ||
                                           ((!lane2_dep_rs_on_lane1) &&
                                            (rs_i_prs_ready_2 || match_src(rs_i_prs_2)));
                    ent_rt_ready[idx_s] <= !opcode_has_rt(rs_i_opcode_2) ||
                                           ((!lane2_dep_rt_on_lane1) &&
                                            (rs_i_prt_ready_2 || match_src(rs_i_prt_2)));
                    ent_ready[idx_s]    <= (!opcode_has_rs(rs_i_opcode_2) ||
                                            ((!lane2_dep_rs_on_lane1) &&
                                             (rs_i_prs_ready_2 || match_src(rs_i_prs_2)))) &&
                                           (!opcode_has_rt(rs_i_opcode_2) ||
                                            ((!lane2_dep_rt_on_lane1) &&
                                             (rs_i_prt_ready_2 || match_src(rs_i_prt_2))));
                    ent_vrs[idx_s]      <= lane2_dep_rs_on_lane1 ? {`DWIDTH{1'b0}} :
                                           (match_src(rs_i_prs_2) ?
                                            match_src_data(rs_i_prs_2) : rs_i_data_rs_2);
                    ent_vrt[idx_s]      <= lane2_dep_rt_on_lane1 ? {`DWIDTH{1'b0}} :
                                           (match_src(rs_i_prt_2) ?
                                            match_src_data(rs_i_prt_2) : rs_i_data_rt_2);
                end
                else if (rs_i_alloc_valid_2 && !rs_o_stall_2 &&
                         !rs_i_alloc_valid_1 && free1_sel[idx_s]) begin
                    ent_valid[idx_s]    <= 1'b1;
                    ent_pc[idx_s]       <= rs_i_pc_2;
                    ent_opcode[idx_s]   <= rs_i_opcode_2;
                    ent_funct3[idx_s]   <= rs_i_funct3_2;
                    ent_funct7[idx_s]   <= rs_i_funct7_2;
                    ent_shamt[idx_s]    <= rs_i_shamt_2;
                    ent_imm[idx_s]      <= rs_i_imm_2;
                    ent_alu_src[idx_s]  <= rs_i_alu_src_2;
                    ent_jal[idx_s]      <= rs_i_jal_2;
                    ent_memwrite[idx_s] <= rs_i_memwrite_2;
                    ent_memtoreg[idx_s] <= rs_i_memtoreg_2;
                    ent_regwrite[idx_s] <= rs_i_regwrite_2;
                    ent_prs[idx_s]      <= rs_i_prs_2;
                    ent_prt[idx_s]      <= rs_i_prt_2;
                    ent_prd[idx_s]      <= rs_i_prd_2;
                    ent_rob_tag[idx_s]  <= rs_i_rob_tag_2;
                    ent_sq_idx[idx_s]   <= rs_i_sq_idx_2;
                    ent_has_rs[idx_s]   <= opcode_has_rs(rs_i_opcode_2);
                    ent_has_rt[idx_s]   <= opcode_has_rt(rs_i_opcode_2);
                    ent_rs_ready[idx_s] <= !opcode_has_rs(rs_i_opcode_2) ||
                                           rs_i_prs_ready_2 ||
                                           match_src(rs_i_prs_2);
                    ent_rt_ready[idx_s] <= !opcode_has_rt(rs_i_opcode_2) ||
                                           rs_i_prt_ready_2 ||
                                           match_src(rs_i_prt_2);
                    ent_ready[idx_s]    <= (!opcode_has_rs(rs_i_opcode_2) ||
                                            rs_i_prs_ready_2 ||
                                            match_src(rs_i_prs_2)) &&
                                           (!opcode_has_rt(rs_i_opcode_2) ||
                                            rs_i_prt_ready_2 ||
                                            match_src(rs_i_prt_2));
                    ent_vrs[idx_s]      <= match_src(rs_i_prs_2) ?
                                           match_src_data(rs_i_prs_2) : rs_i_data_rs_2;
                    ent_vrt[idx_s]      <= match_src(rs_i_prt_2) ?
                                           match_src_data(rs_i_prt_2) : rs_i_data_rt_2;
                end
            end
        end
    end
endmodule