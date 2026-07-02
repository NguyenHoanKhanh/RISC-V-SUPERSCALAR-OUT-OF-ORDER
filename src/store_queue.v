`timescale 1ns/1ps

// Simple store-only Store Queue.
//
// This module does only the minimum needed for precise stores:
// 1) Dispatch allocates a queue entry for each STORE and receives sq_idx.
// 2) Execute fills that sq_idx with address, data and byte mask.
// 3) Commit writes memory only when the committed store is the oldest filled
//    queue entry.
//
// It also answers Load Queue ordering/forwarding queries for older stores.
// Recovery/cache retry logic is intentionally outside this simple block.
// SQ size is kept equal to ROB_SIZE so ROB_IDX_W can be reused.
module store_queue (
    input                       sq_clk,
    input                       sq_rstn,
    input                       sq_i_ce,

    // Allocate from Dispatch/Rename, only for STORE instructions.
    input                       sq_i_alloc_valid_1,
    output reg [`ROB_IDX_W-1:0] sq_o_alloc_ptr_1,

    input                       sq_i_alloc_valid_2,
    output reg [`ROB_IDX_W-1:0] sq_o_alloc_ptr_2,

    // Fill from Execute.
    input                       sq_i_fill_valid_1,
    input      [`ROB_IDX_W-1:0] sq_i_fill_ptr_1,
    input      [`DWIDTH-1:0]    sq_i_fill_addr_1,
    input      [`DWIDTH-1:0]    sq_i_fill_data_1,
    input      [3:0]            sq_i_fill_mask_1,

    input                       sq_i_fill_valid_2,
    input      [`ROB_IDX_W-1:0] sq_i_fill_ptr_2,
    input      [`DWIDTH-1:0]    sq_i_fill_addr_2,
    input      [`DWIDTH-1:0]    sq_i_fill_data_2,
    input      [3:0]            sq_i_fill_mask_2,

    // Commit request from ROB. Assert valid only for committed STOREs.
    input                       sq_i_commit_valid_1,
    input      [`ROB_IDX_W-1:0] sq_i_commit_ptr_1,

    input                       sq_i_commit_valid_2,
    input      [`ROB_IDX_W-1:0] sq_i_commit_ptr_2,

    // Store write port to Data Memory.
    output reg                  sq_o_mem_ce_1,
    output reg                  sq_o_mem_wr_en_1,
    output reg [`DWIDTH-1:0]    sq_o_mem_addr_1,
    output reg [`DWIDTH-1:0]    sq_o_mem_data_1,
    output reg [3:0]            sq_o_mem_mask_1,

    output reg                  sq_o_mem_ce_2,
    output reg                  sq_o_mem_wr_en_2,
    output reg [`DWIDTH-1:0]    sq_o_mem_addr_2,
    output reg [`DWIDTH-1:0]    sq_o_mem_data_2,
    output reg [3:0]            sq_o_mem_mask_2,

    // Query from Load Queue.
    input                       sq_i_load_query_valid_1,
    input      [`ROB_IDX_W-1:0] sq_i_load_query_ptr_1,
    input      [`DWIDTH-1:0]    sq_i_load_query_addr_1,
    input      [3:0]            sq_i_load_query_mask_1,
    input      [`ROB_IDX_W-1:0] sq_i_load_query_tail_snapshot_1,
    input      [`ROB_IDX_W:0]   sq_i_load_query_older_store_count_1,
    output reg                  sq_o_load_resp_valid_1,
    output reg [`ROB_IDX_W-1:0] sq_o_load_resp_ptr_1,
    output reg                  sq_o_load_resp_read_mem_1,
    output reg                  sq_o_load_resp_forward_valid_1,
