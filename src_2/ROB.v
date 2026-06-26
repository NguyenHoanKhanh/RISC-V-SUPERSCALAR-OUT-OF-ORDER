`timescale 1ns/1ps
`include "header_nomul.vh"
module ROB (
    input rob_clk,
    input rob_rstn,
    input rob_i_ce,
    input rob_i_flush,

    // Allocate from rename (2-wide)
    input rob_i_alloc_valid_1,
    input [`AWIDTH - 1 : 0] rob_i_alloc_arch_rd_1,
    input [`RAT_SIZE - 1 : 0] rob_i_alloc_new_prd_1,
    input [`RAT_SIZE - 1 : 0] rob_i_alloc_old_prd_1,
    input rob_i_alloc_is_store_1,
    input [`ROB_IDX_W - 1 : 0] rob_i_alloc_sq_idx_1,
    input rob_i_alloc_is_load_1,
    input [`ROB_IDX_W - 1 : 0] rob_i_alloc_ld_idx_1,
    input [`OPCODE_WIDTH - 1 : 0] rob_i_alloc_opcode_1,
    input [`FUNCT3_WIDTH - 1 : 0] rob_i_alloc_funct3_1,
    input [`FUNCT7_WIDTH - 1 : 0] rob_i_alloc_funct7_1,
    output rob_o_alloc_fire_1,
    output [`ROB_IDX_W - 1 : 0] rob_o_alloc_tag_1,

    input rob_i_alloc_valid_2,
    input [`AWIDTH - 1 : 0] rob_i_alloc_arch_rd_2,
    input [`RAT_SIZE - 1 : 0] rob_i_alloc_new_prd_2,
    input [`RAT_SIZE - 1 : 0] rob_i_alloc_old_prd_2,
    input rob_i_alloc_is_store_2,
    input [`ROB_IDX_W - 1 : 0] rob_i_alloc_sq_idx_2,
    input rob_i_alloc_is_load_2,
    input [`ROB_IDX_W - 1 : 0] rob_i_alloc_ld_idx_2,
    input [`OPCODE_WIDTH - 1 : 0] rob_i_alloc_opcode_2,
    input [`FUNCT3_WIDTH - 1 : 0] rob_i_alloc_funct3_2,
    input [`FUNCT7_WIDTH - 1 : 0] rob_i_alloc_funct7_2,
    output rob_o_alloc_fire_2,
    output [`ROB_IDX_W - 1 : 0] rob_o_alloc_tag_2,

    // Complete from execute/WB (2-wide)
    input rob_i_cpl_valid_1,
    input [`ROB_IDX_W - 1 : 0] rob_i_cpl_tag_1,
    input [`DWIDTH - 1 : 0] rob_i_cpl_data_1,
    input rob_i_cpl_valid_2,
    input [`ROB_IDX_W - 1 : 0] rob_i_cpl_tag_2,
    input [`DWIDTH - 1 : 0] rob_i_cpl_data_2,

    // WB mirror to PRF (typically from CDB side)
    output rob_o_wb_valid_1,
    output [`RAT_SIZE - 1 : 0] rob_o_wb_prd_1,
    output [`DWIDTH - 1 : 0] rob_o_wb_data_1,
    output rob_o_wb_valid_2,
    output [`RAT_SIZE - 1 : 0] rob_o_wb_prd_2,
    output [`DWIDTH - 1 : 0] rob_o_wb_data_2,

    // Commit (in-order, up to 2/cycle) to ARF
    output rob_o_commit_valid_1,
    output [`ROB_IDX_W - 1 : 0] rob_o_commit_tag_1,
    output [`AWIDTH - 1 : 0] rob_o_commit_arch_rd_1,
    output [`DWIDTH - 1 : 0] rob_o_commit_data_1,
    output rob_o_commit_is_store_1,
    output [`ROB_IDX_W - 1 : 0] rob_o_commit_sq_idx_1,
    output rob_o_commit_is_load_1,
    output [`ROB_IDX_W - 1 : 0] rob_o_commit_ld_idx_1,
    output rob_o_commit_valid_2,
    output [`ROB_IDX_W - 1 : 0] rob_o_commit_tag_2,
    output [`AWIDTH - 1 : 0] rob_o_commit_arch_rd_2,
    output [`DWIDTH - 1 : 0] rob_o_commit_data_2,
    output rob_o_commit_is_store_2,
    output [`ROB_IDX_W - 1 : 0] rob_o_commit_sq_idx_2,
    output rob_o_commit_is_load_2,
    output [`ROB_IDX_W - 1 : 0] rob_o_commit_ld_idx_2,

    // Release stale PRD to free list / RAT
    output rob_o_rel_valid_1,
    output [`RAT_SIZE - 1 : 0] rob_o_rel_prd_1,
    output rob_o_rel_valid_2,
    output [`RAT_SIZE - 1 : 0] rob_o_rel_prd_2,

    output rob_o_full,
    output rob_o_can_alloc_1,
    output rob_o_can_alloc_2
);

    integer rob_init_i;

    reg ent_valid [0 : `ROB_SIZE - 1];
    reg ent_done [0 : `ROB_SIZE - 1];
    reg [`AWIDTH - 1 : 0] ent_arch_rd [0 : `ROB_SIZE - 1];
    reg [`RAT_SIZE - 1 : 0] ent_new_prd [0 : `ROB_SIZE - 1];
    reg [`RAT_SIZE - 1 : 0] ent_old_prd [0 : `ROB_SIZE - 1];
