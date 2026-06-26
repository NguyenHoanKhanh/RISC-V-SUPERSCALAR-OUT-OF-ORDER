`timescale 1ns/1ps

// Simple Load Queue for conservative memory ordering.
//
// This module is intentionally standalone. It does not access Store Queue or
// Data Memory directly; instead it exposes request/response ports:
// 1) Dispatch allocates an ld_idx for each LOAD and stores the Store Queue
//    snapshot seen by that LOAD.
// 2) Execute fills ld_idx with the calculated address. The Load Queue then
//    queries Store Queue using address/mask/snapshot.
// 3) Store Queue response chooses one of:
//      - read memory
//      - forward raw data
//      - wait/retry
// 4) Memory/forward data is reported as a complete packet. The entry is kept
//    until ROB commits the LOAD and releases ld_idx.
module load_queue (
    input                       lq_clk,
    input                       lq_rstn,
    input                       lq_i_ce,

    // Allocate from Dispatch/Rename, only for LOAD instructions.
    input                       lq_i_alloc_valid_1,
    input      [`ROB_IDX_W-1:0] lq_i_alloc_sq_tail_snapshot_1,
    input      [`ROB_IDX_W:0]   lq_i_alloc_older_store_count_1,
    output reg [`ROB_IDX_W-1:0] lq_o_alloc_ptr_1,

    input                       lq_i_alloc_valid_2,
    input      [`ROB_IDX_W-1:0] lq_i_alloc_sq_tail_snapshot_2,
    input      [`ROB_IDX_W:0]   lq_i_alloc_older_store_count_2,
    output reg [`ROB_IDX_W-1:0] lq_o_alloc_ptr_2,

    // Fill from Execute after LOAD effective address is calculated.
    input                       lq_i_exec_valid_1,
    input      [`ROB_IDX_W-1:0] lq_i_exec_ptr_1,
    input      [`ROB_IDX_W-1:0] lq_i_exec_rob_tag_1,
    input      [`RAT_SIZE-1:0]  lq_i_exec_prd_1,
    input      [`FUNCT3_WIDTH-1:0] lq_i_exec_funct3_1,
    input      [`DWIDTH-1:0]    lq_i_exec_addr_1,

    input                       lq_i_exec_valid_2,
    input      [`ROB_IDX_W-1:0] lq_i_exec_ptr_2,
    input      [`ROB_IDX_W-1:0] lq_i_exec_rob_tag_2,
    input      [`RAT_SIZE-1:0]  lq_i_exec_prd_2,
    input      [`FUNCT3_WIDTH-1:0] lq_i_exec_funct3_2,
    input      [`DWIDTH-1:0]    lq_i_exec_addr_2,

    // Query Store Queue for older-store forwarding/ordering.
    output reg                  lq_o_sq_query_valid_1,
    output reg [`ROB_IDX_W-1:0] lq_o_sq_query_ptr_1,
    output reg [`DWIDTH-1:0]    lq_o_sq_query_addr_1,
    output reg [3:0]            lq_o_sq_query_mask_1,
    output reg [`ROB_IDX_W-1:0] lq_o_sq_query_tail_snapshot_1,
    output reg [`ROB_IDX_W:0]   lq_o_sq_query_older_store_count_1,

    output reg                  lq_o_sq_query_valid_2,
    output reg [`ROB_IDX_W-1:0] lq_o_sq_query_ptr_2,
    output reg [`DWIDTH-1:0]    lq_o_sq_query_addr_2,
    output reg [3:0]            lq_o_sq_query_mask_2,
    output reg [`ROB_IDX_W-1:0] lq_o_sq_query_tail_snapshot_2,
    output reg [`ROB_IDX_W:0]   lq_o_sq_query_older_store_count_2,

    // Store Queue response. Response ptr identifies which ld_idx this result
    // belongs to. Priority when multiple bits are asserted:
    // forward_valid > read_mem > wait.
    input                       lq_i_sq_resp_valid_1,
    input      [`ROB_IDX_W-1:0] lq_i_sq_resp_ptr_1,
    input                       lq_i_sq_resp_read_mem_1,
    input                       lq_i_sq_resp_forward_valid_1,
    input                       lq_i_sq_resp_wait_1,
    input      [`DWIDTH-1:0]    lq_i_sq_resp_forward_data_1,

    input                       lq_i_sq_resp_valid_2,
    input      [`ROB_IDX_W-1:0] lq_i_sq_resp_ptr_2,
    input                       lq_i_sq_resp_read_mem_2,
    input                       lq_i_sq_resp_forward_valid_2,
    input                       lq_i_sq_resp_wait_2,
    input      [`DWIDTH-1:0]    lq_i_sq_resp_forward_data_2,

    // Memory read request for loads whose Store Queue query says read memory.
    // The request remains asserted until a memory response marks the entry done.
    output reg                  lq_o_mem_req_valid_1,
    output reg [`ROB_IDX_W-1:0] lq_o_mem_req_ptr_1,
    output reg [`DWIDTH-1:0]    lq_o_mem_req_addr_1,

    output reg                  lq_o_mem_req_valid_2,
    output reg [`ROB_IDX_W-1:0] lq_o_mem_req_ptr_2,
    output reg [`DWIDTH-1:0]    lq_o_mem_req_addr_2,

    input                       lq_i_mem_resp_valid_1,
    input      [`ROB_IDX_W-1:0] lq_i_mem_resp_ptr_1,
    input      [`DWIDTH-1:0]    lq_i_mem_resp_data_1,
    input                       lq_i_mem_resp_valid_2,
    input      [`ROB_IDX_W-1:0] lq_i_mem_resp_ptr_2,
    input      [`DWIDTH-1:0]    lq_i_mem_resp_data_2,

    // Completed raw load data. External treat_load still formats/sign-extends.
    input                       lq_i_complete_accept_1,
    output reg                  lq_o_complete_valid_1,
    output reg [`ROB_IDX_W-1:0] lq_o_complete_rob_tag_1,
    output reg [`RAT_SIZE-1:0]  lq_o_complete_prd_1,
    output reg [`FUNCT3_WIDTH-1:0] lq_o_complete_funct3_1,
    output reg [`DWIDTH-1:0]    lq_o_complete_raw_data_1,
    output reg [`DWIDTH-1:0]    lq_o_complete_addr_1,

    input                       lq_i_complete_accept_2,
    output reg                  lq_o_complete_valid_2,
    output reg [`ROB_IDX_W-1:0] lq_o_complete_rob_tag_2,
    output reg [`RAT_SIZE-1:0]  lq_o_complete_prd_2,
    output reg [`FUNCT3_WIDTH-1:0] lq_o_complete_funct3_2,
    output reg [`DWIDTH-1:0]    lq_o_complete_raw_data_2,
    output reg [`DWIDTH-1:0]    lq_o_complete_addr_2,

    // Release from ROB commit. Assert valid only for committed LOADs.
    input                       lq_i_commit_valid_1,
    input      [`ROB_IDX_W-1:0] lq_i_commit_ptr_1,

    input                       lq_i_commit_valid_2,
    input      [`ROB_IDX_W-1:0] lq_i_commit_ptr_2,

    output     [`ROB_IDX_W:0]   lq_o_count
);

    localparam [`ROB_IDX_W:0] LQ_CAPACITY = `ROB_SIZE;
    localparam [`ROB_IDX_W:0] LQ_ONE      = {{`ROB_IDX_W{1'b0}}, 1'b1};
    localparam [`ROB_IDX_W:0] LQ_TWO      = {{(`ROB_IDX_W-1){1'b0}}, 2'b10};

    reg                  ent_valid       [0:`ROB_SIZE-1];
    reg                  ent_addr_valid  [0:`ROB_SIZE-1];
    reg                  ent_query_wait  [0:`ROB_SIZE-1];
    reg                  ent_mem_wait    [0:`ROB_SIZE-1];
    reg                  ent_done        [0:`ROB_SIZE-1];
    reg                  ent_complete_sent [0:`ROB_SIZE-1];

    reg [`ROB_IDX_W-1:0] ent_sq_tail_snapshot [0:`ROB_SIZE-1];
    reg [`ROB_IDX_W:0]   ent_older_store_count [0:`ROB_SIZE-1];
    reg [`ROB_IDX_W-1:0] ent_rob_tag [0:`ROB_SIZE-1];
    reg [`RAT_SIZE-1:0]  ent_prd     [0:`ROB_SIZE-1];
    reg [`FUNCT3_WIDTH-1:0] ent_funct3 [0:`ROB_SIZE-1];
    reg [`DWIDTH-1:0]    ent_addr    [0:`ROB_SIZE-1];
    reg [3:0]            ent_mask    [0:`ROB_SIZE-1];
    reg [`DWIDTH-1:0]    ent_raw_data [0:`ROB_SIZE-1];

    reg [`ROB_IDX_W-1:0] head_ptr;
    reg [`ROB_IDX_W-1:0] tail_ptr;
    reg [`ROB_IDX_W:0]   used_count;

    integer i;
    integer cidx;
    integer sidx;

    reg [`ROB_IDX_W-1:0] complete_idx_1;
    reg [`ROB_IDX_W-1:0] complete_idx_2;

    wire [`ROB_IDX_W:0] free_count = LQ_CAPACITY - used_count;

    wire [`ROB_IDX_W-1:0] head_plus_1 = head_ptr + {{(`ROB_IDX_W-1){1'b0}}, 1'b1};
    wire [`ROB_IDX_W-1:0] tail_plus_1 = tail_ptr + {{(`ROB_IDX_W-1){1'b0}}, 1'b1};

    wire commit1_ok;
    wire commit2_ok;
    wire [`ROB_IDX_W-1:0] commit2_ptr;

    assign commit1_ok = lq_i_ce &&
                        lq_i_commit_valid_1 &&
                        (lq_i_commit_ptr_1 == head_ptr) &&
                        ent_valid[head_ptr] &&
                        ent_done[head_ptr];

    assign commit2_ptr = commit1_ok ? head_plus_1 : head_ptr;

    assign commit2_ok = lq_i_ce &&
                        lq_i_commit_valid_2 &&
                        (lq_i_commit_ptr_2 == commit2_ptr) &&
                        ent_valid[commit2_ptr] &&
                        ent_done[commit2_ptr];

    wire [`ROB_IDX_W:0] pop_n = {{`ROB_IDX_W{1'b0}}, commit1_ok} +
                                {{`ROB_IDX_W{1'b0}}, commit2_ok};

    assign lq_o_count    = used_count;

    wire alloc1_req = lq_i_ce && lq_i_alloc_valid_1;
    wire alloc2_req = lq_i_ce && lq_i_alloc_valid_2;
    wire alloc1_ok  = alloc1_req && (free_count >= LQ_ONE);
    wire alloc2_ok  = alloc2_req &&
                      (alloc1_ok ? (free_count >= LQ_TWO) :
                                   (free_count >= LQ_ONE));

    wire [`ROB_IDX_W-1:0] alloc1_ptr = tail_ptr;
    wire [`ROB_IDX_W-1:0] alloc2_ptr =
        tail_ptr + {{(`ROB_IDX_W-1){1'b0}}, alloc1_ok};

    wire [`ROB_IDX_W:0] push_n = {{`ROB_IDX_W{1'b0}}, alloc1_ok} +
                                 {{`ROB_IDX_W{1'b0}}, alloc2_ok};

    function [3:0] load_mask_from_addr;
        input [`FUNCT3_WIDTH-1:0] funct3;
        input [`DWIDTH-1:0] addr;
        begin
            case (funct3)
                `LB,
                `LBU: begin
                    case (addr[1:0])
                        2'b00: load_mask_from_addr = 4'b0001;
                        2'b01: load_mask_from_addr = 4'b0010;
                        2'b10: load_mask_from_addr = 4'b0100;
                        default: load_mask_from_addr = 4'b1000;
                    endcase
                end
                `LH,
                `LHU: begin
                    load_mask_from_addr = addr[1] ? 4'b1100 : 4'b0011;
                end
                `LW: begin
                    load_mask_from_addr = 4'b1111;
                end
                default: begin
                    load_mask_from_addr = 4'b0000;
                end
            endcase
        end
    endfunction

    always @(*) begin
        lq_o_alloc_ptr_1  = alloc1_ptr;
        lq_o_alloc_ptr_2  = lq_i_alloc_valid_2 ? alloc2_ptr : tail_plus_1;

        lq_o_sq_query_valid_1 = 1'b0;
        lq_o_sq_query_valid_2 = 1'b0;
        lq_o_sq_query_ptr_1 = {`ROB_IDX_W{1'b0}};
        lq_o_sq_query_ptr_2 = {`ROB_IDX_W{1'b0}};
        lq_o_sq_query_addr_1 = {`DWIDTH{1'b0}};
        lq_o_sq_query_addr_2 = {`DWIDTH{1'b0}};
        lq_o_sq_query_mask_1 = 4'b0000;
        lq_o_sq_query_mask_2 = 4'b0000;
        lq_o_sq_query_tail_snapshot_1 = {`ROB_IDX_W{1'b0}};
        lq_o_sq_query_tail_snapshot_2 = {`ROB_IDX_W{1'b0}};
        lq_o_sq_query_older_store_count_1 = {(`ROB_IDX_W+1){1'b0}};
        lq_o_sq_query_older_store_count_2 = {(`ROB_IDX_W+1){1'b0}};

        lq_o_mem_req_valid_1 = 1'b0;
        lq_o_mem_req_valid_2 = 1'b0;
        lq_o_mem_req_ptr_1 = {`ROB_IDX_W{1'b0}};
        lq_o_mem_req_ptr_2 = {`ROB_IDX_W{1'b0}};
        lq_o_mem_req_addr_1 = {`DWIDTH{1'b0}};
        lq_o_mem_req_addr_2 = {`DWIDTH{1'b0}};

        lq_o_complete_valid_1 = 1'b0;
        lq_o_complete_valid_2 = 1'b0;
        complete_idx_1 = {`ROB_IDX_W{1'b0}};
        complete_idx_2 = {`ROB_IDX_W{1'b0}};
        lq_o_complete_rob_tag_1 = {`ROB_IDX_W{1'b0}};
        lq_o_complete_rob_tag_2 = {`ROB_IDX_W{1'b0}};
        lq_o_complete_prd_1 = {`RAT_SIZE{1'b0}};
        lq_o_complete_prd_2 = {`RAT_SIZE{1'b0}};
        lq_o_complete_funct3_1 = {`FUNCT3_WIDTH{1'b0}};
        lq_o_complete_funct3_2 = {`FUNCT3_WIDTH{1'b0}};
        lq_o_complete_raw_data_1 = {`DWIDTH{1'b0}};
        lq_o_complete_raw_data_2 = {`DWIDTH{1'b0}};
        lq_o_complete_addr_1 = {`DWIDTH{1'b0}};
        lq_o_complete_addr_2 = {`DWIDTH{1'b0}};

        for (cidx = 0; cidx < `ROB_SIZE; cidx = cidx + 1) begin
            if (ent_valid[cidx] && ent_query_wait[cidx] && !ent_done[cidx]) begin
                if (!lq_o_sq_query_valid_1) begin
                    lq_o_sq_query_valid_1 = 1'b1;
                    lq_o_sq_query_ptr_1 = cidx[`ROB_IDX_W-1:0];
                    lq_o_sq_query_addr_1 = ent_addr[cidx];
                    lq_o_sq_query_mask_1 = ent_mask[cidx];
                    lq_o_sq_query_tail_snapshot_1 = ent_sq_tail_snapshot[cidx];
                    lq_o_sq_query_older_store_count_1 = ent_older_store_count[cidx];
                end
                else if (!lq_o_sq_query_valid_2) begin
                    lq_o_sq_query_valid_2 = 1'b1;
                    lq_o_sq_query_ptr_2 = cidx[`ROB_IDX_W-1:0];
                    lq_o_sq_query_addr_2 = ent_addr[cidx];
                    lq_o_sq_query_mask_2 = ent_mask[cidx];
                    lq_o_sq_query_tail_snapshot_2 = ent_sq_tail_snapshot[cidx];
                    lq_o_sq_query_older_store_count_2 = ent_older_store_count[cidx];
                end
            end

            if (ent_valid[cidx] && ent_mem_wait[cidx] && !ent_done[cidx]) begin
                if (!lq_o_mem_req_valid_1) begin
                    lq_o_mem_req_valid_1 = 1'b1;
                    lq_o_mem_req_ptr_1 = cidx[`ROB_IDX_W-1:0];
                    lq_o_mem_req_addr_1 = ent_addr[cidx];
                end
                else if (!lq_o_mem_req_valid_2) begin
                    lq_o_mem_req_valid_2 = 1'b1;
                    lq_o_mem_req_ptr_2 = cidx[`ROB_IDX_W-1:0];
                    lq_o_mem_req_addr_2 = ent_addr[cidx];
                end
            end

            if (ent_valid[cidx] && ent_done[cidx] && !ent_complete_sent[cidx]) begin
                if (!lq_o_complete_valid_1) begin
                    lq_o_complete_valid_1 = 1'b1;
                    complete_idx_1 = cidx[`ROB_IDX_W-1:0];
                    lq_o_complete_rob_tag_1 = ent_rob_tag[cidx];
                    lq_o_complete_prd_1 = ent_prd[cidx];
                    lq_o_complete_funct3_1 = ent_funct3[cidx];
                    lq_o_complete_raw_data_1 = ent_raw_data[cidx];
                    lq_o_complete_addr_1 = ent_addr[cidx];
                end
                else if (!lq_o_complete_valid_2) begin
                    lq_o_complete_valid_2 = 1'b1;
                    complete_idx_2 = cidx[`ROB_IDX_W-1:0];
                    lq_o_complete_rob_tag_2 = ent_rob_tag[cidx];
                    lq_o_complete_prd_2 = ent_prd[cidx];
                    lq_o_complete_funct3_2 = ent_funct3[cidx];
                    lq_o_complete_raw_data_2 = ent_raw_data[cidx];
                    lq_o_complete_addr_2 = ent_addr[cidx];
                end
            end
        end
    end

    task handle_sq_response;
        input [`ROB_IDX_W-1:0] ptr;
        input read_mem;
        input forward_valid;
        input wait_resp;
        input [`DWIDTH-1:0] forward_data;
        begin
            if (ent_valid[ptr] && ent_query_wait[ptr] && !ent_done[ptr]) begin
                if (forward_valid) begin
                    ent_query_wait[ptr] <= 1'b0;
                    ent_mem_wait[ptr] <= 1'b0;
                    ent_done[ptr] <= 1'b1;
                    ent_raw_data[ptr] <= forward_data;
                end
                else if (read_mem) begin
                    ent_query_wait[ptr] <= 1'b0;
                    ent_mem_wait[ptr] <= 1'b1;
                end
                else if (wait_resp) begin
                    ent_query_wait[ptr] <= 1'b1;
                    ent_mem_wait[ptr] <= 1'b0;
                end
                else begin
                    ent_query_wait[ptr] <= 1'b1;
                    ent_mem_wait[ptr] <= 1'b0;
                end
            end
        end
    endtask

    task handle_mem_response;
        input [`ROB_IDX_W-1:0] ptr;
        input [`DWIDTH-1:0] data;
        begin
            if (ent_valid[ptr] && ent_mem_wait[ptr] && !ent_done[ptr]) begin
                ent_mem_wait[ptr] <= 1'b0;
                ent_done[ptr] <= 1'b1;
                ent_raw_data[ptr] <= data;
            end
        end
    endtask

    always @(posedge lq_clk or negedge lq_rstn) begin
        if (!lq_rstn) begin
            head_ptr   <= {`ROB_IDX_W{1'b0}};
            tail_ptr   <= {`ROB_IDX_W{1'b0}};
            used_count <= {(`ROB_IDX_W+1){1'b0}};

            for (i = 0; i < `ROB_SIZE; i = i + 1) begin
                ent_valid[i] <= 1'b0;
                ent_addr_valid[i] <= 1'b0;
                ent_query_wait[i] <= 1'b0;
                ent_mem_wait[i] <= 1'b0;
                ent_done[i] <= 1'b0;
                ent_complete_sent[i] <= 1'b0;
                ent_sq_tail_snapshot[i] <= {`ROB_IDX_W{1'b0}};
                ent_older_store_count[i] <= {(`ROB_IDX_W+1){1'b0}};
                ent_rob_tag[i] <= {`ROB_IDX_W{1'b0}};
                ent_prd[i] <= {`RAT_SIZE{1'b0}};
                ent_funct3[i] <= {`FUNCT3_WIDTH{1'b0}};
                ent_addr[i] <= {`DWIDTH{1'b0}};
                ent_mask[i] <= 4'b0000;
                ent_raw_data[i] <= {`DWIDTH{1'b0}};
            end
        end
        else if (lq_i_ce) begin
            if (commit1_ok) begin
                ent_valid[head_ptr] <= 1'b0;
                ent_addr_valid[head_ptr] <= 1'b0;
                ent_query_wait[head_ptr] <= 1'b0;
                ent_mem_wait[head_ptr] <= 1'b0;
                ent_done[head_ptr] <= 1'b0;
                ent_complete_sent[head_ptr] <= 1'b0;
            end

            if (commit2_ok) begin
                ent_valid[commit2_ptr] <= 1'b0;
                ent_addr_valid[commit2_ptr] <= 1'b0;
                ent_query_wait[commit2_ptr] <= 1'b0;
                ent_mem_wait[commit2_ptr] <= 1'b0;
                ent_done[commit2_ptr] <= 1'b0;
                ent_complete_sent[commit2_ptr] <= 1'b0;
            end

            if (alloc1_ok) begin
                ent_valid[alloc1_ptr] <= 1'b1;
                ent_addr_valid[alloc1_ptr] <= 1'b0;
                ent_query_wait[alloc1_ptr] <= 1'b0;
                ent_mem_wait[alloc1_ptr] <= 1'b0;
                ent_done[alloc1_ptr] <= 1'b0;
                ent_complete_sent[alloc1_ptr] <= 1'b0;
                ent_sq_tail_snapshot[alloc1_ptr] <= lq_i_alloc_sq_tail_snapshot_1;
                ent_older_store_count[alloc1_ptr] <= lq_i_alloc_older_store_count_1;
                ent_rob_tag[alloc1_ptr] <= {`ROB_IDX_W{1'b0}};
                ent_prd[alloc1_ptr] <= {`RAT_SIZE{1'b0}};
                ent_funct3[alloc1_ptr] <= {`FUNCT3_WIDTH{1'b0}};
                ent_addr[alloc1_ptr] <= {`DWIDTH{1'b0}};
                ent_mask[alloc1_ptr] <= 4'b0000;
                ent_raw_data[alloc1_ptr] <= {`DWIDTH{1'b0}};
            end

            if (alloc2_ok) begin
                ent_valid[alloc2_ptr] <= 1'b1;
                ent_addr_valid[alloc2_ptr] <= 1'b0;
                ent_query_wait[alloc2_ptr] <= 1'b0;
                ent_mem_wait[alloc2_ptr] <= 1'b0;
                ent_done[alloc2_ptr] <= 1'b0;
                ent_complete_sent[alloc2_ptr] <= 1'b0;
ent_sq_tail_snapshot[alloc2_ptr] <= lq_i_alloc_sq_tail_snapshot_2;
                ent_older_store_count[alloc2_ptr] <= lq_i_alloc_older_store_count_2;
                ent_rob_tag[alloc2_ptr] <= {`ROB_IDX_W{1'b0}};
                ent_prd[alloc2_ptr] <= {`RAT_SIZE{1'b0}};
                ent_funct3[alloc2_ptr] <= {`FUNCT3_WIDTH{1'b0}};
                ent_addr[alloc2_ptr] <= {`DWIDTH{1'b0}};
                ent_mask[alloc2_ptr] <= 4'b0000;
                ent_raw_data[alloc2_ptr] <= {`DWIDTH{1'b0}};
            end

            if (lq_i_exec_valid_1 && ent_valid[lq_i_exec_ptr_1]) begin
                ent_addr_valid[lq_i_exec_ptr_1] <= 1'b1;
                ent_query_wait[lq_i_exec_ptr_1] <= 1'b1;
                ent_mem_wait[lq_i_exec_ptr_1] <= 1'b0;
                ent_done[lq_i_exec_ptr_1] <= 1'b0;
                ent_complete_sent[lq_i_exec_ptr_1] <= 1'b0;
                ent_rob_tag[lq_i_exec_ptr_1] <= lq_i_exec_rob_tag_1;
                ent_prd[lq_i_exec_ptr_1] <= lq_i_exec_prd_1;
                ent_funct3[lq_i_exec_ptr_1] <= lq_i_exec_funct3_1;
                ent_addr[lq_i_exec_ptr_1] <= lq_i_exec_addr_1;
                ent_mask[lq_i_exec_ptr_1] <= load_mask_from_addr(lq_i_exec_funct3_1, lq_i_exec_addr_1);
            end

            if (lq_i_exec_valid_2 && ent_valid[lq_i_exec_ptr_2]) begin
                ent_addr_valid[lq_i_exec_ptr_2] <= 1'b1;
                ent_query_wait[lq_i_exec_ptr_2] <= 1'b1;
                ent_mem_wait[lq_i_exec_ptr_2] <= 1'b0;
                ent_done[lq_i_exec_ptr_2] <= 1'b0;
                ent_complete_sent[lq_i_exec_ptr_2] <= 1'b0;
                ent_rob_tag[lq_i_exec_ptr_2] <= lq_i_exec_rob_tag_2;
                ent_prd[lq_i_exec_ptr_2] <= lq_i_exec_prd_2;
                ent_funct3[lq_i_exec_ptr_2] <= lq_i_exec_funct3_2;
                ent_addr[lq_i_exec_ptr_2] <= lq_i_exec_addr_2;
                ent_mask[lq_i_exec_ptr_2] <= load_mask_from_addr(lq_i_exec_funct3_2, lq_i_exec_addr_2);
            end

            if (lq_i_sq_resp_valid_1) begin
                handle_sq_response(lq_i_sq_resp_ptr_1,
                                   lq_i_sq_resp_read_mem_1,
                                   lq_i_sq_resp_forward_valid_1,
                                   lq_i_sq_resp_wait_1,
                                   lq_i_sq_resp_forward_data_1);
            end
            if (lq_i_sq_resp_valid_2) begin
                handle_sq_response(lq_i_sq_resp_ptr_2,
                                   lq_i_sq_resp_read_mem_2,
                                   lq_i_sq_resp_forward_valid_2,
                                   lq_i_sq_resp_wait_2,
                                   lq_i_sq_resp_forward_data_2);
            end

            if (lq_i_mem_resp_valid_1) begin
                handle_mem_response(lq_i_mem_resp_ptr_1, lq_i_mem_resp_data_1);
            end
            if (lq_i_mem_resp_valid_2) begin
                handle_mem_response(lq_i_mem_resp_ptr_2, lq_i_mem_resp_data_2);
            end
            if (lq_i_complete_accept_1 && lq_o_complete_valid_1) begin
                ent_complete_sent[complete_idx_1] <= 1'b1;
            end
            if (lq_i_complete_accept_2 && lq_o_complete_valid_2) begin
                ent_complete_sent[complete_idx_2] <= 1'b1;
            end

            head_ptr   <= head_ptr + pop_n[`ROB_IDX_W-1:0];
            tail_ptr   <= tail_ptr + push_n[`ROB_IDX_W-1:0];
            used_count <= used_count + push_n - pop_n;
        end
    end
endmodule