output reg                  sq_o_load_resp_wait_1,
    output reg [`DWIDTH-1:0]    sq_o_load_resp_forward_data_1,

    input                       sq_i_load_query_valid_2,
    input      [`ROB_IDX_W-1:0] sq_i_load_query_ptr_2,
    input      [`DWIDTH-1:0]    sq_i_load_query_addr_2,
    input      [3:0]            sq_i_load_query_mask_2,
    input      [`ROB_IDX_W-1:0] sq_i_load_query_tail_snapshot_2,
    input      [`ROB_IDX_W:0]   sq_i_load_query_older_store_count_2,
    output reg                  sq_o_load_resp_valid_2,
    output reg [`ROB_IDX_W-1:0] sq_o_load_resp_ptr_2,
    output reg                  sq_o_load_resp_read_mem_2,
    output reg                  sq_o_load_resp_forward_valid_2,
    output reg                  sq_o_load_resp_wait_2,
    output reg [`DWIDTH-1:0]    sq_o_load_resp_forward_data_2,

    output     [`ROB_IDX_W:0]   sq_o_count,
    output     [`ROB_IDX_W-1:0] sq_o_tail_ptr
);

    localparam [`ROB_IDX_W:0] SQ_CAPACITY = `SQ_SIZE;
    localparam [`ROB_IDX_W:0] SQ_ONE      = {{`ROB_IDX_W{1'b0}}, 1'b1};
    localparam [`ROB_IDX_W:0] SQ_TWO      = {{(`ROB_IDX_W-1){1'b0}}, 2'b10};
    localparam [`ROB_IDX_W-1:0] SQ_LAST_IDX = `SQ_SIZE - 1;
    localparam [`ROB_IDX_W-1:0] SQ_LAST_MINUS1 = `SQ_SIZE - 2;
    localparam integer SQ_HALF = `SQ_SIZE / 2;

    reg                  ent_valid  [0:`SQ_SIZE-1];
    reg                  ent_filled [0:`SQ_SIZE-1];
    reg [`DWIDTH-1:0]    ent_addr   [0:`SQ_SIZE-1];
    reg [`DWIDTH-1:0]    ent_data   [0:`SQ_SIZE-1];
    reg [3:0]            ent_mask   [0:`SQ_SIZE-1];

    reg [`ROB_IDX_W-1:0] head_ptr;
    reg [`ROB_IDX_W-1:0] tail_ptr;
    reg [`ROB_IDX_W:0]   used_count;

    integer i;
    integer q_i;

    wire [`ROB_IDX_W:0] free_count = SQ_CAPACITY - used_count;

    reg                  query_resp_valid_1;
    reg [`ROB_IDX_W-1:0] query_resp_ptr_1;
    reg                  query_resp_read_mem_1;
    reg                  query_resp_forward_valid_1;
    reg                  query_resp_wait_1;
    reg [`ROB_IDX_W-1:0] query_resp_forward_idx_1;

    reg                  query_resp_valid_2;
    reg [`ROB_IDX_W-1:0] query_resp_ptr_2;
    reg                  query_resp_read_mem_2;
    reg                  query_resp_forward_valid_2;
    reg                  query_resp_wait_2;
    reg [`ROB_IDX_W-1:0] query_resp_forward_idx_2;

    reg                  query_search_valid_1;
    reg [`ROB_IDX_W-1:0] query_search_ptr_1;
    reg                  query_search_read_mem_1;
    reg                  query_search_forward_valid_1;
    reg                  query_search_wait_1;
    reg [`ROB_IDX_W-1:0] query_search_forward_idx_1;

    reg                  query_search_valid_2;
    reg [`ROB_IDX_W-1:0] query_search_ptr_2;
    reg                  query_search_read_mem_2;
    reg                  query_search_forward_valid_2;
    reg                  query_search_wait_2;
    reg [`ROB_IDX_W-1:0] query_search_forward_idx_2;

    function [`ROB_IDX_W-1:0] sq_ptr_plus1;
        input [`ROB_IDX_W-1:0] ptr;
        begin
            sq_ptr_plus1 = (ptr == SQ_LAST_IDX) ? {`ROB_IDX_W{1'b0}} :
                                                (ptr + {{(`ROB_IDX_W-1){1'b0}}, 1'b1});
        end
    endfunction

    function [`ROB_IDX_W-1:0] sq_ptr_plus2;
        input [`ROB_IDX_W-1:0] ptr;
        begin
            sq_ptr_plus2 = (ptr >= SQ_LAST_MINUS1) ? (ptr - SQ_LAST_MINUS1) :
                                                     (ptr + {{(`ROB_IDX_W-2){1'b0}}, 2'b10});
        end
    endfunction

    function [`ROB_IDX_W-1:0] sq_ptr_add_count;
        input [`ROB_IDX_W-1:0] ptr;
        input [`ROB_IDX_W:0] count;
        begin
            if (count == SQ_TWO) begin
                sq_ptr_add_count = sq_ptr_plus2(ptr);
            end
            else if (count == SQ_ONE) begin
                sq_ptr_add_count = sq_ptr_plus1(ptr);
            end
            else begin
                sq_ptr_add_count = ptr;
            end
        end
    endfunction

    wire [`ROB_IDX_W-1:0] head_plus_1 = sq_ptr_plus1(head_ptr);
    wire [`ROB_IDX_W-1:0] tail_plus_1 = sq_ptr_plus1(tail_ptr);

    wire commit1_ok;
    wire commit2_ok;
    wire [`ROB_IDX_W-1:0] commit2_ptr;

    assign commit1_ok = sq_i_ce &&
                        sq_i_commit_valid_1 &&
                        (sq_i_commit_ptr_1 == head_ptr) &&
                        ent_valid[head_ptr] &&
                        ent_filled[head_ptr];

    assign commit2_ptr = commit1_ok ? head_plus_1 : head_ptr;

    assign commit2_ok = sq_i_ce &&
                        sq_i_commit_valid_2 &&
                        (sq_i_commit_ptr_2 == commit2_ptr) &&
                        ent_valid[commit2_ptr] &&
                        ent_filled[commit2_ptr];

    wire [`ROB_IDX_W:0] pop_n = {{`ROB_IDX_W{1'b0}}, commit1_ok} +
                                {{`ROB_IDX_W{1'b0}}, commit2_ok};

    assign sq_o_count    = used_count;
    assign sq_o_tail_ptr = tail_ptr;

    wire alloc1_req = sq_i_ce && sq_i_alloc_valid_1;
    wire alloc2_req = sq_i_ce && sq_i_alloc_valid_2;
    wire alloc1_ok  = alloc1_req && (free_count >= SQ_ONE);
    wire alloc2_ok  = alloc2_req &&
                      (alloc1_ok ? (free_count >= SQ_TWO) :
                                   (free_count >= SQ_ONE));

    wire [`ROB_IDX_W-1:0] alloc1_ptr = tail_ptr;
    wire [`ROB_IDX_W-1:0] alloc2_ptr =
        alloc1_ok ? sq_ptr_plus1(tail_ptr) : tail_ptr;

    always @(*) begin
        sq_o_alloc_ptr_1  = alloc1_ptr;

        // If lane2 is actually requesting alone, it gets tail_ptr.
        // Otherwise expose tail+1 as the natural second slot.
        sq_o_alloc_ptr_2  = sq_i_alloc_valid_2 ? alloc2_ptr : tail_plus_1;
    end

    wire [`ROB_IDX_W:0] push_n = {{`ROB_IDX_W{1'b0}}, alloc1_ok} +
                                 {{`ROB_IDX_W{1'b0}}, alloc2_ok};

    function query_in_older_range;
        input [`ROB_IDX_W-1:0] idx;
        input [`ROB_IDX_W-1:0] tail_snapshot;
        input [`ROB_IDX_W:0] older_store_count;
        begin
            if (older_store_count == {(`ROB_IDX_W+1){1'b0}}) begin
                query_in_older_range = 1'b0;
            end
            else if (older_store_count >= SQ_CAPACITY) begin
                query_in_older_range = 1'b1;
            end
            else if (head_ptr < tail_snapshot) begin
                query_in_older_range = (idx >= head_ptr) && (idx < tail_snapshot);
            end
            else if (head_ptr > tail_snapshot) begin
                query_in_older_range = (idx >= head_ptr) || (idx < tail_snapshot);
            end
            else begin
                query_in_older_range = 1'b0;
            end
        end
    endfunction

    task build_load_response_half;
        input                       query_valid;
        input      [`DWIDTH-1:0]    query_addr;
        input      [3:0]            query_mask;
        input      [`ROB_IDX_W-1:0] tail_snapshot;
        input      [`ROB_IDX_W:0]   older_store_count;
        input      integer          begin_idx;
        input      integer          end_idx;
        output                      half_match;
        output                      half_wait;
        output     [`ROB_IDX_W-1:0] half_best_idx;

        reg found_unresolved;
        reg found_partial;
        begin
            q_i = 0;
            half_match = 1'b0;
            half_wait = 1'b0;
            half_best_idx = {`ROB_IDX_W{1'b0}};
            found_unresolved = 1'b0;
            found_partial = 1'b0;

            if (query_valid) begin
                for (q_i = begin_idx; q_i < end_idx; q_i = q_i + 1) begin
                    if (query_in_older_range(q_i[`ROB_IDX_W-1:0],
                                             tail_snapshot,
                                             older_store_count) &&
                        ent_valid[q_i]) begin
                        if (!ent_filled[q_i]) begin
                            found_unresolved = 1'b1;
                        end
                        else if (ent_addr[q_i][`DWIDTH-1:2] == query_addr[`DWIDTH-1:2]) begin
                            if ((ent_mask[q_i] & query_mask) == query_mask) begin
                                half_match = 1'b1;
                                half_best_idx = q_i[`ROB_IDX_W-1:0];
                            end
                            else if ((ent_mask[q_i] & query_mask) != 4'b0000) begin
                                found_partial = 1'b1;
                            end
                        end
                    end
                end

                half_wait = found_unresolved || found_partial;
            end
        end
    endtask

    task build_load_response;
        input                       query_valid;
        input      [`ROB_IDX_W-1:0] query_ptr;
        input      [`DWIDTH-1:0]    query_addr;
        input      [3:0]            query_mask;
        input      [`ROB_IDX_W-1:0] tail_snapshot;
        input      [`ROB_IDX_W:0]   older_store_count;
        output                      resp_valid;
        output     [`ROB_IDX_W-1:0] resp_ptr;
        output                      resp_read_mem;
        output                      resp_forward_valid;
        output                      resp_wait;
        output     [`ROB_IDX_W-1:0] resp_forward_idx;

        reg low_match;
        reg high_match;
        reg low_wait;
        reg high_wait;
        reg [`ROB_IDX_W-1:0] low_best_idx;
        reg [`ROB_IDX_W-1:0] high_best_idx;
        reg found_match;
        reg wrap_order;
        begin
            resp_valid = query_valid;
            resp_ptr = query_ptr;
            resp_read_mem = 1'b0;
            resp_forward_valid = 1'b0;
            resp_wait = 1'b0;
            resp_forward_idx = {`ROB_IDX_W{1'b0}};

            low_match = 1'b0;
            high_match = 1'b0;
            low_wait = 1'b0;
            high_wait = 1'b0;
            low_best_idx = {`ROB_IDX_W{1'b0}};
            high_best_idx = {`ROB_IDX_W{1'b0}};
            wrap_order = 1'b0;

            if (query_valid) begin
                build_load_response_half(query_valid,
                                         query_addr,
                                         query_mask,
                                         tail_snapshot,
                                         older_store_count,
                                         0,
                                         SQ_HALF,
                                         low_match,
                                         low_wait,
                                         low_best_idx);

                build_load_response_half(query_valid,
                                         query_addr,
                                         query_mask,
                                         tail_snapshot,
                                         older_store_count,
                                         SQ_HALF,
                                         `SQ_SIZE,
                                         high_match,
                                         high_wait,
                                         high_best_idx);

                found_match = low_match || high_match;
                wrap_order = (older_store_count >= SQ_CAPACITY) ?
                             (head_ptr != {`ROB_IDX_W{1'b0}}) :
                             (head_ptr > tail_snapshot);

                if (low_wait || high_wait) begin
                    resp_wait = 1'b1;
                end
                else if (found_match) begin
                    resp_forward_valid = 1'b1;
                    if (wrap_order) begin
                        resp_forward_idx = low_match ? low_best_idx : high_best_idx;
                    end
                    else if (high_match) begin
                        resp_forward_idx = high_best_idx;
                    end
                    else begin
                        resp_forward_idx = low_best_idx;
                    end
                end
                else begin
                    resp_read_mem = 1'b1;
                end

            end
        end
    endtask

    always @(*) begin
        sq_o_mem_ce_1       = commit1_ok;
        sq_o_mem_wr_en_1    = commit1_ok;
        sq_o_mem_addr_1     = {`DWIDTH{1'b0}};
        sq_o_mem_data_1     = {`DWIDTH{1'b0}};
        sq_o_mem_mask_1     = 4'b0000;

        sq_o_mem_ce_2       = commit2_ok;
        sq_o_mem_wr_en_2    = commit2_ok;
        sq_o_mem_addr_2     = {`DWIDTH{1'b0}};
        sq_o_mem_data_2     = {`DWIDTH{1'b0}};
        sq_o_mem_mask_2     = 4'b0000;

        if (commit1_ok) begin
            sq_o_mem_addr_1 = ent_addr[head_ptr];
            sq_o_mem_data_1 = ent_data[head_ptr];
            sq_o_mem_mask_1 = ent_mask[head_ptr];
        end

        if (commit2_ok) begin
            sq_o_mem_addr_2 = ent_addr[commit2_ptr];
            sq_o_mem_data_2 = ent_data[commit2_ptr];
            sq_o_mem_mask_2 = ent_mask[commit2_ptr];
        end

        build_load_response(sq_i_load_query_valid_1,
                            sq_i_load_query_ptr_1,
                            sq_i_load_query_addr_1,
                            sq_i_load_query_mask_1,
                            sq_i_load_query_tail_snapshot_1,
                            sq_i_load_query_older_store_count_1,
                            query_search_valid_1,
                            query_search_ptr_1,
                            query_search_read_mem_1,
                            query_search_forward_valid_1,
                            query_search_wait_1,
                            query_search_forward_idx_1);

        build_load_response(sq_i_load_query_valid_2,
                            sq_i_load_query_ptr_2,
                            sq_i_load_query_addr_2,
                            sq_i_load_query_mask_2,
                            sq_i_load_query_tail_snapshot_2,
                            sq_i_load_query_older_store_count_2,
                            query_search_valid_2,
                            query_search_ptr_2,
                            query_search_read_mem_2,
                            query_search_forward_valid_2,
                            query_search_wait_2,
                            query_search_forward_idx_2);

        sq_o_load_resp_valid_1 = query_resp_valid_1;
        sq_o_load_resp_ptr_1 = query_resp_ptr_1;
        sq_o_load_resp_read_mem_1 = query_resp_read_mem_1;
        sq_o_load_resp_forward_valid_1 = query_resp_forward_valid_1;
        sq_o_load_resp_wait_1 = query_resp_wait_1;
        sq_o_load_resp_forward_data_1 =
            query_resp_forward_valid_1 ? ent_data[query_resp_forward_idx_1] :
                                         {`DWIDTH{1'b0}};

        sq_o_load_resp_valid_2 = query_resp_valid_2;
        sq_o_load_resp_ptr_2 = query_resp_ptr_2;
        sq_o_load_resp_read_mem_2 = query_resp_read_mem_2;
        sq_o_load_resp_forward_valid_2 = query_resp_forward_valid_2;
        sq_o_load_resp_wait_2 = query_resp_wait_2;
        sq_o_load_resp_forward_data_2 =
            query_resp_forward_valid_2 ? ent_data[query_resp_forward_idx_2] :
                                         {`DWIDTH{1'b0}};
    end

    always @(posedge sq_clk or negedge sq_rstn) begin
        if (!sq_rstn) begin
            head_ptr   <= {`ROB_IDX_W{1'b0}};
            tail_ptr   <= {`ROB_IDX_W{1'b0}};
            used_count <= {(`ROB_IDX_W+1){1'b0}};
            query_resp_valid_1 <= 1'b0;
            query_resp_valid_2 <= 1'b0;
            query_resp_ptr_1 <= {`ROB_IDX_W{1'b0}};
            query_resp_ptr_2 <= {`ROB_IDX_W{1'b0}};
            query_resp_read_mem_1 <= 1'b0;
            query_resp_read_mem_2 <= 1'b0;
            query_resp_forward_valid_1 <= 1'b0;
            query_resp_forward_valid_2 <= 1'b0;
            query_resp_wait_1 <= 1'b0;
            query_resp_wait_2 <= 1'b0;
            query_resp_forward_idx_1 <= {`ROB_IDX_W{1'b0}};
            query_resp_forward_idx_2 <= {`ROB_IDX_W{1'b0}};

            for (i = 0; i < `SQ_SIZE; i = i + 1) begin
                ent_valid[i]  <= 1'b0;
                ent_filled[i] <= 1'b0;
                ent_addr[i]   <= {`DWIDTH{1'b0}};
                ent_data[i]   <= {`DWIDTH{1'b0}};
                ent_mask[i]   <= 4'b0000;
            end
        end
        else if (sq_i_ce) begin
            query_resp_valid_1 <= query_search_valid_1;
            query_resp_ptr_1 <= query_search_ptr_1;
            query_resp_read_mem_1 <= query_search_read_mem_1;
            query_resp_forward_valid_1 <= query_search_forward_valid_1;
            query_resp_wait_1 <= query_search_wait_1;
            query_resp_forward_idx_1 <= query_search_forward_idx_1;

            query_resp_valid_2 <= query_search_valid_2;
            query_resp_ptr_2 <= query_search_ptr_2;
            query_resp_read_mem_2 <= query_search_read_mem_2;
            query_resp_forward_valid_2 <= query_search_forward_valid_2;
            query_resp_wait_2 <= query_search_wait_2;
            query_resp_forward_idx_2 <= query_search_forward_idx_2;

            if (commit1_ok) begin
                ent_valid[head_ptr]  <= 1'b0;
                ent_filled[head_ptr] <= 1'b0;
            end

            if (commit2_ok) begin
                ent_valid[commit2_ptr]  <= 1'b0;
                ent_filled[commit2_ptr] <= 1'b0;
            end

            if (alloc1_ok) begin
                ent_valid[alloc1_ptr]  <= 1'b1;
                ent_filled[alloc1_ptr] <= 1'b0;
                ent_addr[alloc1_ptr]   <= {`DWIDTH{1'b0}};
                ent_data[alloc1_ptr]   <= {`DWIDTH{1'b0}};
                ent_mask[alloc1_ptr]   <= 4'b0000;
            end

            if (alloc2_ok) begin
                ent_valid[alloc2_ptr]  <= 1'b1;
                ent_filled[alloc2_ptr] <= 1'b0;
                ent_addr[alloc2_ptr]   <= {`DWIDTH{1'b0}};
                ent_data[alloc2_ptr]   <= {`DWIDTH{1'b0}};
                ent_mask[alloc2_ptr]   <= 4'b0000;
            end

            if (sq_i_fill_valid_1 && ent_valid[sq_i_fill_ptr_1]) begin
                ent_addr[sq_i_fill_ptr_1]   <= sq_i_fill_addr_1;
                ent_data[sq_i_fill_ptr_1]   <= sq_i_fill_data_1;
                ent_mask[sq_i_fill_ptr_1]   <= sq_i_fill_mask_1;
                ent_filled[sq_i_fill_ptr_1] <= 1'b1;
            end

            if (sq_i_fill_valid_2 && ent_valid[sq_i_fill_ptr_2]) begin
                ent_addr[sq_i_fill_ptr_2]   <= sq_i_fill_addr_2;
                ent_data[sq_i_fill_ptr_2]   <= sq_i_fill_data_2;
                ent_mask[sq_i_fill_ptr_2]   <= sq_i_fill_mask_2;
                ent_filled[sq_i_fill_ptr_2] <= 1'b1;
            end

            head_ptr   <= sq_ptr_add_count(head_ptr, pop_n);
            tail_ptr   <= sq_ptr_add_count(tail_ptr, push_n);
            used_count <= used_count + push_n - pop_n;
        end
    end
endmodule