reg [`DWIDTH - 1 : 0] ent_data [0 : `ROB_SIZE - 1];
    reg ent_is_store [0 : `ROB_SIZE - 1];
    reg [`ROB_IDX_W - 1 : 0] ent_sq_idx [0 : `ROB_SIZE - 1];
    reg ent_is_load [0 : `ROB_SIZE - 1];
    reg [`ROB_IDX_W - 1 : 0] ent_ld_idx [0 : `ROB_SIZE - 1];
    reg [`OPCODE_WIDTH - 1 : 0] ent_opcode [0 : `ROB_SIZE - 1];
    reg [`FUNCT3_WIDTH - 1 : 0] ent_funct3 [0 : `ROB_SIZE - 1];
    reg [`FUNCT7_WIDTH - 1 : 0] ent_funct7 [0 : `ROB_SIZE - 1];

    reg [`ROB_IDX_W - 1 : 0] head_ptr;
    reg [`ROB_IDX_W - 1 : 0] tail_ptr;
    reg [`ROB_IDX_W : 0] used_count;

    localparam [`ROB_IDX_W : 0] ROB_CAPACITY = {1'b1, {`ROB_IDX_W{1'b0}}};
    localparam [`ROB_IDX_W - 1 : 0] ROB_LAST_IDX = {`ROB_IDX_W{1'b1}};
    localparam [`ROB_IDX_W - 1 : 0] ROB_LAST_MINUS1 = ROB_LAST_IDX - {{(`ROB_IDX_W - 1){1'b0}}, 1'b1};
    localparam [`ROB_IDX_W - 1 : 0] ROB_ONE_IDX = {{(`ROB_IDX_W - 1){1'b0}}, 1'b1};
    localparam [`ROB_IDX_W - 1 : 0] ROB_TWO_IDX = {{(`ROB_IDX_W - 2){1'b0}}, 2'b10};
    localparam [`ROB_IDX_W : 0] ROB_FREE_ONE = {{`ROB_IDX_W{1'b0}}, 1'b1};
    localparam [`ROB_IDX_W : 0] ROB_FREE_TWO = {{(`ROB_IDX_W - 1){1'b0}}, 2'b10};

    wire [`ROB_IDX_W : 0] free_count = ROB_CAPACITY - used_count;
    assign rob_o_full = (free_count == {(`ROB_IDX_W + 1){1'b0}});
    assign rob_o_can_alloc_1 = (free_count >= ROB_FREE_ONE);
    assign rob_o_can_alloc_2 = (free_count >= ROB_FREE_TWO);

    wire alloc_ok_1 = rob_i_ce && !rob_i_flush && rob_i_alloc_valid_1 && (free_count >= ROB_FREE_ONE);
    wire alloc_ok_2 = rob_i_ce && !rob_i_flush && rob_i_alloc_valid_2 &&
                      ((rob_i_alloc_valid_1 && (free_count >= ROB_FREE_TWO)) ||
                       (!rob_i_alloc_valid_1 && (free_count >= ROB_FREE_ONE)));

    wire [`ROB_IDX_W - 1 : 0] tail_plus_1 =
        (tail_ptr == ROB_LAST_IDX) ? {`ROB_IDX_W{1'b0}} : (tail_ptr + ROB_ONE_IDX);
    wire [`ROB_IDX_W - 1 : 0] tail_plus_2 =
        (tail_ptr >= ROB_LAST_MINUS1) ? (tail_ptr - ROB_LAST_MINUS1) : (tail_ptr + ROB_TWO_IDX);

    assign rob_o_alloc_fire_1 = alloc_ok_1;
    assign rob_o_alloc_fire_2 = alloc_ok_2;
    assign rob_o_alloc_tag_1 = tail_ptr;
    assign rob_o_alloc_tag_2 = rob_i_alloc_valid_1 ? tail_plus_1 : tail_ptr;

    wire [1 : 0] alloc_num = {1'b0, alloc_ok_1} + {1'b0, alloc_ok_2};
    wire [`ROB_IDX_W : 0] alloc_num_ext = {{(`ROB_IDX_W - 1){1'b0}}, alloc_num};

    // Completion and commit are independent from dispatch allocation CE.
    wire cpl_ok_1 = !rob_i_flush && rob_i_cpl_valid_1 && ent_valid[rob_i_cpl_tag_1];
    wire cpl_ok_2 = !rob_i_flush && rob_i_cpl_valid_2 && ent_valid[rob_i_cpl_tag_2];
    assign rob_o_wb_valid_1 = cpl_ok_1;
    assign rob_o_wb_valid_2 = cpl_ok_2;
    assign rob_o_wb_prd_1 = ent_new_prd[rob_i_cpl_tag_1];
    assign rob_o_wb_prd_2 = ent_new_prd[rob_i_cpl_tag_2];
    assign rob_o_wb_data_1 = rob_i_cpl_data_1;
    assign rob_o_wb_data_2 = rob_i_cpl_data_2;

    // Commit logic (combinational, in-order from head)
    wire head_valid = ent_valid[head_ptr];
    wire head_done = ent_done[head_ptr];
    wire [`ROB_IDX_W - 1 : 0] head_next =
        (head_ptr == ROB_LAST_IDX) ? {`ROB_IDX_W{1'b0}} : (head_ptr + ROB_ONE_IDX);
    wire [`ROB_IDX_W - 1 : 0] head_plus_2 =
        (head_ptr >= ROB_LAST_MINUS1) ? (head_ptr - ROB_LAST_MINUS1) : (head_ptr + ROB_TWO_IDX);
    wire next_valid = ent_valid[head_next];
    wire next_done = ent_done[head_next];

    wire commit1 = !rob_i_flush && head_valid && head_done;
    wire commit2 = commit1 && next_valid && next_done;
    wire [1 : 0] commit_num = {1'b0, commit1} + {1'b0, commit2};
    wire [`ROB_IDX_W : 0] commit_num_ext = {{(`ROB_IDX_W - 1){1'b0}}, commit_num};

    assign rob_o_commit_valid_1 = commit1;
    assign rob_o_commit_valid_2 = commit2;
    assign rob_o_commit_tag_1 = head_ptr;
    assign rob_o_commit_tag_2 = head_next;
    assign rob_o_commit_arch_rd_1 = ent_arch_rd[head_ptr];
    assign rob_o_commit_data_1 = ent_data[head_ptr];
    assign rob_o_commit_is_store_1 = ent_is_store[head_ptr];
    assign rob_o_commit_sq_idx_1 = ent_sq_idx[head_ptr];
    assign rob_o_commit_is_load_1 = ent_is_load[head_ptr];
    assign rob_o_commit_ld_idx_1 = ent_ld_idx[head_ptr];
    assign rob_o_commit_arch_rd_2 = ent_arch_rd[head_next];
    assign rob_o_commit_data_2 = ent_data[head_next];
    assign rob_o_commit_is_store_2 = ent_is_store[head_next];
    assign rob_o_commit_sq_idx_2 = ent_sq_idx[head_next];
    assign rob_o_commit_is_load_2 = ent_is_load[head_next];
    assign rob_o_commit_ld_idx_2 = ent_ld_idx[head_next];

    assign rob_o_rel_valid_1 = commit1 && (ent_arch_rd[head_ptr] != {`AWIDTH{1'b0}});
    assign rob_o_rel_valid_2 = commit2 && (ent_arch_rd[head_next] != {`AWIDTH{1'b0}});
    assign rob_o_rel_prd_1 = ent_old_prd[head_ptr];
    assign rob_o_rel_prd_2 = ent_old_prd[head_next];

    always @(posedge rob_clk or negedge rob_rstn) begin
        if (!rob_rstn) begin
            for (rob_init_i = 0; rob_init_i < `ROB_SIZE; rob_init_i = rob_init_i + 1) begin
                ent_valid[rob_init_i] <= 1'b0;
                ent_done[rob_init_i] <= 1'b0;
                ent_arch_rd[rob_init_i] <= {`AWIDTH{1'b0}};
                ent_new_prd[rob_init_i] <= {`RAT_SIZE{1'b0}};
                ent_old_prd[rob_init_i] <= {`RAT_SIZE{1'b0}};
                ent_data[rob_init_i] <= {`DWIDTH{1'b0}};
                ent_is_store[rob_init_i] <= 1'b0;
                ent_sq_idx[rob_init_i] <= {`ROB_IDX_W{1'b0}};
                ent_is_load[rob_init_i] <= 1'b0;
                ent_ld_idx[rob_init_i] <= {`ROB_IDX_W{1'b0}};
                ent_opcode[rob_init_i] <= {`OPCODE_WIDTH{1'b0}};
                ent_funct3[rob_init_i] <= {`FUNCT3_WIDTH{1'b0}};
                ent_funct7[rob_init_i] <= {`FUNCT7_WIDTH{1'b0}};
            end
            head_ptr <= {`ROB_IDX_W{1'b0}};
            tail_ptr <= {`ROB_IDX_W{1'b0}};
            used_count <= {(`ROB_IDX_W + 1){1'b0}};
        end
        else if (rob_i_flush) begin
            for (rob_init_i = 0; rob_init_i < `ROB_SIZE; rob_init_i = rob_init_i + 1) begin
                ent_valid[rob_init_i] <= 1'b0;
                ent_done[rob_init_i] <= 1'b0;
                ent_arch_rd[rob_init_i] <= {`AWIDTH{1'b0}};
                ent_new_prd[rob_init_i] <= {`RAT_SIZE{1'b0}};
                ent_old_prd[rob_init_i] <= {`RAT_SIZE{1'b0}};
                ent_data[rob_init_i] <= {`DWIDTH{1'b0}};
                ent_is_store[rob_init_i] <= 1'b0;
                ent_sq_idx[rob_init_i] <= {`ROB_IDX_W{1'b0}};
                ent_is_load[rob_init_i] <= 1'b0;
                ent_ld_idx[rob_init_i] <= {`ROB_IDX_W{1'b0}};
                ent_opcode[rob_init_i] <= {`OPCODE_WIDTH{1'b0}};
                ent_funct3[rob_init_i] <= {`FUNCT3_WIDTH{1'b0}};
                ent_funct7[rob_init_i] <= {`FUNCT7_WIDTH{1'b0}};
            end
            head_ptr <= {`ROB_IDX_W{1'b0}};
            tail_ptr <= {`ROB_IDX_W{1'b0}};
            used_count <= {(`ROB_IDX_W + 1){1'b0}};
        end
        else begin
            // 1) mark complete
            if (cpl_ok_1) begin
                ent_done[rob_i_cpl_tag_1] <= 1'b1;
                ent_data[rob_i_cpl_tag_1] <= rob_i_cpl_data_1;
            end
            if (cpl_ok_2) begin
                ent_done[rob_i_cpl_tag_2] <= 1'b1;
                ent_data[rob_i_cpl_tag_2] <= rob_i_cpl_data_2;
            end

            // 2) commit in-order
            if (commit1) begin
                ent_valid[head_ptr] <= 1'b0;
                ent_done[head_ptr] <= 1'b0;
            end
            if (commit2) begin
                ent_valid[head_next] <= 1'b0;
                ent_done[head_next] <= 1'b0;
            end

            // 3) allocate from rename
            if (alloc_ok_1) begin
                ent_valid[tail_ptr] <= 1'b1;
                ent_done[tail_ptr] <= 1'b0;
                ent_arch_rd[tail_ptr] <= rob_i_alloc_arch_rd_1;
                ent_new_prd[tail_ptr] <= rob_i_alloc_new_prd_1;
                ent_old_prd[tail_ptr] <= rob_i_alloc_old_prd_1;
                ent_data[tail_ptr] <= {`DWIDTH{1'b0}};
                ent_is_store[tail_ptr] <= rob_i_alloc_is_store_1;
                ent_sq_idx[tail_ptr] <= rob_i_alloc_sq_idx_1;
                ent_is_load[tail_ptr] <= rob_i_alloc_is_load_1;
                ent_ld_idx[tail_ptr] <= rob_i_alloc_ld_idx_1;
                ent_opcode[tail_ptr] <= rob_i_alloc_opcode_1;
                ent_funct3[tail_ptr] <= rob_i_alloc_funct3_1;
                ent_funct7[tail_ptr] <= rob_i_alloc_funct7_1;
            end
            if (alloc_ok_2) begin
                if (rob_i_alloc_valid_1) begin
                    ent_valid[tail_plus_1] <= 1'b1;
                    ent_done[tail_plus_1] <= 1'b0;
                    ent_arch_rd[tail_plus_1] <= rob_i_alloc_arch_rd_2;
                    ent_new_prd[tail_plus_1] <= rob_i_alloc_new_prd_2;
                    ent_old_prd[tail_plus_1] <= rob_i_alloc_old_prd_2;
                    ent_data[tail_plus_1] <= {`DWIDTH{1'b0}};
                    ent_is_store[tail_plus_1] <= rob_i_alloc_is_store_2;
                    ent_sq_idx[tail_plus_1] <= rob_i_alloc_sq_idx_2;
                    ent_is_load[tail_plus_1] <= rob_i_alloc_is_load_2;
                    ent_ld_idx[tail_plus_1] <= rob_i_alloc_ld_idx_2;
                    ent_opcode[tail_plus_1] <= rob_i_alloc_opcode_2;
                    ent_funct3[tail_plus_1] <= rob_i_alloc_funct3_2;
                    ent_funct7[tail_plus_1] <= rob_i_alloc_funct7_2;
                end
                else begin
                    ent_valid[tail_ptr] <= 1'b1;
                    ent_done[tail_ptr] <= 1'b0;
                    ent_arch_rd[tail_ptr] <= rob_i_alloc_arch_rd_2;
                    ent_new_prd[tail_ptr] <= rob_i_alloc_new_prd_2;
                    ent_old_prd[tail_ptr] <= rob_i_alloc_old_prd_2;
                    ent_data[tail_ptr] <= {`DWIDTH{1'b0}};
                    ent_is_store[tail_ptr] <= rob_i_alloc_is_store_2;
                    ent_sq_idx[tail_ptr] <= rob_i_alloc_sq_idx_2;
                    ent_is_load[tail_ptr] <= rob_i_alloc_is_load_2;
                    ent_ld_idx[tail_ptr] <= rob_i_alloc_ld_idx_2;
                    ent_opcode[tail_ptr] <= rob_i_alloc_opcode_2;
                    ent_funct3[tail_ptr] <= rob_i_alloc_funct3_2;
                    ent_funct7[tail_ptr] <= rob_i_alloc_funct7_2;
                end
            end

            // 4) pointers/count
            if (commit_num == 2'd1) begin
                head_ptr <= head_next;
            end
            else if (commit_num == 2'd2) begin
                head_ptr <= head_plus_2;
            end

            if (alloc_num == 2'd1) begin
                tail_ptr <= tail_plus_1;
            end
            else if (alloc_num == 2'd2) begin
                tail_ptr <= tail_plus_2;
            end

            used_count <= used_count + alloc_num_ext - commit_num_ext;
        end
    end

endmodule
