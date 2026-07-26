`timescale 1ns/1ps
`include "branch_spec_controller.v"

module tb_branch_spec_controller;
    reg clk;
    reg rstn;
    reg flush;
    reg save;
    reg [`ROB_IDX_W - 1 : 0] save_tag;
    reg save_pred_taken;
    reg resolve_valid_1;
    reg [`ROB_IDX_W - 1 : 0] resolve_tag_1;
    reg resolve_taken_1;
    reg resolve_valid_2;
    reg [`ROB_IDX_W - 1 : 0] resolve_tag_2;
    reg resolve_taken_2;
    reg commit_valid_1;
    reg [`ROB_IDX_W - 1 : 0] commit_tag_1;
    reg commit_valid_2;
    reg [`ROB_IDX_W - 1 : 0] commit_tag_2;

    wire active;
    wire [`ROB_IDX_W - 1 : 0] branch_tag;
    wire [`ROB_IDX_W - 1 : 0] restore_tag;
    wire [1:0] depth;
    wire full;
    wire restore;
    wire resolve;

    branch_spec_controller dut (
        .bsc_clk(clk),
        .bsc_rstn(rstn),
        .bsc_i_flush(flush),
        .bsc_i_save(save),
        .bsc_i_save_tag(save_tag),
        .bsc_i_save_pred_taken(save_pred_taken),
        .bsc_i_resolve_valid_1(resolve_valid_1),
        .bsc_i_resolve_tag_1(resolve_tag_1),
        .bsc_i_resolve_taken_1(resolve_taken_1),
        .bsc_i_resolve_valid_2(resolve_valid_2),
        .bsc_i_resolve_tag_2(resolve_tag_2),
        .bsc_i_resolve_taken_2(resolve_taken_2),
        .bsc_i_commit_valid_1(commit_valid_1),
        .bsc_i_commit_tag_1(commit_tag_1),
        .bsc_i_commit_valid_2(commit_valid_2),
        .bsc_i_commit_tag_2(commit_tag_2),
        .bsc_o_active(active),
        .bsc_o_branch_tag(branch_tag),
        .bsc_o_restore_tag(restore_tag),
        .bsc_o_depth(depth),
        .bsc_o_full(full),
        .bsc_o_restore(restore),
        .bsc_o_resolve(resolve)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task clear_inputs;
    begin
        flush = 1'b0;
        save = 1'b0;
        save_tag = {`ROB_IDX_W{1'b0}};
        save_pred_taken = 1'b0;
        resolve_valid_1 = 1'b0;
        resolve_tag_1 = {`ROB_IDX_W{1'b0}};
        resolve_taken_1 = 1'b0;
        resolve_valid_2 = 1'b0;
        resolve_tag_2 = {`ROB_IDX_W{1'b0}};
        resolve_taken_2 = 1'b0;
        commit_valid_1 = 1'b0;
        commit_tag_1 = {`ROB_IDX_W{1'b0}};
        commit_valid_2 = 1'b0;
        commit_tag_2 = {`ROB_IDX_W{1'b0}};
    end
    endtask

    task expect_state;
        input [127:0] name;
        input exp_active;
        input [`ROB_IDX_W - 1 : 0] exp_tag;
        input [1:0] exp_depth;
        input exp_full;
    begin
        if ((active !== exp_active) ||
            (exp_active && (branch_tag !== exp_tag)) ||
            (depth !== exp_depth) ||
            (full !== exp_full)) begin
            $display("FAIL %0s active=%0b tag=%0d depth=%0d full=%0b",
                     name, active, branch_tag, depth, full);
            $fatal;
        end
    end
    endtask

    task expect_restore_now;
        input [127:0] name;
        input exp_restore;
        input [`ROB_IDX_W - 1 : 0] exp_restore_tag;
    begin
        #1;
        if ((restore !== exp_restore) ||
            (restore_tag !== exp_restore_tag)) begin
            $display("FAIL %0s restore=%0b restore_tag=%0d",
                     name, restore, restore_tag);
            $fatal;
        end
    end
    endtask

    initial begin
        clear_inputs();
        rstn = 1'b0;
        repeat (2) @(posedge clk);
        rstn = 1'b1;
        @(posedge clk);
        expect_state("reset", 1'b0, 0, 2'd0, 1'b0);

        save = 1'b1;
        save_tag = 3;
        save_pred_taken = 1'b0;
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("save oldest", 1'b1, 3, 2'd1, 1'b0);

        save = 1'b1;
        save_tag = 5;
        save_pred_taken = 1'b1;
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("save nested", 1'b1, 3, 2'd2, 1'b1);

        resolve_valid_1 = 1'b1;
        resolve_tag_1 = 5;
        resolve_taken_1 = 1'b1;
        expect_restore_now("nested correct", 1'b0, 3);
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("after nested correct", 1'b1, 3, 2'd1, 1'b0);

        resolve_valid_1 = 1'b1;
        resolve_tag_1 = 3;
        resolve_taken_1 = 1'b1;
        expect_restore_now("oldest wrong", 1'b1, 3);
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("after oldest restore", 1'b0, 0, 2'd0, 1'b0);

        save = 1'b1;
        save_tag = 8;
        save_pred_taken = 1'b1;
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("save second oldest", 1'b1, 8, 2'd1, 1'b0);

        save = 1'b1;
        save_tag = 9;
        save_pred_taken = 1'b0;
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("save second nested", 1'b1, 8, 2'd2, 1'b1);

        resolve_valid_1 = 1'b1;
        resolve_tag_1 = 8;
        resolve_taken_1 = 1'b0;
        expect_restore_now("older wrong clears younger", 1'b1, 8);
        @(posedge clk);
        clear_inputs();
        #1;
        expect_state("after older restore clears younger", 1'b0, 0, 2'd0, 1'b0);

        $display("PASS branch_spec_controller depth2 smoke");
        $finish;
    end
endmodule
