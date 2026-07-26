`ifdef USE_1CYCLE
`include "./src/datapath.v"
`elsif USE_SRC2
`include "./src_2/datapath_fix.v"
`elsif USE_DHRYSTONE_SRC_COPY
`include "./src copy/datapath_fix.v"
`else
`include "./src/datapath_fix.v"
`endif
`timescale 1ns/1ps

module tb_datapath;
    reg dp_clk;
    reg dp_rstn;
    reg dp_i_ce;
    integer imem_init_i;
    integer drain_i;

    wire [`PC_WIDTH - 1 : 0]  dp_o_pc_1, dp_o_pc_2;
    wire [`DWIDTH - 1 : 0]    dp_o_data_1, dp_o_data_2;
    reg [`AWIDTH - 1 : 0]     arf_display_addr_1, arf_display_addr_2;
    wire [`DWIDTH - 1 : 0]    arf_display_data_1, arf_display_data_2;


    localparam [`IWIDTH - 1 : 0] NOP_INSTR = 32'h00000013;
    localparam integer DRAIN_CYCLES = (`PROGRAM_INSTRS * 12) + 500;
    localparam integer SCOREBOARD_SETTLE_CYCLES = 80;
    reg [`PC_WIDTH - 1 : 0] debug_pc_lo;
    reg [`PC_WIDTH - 1 : 0] debug_pc_hi;
    localparam [`PC_WIDTH - 1 : 0] DEBUG_ADD_T5_PC = 32'h00000084;
    reg print_commits;
    reg print_profile;
    reg print_raw_regs;
    reg print_markers;
    reg debug_verbose;
    reg debug_load_flow;
    reg debug_store_flow;
    reg spec_lq_debug;
    reg raw_result;
    reg ignore_scoreboard;
    reg no_commit_limit;
    reg beebs_stop_on_x29;
    reg beebs_debug_head;
    reg beebs_done;
    reg [`DWIDTH - 1 : 0] beebs_status;
    reg dhrystone_report;
    reg dhrystone_active;
    reg dhrystone_done;
    integer dhrystone_runs;
    integer dhrystone_start_cycle;
    integer dhrystone_cycle_count;
    integer dhrystone_start_commit;
    integer dhrystone_commit_count;
    real dhrystone_fmax_mhz;
    real dhrystone_dmips;
    real dhrystone_dmips_mhz;
    real dhrystone_per_sec;
    integer max_drain_cycles;
    integer spec_lq_restore_sample_count;
    integer spec_lq_unknown_sample_count;
    datapath dut (
        .dp_clk(dp_clk),
        .dp_rstn(dp_rstn),
        .dp_i_ce(dp_i_ce),
        .dp_o_pc_1(dp_o_pc_1),
        .dp_o_pc_2(dp_o_pc_2),
        .dp_o_data_1(dp_o_data_1),
        .dp_o_data_2(dp_o_data_2),
        .dp_i_arf_display_addr_1(arf_display_addr_1),
        .dp_o_arf_display_data_1(arf_display_data_1),
        .dp_i_arf_display_addr_2(arf_display_addr_2),
        .dp_o_arf_display_data_2(arf_display_data_2)
    );
  
    initial begin
        dp_clk = 1'b0;
        dp_rstn = 1'b0;
        dp_i_ce = 1'b0;
        print_commits = 1'b0;
        print_profile = 1'b0;
        print_raw_regs = 1'b0;
        print_markers = 1'b0;
        debug_verbose = 1'b0;
        debug_load_flow = 1'b0;
        debug_store_flow = 1'b0;
        spec_lq_debug = 1'b0;
        raw_result = 1'b0;
        ignore_scoreboard = 1'b0;
        no_commit_limit = 1'b0;
        beebs_stop_on_x29 = 1'b0;
        beebs_debug_head = 1'b0;
        beebs_done = 1'b0;
        beebs_status = {`DWIDTH{1'b0}};
        dhrystone_report = 1'b0;
        dhrystone_active = 1'b0;
        dhrystone_done = 1'b0;
        dhrystone_runs = 0;
        dhrystone_start_cycle = 0;
        dhrystone_cycle_count = 0;
        dhrystone_start_commit = 0;
        dhrystone_commit_count = 0;
        dhrystone_fmax_mhz = 0.0;
        dhrystone_dmips = 0.0;
        dhrystone_dmips_mhz = 0.0;
        dhrystone_per_sec = 0.0;
        max_drain_cycles = DRAIN_CYCLES;
        spec_lq_restore_sample_count = 0;
        spec_lq_unknown_sample_count = 0;
        debug_pc_lo = 32'h00000400;
        debug_pc_hi = 32'h00000480;
        arf_display_addr_1 = {`AWIDTH{1'b0}};
        arf_display_addr_2 = {`AWIDTH{1'b0}};
        print_commits = $test$plusargs("PRINT_COMMITS");
        print_profile = $test$plusargs("PRINT_PROFILE");
        print_raw_regs = $test$plusargs("PRINT_RAW_REGS");
        print_markers = $test$plusargs("PRINT_MARKERS");
        debug_verbose = $test$plusargs("DEBUG_VERBOSE");
        debug_load_flow = $test$plusargs("DEBUG_LOAD_FLOW");
        debug_store_flow = $test$plusargs("DEBUG_STORE_FLOW");
        spec_lq_debug = $test$plusargs("SPEC_LQ_DEBUG");
        raw_result = $test$plusargs("RAW_RESULT");
        ignore_scoreboard = $test$plusargs("IGNORE_SCOREBOARD");
        no_commit_limit = $test$plusargs("NO_COMMIT_LIMIT");
        beebs_stop_on_x29 = $test$plusargs("BEEBS_STOP_ON_X29");
        beebs_debug_head = $test$plusargs("BEEBS_DEBUG_HEAD");
        dhrystone_report = $test$plusargs("DHRYSTONE_REPORT");
        if (!$value$plusargs("DHRYSTONE_RUNS=%d", dhrystone_runs)) begin
          dhrystone_runs = 0;
        end
        if (!$value$plusargs("FMAX_MHZ=%f", dhrystone_fmax_mhz)) begin
          dhrystone_fmax_mhz = 0.0;
        end
        if (!$value$plusargs("MAX_CYCLES=%d", max_drain_cycles)) begin
          max_drain_cycles = DRAIN_CYCLES;
        end
        if (!$value$plusargs("DEBUG_PC_LO=%h", debug_pc_lo)) begin
          debug_pc_lo = 32'h00000400;
        end
        if (!$value$plusargs("DEBUG_PC_HI=%h", debug_pc_hi)) begin
          debug_pc_hi = 32'h00000480;
        end
    end

    always #5 dp_clk = ~dp_clk;

    initial begin
        if ($test$plusargs("DUMP_VCD")) begin
            $dumpfile("sim/datapath.vcd");
            $dumpvars(0, tb_datapath);
        end
    end

    task reset (input integer count);
      begin
        dp_rstn = 1'b0;
        repeat(count) @(posedge dp_clk);
        dp_rstn = 1'b1;
      end
    endtask

    initial begin
      reset(2);

      // Convert all unused IMEM entries to NOP so the real program appears only once.
      for (imem_init_i = `PROGRAM_INSTRS; imem_init_i < `DEPTH; imem_init_i = imem_init_i + 1) begin
        dut.u_imem.mem_instr[imem_init_i] = NOP_INSTR;
      end

      // Keep fetch enabled during the run. The datapath front-end stalls itself
      // through fe_ce when decode/rename cannot accept a new packet.
      @(posedge dp_clk);
      dp_i_ce = 1'b1;

      drain_i = 0;
      scoreboard_settle_i = 0;
      while ((drain_i < max_drain_cycles) &&
             (no_commit_limit || (commit_count < (`PROGRAM_INSTRS + 200))) &&
             !(raw_result && !no_commit_limit && (commit_count >= `PROGRAM_INSTRS)) &&
             !(beebs_stop_on_x29 && beebs_done) &&
             !scoreboard_done) begin
        @(posedge dp_clk);
        drain_i = drain_i + 1;
        if (scoreboard_seen && (scoreboard_x31 == 32'd1)) begin
          scoreboard_settle_i = scoreboard_settle_i + 1;
        end
      end
      dp_i_ce = 1'b0;
      $display("==========================================");
      if (scoreboard_seen) begin
        $display("RV32IM scoreboard: x31=%0d x30=%0d commits=%0d",
                 scoreboard_x31,
                 scoreboard_x30,
                 scoreboard_commit_count);
        if (scoreboard_cycle_count != 0) begin
          scoreboard_ipc = $itor(scoreboard_commit_count) / $itor(scoreboard_cycle_count);
          $display("PERF: cycles=%0d commits=%0d IPC=%0.3f",
                   scoreboard_cycle_count,
                   scoreboard_commit_count,
                   scoreboard_ipc);
        end
      end else begin
        $display("RV32IM scoreboard: x31=%0d x30=%0d commits=%0d",
                 dut.u_arf.arf_value[31],
                 dut.u_arf.arf_value[30],
                 commit_count);
        if (cycle_count != 0) begin
          scoreboard_ipc = $itor(commit_count) / $itor(cycle_count);
          $display("PERF: cycles=%0d commits=%0d IPC=%0.3f",
                   cycle_count,
                   commit_count,
                   scoreboard_ipc);
        end
      end
      if (print_profile) begin
        print_pipeline_profile();
      end
      if (scoreboard_seen && (scoreboard_x31 == 32'd1)) begin
        $display("RESULT: PASS");
      end else if (scoreboard_seen && (scoreboard_x31 == 32'hffffffff)) begin
        $display("RESULT: FAIL test_id=%0d", scoreboard_x30);
      end else if (beebs_stop_on_x29 && beebs_done) begin
        if (beebs_status == 32'd1) begin
          $display("BEEBS RESULT: PASS x28=%0d (0x%08h)",
                   dut.u_arf.arf_value[28],
                   dut.u_arf.arf_value[28]);
        end else begin
          $display("BEEBS RESULT: FAIL status=%0d (0x%08h) x28=%0d (0x%08h)",
                   beebs_status,
                   beebs_status,
                   dut.u_arf.arf_value[28],
                   dut.u_arf.arf_value[28]);
        end
        if (print_raw_regs) begin
          print_raw_registers();
        end else begin
          print_result_registers();
        end
        if (dhrystone_report) begin
          print_dhrystone_report();
        end
      end else if (raw_result) begin
        if (print_raw_regs) begin
          print_raw_registers();
        end else begin
          print_result_registers();
        end
        $display("RESULT: RAW RUN COMPLETE, NO PASS/FAIL CHECK");
      end else begin
        $display("RESULT: INCOMPLETE or NO SCOREBOARD UPDATE");
      end
      if (beebs_debug_head) begin
        print_final_pipeline_state();
      end
      $display("==========================================");
      $finish;
    end

    task print_final_pipeline_state;
      begin
        $display("FINAL_PIPELINE_STATE cycle=%0d commit=%0d pc1=0x%08h pc2=0x%08h fe_ce=%b",
                 cycle_count,
                 commit_count,
                 dp_o_pc_1,
                 dp_o_pc_2,
                 dut.fe_ce);
        $display("  ROB head=%0d head_pc=0x%08h head_valid=%b head_done=%b used=%0d full=%b can_alloc1=%b can_alloc2=%b",
                 dut.u_rob.head_ptr,
                 pc_by_rob[dut.u_rob.head_ptr],
                 dut.u_rob.head_valid,
                 dut.u_rob.head_done,
                 dut.u_rob.used_count,
                 dut.rob_o_full,
                 dut.rob_o_can_alloc_1,
                 dut.rob_o_can_alloc_2);
        $display("  DISPATCH ds_ce=%b/%b fire=%b/%b rs_full=%b ren_fire=%b/%b is3=%b/%b cpl=%b/%b",
                 dut.ds1_rs_o_ce,
                 dut.ds2_rs_o_ce,
                 dut.ru_rs_dispatch_fire_1,
                 dut.ru_rs_dispatch_fire_2,
                 dut.rs_o_full,
                 dut.ren_fire_1,
                 dut.ren_fire_2,
                 dut.is3_valid_1,
                 dut.is3_valid_2,
                 dut.cpl_valid_1,
                 dut.cpl_valid_2);
        $display("  DECODE ds_req=%b/%b ds_store=%b/%b pre_req=%b/%b pre_ok=%b/%b dec_consume=%b/%b lane_done=%b/%b",
                 dut.ds_req_1,
                 dut.ds_req_2,
                 dut.ds_store_1,
                 dut.ds_store_2,
                 dut.pre_req_1,
                 dut.pre_req_2,
                 dut.pre_ok_1,
                 dut.pre_ok_2,
                 dut.dec_consume_1,
                 dut.dec_consume_2,
                 dut.dec_lane_done_1,
                 dut.dec_lane_done_2);
`ifdef USE_DHRYSTONE_SRC_COPY
        $display("  PRECHECK ru_can_take=%b/%b lane1_allows_lane2=%b lane1_buf_blocks=%b rob_free_shadow=%0d ru_valid=%b/%b ru_older=%b",
                 dut.ru_rs_can_take_1,
                 dut.ru_rs_can_take_2,
                 dut.lane1_allows_lane2_pre,
                 dut.lane1_buffer_blocks_lane2_pre,
                 dut.rob_free_shadow,
                 dut.ru_rs_valid_1,
                 dut.ru_rs_valid_2,
                 dut.ru_rs_lane2_older_pending);
`else
        $display("  PRECHECK ru_can_take=%b/%b lane1_allows_lane2=%b rob_free_shadow=%0d ru_valid=%b/%b ru_older=%b",
                 dut.ru_rs_can_take_1,
                 dut.ru_rs_can_take_2,
                 dut.lane1_allows_lane2_pre,
                 dut.rob_free_shadow,
                 dut.ru_rs_valid_1,
                 dut.ru_rs_valid_2,
                 dut.ru_rs_lane2_older_pending);
`endif
        $display("  FREE_LIST count=%0d", dut.u_rename.u_rat.u_free_list.count);
        $display("  FRONTEND pc_im=0x%08h im_instr=%08h/%08h decode_hold=%b decode_can_load=%b",
                 dut.pc_im_o_pc_1,
                 dut.im_o_instr_1,
                 dut.im_o_instr_2,
                 dut.decode_hold,
                 dut.decode_can_load);
`ifdef USE_DHRYSTONE_SRC_COPY
        $display("  CONTROL jal_pending=%b branch_pending=%b jal_accept=%b branch_accept=%b branch_dispatch=%b branch_resolve=%b es_pc_flush=%b",
                 dut.jal_pending,
                 dut.branch_pending,
                 dut.jal_accept_now,
                 dut.branch_accept_now,
                 dut.branch_dispatch_now,
                 dut.branch_resolve_now,
                 dut.es_pc_flush);
        $display("  REDIRECT r1=%b br1=%b pc1=0x%08h target1=0x%08h r2=%b br2=%b pc2=0x%08h target2=0x%08h pipe_flush=%b backend_flush=%b",
                 dut.es_pc_redirect_1,
                 dut.es_pc_redirect_is_branch_1,
                 dut.es_pc_redirect_pc_1,
                 dut.es_pc_redirect_target_1,
                 dut.es_pc_redirect_2,
                 dut.es_pc_redirect_is_branch_2,
                 dut.es_pc_redirect_pc_2,
                 dut.es_pc_redirect_target_2,
                 dut.es_pipe_flush,
                 dut.es_backend_flush);
`else
        $display("  CONTROL es_pc_flush=%b", dut.es_pc_flush);
        $display("  REDIRECT r1=%b pc1=0x%08h target1=0x%08h r2=%b pc2=0x%08h target2=0x%08h pipe_flush=%b backend_flush=%b",
                 dut.es_pc_redirect_1,
                 dut.es_pc_redirect_pc_1,
                 dut.es_pc_redirect_target_1,
                 dut.es_pc_redirect_2,
                 dut.es_pc_redirect_pc_2,
                 dut.es_pc_redirect_target_2,
                 dut.es_pipe_flush,
                 dut.es_backend_flush);
`endif
        $display("  SQ head=%0d tail=%0d used=%0d resp_wait=%b/%b resp_read=%b/%b resp_fwd=%b/%b q_older=%0d/%0d q_tail=%0d/%0d",
                 dut.u_store_queue.head_ptr,
                 dut.u_store_queue.tail_ptr,
                 dut.u_store_queue.used_count,
                 dut.sq_o_load_resp_wait_1,
                 dut.sq_o_load_resp_wait_2,
                 dut.sq_o_load_resp_read_mem_1,
                 dut.sq_o_load_resp_read_mem_2,
                 dut.sq_o_load_resp_forward_valid_1,
                 dut.sq_o_load_resp_forward_valid_2,
                 dut.lq_sq_query_older_store_count_1_q,
                 dut.lq_sq_query_older_store_count_2_q,
                 dut.lq_sq_query_tail_snapshot_1_q,
                 dut.lq_sq_query_tail_snapshot_2_q);
        $display("  SQ entries h=%0d v/f=%b/%b addr=0x%08h mask=%b | h1=%0d v/f=%b/%b addr=0x%08h mask=%b",
                 dut.u_store_queue.head_ptr,
                 dut.u_store_queue.ent_valid[dut.u_store_queue.head_ptr],
                 dut.u_store_queue.ent_filled[dut.u_store_queue.head_ptr],
                 dut.u_store_queue.ent_addr[dut.u_store_queue.head_ptr],
                 dut.u_store_queue.ent_mask[dut.u_store_queue.head_ptr],
                 dut.u_store_queue.head_plus_1,
                 dut.u_store_queue.ent_valid[dut.u_store_queue.head_plus_1],
                 dut.u_store_queue.ent_filled[dut.u_store_queue.head_plus_1],
                 dut.u_store_queue.ent_addr[dut.u_store_queue.head_plus_1],
                 dut.u_store_queue.ent_mask[dut.u_store_queue.head_plus_1]);
      end
    endtask

    task print_spec_lq_state;
      begin
`ifdef USE_DHRYSTONE_SRC_COPY
        $display("SPEC_LQ_STATE cycle=%0d commit=%0d restore=%b save=%b resolve=%b spec_active=%b spec_tag=%0d",
                 cycle_count,
                 commit_count,
                 dut.spec_restore,
                 dut.spec_checkpoint_save,
                 dut.spec_resolve,
                 dut.spec_active,
                 dut.spec_branch_tag);
`else
        $display("SPEC_LQ_STATE cycle=%0d commit=%0d", cycle_count, commit_count);
`endif
        $display("  ROB head=%0d pc=0x%08h valid=%b done=%b is_load=%b ld_idx=%0d opcode=%07b issue=%b exm=%b cpl=%b done_seen=%b",
                 dut.u_rob.head_ptr,
                 pc_by_rob[dut.u_rob.head_ptr],
                 dut.u_rob.head_valid,
                 dut.u_rob.head_done,
                 dut.u_rob.ent_is_load[dut.u_rob.head_ptr],
                 dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr],
                 dut.u_rob.ent_opcode[dut.u_rob.head_ptr],
                 issue_seen_by_rob[dut.u_rob.head_ptr],
                 exm_seen_by_rob[dut.u_rob.head_ptr],
                 cpl_seen_by_rob[dut.u_rob.head_ptr],
                 done_seen_by_rob[dut.u_rob.head_ptr]);
        $display("  LQ ptrs head=%0d head1=%0d tail=%0d checkpoint_tail=%0d used=%0d commit_req=%b/%0d %b/%0d",
                 dut.u_load_queue.head_ptr,
                 dut.u_load_queue.head_plus_1,
                 dut.u_load_queue.tail_ptr,
                 dut.u_load_queue.checkpoint_tail_ptr,
                 dut.u_load_queue.used_count,
                 dut.u_load_queue.lq_i_commit_valid_1,
                 dut.u_load_queue.lq_i_commit_ptr_1,
                 dut.u_load_queue.lq_i_commit_valid_2,
                 dut.u_load_queue.lq_i_commit_ptr_2);
        $display("  LQ head entry v=%b av=%b qw=%b mw=%b done=%b sent=%b rob=%0d prd=%0d f3=%03b addr=0x%08h mask=%b raw=0x%08h older=%0d",
                 dut.u_load_queue.ent_valid[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_addr_valid[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_query_wait[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_mem_wait[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_done[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_complete_sent[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_rob_tag[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_prd[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_funct3[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_addr[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_mask[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_raw_data[dut.u_load_queue.head_ptr],
                 dut.u_load_queue.ent_older_store_count[dut.u_load_queue.head_ptr]);
        $display("  LQ rob-head-ld entry idx=%0d v=%b av=%b qw=%b mw=%b done=%b sent=%b rob=%0d prd=%0d f3=%03b addr=0x%08h mask=%b raw=0x%08h older=%0d",
                 dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr],
                 dut.u_load_queue.ent_valid[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_addr_valid[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_query_wait[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_mem_wait[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_done[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_complete_sent[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_rob_tag[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_prd[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_funct3[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_addr[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_mask[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_raw_data[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]],
                 dut.u_load_queue.ent_older_store_count[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]]);
        $display("  LQ IO exec=%b/%0d rob=%0d addr=0x%08h | %b/%0d rob=%0d addr=0x%08h mem_req=%b/%0d %b/%0d cpl=%b/%0d acc=%b %b/%0d acc=%b",
                 dut.u_load_queue.lq_i_exec_valid_1,
                 dut.u_load_queue.lq_i_exec_ptr_1,
                 dut.u_load_queue.lq_i_exec_rob_tag_1,
                 dut.u_load_queue.lq_i_exec_addr_1,
                 dut.u_load_queue.lq_i_exec_valid_2,
                 dut.u_load_queue.lq_i_exec_ptr_2,
                 dut.u_load_queue.lq_i_exec_rob_tag_2,
                 dut.u_load_queue.lq_i_exec_addr_2,
                 dut.lq_o_mem_req_valid_1,
                 dut.lq_o_mem_req_ptr_1,
                 dut.lq_o_mem_req_valid_2,
                 dut.lq_o_mem_req_ptr_2,
                 dut.lq_o_complete_valid_1,
                 dut.lq_o_complete_rob_tag_1,
                 dut.lq_i_complete_accept_1,
                 dut.lq_o_complete_valid_2,
                 dut.lq_o_complete_rob_tag_2,
                 dut.lq_i_complete_accept_2);
      end
    endtask

    task print_raw_registers;
      integer reg_i;
      begin
        $display("RAW RESULT MODE");
        $display("No scoreboard PASS/FAIL update detected.");
        $display("Final architectural register values:");
        for (reg_i = 0; reg_i < 32; reg_i = reg_i + 1) begin
          $display("x%0d = %0d (0x%08h)",
                   reg_i,
                   dut.u_arf.arf_value[reg_i],
                   dut.u_arf.arf_value[reg_i]);
        end
      end
    endtask

    task print_result_registers;
      begin
        $display("RESULT REGS: x28=%0d (0x%08h) x29=%0d (0x%08h) x30=%0d (0x%08h) x31=%0d (0x%08h)",
                 dut.u_arf.arf_value[28],
                 dut.u_arf.arf_value[28],
                 dut.u_arf.arf_value[29],
                 dut.u_arf.arf_value[29],
                 dut.u_arf.arf_value[30],
                 dut.u_arf.arf_value[30],
                 dut.u_arf.arf_value[31],
                 dut.u_arf.arf_value[31]);
      end
    endtask

    task print_dhrystone_report;
      begin
        $display("DHRYSTONE REPORT:");
        $display("  runs            = %0d", dhrystone_runs);
        $display("  measured_cycles = %0d", dhrystone_cycle_count);
        $display("  measured_commits= %0d", dhrystone_commit_count);
        if (dhrystone_done && (dhrystone_cycle_count > 0) && (dhrystone_runs > 0)) begin
          dhrystone_dmips_mhz =
            ($itor(dhrystone_runs) * 1000000.0) /
            ($itor(dhrystone_cycle_count) * 1757.0);
          $display("  DMIPS/MHz        = %0.6f", dhrystone_dmips_mhz);
          if (dhrystone_fmax_mhz > 0.0) begin
            dhrystone_dmips = dhrystone_dmips_mhz * dhrystone_fmax_mhz;
            dhrystone_per_sec = dhrystone_dmips * 1757.0;
            $display("  Fmax(MHz)        = %0.3f", dhrystone_fmax_mhz);
            $display("  Dhrystones/s     = %0.3f", dhrystone_per_sec);
            $display("  DMIPS            = %0.6f", dhrystone_dmips);
          end
        end else begin
          $display("  DMIPS/MHz        = unavailable");
        end
      end
    endtask

`define PRINT_BEEBS_RS_ENTRY(ID) \
        if (dut.u_rs.ent_valid[ID] && \
            (dut.u_rs.ent_rob_tag[ID] == dut.u_rob.head_ptr)) begin \
          dbg_found_rs = 1; \
          $display("  RS entry=%0d opcode=%07b funct3=%03b funct7=%07b has_rs=%0d prs=%0d rs_ready=%0d vrs=0x%08h has_rt=%0d prt=%0d rt_ready=%0d vrt=0x%08h pc=0x%08h", \
                   ID, \
                   dut.u_rs.ent_opcode[ID], \
                   dut.u_rs.ent_funct3[ID], \
                   dut.u_rs.ent_funct7[ID], \
                   dut.u_rs.ent_has_rs[ID], \
                   dut.u_rs.ent_prs[ID], \
                   dut.u_rs.ent_rs_ready[ID], \
                   dut.u_rs.ent_vrs[ID], \
                   dut.u_rs.ent_has_rt[ID], \
                   dut.u_rs.ent_prt[ID], \
                   dut.u_rs.ent_rt_ready[ID], \
                   dut.u_rs.ent_vrt[ID], \
                   dut.u_rs.ent_pc[ID]); \
        end

    task print_beebs_head_debug;
      integer dbg_found_rs;
      integer dbg_lq_idx;
      begin
        dbg_found_rs = 0;
        dbg_lq_idx = 0;
        $display("BEEBS_HEAD_DEBUG cycle=%0d pc1=0x%08h pc2=0x%08h head=%0d head_pc=0x%08h valid=%0d done=%0d opcode=%07b funct3=%03b funct7=%07b rd=%0d new_prd=%0d used=%0d",
                 cycle_count,
                 dp_o_pc_1,
                 dp_o_pc_2,
                 dut.u_rob.head_ptr,
                 pc_by_rob[dut.u_rob.head_ptr],
                 dut.u_rob.head_valid,
                 dut.u_rob.head_done,
                 dut.u_rob.ent_opcode[dut.u_rob.head_ptr],
                 dut.u_rob.ent_funct3[dut.u_rob.head_ptr],
                 dut.u_rob.ent_funct7[dut.u_rob.head_ptr],
                 dut.u_rob.ent_arch_rd[dut.u_rob.head_ptr],
                 dut.u_rob.ent_new_prd[dut.u_rob.head_ptr],
                 dut.u_rob.used_count);
        `PRINT_BEEBS_RS_ENTRY(0)
        `PRINT_BEEBS_RS_ENTRY(1)
        `PRINT_BEEBS_RS_ENTRY(2)
        `PRINT_BEEBS_RS_ENTRY(3)
        `PRINT_BEEBS_RS_ENTRY(4)
        `PRINT_BEEBS_RS_ENTRY(5)
        `PRINT_BEEBS_RS_ENTRY(6)
        `PRINT_BEEBS_RS_ENTRY(7)
        `PRINT_BEEBS_RS_ENTRY(8)
        `PRINT_BEEBS_RS_ENTRY(9)
        `PRINT_BEEBS_RS_ENTRY(10)
        `PRINT_BEEBS_RS_ENTRY(11)
        `PRINT_BEEBS_RS_ENTRY(12)
        `PRINT_BEEBS_RS_ENTRY(13)
        `PRINT_BEEBS_RS_ENTRY(14)
        `PRINT_BEEBS_RS_ENTRY(15)
        `PRINT_BEEBS_RS_ENTRY(16)
        `PRINT_BEEBS_RS_ENTRY(17)
        `PRINT_BEEBS_RS_ENTRY(18)
        `PRINT_BEEBS_RS_ENTRY(19)
        `PRINT_BEEBS_RS_ENTRY(20)
        `PRINT_BEEBS_RS_ENTRY(21)
        `PRINT_BEEBS_RS_ENTRY(22)
        `PRINT_BEEBS_RS_ENTRY(23)
        `PRINT_BEEBS_RS_ENTRY(24)
        `PRINT_BEEBS_RS_ENTRY(25)
        `PRINT_BEEBS_RS_ENTRY(26)
        `PRINT_BEEBS_RS_ENTRY(27)
        `PRINT_BEEBS_RS_ENTRY(28)
        `PRINT_BEEBS_RS_ENTRY(29)
        `PRINT_BEEBS_RS_ENTRY(30)
        `PRINT_BEEBS_RS_ENTRY(31)
        if (!dbg_found_rs) begin
          $display("  RS entry for ROB head was not found. issue_seen=%0d exm_seen=%0d cpl_seen=%0d done_seen=%0d",
                   issue_seen_by_rob[dut.u_rob.head_ptr],
                   exm_seen_by_rob[dut.u_rob.head_ptr],
                   cpl_seen_by_rob[dut.u_rob.head_ptr],
                   done_seen_by_rob[dut.u_rob.head_ptr]);
        end
        $display("  issue valid/tag: lane1=%0d/%0d lane2=%0d/%0d | is3=%0d/%0d %0d/%0d | cpl=%0d/%0d %0d/%0d",
                 dut.u_rs.rs_o_issue_valid_1,
                 dut.u_rs.rs_o_rob_tag_1,
                 dut.u_rs.rs_o_issue_valid_2,
                 dut.u_rs.rs_o_rob_tag_2,
                 dut.is3_valid_1,
                 dut.is3_rob_tag_1,
                 dut.is3_valid_2,
                 dut.is3_rob_tag_2,
                 dut.cpl_valid_1,
                 dut.cpl_tag_1,
                 dut.cpl_valid_2,
                 dut.cpl_tag_2);
        if (dut.u_rob.head_valid && dut.u_rob.ent_is_load[dut.u_rob.head_ptr]) begin
          dbg_lq_idx = dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr];
          $display("  LQ head-load: ld_idx=%0d valid=%0d addr_valid=%0d query_wait=%0d mem_wait=%0d done=%0d complete_sent=%0d rob_tag=%0d prd=%0d funct3=%03b addr=0x%08h raw=0x%08h",
                   dbg_lq_idx,
                   dut.u_load_queue.ent_valid[dbg_lq_idx],
                   dut.u_load_queue.ent_addr_valid[dbg_lq_idx],
                   dut.u_load_queue.ent_query_wait[dbg_lq_idx],
                   dut.u_load_queue.ent_mem_wait[dbg_lq_idx],
                   dut.u_load_queue.ent_done[dbg_lq_idx],
                   dut.u_load_queue.ent_complete_sent[dbg_lq_idx],
                   dut.u_load_queue.ent_rob_tag[dbg_lq_idx],
                   dut.u_load_queue.ent_prd[dbg_lq_idx],
                   dut.u_load_queue.ent_funct3[dbg_lq_idx],
                   dut.u_load_queue.ent_addr[dbg_lq_idx],
                   dut.u_load_queue.ent_raw_data[dbg_lq_idx]);
          $display("  LQ query: q1=%0d ptr=%0d addr=0x%08h older=%0d | q2=%0d ptr=%0d addr=0x%08h older=%0d",
                   dut.lq_o_sq_query_valid_1,
                   dut.lq_o_sq_query_ptr_1,
                   dut.lq_o_sq_query_addr_1,
                   dut.lq_o_sq_query_older_store_count_1,
                   dut.lq_o_sq_query_valid_2,
                   dut.lq_o_sq_query_ptr_2,
                   dut.lq_o_sq_query_addr_2,
                   dut.lq_o_sq_query_older_store_count_2);
          $display("  SQ resp->LQ: r1=%0d ptr=%0d read_mem=%0d fwd=%0d wait=%0d data=0x%08h | r2=%0d ptr=%0d read_mem=%0d fwd=%0d wait=%0d data=0x%08h",
                   dut.lq_i_sq_resp_valid_1,
                   dut.lq_i_sq_resp_ptr_1,
                   dut.lq_i_sq_resp_read_mem_1,
                   dut.lq_i_sq_resp_forward_valid_1,
                   dut.lq_i_sq_resp_wait_1,
                   dut.lq_i_sq_resp_forward_data_1,
                   dut.lq_i_sq_resp_valid_2,
                   dut.lq_i_sq_resp_ptr_2,
                   dut.lq_i_sq_resp_read_mem_2,
                   dut.lq_i_sq_resp_forward_valid_2,
                   dut.lq_i_sq_resp_wait_2,
                   dut.lq_i_sq_resp_forward_data_2);
          $display("  LQ mem: req1=%0d ptr=%0d addr=0x%08h q1=%0d/%0d/0x%08h resp1=%0d ptr=%0d data=0x%08h | req2=%0d ptr=%0d addr=0x%08h q2=%0d/%0d/0x%08h resp2=%0d ptr=%0d data=0x%08h",
                   dut.lq_o_mem_req_valid_1,
                   dut.lq_o_mem_req_ptr_1,
                   dut.lq_o_mem_req_addr_1,
                   dut.lq_mem_req_valid_1_q,
                   dut.lq_mem_req_ptr_1_q,
                   dut.lq_mem_req_addr_1_q,
                   dut.lq_i_mem_resp_valid_1,
                   dut.lq_i_mem_resp_ptr_1,
                   dut.lq_i_mem_resp_data_1,
                   dut.lq_o_mem_req_valid_2,
                   dut.lq_o_mem_req_ptr_2,
                   dut.lq_o_mem_req_addr_2,
                   dut.lq_mem_req_valid_2_q,
                   dut.lq_mem_req_ptr_2_q,
                   dut.lq_mem_req_addr_2_q,
                   dut.lq_i_mem_resp_valid_2,
                   dut.lq_i_mem_resp_ptr_2,
                   dut.lq_i_mem_resp_data_2);
          $display("  LQ complete: c1=%0d rob=%0d prd=%0d addr=0x%08h raw=0x%08h accept=%0d | c2=%0d rob=%0d prd=%0d addr=0x%08h raw=0x%08h accept=%0d",
                   dut.lq_o_complete_valid_1,
                   dut.lq_o_complete_rob_tag_1,
                   dut.lq_o_complete_prd_1,
                   dut.lq_o_complete_addr_1,
                   dut.lq_o_complete_raw_data_1,
                   dut.lq_i_complete_accept_1,
                   dut.lq_o_complete_valid_2,
                   dut.lq_o_complete_rob_tag_2,
                   dut.lq_o_complete_prd_2,
                   dut.lq_o_complete_addr_2,
                   dut.lq_o_complete_raw_data_2,
                   dut.lq_i_complete_accept_2);
        end
      end
    endtask

`undef PRINT_BEEBS_RS_ENTRY

integer commit_count;
integer next_commit_count;
integer cycle_count;
integer scoreboard_commit_count;
integer scoreboard_cycle_count;
integer scoreboard_settle_i;
real scoreboard_ipc;
reg scoreboard_seen;
reg scoreboard_done;
reg [`DWIDTH - 1 : 0] scoreboard_x31;
reg [`DWIDTH - 1 : 0] scoreboard_x30;
reg [`DWIDTH - 1 : 0] scoreboard_x30_shadow;
reg [`DWIDTH - 1 : 0] next_scoreboard_x30;
integer fetch_stall_cycles;
integer decode_hold_cycles;
integer dispatch0_cycles;
integer dispatch1_cycles;
integer dispatch2_cycles;
integer commit0_cycles;
integer commit1_cycles;
integer commit2_cycles;
integer branch_flush_count;
integer flush_spec_restore_count;
integer flush_early_taken_count;
integer flush_btfnt_predict_count;
integer flush_ru_branch_count;
integer flush_ru_jal_count;
integer flush_btfnt_mispredict_nt_count;
integer flush_fast_branch_exec_count;
integer flush_registered_redirect_count;
integer flush_lane2_redirect_count;
integer fetch_btb_redirect_count;
integer fetch_btb_redirect_lane1_count;
integer fetch_btb_redirect_lane2_count;
integer jal_accept_count;
integer jal_accept_jal_count;
integer jal_accept_jalr_count;
integer branch_accept_count;
integer branch_dispatch_count;
integer branch_resolve_count;
integer branch_taken_count;
integer branch_not_taken_count;
integer early_branch_nt_count;
integer early_branch_nt_lane1_count;
integer early_branch_nt_lane2_count;
integer early_branch_taken_count;
integer early_branch_taken_lane1_count;
integer early_branch_taken_lane2_count;
integer early_branch_lane2_dep_count;
integer btfnt_predict_taken_count;
integer btfnt_predict_taken_lane1_count;
integer btfnt_predict_taken_lane2_count;
integer btfnt_mispredict_nt_count;
integer btfnt_pending_cycles;
integer spec_save_count;
integer spec_active_cycles;
integer spec_resolve_count;
integer spec_restore_count;
integer branch_decode_lane1_count;
integer branch_decode_lane2_count;
integer branch_decode_ready_lane1_count;
integer branch_decode_ready_lane2_count;
integer branch_decode_ready_taken_count;
integer branch_decode_ready_not_taken_count;
integer branch_decode_not_ready_rs_count;
integer branch_decode_not_ready_rt_count;
integer branch_decode_lane2_dep_rs_count;
integer branch_decode_lane2_dep_rt_count;
integer branch_rs_wait_rs_alu_cycles;
integer branch_rs_wait_rt_alu_cycles;
integer branch_rs_wait_rs_load_cycles;
integer branch_rs_wait_rt_load_cycles;
integer branch_rs_wait_rs_muldiv_cycles;
integer branch_rs_wait_rt_muldiv_cycles;
integer branch_rs_wait_rs_other_cycles;
integer branch_rs_wait_rt_other_cycles;
integer jal_pending_cycles;
integer branch_pending_cycles;
integer branch_pending_decode_cycles;
integer branch_pending_ru_cycles;
integer branch_pending_rs_wait_cycles;
integer branch_pending_rs_ready_cycles;
integer branch_pending_rs_ready_resolve_cycles;
integer branch_pending_rs_ready_no_resolve_cycles;
integer branch_pending_rs_ready_taken_cycles;
integer branch_pending_rs_ready_not_taken_cycles;
integer branch_pending_is3_cycles;
integer branch_pending_execute_cycles;
integer branch_pending_unknown_cycles;
integer branch_pending_blocks_fe_cycles;
integer branch_pending_not_block_fe_cycles;
integer branch_pending_ru_lane1_cycles;
integer branch_pending_ru_lane2_cycles;
integer branch_pending_ru_dispatch_fire_cycles;
integer branch_pending_ru_ready_cycles;
integer branch_pending_ru_ready_taken_cycles;
integer branch_pending_ru_ready_not_taken_cycles;
integer branch_pending_ru_l1_no_dispatch_cycles;
integer branch_pending_ru_l1_lane2_older_cycles;
integer branch_pending_ru_l2_pair_l1_block_cycles;
integer branch_pending_ru_l2_pair_credit_block_cycles;
integer branch_pending_ru_l2_solo_credit_block_cycles;
integer branch_pending_ru_l2_solo_order_block_cycles;
integer branch_pending_set_btfnt_count;
integer branch_pending_set_btfnt_btb_hit_count;
integer branch_pending_set_accept_wait_count;
integer branch_pending_set_dispatch_wait_count;
integer branch_load_wait_not_issued_cycles;
integer branch_load_wait_issued_not_exm_cycles;
integer branch_load_wait_exm_not_cpl_cycles;
integer branch_load_wait_cpl_not_done_cycles;
integer branch_load_wait_done_no_wakeup_cycles;
integer branch_load_wait_unknown_cycles;
integer branch_hot_i;
integer branch_hot_load_wait_total [0:5];
integer branch_hot_load_wait_not_issued [0:5];
integer branch_hot_load_wait_issued_not_exm [0:5];
integer branch_hot_load_wait_exm_not_cpl [0:5];
integer branch_hot_load_wait_cpl_not_done [0:5];
integer branch_hot_load_wait_done_no_wakeup [0:5];
integer branch_4a4_load_wait_total;
integer branch_4a4_wait_prs_count;
integer branch_4a4_wait_prt_count;
integer branch_4a4_prod_pc_4a0_count;
integer branch_4a4_prod_other_pc_count;
integer branch_4a4_prod_rs_found_count;
integer branch_4a4_prod_rs_missing_count;
integer branch_4a4_prod_rs_ready_vec_count;
integer branch_4a4_prod_rs_stored_ready_count;
integer branch_4a4_prod_rs_not_ready_count;
integer branch_4a4_prod_issue_same_cycle_count;
integer branch_4a4_prod_ready_no_issue_count;
integer branch_4a4_prod_ready_no_issue_issue0_count;
integer branch_4a4_prod_ready_no_issue_issue1_count;
integer branch_4a4_prod_ready_no_issue_issue2_count;
integer branch_4a4_load_base_wait_total;
integer branch_4a4_load_base_ready_count;
integer branch_4a4_load_base_not_ready_count;
integer branch_4a4_load_base_prod_pc_49c_count;
integer branch_4a4_load_base_prod_other_pc_count;
integer branch_4a4_load_base_prod_rs_found_count;
integer branch_4a4_load_base_prod_rs_missing_count;
integer branch_4a4_load_base_prod_rs_ready_count;
integer branch_4a4_load_base_prod_rs_not_ready_count;
integer branch_4a4_load_base_prod_issue_same_cycle_count;
integer branch_4a4_load_base_prod_issued_seen_count;
integer branch_4a4_load_base_prod_exm_seen_count;
integer branch_4a4_load_base_prod_cpl_seen_count;
integer branch_4a4_load_base_prod_done_seen_count;
integer branch_4a4_load_base_prod_cpl_same_cycle_count;
integer branch_4a4_load_base_prod_wakeup_same_cycle_count;
integer branch_4a4_load_base_not_ready_ready_vec_count;
integer branch_4a4_load_base_not_ready_wakeup_hold_count;
integer branch_4a4_load_base_not_ready_spec_active_count;
integer branch_4a4_load_base_not_ready_es_wakeup_count;
integer branch_4a4_load_base_not_ready_mem_wakeup_count;
integer branch_4a4_load_base_not_ready_no_wakeup_count;
integer branch_4a4_load_base_not_ready_opcode_load_count;
integer branch_4a4_load_base_not_ready_has_rt_unready_count;
integer branch_4a4_load_base_not_ready_prs_es_hit_count;
integer branch_4a4_load_base_not_ready_prs_mem_hit_count;
integer branch_4a4_load_base_not_ready_prt_es_hit_count;
integer branch_4a4_load_base_not_ready_prt_mem_hit_count;
integer decode_hold_lane1_cycles;
integer decode_hold_lane2_cycles;
integer decode_hold_lane2_after_branch_cycles;
integer decode_hold_lane2_after_jal_cycles;
integer branch_pending_rs_scan_i;
reg branch_pending_rs_found;
reg branch_pending_rs_ready_found;
integer load_head_rs_scan_i;
reg load_head_rs_found_cur;
reg load_head_rs_ready_cur;
reg rob_head_issue_same_cycle_cur;
reg rob_head_exm_same_cycle_cur;
integer jal_accept_stall_cycles;
integer branch_accept_stall_cycles;
integer decode_hold_rs_full_cycles;
integer decode_hold_rob_full_cycles;
integer decode_hold_no_decode_load_cycles;
integer dec_hold_l1_req_no_ren_cycles;
integer dec_hold_l1_buf_full_cycles;
integer dec_hold_l1_lane2_older_cycles;
integer dec_hold_l1_spec_barrier_cycles;
integer dec_hold_l1_spec_save_cycles;
integer dec_hold_l1_branch_pending_cycles;
integer dec_hold_l1_jal_pending_cycles;
integer dec_hold_l1_rob_credit_cycles;
integer dec_hold_l1_freelist_cycles;
integer dec_hold_l1_rs_credit_cycles;
integer dec_hold_l1_sq_block_cycles;
integer dec_hold_l1_lq_block_cycles;
integer dec_hold_l1_pre_not_req_cycles;
integer dec_root_l1_lane2_older_cycles;
integer dec_root_l1_buf_full_cycles;
integer dec_root_l1_spec_barrier_cycles;
integer dec_root_l1_spec_save_cycles;
integer dec_root_l1_branch_pending_cycles;
integer dec_root_l1_jal_pending_cycles;
integer dec_root_l1_rob_credit_cycles;
integer dec_root_l1_freelist_cycles;
integer dec_root_l1_rs_credit_cycles;
integer dec_root_l1_sq_lq_cycles;
integer dec_root_l1_other_cycles;
integer dec_hold_l2_req_no_ren_cycles;
integer dec_hold_l2_buf_full_cycles;
integer dec_hold_l2_lane1_not_allow_cycles;
integer dec_hold_l2_lane1_buffer_cycles;
integer dec_hold_l2_after_ctrl_cycles;
integer dec_hold_l2_spec_barrier_cycles;
integer dec_hold_l2_spec_save_cycles;
integer dec_hold_l2_branch_pending_cycles;
integer dec_hold_l2_jal_pending_cycles;
integer dec_hold_l2_rob_credit_cycles;
integer dec_hold_l2_freelist_cycles;
integer dec_hold_l2_rs_credit_cycles;
integer dec_hold_l2_sq_block_cycles;
integer dec_hold_l2_lq_block_cycles;
integer dec_hold_l2_pre_not_req_cycles;
integer dec_root_l2_buf_full_cycles;
integer dec_root_l2_lane1_not_allow_cycles;
integer dec_root_l2_lane1_buffer_cycles;
integer dec_root_l2_after_ctrl_cycles;
integer dec_root_l2_spec_barrier_cycles;
integer dec_root_l2_spec_save_cycles;
integer dec_root_l2_branch_pending_cycles;
integer dec_root_l2_jal_pending_cycles;
integer dec_root_l2_rob_credit_cycles;
integer dec_root_l2_freelist_cycles;
integer dec_root_l2_rs_credit_cycles;
integer dec_root_l2_sq_lq_cycles;
integer dec_root_l2_other_cycles;
integer dec_root_l2_other_spec_ctrl_cycles;
integer dec_root_l2_other_pre_req_true_cycles;
integer dec_root_l2_other_pre_req_false_cycles;
integer dec_root_l2_other_pre_ok_false_cycles;
integer dec_root_l2_other_simple_cycles;
integer dec_root_l2_other_load_cycles;
integer dec_root_l2_other_store_cycles;
integer dec_root_l2_other_branch_cycles;
integer dec_root_l2_other_jal_cycles;
integer lane2_not_allow_l1_simple_cycles;
integer lane2_not_allow_l1_load_cycles;
integer lane2_not_allow_l1_store_cycles;
integer lane2_not_allow_l1_branch_cycles;
integer lane2_not_allow_l1_jal_cycles;
integer lane2_not_allow_l1_other_cycles;
integer lane2_not_allow_simple_indep_cycles;
integer lane2_not_allow_simple_dep_rs_cycles;
integer lane2_not_allow_simple_dep_rt_cycles;
integer lane2_not_allow_simple_dep_rd_cycles;
integer lane2_not_allow_simple_dep_any_cycles;
integer lane2_buffer_l1_simple_cycles;
integer lane2_buffer_l1_load_cycles;
integer lane2_buffer_l1_store_cycles;
integer lane2_buffer_l1_branch_cycles;
integer lane2_buffer_l1_jal_cycles;
integer lane2_buffer_l1_other_cycles;
integer lane2_can_take2_block_cycles;
integer lane2_can_take2_older_block_cycles;
integer lane2_can_take2_full_block_cycles;
integer lane2_older_pending_cycles;
integer lane2_older_dispatch_cycles;
integer lane2_older_dispatch_ds2_wait_cycles;
integer lane2_older_dispatch_l1_valid_cycles;
integer lane2_older_dispatch_l1_empty_cycles;
integer lane2_older_dispatch_l1_samefire_cycles;
integer lane2_older_dispatch_ds2_indep_cycles;
integer lane2_older_dispatch_ds2_dep_cycles;
integer lane2_older_dispatch_ds2_simple_cycles;
integer lane2_older_dispatch_ds2_load_cycles;
integer lane2_older_dispatch_ds2_store_cycles;
integer lane2_older_dispatch_ds2_branch_cycles;
integer lane2_older_dispatch_ds2_jal_cycles;
integer lane2_older_dispatch_ds2_other_cycles;
integer ckpt_barrier_cycles;
integer ckpt_barrier_decode_hold_cycles;
integer ckpt_barrier_l1_ready_cycles;
integer ckpt_barrier_l2_ready_cycles;
integer ckpt_barrier_l1_simple_cycles;
integer ckpt_barrier_l1_mem_cycles;
integer ckpt_barrier_l1_ctrl_cycles;
integer ckpt_barrier_l2_simple_cycles;
integer ckpt_barrier_l2_mem_cycles;
integer ckpt_barrier_l2_ctrl_cycles;
integer ckpt_save_raw_cycles;
integer ckpt_save_l1_ready_cycles;
integer ckpt_save_l2_ready_cycles;
integer ckpt_save_decode_hold_cycles;
integer dispatch0_rs_full_cycles;
integer dispatch0_rob_full_cycles;
integer dispatch0_no_rename_fire_cycles;
integer dispatch0_no_dispatch_accept_cycles;
integer rename0_cycles;
integer rename1_cycles;
integer rename2_cycles;
integer commit0_with_dispatch0_cycles;
integer rob_empty_cycles;
integer rob_head_wait_cycles;
integer rob_commit1_blocked_cycles;
integer rob_full_cycles;
integer rob_near_full_cycles;
integer rob_max_used;
integer rob_used_sum;
integer rob_head_wait_load_cycles;
integer rob_head_wait_store_cycles;
integer rob_head_wait_non_mem_cycles;
integer rob_head_wait_alu_cycles;
integer rob_head_wait_mul_cycles;
integer rob_head_wait_div_cycles;
integer rob_head_wait_branch_cycles;
integer rs_issue0_cycles;
integer rs_issue1_cycles;
integer rs_issue2_cycles;
integer complete0_cycles;
integer complete1_cycles;
integer complete2_cycles;
integer rs_profile_i;
integer rs_valid_count_cur;
integer rs_ready_count_cur;
integer rs_effective_ready_count_cur;
integer rs_bypass_ready_count_cur;
integer rs_true_ready_count_cur;
integer rs_issue_count_cur;
integer rs_comb_select_count_cur;
integer rs_issueq_can_load_count_cur;
integer rs_issueq_output_valid_count_cur;
integer rs_issueq_accept_count_cur;
integer rs_valid_count_sum;
integer rs_ready_count_sum;
integer rs_effective_ready_count_sum;
integer rs_bypass_ready_count_sum;
integer rs_true_ready_count_sum;
integer rs_max_valid_count;
integer rs_max_ready_count;
integer rs_max_effective_ready_count;
integer rs_max_bypass_ready_count;
integer rs_max_true_ready_count;
integer rs_empty_cycles;
integer rs_no_ready_cycles;
integer rs_ready_but_issue0_cycles;
integer rs_true_ready2plus_cycles;
integer rs_true_ready2plus_issue0_cycles;
integer rs_true_ready2plus_issue1_cycles;
integer rs_true_ready2plus_issue2_cycles;
integer rs_true_ready2plus_selected_lt2_cycles;
integer rs_true_ready2plus_is3_block_cycles;
integer rs_true_ready2plus_comb_select0_cycles;
integer rs_true_ready2plus_comb_select1_cycles;
integer rs_true_ready2plus_comb_select2_cycles;
integer rs_true_ready2plus_issueq_load0_cycles;
integer rs_true_ready2plus_issueq_load1_cycles;
integer rs_true_ready2plus_issueq_load2_cycles;
integer rs_true_ready2plus_output0_cycles;
integer rs_true_ready2plus_output1_cycles;
integer rs_true_ready2plus_output2_cycles;
integer rs_true_ready2plus_accept0_cycles;
integer rs_true_ready2plus_accept1_cycles;
integer rs_true_ready2plus_accept2_cycles;
integer rs_true_ready2plus_block_selector_cycles;
integer rs_true_ready2plus_block_issueq_cycles;
integer rs_true_ready2plus_block_downstream_cycles;
integer rs_ready0_cycles;
integer rs_ready1_cycles;
integer rs_ready2plus_cycles;
integer rs_ready2plus_issue0_cycles;
integer rs_ready2plus_issue1_cycles;
integer rs_ready2plus_issue2_cycles;
integer rs_ready1_issue0_cycles;
integer rs_ready1_issue1_cycles;
integer rs_effective_ready2plus_cycles;
integer rs_effective_ready2plus_issue_lt2_cycles;
integer rs_wait_rs_operand_sum;
integer rs_wait_rt_operand_sum;
integer rs_wait_both_operands_sum;
integer rs_wait_any_operand_sum;
integer rs_wait_rs_operand_max;
integer rs_wait_rt_operand_max;
integer rs_wait_both_operands_max;
integer rs_wait_rs_count_cur;
integer rs_wait_rt_count_cur;
integer rs_wait_both_count_cur;
integer rs_wait_any_count_cur;
integer rs_wakeup_es1_count;
integer rs_wakeup_es2_count;
integer rs_wakeup_mem1_count;
integer rs_wakeup_mem2_count;
integer lat_i;
integer prd_i;
integer cpl_latency_tmp;
integer issue_cycle_by_rob [0:`ROB_SIZE-1];
integer issue_kind_by_rob [0:`ROB_SIZE-1];
integer stage_kind_by_rob [0:`ROB_SIZE-1];
integer exm_cycle_by_rob [0:`ROB_SIZE-1];
integer cpl_cycle_by_rob [0:`ROB_SIZE-1];
integer done_cycle_by_rob [0:`ROB_SIZE-1];
reg [`PC_WIDTH - 1 : 0] pc_by_rob [0:`ROB_SIZE-1];
reg issue_seen_by_rob [0:`ROB_SIZE-1];
reg exm_seen_by_rob [0:`ROB_SIZE-1];
reg cpl_seen_by_rob [0:`ROB_SIZE-1];
reg done_seen_by_rob [0:`ROB_SIZE-1];
reg [2:0] prd_producer_kind [0:(2**`RAT_SIZE)-1];
reg [`ROB_IDX_W-1:0] prd_producer_rob_tag [0:(2**`RAT_SIZE)-1];
integer alu_issue_complete_count;
integer alu_issue_complete_sum;
integer alu_issue_complete_max;
integer div_issue_complete_count;
integer div_issue_complete_sum;
integer div_issue_complete_max;
integer rs_lat_i;
integer rs_wakeup_to_ready_tmp;
integer rs_ready_to_issue_tmp;
integer rs_ready_start_cycle [0:`RS_SIZE-1];
integer rs_wakeup_rs_start_cycle [0:`RS_SIZE-1];
integer rs_wakeup_rt_start_cycle [0:`RS_SIZE-1];
reg rs_ready_tracking [0:`RS_SIZE-1];
reg rs_wakeup_rs_tracking [0:`RS_SIZE-1];
reg rs_wakeup_rt_tracking [0:`RS_SIZE-1];
integer rs_wakeup_to_ready_count;
integer rs_wakeup_to_ready_sum;
integer rs_wakeup_to_ready_max;
integer rs_ready_to_issue_count;
integer rs_ready_to_issue_sum;
integer rs_ready_to_issue_max;
integer stage_latency_tmp;
integer alu_issue_exm_count, alu_issue_exm_sum, alu_issue_exm_max;
integer alu_exm_cpl_count, alu_exm_cpl_sum, alu_exm_cpl_max;
integer alu_cpl_done_count, alu_cpl_done_sum, alu_cpl_done_max;
integer alu_done_commit_count, alu_done_commit_sum, alu_done_commit_max;
integer alu_done_commit_le1_count;
integer alu_done_commit_2to4_count;
integer alu_done_commit_5to16_count;
integer alu_done_commit_gt16_count;
integer div_issue_exm_count, div_issue_exm_sum, div_issue_exm_max;
integer div_exm_cpl_count, div_exm_cpl_sum, div_exm_cpl_max;
integer div_cpl_done_count, div_cpl_done_sum, div_cpl_done_max;
integer div_done_commit_count, div_done_commit_sum, div_done_commit_max;
integer div_done_commit_le1_count;
integer div_done_commit_2to4_count;
integer div_done_commit_5to16_count;
integer div_done_commit_gt16_count;
integer rob_done_count_cur;
integer rob_done_not_head_count_cur;
integer rob_done_not_head_cycles;
integer rob_done_not_head_sum;
integer rob_done_not_head_max;
integer rob_younger_done_blocked_by_head_cycles;
integer rob_younger_done_blocked_by_alu_cycles;
integer rob_younger_done_blocked_by_mul_cycles;
integer rob_younger_done_blocked_by_div_cycles;
integer rob_younger_done_blocked_by_branch_cycles;
integer rob_younger_done_blocked_by_load_cycles;
integer rob_younger_done_blocked_by_store_cycles;
integer rob_head_wait_not_issued_cycles;
integer rob_head_wait_issued_not_exm_cycles;
integer rob_head_wait_exm_not_cpl_cycles;
integer rob_head_wait_cpl_seen_not_done_cycles;
integer rob_head_wait_cpl_same_cycle_cycles;
integer rob_head_wait_unknown_cycles;
integer rob_head_wait_real_not_issued_cycles;
integer rob_head_wait_issue_same_cycle_cycles;
integer rob_head_wait_real_issued_not_exm_cycles;
integer rob_head_wait_exm_same_cycle_cycles;
integer rob_head_wait_load_not_issued_cycles;
integer rob_head_wait_load_issued_not_exm_cycles;
integer rob_head_wait_load_exm_not_cpl_cycles;
integer rob_head_wait_load_cpl_seen_not_done_cycles;
integer rob_head_wait_load_cpl_same_cycle_cycles;
integer rob_head_wait_load_unknown_cycles;
integer rob_head_wait_load_real_not_issued_cycles;
integer rob_head_wait_load_issue_same_cycle_cycles;
integer rob_head_wait_load_real_issued_not_exm_cycles;
integer rob_head_wait_load_exm_same_cycle_cycles;
integer rob_head_wait_load_lq_not_done_cycles;
integer rob_head_wait_load_lq_query_wait_cycles;
integer rob_head_wait_load_lq_mem_wait_cycles;
integer rob_head_wait_load_lq_done_not_sent_cycles;
integer rob_head_wait_load_lq_done_no_out_cycles;
integer rob_head_wait_load_lq_out_other_cycles;
integer rob_head_wait_load_lq_complete_out_cycles;
integer rob_head_wait_load_lq_complete_accept_cycles;
integer rob_head_wait_load_lq_complete_block_cycles;
integer rob_head_wait_load_lq_block_two_pipe_cycles;
integer rob_head_wait_load_lq_block_one_pipe_cycles;
integer rob_head_wait_load_lq_block_no_pipe_cycles;
integer rob_head_load_rs_found_cycles;
integer rob_head_load_rs_missing_cycles;
integer rob_head_load_rs_ready_cycles;
integer rob_head_load_rs_ready_issued_cycles;
integer rob_head_load_rs_ready_not_issued_cycles;
integer rob_head_load_rs_wait_rs_alu_cycles;
integer rob_head_load_rs_wait_rs_load_cycles;
integer rob_head_load_rs_wait_rs_muldiv_cycles;
integer rob_head_load_rs_wait_rs_other_cycles;
integer rob_head_load_rs_wait_rt_alu_cycles;
integer rob_head_load_rs_wait_rt_load_cycles;
integer rob_head_load_rs_wait_rt_muldiv_cycles;
integer rob_head_load_rs_wait_rt_other_cycles;
integer rob_head_wait_store_not_issued_cycles;
integer rob_head_wait_store_issued_not_exm_cycles;
integer rob_head_wait_store_exm_not_cpl_cycles;
integer rob_head_wait_store_cpl_same_cycle_cycles;
integer rob_head_wait_store_real_not_issued_cycles;
integer rob_head_wait_store_issue_same_cycle_cycles;
integer rob_head_wait_store_real_issued_not_exm_cycles;
integer rob_head_wait_store_exm_same_cycle_cycles;
integer rob_head_wait_nonmem_not_issued_cycles;
integer rob_head_wait_nonmem_issued_not_exm_cycles;
integer rob_head_wait_nonmem_exm_not_cpl_cycles;
integer rob_head_wait_nonmem_cpl_same_cycle_cycles;
integer rob_head_wait_nonmem_real_not_issued_cycles;
integer rob_head_wait_nonmem_issue_same_cycle_cycles;
integer rob_head_wait_nonmem_real_issued_not_exm_cycles;
integer rob_head_wait_nonmem_exm_same_cycle_cycles;
integer rob_head_wait_nonmem_issued_not_exm_alu_cycles;
integer rob_head_wait_nonmem_issued_not_exm_branch_cycles;
integer rob_head_wait_nonmem_issued_not_exm_jal_cycles;
integer rob_head_wait_nonmem_issued_not_exm_u_cycles;
integer rob_head_wait_nonmem_issued_not_exm_mul_cycles;
integer rob_head_wait_nonmem_issued_not_exm_div_cycles;
integer rob_head_wait_nonmem_issued_not_exm_other_cycles;
integer rob_head_wait_nonmem_i2e_other_load_opcode_cycles;
integer rob_head_wait_nonmem_i2e_other_store_opcode_cycles;
integer rob_head_wait_nonmem_i2e_other_zero_opcode_cycles;
integer rob_head_wait_nonmem_i2e_other_system_opcode_cycles;
integer rob_head_wait_nonmem_i2e_other_fence_opcode_cycles;
integer rob_head_wait_nonmem_i2e_other_unknown_opcode_cycles;
integer rob_head_wait_nonmem_i2e_other_sample_count;
integer lq_head_valid_cycles;
integer lq_head_query_wait_cycles;
integer lq_head_mem_wait_cycles;
integer lq_head_done_not_sent_cycles;
integer lq_head_complete_sent_cycles;
integer lq_head_plus1_valid_cycles;
integer lq_head_plus1_query_wait_cycles;
integer lq_head_plus1_mem_wait_cycles;
integer lq_mem_req0_cycles;
integer lq_mem_req1_cycles;
integer lq_mem_req2_cycles;
integer lq_complete0_cycles;
integer lq_complete1_cycles;
integer lq_complete2_cycles;
integer lq_complete_wait_cycles;
integer lq_complete_wait_both_pipe_cycles;
integer lq_complete_wait_one_pipe_cycles;
integer lq_complete_wait_no_pipe_cycles;
integer issue2_ready2_cycles;
integer issue2_ready2_success_cycles;
integer issue2_ready2_blocked_cycles;
integer issue2_not_enough_ready_cycles;
integer issue2_accept_block_cycles;
integer issue2_block_has_alu_cycles;
integer issue2_block_has_mul_cycles;
integer issue2_block_has_div_cycles;
integer issue2_block_has_lsu_cycles;
integer issue2_block_has_branch_cycles;
integer issue2_block_has_other_cycles;
integer issue2_block_selected_lt2_cycles;
integer issue2_block_is3_backpressure_cycles;
integer issue2_block_is3_lane1_busy_cycles;
integer issue2_block_is3_lane2_busy_cycles;
integer es1_not_ready_cycles;
integer es2_not_ready_cycles;
integer es1_queue_full_cycles;
integer es2_queue_full_cycles;
integer es1_queue_any_cycles;
integer es2_queue_any_cycles;
integer issue2_block_es1_not_ready_cycles;
integer issue2_block_es2_not_ready_cycles;
integer issue2_block_es1_queue_full_cycles;
integer issue2_block_es2_queue_full_cycles;
integer commit2_possible_cycles;
integer commit2_success_cycles;
integer commit2_blocked_next_not_done_cycles;
integer commit2_blocked_next_invalid_cycles;
integer rs_effective_ready_alu_cur;
integer rs_effective_ready_mul_cur;
integer rs_effective_ready_div_cur;
integer rs_effective_ready_lsu_cur;
integer rs_effective_ready_branch_cur;
integer rs_effective_ready_other_cur;
integer rs_selected_count_cur;
integer rs_ready_min_age_cur;
integer rs_ready_max_age_cur;
integer rs_issue_age_1_cur;
integer rs_issue_age_2_cur;
integer rs_issue_count_age_cur;
integer rs_issue_min_age_cur;
integer rs_issue_max_age_cur;
integer rs_head_ready_cur;
integer rs_head_issued_cur;
integer rs_issue_age_count;
integer rs_issue_age_sum;
integer rs_issue_age_max;
integer rs_issue_age_le3_count;
integer rs_issue_age_4to15_count;
integer rs_issue_age_16plus_count;
integer rs_ready_oldest_age_count;
integer rs_ready_oldest_age_sum;
integer rs_ready_oldest_age_max;
integer rs_issue_younger_than_oldest_ready_cycles;
integer rs_issue_younger_than_oldest_ready_count;
integer rs_issue_younger_delta_sum;
integer rs_issue_younger_delta_max;
integer rs_head_wait_ready_cycles;
integer rs_head_wait_ready_issued_cycles;
integer rs_head_wait_ready_not_issued_cycles;
integer rs_head_wait_not_ready_cycles;

wire prof_issue_valid_1;
wire prof_issue_valid_2;
wire [`ROB_IDX_W-1:0] prof_issue_rob_tag_1;
wire [`ROB_IDX_W-1:0] prof_issue_rob_tag_2;
wire [`OPCODE_WIDTH-1:0] prof_issue_opcode_1;
wire [`OPCODE_WIDTH-1:0] prof_issue_opcode_2;
wire [`FUNCT3_WIDTH-1:0] prof_issue_funct3_1;
wire [`FUNCT3_WIDTH-1:0] prof_issue_funct3_2;
wire [`FUNCT7_WIDTH-1:0] prof_issue_funct7_1;
wire [`FUNCT7_WIDTH-1:0] prof_issue_funct7_2;

`ifdef FAST_ISSUE_BYPASS
assign prof_issue_valid_1 = dut.rs_issue_accept_1;
assign prof_issue_valid_2 = dut.rs_issue_accept_2;
assign prof_issue_rob_tag_1 = dut.rs_o_rob_tag_1;
assign prof_issue_rob_tag_2 = dut.rs_o_rob_tag_2;
assign prof_issue_opcode_1 = dut.rs_o_opcode_1;
assign prof_issue_opcode_2 = dut.rs_o_opcode_2;
assign prof_issue_funct3_1 = dut.rs_o_funct3_1;
assign prof_issue_funct3_2 = dut.rs_o_funct3_2;
assign prof_issue_funct7_1 = dut.rs_o_funct7_1;
assign prof_issue_funct7_2 = dut.rs_o_funct7_2;
`else
assign prof_issue_valid_1 = dut.is3_valid_1;
assign prof_issue_valid_2 = dut.is3_valid_2;
assign prof_issue_rob_tag_1 = dut.is3_rob_tag_1;
assign prof_issue_rob_tag_2 = dut.is3_rob_tag_2;
assign prof_issue_opcode_1 = dut.is3_opcode_1;
assign prof_issue_opcode_2 = dut.is3_opcode_2;
assign prof_issue_funct3_1 = dut.is3_funct3_1;
assign prof_issue_funct3_2 = dut.is3_funct3_2;
assign prof_issue_funct7_1 = dut.is3_funct7_1;
assign prof_issue_funct7_2 = dut.is3_funct7_2;
`endif

function [2:0] producer_kind;
  input [`OPCODE_WIDTH-1:0] opcode;
  input [`FUNCT3_WIDTH-1:0] funct3;
  input [`FUNCT7_WIDTH-1:0] funct7;
  begin
    if (opcode == `LOAD) begin
      producer_kind = 3'd2;
    end
    else if ((opcode == `RTYPE) && (funct7 == `MUL_7) &&
             ((funct3 == `MUL) || (funct3 == `MULH) ||
              (funct3 == `MULHSU) || (funct3 == `MULHU) ||
              (funct3 == `DIV) || (funct3 == `DIVU) ||
              (funct3 == `REM) || (funct3 == `REMU))) begin
      producer_kind = 3'd3;
    end
    else if ((opcode == `RTYPE) || (opcode == `ITYPE) ||
             (opcode == `LUI) || (opcode == `AUIPC) ||
             (opcode == `JAL) || (opcode == `JALR)) begin
      producer_kind = 3'd1;
    end
    else begin
      producer_kind = 3'd4;
    end
  end
endfunction

function integer branch_hot_pc_slot;
  input [`PC_WIDTH-1:0] pc;
  begin
    case (pc)
      32'h000003b0: branch_hot_pc_slot = 0;
      32'h000003d0: branch_hot_pc_slot = 1;
      32'h00000450: branch_hot_pc_slot = 2;
      32'h00000498: branch_hot_pc_slot = 3;
      32'h000004a4: branch_hot_pc_slot = 4;
      default:      branch_hot_pc_slot = 5;
    endcase
  end
endfunction

task record_branch_load_wait_stage;
  input [`PC_WIDTH-1:0] branch_pc;
  input [`RAT_SIZE-1:0] prd;
  input wait_on_rt;
  integer hot_slot;
  integer trace_i;
  integer producer_rs_idx;
  integer base_prod_rs_idx;
  reg producer_rs_found;
  reg producer_rs_ready_vec;
  reg producer_rs_stored_ready;
  reg [`ROB_IDX_W-1:0] producer_rob_tag;
  reg base_prod_rs_found;
  reg base_prod_rs_ready_vec;
  reg [`ROB_IDX_W-1:0] base_producer_rob_tag;
  reg [`RAT_SIZE-1:0] load_base_prs;
  begin
    hot_slot = branch_hot_pc_slot(branch_pc);
    branch_hot_load_wait_total[hot_slot] <= branch_hot_load_wait_total[hot_slot] + 1;
    producer_rob_tag = prd_producer_rob_tag[prd];

    if (branch_pc == 32'h000004a4) begin
      producer_rs_found = 1'b0;
      producer_rs_ready_vec = 1'b0;
      producer_rs_stored_ready = 1'b0;
      producer_rs_idx = 0;
      for (trace_i = 0; trace_i < `RS_SIZE; trace_i = trace_i + 1) begin
        if (!producer_rs_found &&
            dut.u_rs.ent_valid[trace_i] &&
            (dut.u_rs.ent_rob_tag[trace_i] == producer_rob_tag)) begin
          producer_rs_found = 1'b1;
          producer_rs_idx = trace_i;
          producer_rs_ready_vec = dut.u_rs.ready_vec[trace_i];
          producer_rs_stored_ready =
            (!dut.u_rs.ent_has_rs[trace_i] || dut.u_rs.ent_rs_ready[trace_i]) &&
            (!dut.u_rs.ent_has_rt[trace_i] || dut.u_rs.ent_rt_ready[trace_i]);
        end
      end

      branch_4a4_load_wait_total <= branch_4a4_load_wait_total + 1;
      if (wait_on_rt)
        branch_4a4_wait_prt_count <= branch_4a4_wait_prt_count + 1;
      else
        branch_4a4_wait_prs_count <= branch_4a4_wait_prs_count + 1;
      if (pc_by_rob[producer_rob_tag] == 32'h000004a0)
        branch_4a4_prod_pc_4a0_count <= branch_4a4_prod_pc_4a0_count + 1;
      else
        branch_4a4_prod_other_pc_count <= branch_4a4_prod_other_pc_count + 1;

      if (producer_rs_found) begin
        branch_4a4_prod_rs_found_count <= branch_4a4_prod_rs_found_count + 1;
        if (producer_rs_ready_vec)
          branch_4a4_prod_rs_ready_vec_count <= branch_4a4_prod_rs_ready_vec_count + 1;
        if (producer_rs_stored_ready)
          branch_4a4_prod_rs_stored_ready_count <= branch_4a4_prod_rs_stored_ready_count + 1;
        if (!producer_rs_ready_vec)
          branch_4a4_prod_rs_not_ready_count <= branch_4a4_prod_rs_not_ready_count + 1;
      end
      else begin
        branch_4a4_prod_rs_missing_count <= branch_4a4_prod_rs_missing_count + 1;
      end

      if (producer_rs_found && (dut.u_rs.ent_pc[producer_rs_idx] == 32'h000004a0)) begin
        branch_4a4_load_base_wait_total <= branch_4a4_load_base_wait_total + 1;
        load_base_prs = dut.u_rs.ent_prs[producer_rs_idx];
        base_producer_rob_tag = prd_producer_rob_tag[load_base_prs];
        base_prod_rs_found = 1'b0;
        base_prod_rs_ready_vec = 1'b0;
        base_prod_rs_idx = 0;
        for (trace_i = 0; trace_i < `RS_SIZE; trace_i = trace_i + 1) begin
          if (!base_prod_rs_found &&
              dut.u_rs.ent_valid[trace_i] &&
              (dut.u_rs.ent_rob_tag[trace_i] == base_producer_rob_tag)) begin
            base_prod_rs_found = 1'b1;
            base_prod_rs_idx = trace_i;
            base_prod_rs_ready_vec = dut.u_rs.ready_vec[trace_i];
          end
        end
        if (!dut.u_rs.ent_has_rs[producer_rs_idx] ||
            dut.u_rs.ent_rs_ready[producer_rs_idx]) begin
          branch_4a4_load_base_ready_count <= branch_4a4_load_base_ready_count + 1;
        end else begin
          branch_4a4_load_base_not_ready_count <= branch_4a4_load_base_not_ready_count + 1;
          if (dut.u_rs.ready_vec[producer_rs_idx])
            branch_4a4_load_base_not_ready_ready_vec_count <= branch_4a4_load_base_not_ready_ready_vec_count + 1;
          if (dut.u_rs.ent_wakeup_hold[producer_rs_idx])
            branch_4a4_load_base_not_ready_wakeup_hold_count <= branch_4a4_load_base_not_ready_wakeup_hold_count + 1;
          if (dut.spec_active)
            branch_4a4_load_base_not_ready_spec_active_count <= branch_4a4_load_base_not_ready_spec_active_count + 1;
          if (dut.u_rs.ent_opcode[producer_rs_idx] == `LOAD)
            branch_4a4_load_base_not_ready_opcode_load_count <= branch_4a4_load_base_not_ready_opcode_load_count + 1;
          if (dut.u_rs.ent_has_rt[producer_rs_idx] &&
              !dut.u_rs.ent_rt_ready[producer_rs_idx])
            branch_4a4_load_base_not_ready_has_rt_unready_count <= branch_4a4_load_base_not_ready_has_rt_unready_count + 1;
          if ((dut.rs_wakeup_es_valid_1 && (dut.rs_wakeup_es_prd_1 == dut.u_rs.ent_prs[producer_rs_idx])) ||
              (dut.rs_wakeup_es_valid_2 && (dut.rs_wakeup_es_prd_2 == dut.u_rs.ent_prs[producer_rs_idx])))
            branch_4a4_load_base_not_ready_prs_es_hit_count <= branch_4a4_load_base_not_ready_prs_es_hit_count + 1;
          if ((dut.rs_wakeup_mem_to_rs_valid_1 && (dut.rs_wakeup_mem_to_rs_prd_1 == dut.u_rs.ent_prs[producer_rs_idx])) ||
              (dut.rs_wakeup_mem_to_rs_valid_2 && (dut.rs_wakeup_mem_to_rs_prd_2 == dut.u_rs.ent_prs[producer_rs_idx])))
            branch_4a4_load_base_not_ready_prs_mem_hit_count <= branch_4a4_load_base_not_ready_prs_mem_hit_count + 1;
          if ((dut.rs_wakeup_es_valid_1 && (dut.rs_wakeup_es_prd_1 == dut.u_rs.ent_prt[producer_rs_idx])) ||
              (dut.rs_wakeup_es_valid_2 && (dut.rs_wakeup_es_prd_2 == dut.u_rs.ent_prt[producer_rs_idx])))
            branch_4a4_load_base_not_ready_prt_es_hit_count <= branch_4a4_load_base_not_ready_prt_es_hit_count + 1;
          if ((dut.rs_wakeup_mem_to_rs_valid_1 && (dut.rs_wakeup_mem_to_rs_prd_1 == dut.u_rs.ent_prt[producer_rs_idx])) ||
              (dut.rs_wakeup_mem_to_rs_valid_2 && (dut.rs_wakeup_mem_to_rs_prd_2 == dut.u_rs.ent_prt[producer_rs_idx])))
            branch_4a4_load_base_not_ready_prt_mem_hit_count <= branch_4a4_load_base_not_ready_prt_mem_hit_count + 1;
          if ((dut.rs_wakeup_es_valid_1 && (dut.rs_wakeup_es_prd_1 == load_base_prs)) ||
              (dut.rs_wakeup_es_valid_2 && (dut.rs_wakeup_es_prd_2 == load_base_prs))) begin
            branch_4a4_load_base_not_ready_es_wakeup_count <= branch_4a4_load_base_not_ready_es_wakeup_count + 1;
          end
          if ((dut.rs_wakeup_mem_to_rs_valid_1 && (dut.rs_wakeup_mem_to_rs_prd_1 == load_base_prs)) ||
              (dut.rs_wakeup_mem_to_rs_valid_2 && (dut.rs_wakeup_mem_to_rs_prd_2 == load_base_prs))) begin
            branch_4a4_load_base_not_ready_mem_wakeup_count <= branch_4a4_load_base_not_ready_mem_wakeup_count + 1;
          end
          if (!((dut.rs_wakeup_es_valid_1 && (dut.rs_wakeup_es_prd_1 == load_base_prs)) ||
                (dut.rs_wakeup_es_valid_2 && (dut.rs_wakeup_es_prd_2 == load_base_prs)) ||
                (dut.rs_wakeup_mem_to_rs_valid_1 && (dut.rs_wakeup_mem_to_rs_prd_1 == load_base_prs)) ||
                (dut.rs_wakeup_mem_to_rs_valid_2 && (dut.rs_wakeup_mem_to_rs_prd_2 == load_base_prs)))) begin
            branch_4a4_load_base_not_ready_no_wakeup_count <= branch_4a4_load_base_not_ready_no_wakeup_count + 1;
          end
        end
        if (pc_by_rob[base_producer_rob_tag] == 32'h0000049c)
          branch_4a4_load_base_prod_pc_49c_count <= branch_4a4_load_base_prod_pc_49c_count + 1;
        else
          branch_4a4_load_base_prod_other_pc_count <= branch_4a4_load_base_prod_other_pc_count + 1;
        if (base_prod_rs_found) begin
          branch_4a4_load_base_prod_rs_found_count <= branch_4a4_load_base_prod_rs_found_count + 1;
          if (base_prod_rs_ready_vec)
            branch_4a4_load_base_prod_rs_ready_count <= branch_4a4_load_base_prod_rs_ready_count + 1;
          else
            branch_4a4_load_base_prod_rs_not_ready_count <= branch_4a4_load_base_prod_rs_not_ready_count + 1;
        end else begin
          branch_4a4_load_base_prod_rs_missing_count <= branch_4a4_load_base_prod_rs_missing_count + 1;
        end
        if ((prof_issue_valid_1 && (prof_issue_rob_tag_1 == base_producer_rob_tag)) ||
            (prof_issue_valid_2 && (prof_issue_rob_tag_2 == base_producer_rob_tag))) begin
          branch_4a4_load_base_prod_issue_same_cycle_count <= branch_4a4_load_base_prod_issue_same_cycle_count + 1;
        end
        if (issue_seen_by_rob[base_producer_rob_tag])
          branch_4a4_load_base_prod_issued_seen_count <= branch_4a4_load_base_prod_issued_seen_count + 1;
        if (exm_seen_by_rob[base_producer_rob_tag])
          branch_4a4_load_base_prod_exm_seen_count <= branch_4a4_load_base_prod_exm_seen_count + 1;
        if (cpl_seen_by_rob[base_producer_rob_tag])
          branch_4a4_load_base_prod_cpl_seen_count <= branch_4a4_load_base_prod_cpl_seen_count + 1;
        if (done_seen_by_rob[base_producer_rob_tag])
          branch_4a4_load_base_prod_done_seen_count <= branch_4a4_load_base_prod_done_seen_count + 1;
        if ((dut.cpl_valid_1 && (dut.cpl_tag_1 == base_producer_rob_tag)) ||
            (dut.cpl_valid_2 && (dut.cpl_tag_2 == base_producer_rob_tag))) begin
          branch_4a4_load_base_prod_cpl_same_cycle_count <= branch_4a4_load_base_prod_cpl_same_cycle_count + 1;
        end
        if ((dut.rs_wakeup_es_valid_1 && (dut.rs_wakeup_es_prd_1 == load_base_prs)) ||
            (dut.rs_wakeup_es_valid_2 && (dut.rs_wakeup_es_prd_2 == load_base_prs)) ||
            (dut.rs_wakeup_mem_to_rs_valid_1 && (dut.rs_wakeup_mem_to_rs_prd_1 == load_base_prs)) ||
            (dut.rs_wakeup_mem_to_rs_valid_2 && (dut.rs_wakeup_mem_to_rs_prd_2 == load_base_prs))) begin
          branch_4a4_load_base_prod_wakeup_same_cycle_count <= branch_4a4_load_base_prod_wakeup_same_cycle_count + 1;
        end
      end

      if ((prof_issue_valid_1 && (prof_issue_rob_tag_1 == producer_rob_tag)) ||
          (prof_issue_valid_2 && (prof_issue_rob_tag_2 == producer_rob_tag))) begin
        branch_4a4_prod_issue_same_cycle_count <= branch_4a4_prod_issue_same_cycle_count + 1;
      end
      else if (producer_rs_found && producer_rs_ready_vec) begin
        branch_4a4_prod_ready_no_issue_count <= branch_4a4_prod_ready_no_issue_count + 1;
        case ({prof_issue_valid_2, prof_issue_valid_1})
          2'b00: branch_4a4_prod_ready_no_issue_issue0_count <= branch_4a4_prod_ready_no_issue_issue0_count + 1;
          2'b01,
          2'b10: branch_4a4_prod_ready_no_issue_issue1_count <= branch_4a4_prod_ready_no_issue_issue1_count + 1;
          default: branch_4a4_prod_ready_no_issue_issue2_count <= branch_4a4_prod_ready_no_issue_issue2_count + 1;
        endcase
      end
    end

    if (!issue_seen_by_rob[producer_rob_tag]) begin
      branch_load_wait_not_issued_cycles <= branch_load_wait_not_issued_cycles + 1;
      branch_hot_load_wait_not_issued[hot_slot] <= branch_hot_load_wait_not_issued[hot_slot] + 1;
    end
    else if (!exm_seen_by_rob[producer_rob_tag]) begin
      branch_load_wait_issued_not_exm_cycles <= branch_load_wait_issued_not_exm_cycles + 1;
      branch_hot_load_wait_issued_not_exm[hot_slot] <= branch_hot_load_wait_issued_not_exm[hot_slot] + 1;
    end
    else if (!cpl_seen_by_rob[producer_rob_tag]) begin
      branch_load_wait_exm_not_cpl_cycles <= branch_load_wait_exm_not_cpl_cycles + 1;
      branch_hot_load_wait_exm_not_cpl[hot_slot] <= branch_hot_load_wait_exm_not_cpl[hot_slot] + 1;
    end
    else if (!done_seen_by_rob[producer_rob_tag]) begin
      branch_load_wait_cpl_not_done_cycles <= branch_load_wait_cpl_not_done_cycles + 1;
      branch_hot_load_wait_cpl_not_done[hot_slot] <= branch_hot_load_wait_cpl_not_done[hot_slot] + 1;
    end
    else if (prd != {`RAT_SIZE{1'b0}}) begin
      branch_load_wait_done_no_wakeup_cycles <= branch_load_wait_done_no_wakeup_cycles + 1;
      branch_hot_load_wait_done_no_wakeup[hot_slot] <= branch_hot_load_wait_done_no_wakeup[hot_slot] + 1;
    end
    else begin
      branch_load_wait_unknown_cycles <= branch_load_wait_unknown_cycles + 1;
    end
  end
endtask

function integer rob_age_distance;
  input [`ROB_IDX_W-1:0] tag;
  input [`ROB_IDX_W-1:0] head;
  integer tag_i;
  integer head_i;
  begin
    tag_i = tag;
    head_i = head;
    if (tag_i >= head_i)
      rob_age_distance = tag_i - head_i;
    else
      rob_age_distance = tag_i + `ROB_SIZE - head_i;
  end
endfunction

task record_stage_latency;
  input integer kind;
  input integer stage_id;
  input integer latency;
  begin
    if (kind == 1) begin
      case (stage_id)
        0: begin
          alu_issue_exm_count = alu_issue_exm_count + 1;
          alu_issue_exm_sum = alu_issue_exm_sum + latency;
          if (latency > alu_issue_exm_max) alu_issue_exm_max = latency;
        end
        1: begin
          alu_exm_cpl_count = alu_exm_cpl_count + 1;
          alu_exm_cpl_sum = alu_exm_cpl_sum + latency;
          if (latency > alu_exm_cpl_max) alu_exm_cpl_max = latency;
        end
        2: begin
          alu_cpl_done_count = alu_cpl_done_count + 1;
          alu_cpl_done_sum = alu_cpl_done_sum + latency;
          if (latency > alu_cpl_done_max) alu_cpl_done_max = latency;
        end
        3: begin
          alu_done_commit_count = alu_done_commit_count + 1;
          alu_done_commit_sum = alu_done_commit_sum + latency;
          if (latency > alu_done_commit_max) alu_done_commit_max = latency;
          if (latency <= 1)
            alu_done_commit_le1_count = alu_done_commit_le1_count + 1;
          else if (latency <= 4)
            alu_done_commit_2to4_count = alu_done_commit_2to4_count + 1;
          else if (latency <= 16)
            alu_done_commit_5to16_count = alu_done_commit_5to16_count + 1;
          else
            alu_done_commit_gt16_count = alu_done_commit_gt16_count + 1;
        end
      endcase
    end
    else if (kind == 2) begin
      case (stage_id)
        0: begin
          div_issue_exm_count = div_issue_exm_count + 1;
          div_issue_exm_sum = div_issue_exm_sum + latency;
          if (latency > div_issue_exm_max) div_issue_exm_max = latency;
        end
        1: begin
          div_exm_cpl_count = div_exm_cpl_count + 1;
          div_exm_cpl_sum = div_exm_cpl_sum + latency;
          if (latency > div_exm_cpl_max) div_exm_cpl_max = latency;
        end
        2: begin
          div_cpl_done_count = div_cpl_done_count + 1;
          div_cpl_done_sum = div_cpl_done_sum + latency;
          if (latency > div_cpl_done_max) div_cpl_done_max = latency;
        end
        3: begin
          div_done_commit_count = div_done_commit_count + 1;
          div_done_commit_sum = div_done_commit_sum + latency;
          if (latency > div_done_commit_max) div_done_commit_max = latency;
          if (latency <= 1)
            div_done_commit_le1_count = div_done_commit_le1_count + 1;
          else if (latency <= 4)
            div_done_commit_2to4_count = div_done_commit_2to4_count + 1;
          else if (latency <= 16)
            div_done_commit_5to16_count = div_done_commit_5to16_count + 1;
          else
            div_done_commit_gt16_count = div_done_commit_gt16_count + 1;
        end
      endcase
    end
  end
endtask

task print_pipeline_profile;
  begin
    $display("PIPELINE PROFILE:");
    $display("fetch_stall_cycles = %0d", fetch_stall_cycles);
    $display("decode_hold_cycles = %0d", decode_hold_cycles);
    $display("dispatch0_cycles   = %0d", dispatch0_cycles);
    $display("dispatch1_cycles   = %0d", dispatch1_cycles);
    $display("dispatch2_cycles   = %0d", dispatch2_cycles);
    $display("commit0_cycles     = %0d", commit0_cycles);
    $display("commit1_cycles     = %0d", commit1_cycles);
    $display("commit2_cycles     = %0d", commit2_cycles);
    $display("branch_flush_count = %0d", branch_flush_count);
    $display("FLUSH SOURCE PROFILE:");
    $display("flush_spec_restore          = %0d", flush_spec_restore_count);
    $display("flush_early_taken           = %0d", flush_early_taken_count);
    $display("flush_btfnt_predict         = %0d", flush_btfnt_predict_count);
    $display("flush_ru_branch             = %0d", flush_ru_branch_count);
    $display("flush_ru_jal                = %0d", flush_ru_jal_count);
    $display("flush_btfnt_mispredict_nt   = %0d", flush_btfnt_mispredict_nt_count);
    $display("flush_fast_branch_exec      = %0d", flush_fast_branch_exec_count);
    $display("flush_registered_redirect   = %0d", flush_registered_redirect_count);
    $display("flush_lane2_redirect        = %0d", flush_lane2_redirect_count);
    $display("FETCH BTB PROFILE:");
    $display("fetch_btb_redirect          = %0d", fetch_btb_redirect_count);
    $display("fetch_btb_redirect_lane1    = %0d", fetch_btb_redirect_lane1_count);
    $display("fetch_btb_redirect_lane2    = %0d", fetch_btb_redirect_lane2_count);
    $display("CONTROL-FLOW PROFILE:");
    $display("jal_accept_count          = %0d", jal_accept_count);
    $display("jal_accept_jal_count      = %0d", jal_accept_jal_count);
    $display("jal_accept_jalr_count     = %0d", jal_accept_jalr_count);
    $display("branch_accept_count       = %0d", branch_accept_count);
    $display("branch_dispatch_count     = %0d", branch_dispatch_count);
    $display("branch_resolve_count      = %0d", branch_resolve_count);
    $display("branch_taken_count        = %0d", branch_taken_count);
    $display("branch_not_taken_count    = %0d", branch_not_taken_count);
    $display("early_branch_nt_count     = %0d", early_branch_nt_count);
    $display("early_branch_nt_lane1     = %0d", early_branch_nt_lane1_count);
    $display("early_branch_nt_lane2     = %0d", early_branch_nt_lane2_count);
    $display("early_branch_taken_count  = %0d", early_branch_taken_count);
    $display("early_branch_taken_lane1  = %0d", early_branch_taken_lane1_count);
    $display("early_branch_taken_lane2  = %0d", early_branch_taken_lane2_count);
    $display("early_branch_lane2_dep    = %0d", early_branch_lane2_dep_count);
    $display("btfnt_predict_taken_count = %0d", btfnt_predict_taken_count);
    $display("btfnt_predict_taken_lane1 = %0d", btfnt_predict_taken_lane1_count);
    $display("btfnt_predict_taken_lane2 = %0d", btfnt_predict_taken_lane2_count);
    $display("btfnt_mispredict_nt_count = %0d", btfnt_mispredict_nt_count);
    $display("btfnt_pending_cycles      = %0d", btfnt_pending_cycles);
    $display("spec_save_count           = %0d", spec_save_count);
    $display("spec_active_cycles        = %0d", spec_active_cycles);
    $display("spec_resolve_count        = %0d", spec_resolve_count);
    $display("spec_restore_count        = %0d", spec_restore_count);
    $display("BRANCH EARLY OPPORTUNITY PROFILE:");
    $display("branch_decode_lane1       = %0d", branch_decode_lane1_count);
    $display("branch_decode_lane2       = %0d", branch_decode_lane2_count);
    $display("branch_decode_ready_lane1 = %0d", branch_decode_ready_lane1_count);
    $display("branch_decode_ready_lane2 = %0d", branch_decode_ready_lane2_count);
    $display("branch_decode_ready_taken = %0d", branch_decode_ready_taken_count);
    $display("branch_decode_ready_nt    = %0d", branch_decode_ready_not_taken_count);
    $display("branch_decode_not_ready_rs= %0d", branch_decode_not_ready_rs_count);
    $display("branch_decode_not_ready_rt= %0d", branch_decode_not_ready_rt_count);
    $display("branch_decode_l2_dep_rs   = %0d", branch_decode_lane2_dep_rs_count);
    $display("branch_decode_l2_dep_rt   = %0d", branch_decode_lane2_dep_rt_count);
    $display("BRANCH RS OPERAND PRODUCER PROFILE:");
    $display("branch_rs_wait_rs_alu     = %0d", branch_rs_wait_rs_alu_cycles);
    $display("branch_rs_wait_rt_alu     = %0d", branch_rs_wait_rt_alu_cycles);
    $display("branch_rs_wait_rs_load    = %0d", branch_rs_wait_rs_load_cycles);
    $display("branch_rs_wait_rt_load    = %0d", branch_rs_wait_rt_load_cycles);
    $display("branch_rs_wait_rs_muldiv  = %0d", branch_rs_wait_rs_muldiv_cycles);
    $display("branch_rs_wait_rt_muldiv  = %0d", branch_rs_wait_rt_muldiv_cycles);
    $display("branch_rs_wait_rs_other   = %0d", branch_rs_wait_rs_other_cycles);
    $display("branch_rs_wait_rt_other   = %0d", branch_rs_wait_rt_other_cycles);
    $display("jal_pending_cycles        = %0d", jal_pending_cycles);
    $display("branch_pending_cycles     = %0d", branch_pending_cycles);
    $display("BRANCH PENDING LOCATION PROFILE:");
    $display("branch_pending_decode     = %0d", branch_pending_decode_cycles);
    $display("branch_pending_ru         = %0d", branch_pending_ru_cycles);
    $display("branch_pending_rs_wait    = %0d", branch_pending_rs_wait_cycles);
    $display("branch_pending_rs_ready   = %0d", branch_pending_rs_ready_cycles);
    $display("branch_pending_rs_ready_resolve = %0d", branch_pending_rs_ready_resolve_cycles);
    $display("branch_pending_rs_ready_no_resolve = %0d", branch_pending_rs_ready_no_resolve_cycles);
    $display("branch_pending_rs_ready_taken = %0d", branch_pending_rs_ready_taken_cycles);
    $display("branch_pending_rs_ready_nt = %0d", branch_pending_rs_ready_not_taken_cycles);
    $display("branch_pending_is3        = %0d", branch_pending_is3_cycles);
    $display("branch_pending_execute    = %0d", branch_pending_execute_cycles);
    $display("branch_pending_unknown    = %0d", branch_pending_unknown_cycles);
    $display("branch_pending_blocks_fe  = %0d", branch_pending_blocks_fe_cycles);
    $display("branch_pending_not_block_fe= %0d", branch_pending_not_block_fe_cycles);
    $display("branch_pending_ru_lane1   = %0d", branch_pending_ru_lane1_cycles);
    $display("branch_pending_ru_lane2   = %0d", branch_pending_ru_lane2_cycles);
    $display("branch_pending_ru_fire    = %0d", branch_pending_ru_dispatch_fire_cycles);
    $display("branch_pending_ru_ready   = %0d", branch_pending_ru_ready_cycles);
    $display("branch_pending_ru_ready_taken = %0d", branch_pending_ru_ready_taken_cycles);
    $display("branch_pending_ru_ready_nt = %0d", branch_pending_ru_ready_not_taken_cycles);
    $display("branch_pending_ru_l1_no_dispatch = %0d", branch_pending_ru_l1_no_dispatch_cycles);
    $display("branch_pending_ru_l1_lane2_older = %0d", branch_pending_ru_l1_lane2_older_cycles);
    $display("branch_pending_ru_l2_pair_l1_block = %0d", branch_pending_ru_l2_pair_l1_block_cycles);
    $display("branch_pending_ru_l2_pair_credit_block = %0d", branch_pending_ru_l2_pair_credit_block_cycles);
    $display("branch_pending_ru_l2_solo_credit_block = %0d", branch_pending_ru_l2_solo_credit_block_cycles);
    $display("branch_pending_ru_l2_solo_order_block = %0d", branch_pending_ru_l2_solo_order_block_cycles);
    $display("BRANCH PENDING SET CAUSE:");
    $display("branch_pending_set_btfnt      = %0d", branch_pending_set_btfnt_count);
    $display("branch_pending_set_btfnt_btb  = %0d", branch_pending_set_btfnt_btb_hit_count);
    $display("branch_pending_set_accept_wait= %0d", branch_pending_set_accept_wait_count);
    $display("branch_pending_set_dispatch_wait = %0d", branch_pending_set_dispatch_wait_count);
    $display("BRANCH LOAD PRODUCER WAIT STAGE:");
    $display("branch_load_wait_not_issued   = %0d", branch_load_wait_not_issued_cycles);
    $display("branch_load_wait_issued_not_exm= %0d", branch_load_wait_issued_not_exm_cycles);
    $display("branch_load_wait_exm_not_cpl  = %0d", branch_load_wait_exm_not_cpl_cycles);
    $display("branch_load_wait_cpl_not_done = %0d", branch_load_wait_cpl_not_done_cycles);
    $display("branch_load_wait_done_no_wakeup= %0d", branch_load_wait_done_no_wakeup_cycles);
    $display("branch_load_wait_unknown      = %0d", branch_load_wait_unknown_cycles);
    $display("BRANCH LOAD WAIT HOT PC PROFILE: total/not_issued/issued_not_exm/exm_not_cpl/cpl_not_done/done_no_wakeup");
    $display("branch_hot_pc_3b0 = %0d/%0d/%0d/%0d/%0d/%0d",
             branch_hot_load_wait_total[0], branch_hot_load_wait_not_issued[0],
             branch_hot_load_wait_issued_not_exm[0], branch_hot_load_wait_exm_not_cpl[0],
             branch_hot_load_wait_cpl_not_done[0], branch_hot_load_wait_done_no_wakeup[0]);
    $display("branch_hot_pc_3d0 = %0d/%0d/%0d/%0d/%0d/%0d",
             branch_hot_load_wait_total[1], branch_hot_load_wait_not_issued[1],
             branch_hot_load_wait_issued_not_exm[1], branch_hot_load_wait_exm_not_cpl[1],
             branch_hot_load_wait_cpl_not_done[1], branch_hot_load_wait_done_no_wakeup[1]);
    $display("branch_hot_pc_450 = %0d/%0d/%0d/%0d/%0d/%0d",
             branch_hot_load_wait_total[2], branch_hot_load_wait_not_issued[2],
             branch_hot_load_wait_issued_not_exm[2], branch_hot_load_wait_exm_not_cpl[2],
             branch_hot_load_wait_cpl_not_done[2], branch_hot_load_wait_done_no_wakeup[2]);
    $display("branch_hot_pc_498 = %0d/%0d/%0d/%0d/%0d/%0d",
             branch_hot_load_wait_total[3], branch_hot_load_wait_not_issued[3],
             branch_hot_load_wait_issued_not_exm[3], branch_hot_load_wait_exm_not_cpl[3],
             branch_hot_load_wait_cpl_not_done[3], branch_hot_load_wait_done_no_wakeup[3]);
    $display("branch_hot_pc_4a4 = %0d/%0d/%0d/%0d/%0d/%0d",
             branch_hot_load_wait_total[4], branch_hot_load_wait_not_issued[4],
             branch_hot_load_wait_issued_not_exm[4], branch_hot_load_wait_exm_not_cpl[4],
             branch_hot_load_wait_cpl_not_done[4], branch_hot_load_wait_done_no_wakeup[4]);
    $display("branch_hot_pc_other = %0d/%0d/%0d/%0d/%0d/%0d",
             branch_hot_load_wait_total[5], branch_hot_load_wait_not_issued[5],
             branch_hot_load_wait_issued_not_exm[5], branch_hot_load_wait_exm_not_cpl[5],
             branch_hot_load_wait_cpl_not_done[5], branch_hot_load_wait_done_no_wakeup[5]);
    $display("4A4 LOAD TRACE:");
    $display("branch_4a4_load_wait_total               = %0d", branch_4a4_load_wait_total);
    $display("branch_4a4_wait_prs/prt                  = %0d/%0d",
             branch_4a4_wait_prs_count, branch_4a4_wait_prt_count);
    $display("branch_4a4_prod_pc_4a0/other             = %0d/%0d",
             branch_4a4_prod_pc_4a0_count, branch_4a4_prod_other_pc_count);
    $display("branch_4a4_prod_rs_found/missing         = %0d/%0d",
             branch_4a4_prod_rs_found_count, branch_4a4_prod_rs_missing_count);
    $display("branch_4a4_prod_rs_ready_vec             = %0d", branch_4a4_prod_rs_ready_vec_count);
    $display("branch_4a4_prod_rs_stored_ready          = %0d", branch_4a4_prod_rs_stored_ready_count);
    $display("branch_4a4_prod_rs_not_ready             = %0d", branch_4a4_prod_rs_not_ready_count);
    $display("branch_4a4_prod_issue_same_cycle         = %0d", branch_4a4_prod_issue_same_cycle_count);
    $display("branch_4a4_prod_ready_no_issue           = %0d", branch_4a4_prod_ready_no_issue_count);
    $display("branch_4a4_ready_no_issue_issue0/1/2     = %0d/%0d/%0d",
             branch_4a4_prod_ready_no_issue_issue0_count,
             branch_4a4_prod_ready_no_issue_issue1_count,
             branch_4a4_prod_ready_no_issue_issue2_count);
    $display("4A4 LOAD BASE TRACE:");
    $display("branch_4a4_load_base wait/ready/not_ready = %0d/%0d/%0d",
             branch_4a4_load_base_wait_total,
             branch_4a4_load_base_ready_count,
             branch_4a4_load_base_not_ready_count);
    $display("branch_4a4_load_base producer_pc_49c/other = %0d/%0d",
             branch_4a4_load_base_prod_pc_49c_count,
             branch_4a4_load_base_prod_other_pc_count);
    $display("branch_4a4_load_base prod_rs found/missing = %0d/%0d",
             branch_4a4_load_base_prod_rs_found_count,
             branch_4a4_load_base_prod_rs_missing_count);
    $display("branch_4a4_load_base prod_rs ready/not_ready/issue_same = %0d/%0d/%0d",
             branch_4a4_load_base_prod_rs_ready_count,
             branch_4a4_load_base_prod_rs_not_ready_count,
             branch_4a4_load_base_prod_issue_same_cycle_count);
    $display("branch_4a4_load_base prod stage issued/exm/cpl/done = %0d/%0d/%0d/%0d",
             branch_4a4_load_base_prod_issued_seen_count,
             branch_4a4_load_base_prod_exm_seen_count,
             branch_4a4_load_base_prod_cpl_seen_count,
             branch_4a4_load_base_prod_done_seen_count);
    $display("branch_4a4_load_base prod cpl/wakeup same_cycle = %0d/%0d",
             branch_4a4_load_base_prod_cpl_same_cycle_count,
             branch_4a4_load_base_prod_wakeup_same_cycle_count);
    $display("branch_4a4_load_base not_ready ready_vec/wakeup_hold/spec_active = %0d/%0d/%0d",
             branch_4a4_load_base_not_ready_ready_vec_count,
             branch_4a4_load_base_not_ready_wakeup_hold_count,
             branch_4a4_load_base_not_ready_spec_active_count);
    $display("branch_4a4_load_base not_ready es_wakeup/mem_wakeup/no_wakeup = %0d/%0d/%0d",
             branch_4a4_load_base_not_ready_es_wakeup_count,
             branch_4a4_load_base_not_ready_mem_wakeup_count,
             branch_4a4_load_base_not_ready_no_wakeup_count);
    $display("branch_4a4_load_base not_ready opcode_load/rt_unready = %0d/%0d",
             branch_4a4_load_base_not_ready_opcode_load_count,
             branch_4a4_load_base_not_ready_has_rt_unready_count);
    $display("branch_4a4_load_base not_ready prs_es/prs_mem/prt_es/prt_mem = %0d/%0d/%0d/%0d",
             branch_4a4_load_base_not_ready_prs_es_hit_count,
             branch_4a4_load_base_not_ready_prs_mem_hit_count,
             branch_4a4_load_base_not_ready_prt_es_hit_count,
             branch_4a4_load_base_not_ready_prt_mem_hit_count);
    $display("jal_accept_stall_cycles   = %0d", jal_accept_stall_cycles);
    $display("branch_accept_stall_cycles= %0d", branch_accept_stall_cycles);
    $display("STALL BREAKDOWN:");
    $display("decode_hold_rs_full       = %0d", decode_hold_rs_full_cycles);
    $display("decode_hold_rob_full      = %0d", decode_hold_rob_full_cycles);
    $display("decode_hold_no_dec_load   = %0d", decode_hold_no_decode_load_cycles);
    $display("DECODE/RENAME HOLD DETAIL:");
    $display("dec_l1_req_no_ren         = %0d", dec_hold_l1_req_no_ren_cycles);
    $display("dec_l1_buf_full           = %0d", dec_hold_l1_buf_full_cycles);
    $display("dec_l1_lane2_older        = %0d", dec_hold_l1_lane2_older_cycles);
    $display("dec_l1_spec_barrier       = %0d", dec_hold_l1_spec_barrier_cycles);
    $display("dec_l1_spec_save          = %0d", dec_hold_l1_spec_save_cycles);
    $display("dec_l1_branch_pending     = %0d", dec_hold_l1_branch_pending_cycles);
    $display("dec_l1_jal_pending        = %0d", dec_hold_l1_jal_pending_cycles);
    $display("dec_l1_rob_credit         = %0d", dec_hold_l1_rob_credit_cycles);
    $display("dec_l1_freelist           = %0d", dec_hold_l1_freelist_cycles);
    $display("dec_l1_rs_credit          = %0d", dec_hold_l1_rs_credit_cycles);
    $display("dec_l1_sq_block           = %0d", dec_hold_l1_sq_block_cycles);
    $display("dec_l1_lq_block           = %0d", dec_hold_l1_lq_block_cycles);
    $display("dec_l1_pre_not_req        = %0d", dec_hold_l1_pre_not_req_cycles);
    $display("dec_l2_req_no_ren         = %0d", dec_hold_l2_req_no_ren_cycles);
    $display("dec_l2_buf_full           = %0d", dec_hold_l2_buf_full_cycles);
    $display("dec_l2_lane1_not_allow    = %0d", dec_hold_l2_lane1_not_allow_cycles);
    $display("dec_l2_lane1_buffer       = %0d", dec_hold_l2_lane1_buffer_cycles);
    $display("dec_l2_after_ctrl         = %0d", dec_hold_l2_after_ctrl_cycles);
    $display("dec_l2_spec_barrier       = %0d", dec_hold_l2_spec_barrier_cycles);
    $display("dec_l2_spec_save          = %0d", dec_hold_l2_spec_save_cycles);
    $display("dec_l2_branch_pending     = %0d", dec_hold_l2_branch_pending_cycles);
    $display("dec_l2_jal_pending        = %0d", dec_hold_l2_jal_pending_cycles);
    $display("dec_l2_rob_credit         = %0d", dec_hold_l2_rob_credit_cycles);
    $display("dec_l2_freelist           = %0d", dec_hold_l2_freelist_cycles);
    $display("dec_l2_rs_credit          = %0d", dec_hold_l2_rs_credit_cycles);
    $display("dec_l2_sq_block           = %0d", dec_hold_l2_sq_block_cycles);
    $display("dec_l2_lq_block           = %0d", dec_hold_l2_lq_block_cycles);
    $display("dec_l2_pre_not_req        = %0d", dec_hold_l2_pre_not_req_cycles);
    $display("DECODE HOLD ROOT CAUSE (exclusive):");
    $display("l1 lane2_older/buf/spec_bar/spec_save/branch/jal = %0d/%0d/%0d/%0d/%0d/%0d",
             dec_root_l1_lane2_older_cycles,
             dec_root_l1_buf_full_cycles,
             dec_root_l1_spec_barrier_cycles,
             dec_root_l1_spec_save_cycles,
             dec_root_l1_branch_pending_cycles,
             dec_root_l1_jal_pending_cycles);
    $display("l1 rob/free/rs/sq_lq/other = %0d/%0d/%0d/%0d/%0d",
             dec_root_l1_rob_credit_cycles,
             dec_root_l1_freelist_cycles,
             dec_root_l1_rs_credit_cycles,
             dec_root_l1_sq_lq_cycles,
             dec_root_l1_other_cycles);
    $display("l2 buf/l1_not_allow/l1_buffer/after_ctrl/spec_bar/spec_save = %0d/%0d/%0d/%0d/%0d/%0d",
             dec_root_l2_buf_full_cycles,
             dec_root_l2_lane1_not_allow_cycles,
             dec_root_l2_lane1_buffer_cycles,
             dec_root_l2_after_ctrl_cycles,
             dec_root_l2_spec_barrier_cycles,
             dec_root_l2_spec_save_cycles);
    $display("l2 branch/jal/rob/free/rs/sq_lq/other = %0d/%0d/%0d/%0d/%0d/%0d/%0d",
             dec_root_l2_branch_pending_cycles,
             dec_root_l2_jal_pending_cycles,
             dec_root_l2_rob_credit_cycles,
             dec_root_l2_freelist_cycles,
             dec_root_l2_rs_credit_cycles,
             dec_root_l2_sq_lq_cycles,
             dec_root_l2_other_cycles);
    $display("l2 other spec_ctrl/pre_req_true/pre_req_false/pre_ok_false = %0d/%0d/%0d/%0d",
             dec_root_l2_other_spec_ctrl_cycles,
             dec_root_l2_other_pre_req_true_cycles,
             dec_root_l2_other_pre_req_false_cycles,
             dec_root_l2_other_pre_ok_false_cycles);
    $display("l2 other simple/load/store/branch/jal = %0d/%0d/%0d/%0d/%0d",
             dec_root_l2_other_simple_cycles,
             dec_root_l2_other_load_cycles,
             dec_root_l2_other_store_cycles,
             dec_root_l2_other_branch_cycles,
             dec_root_l2_other_jal_cycles);
    $display("LANE2 BLOCK TRACE:");
    $display("lane2_not_allow_l1 simple/load/store/branch/jal/other = %0d/%0d/%0d/%0d/%0d/%0d",
             lane2_not_allow_l1_simple_cycles,
             lane2_not_allow_l1_load_cycles,
             lane2_not_allow_l1_store_cycles,
             lane2_not_allow_l1_branch_cycles,
             lane2_not_allow_l1_jal_cycles,
             lane2_not_allow_l1_other_cycles);
    $display("lane2_simple_dep indep/rs/rt/rd/any             = %0d/%0d/%0d/%0d/%0d",
             lane2_not_allow_simple_indep_cycles,
             lane2_not_allow_simple_dep_rs_cycles,
             lane2_not_allow_simple_dep_rt_cycles,
             lane2_not_allow_simple_dep_rd_cycles,
             lane2_not_allow_simple_dep_any_cycles);
    $display("lane2_buffer_l1 simple/load/store/branch/jal/other    = %0d/%0d/%0d/%0d/%0d/%0d",
             lane2_buffer_l1_simple_cycles,
             lane2_buffer_l1_load_cycles,
             lane2_buffer_l1_store_cycles,
             lane2_buffer_l1_branch_cycles,
             lane2_buffer_l1_jal_cycles,
             lane2_buffer_l1_other_cycles);
    $display("lane2_can_take2_block/older/full = %0d/%0d/%0d",
             lane2_can_take2_block_cycles,
             lane2_can_take2_older_block_cycles,
             lane2_can_take2_full_block_cycles);
    $display("LANE2 OLDER TRACE:");
    $display("lane2_older pending/dispatch/ds2_wait = %0d/%0d/%0d",
             lane2_older_pending_cycles,
             lane2_older_dispatch_cycles,
             lane2_older_dispatch_ds2_wait_cycles);
    $display("lane2_older l1 valid/empty/samefire = %0d/%0d/%0d",
             lane2_older_dispatch_l1_valid_cycles,
             lane2_older_dispatch_l1_empty_cycles,
             lane2_older_dispatch_l1_samefire_cycles);
    $display("lane2_older ds2 indep/dep = %0d/%0d",
             lane2_older_dispatch_ds2_indep_cycles,
             lane2_older_dispatch_ds2_dep_cycles);
    $display("lane2_older ds2 simple/load/store/branch/jal/other = %0d/%0d/%0d/%0d/%0d/%0d",
             lane2_older_dispatch_ds2_simple_cycles,
             lane2_older_dispatch_ds2_load_cycles,
             lane2_older_dispatch_ds2_store_cycles,
             lane2_older_dispatch_ds2_branch_cycles,
             lane2_older_dispatch_ds2_jal_cycles,
             lane2_older_dispatch_ds2_other_cycles);
    $display("CKPT BLOCK TRACE:");
    $display("ckpt_barrier_cycles       = %0d", ckpt_barrier_cycles);
    $display("ckpt_barrier_decode_hold  = %0d", ckpt_barrier_decode_hold_cycles);
    $display("ckpt_barrier_l1_ready     = %0d", ckpt_barrier_l1_ready_cycles);
    $display("ckpt_barrier_l2_ready     = %0d", ckpt_barrier_l2_ready_cycles);
    $display("ckpt_barrier_l1_simple/mem/ctrl = %0d/%0d/%0d",
             ckpt_barrier_l1_simple_cycles,
             ckpt_barrier_l1_mem_cycles,
             ckpt_barrier_l1_ctrl_cycles);
    $display("ckpt_barrier_l2_simple/mem/ctrl = %0d/%0d/%0d",
             ckpt_barrier_l2_simple_cycles,
             ckpt_barrier_l2_mem_cycles,
             ckpt_barrier_l2_ctrl_cycles);
    $display("ckpt_save_raw_cycles      = %0d", ckpt_save_raw_cycles);
    $display("ckpt_save_decode_hold     = %0d", ckpt_save_decode_hold_cycles);
    $display("ckpt_save_l1/l2_ready     = %0d/%0d",
             ckpt_save_l1_ready_cycles, ckpt_save_l2_ready_cycles);
    $display("DECODE HOLD LANE PROFILE:");
    $display("decode_hold_lane1         = %0d", decode_hold_lane1_cycles);
    $display("decode_hold_lane2         = %0d", decode_hold_lane2_cycles);
    $display("decode_hold_l2_after_br   = %0d", decode_hold_lane2_after_branch_cycles);
    $display("decode_hold_l2_after_jal  = %0d", decode_hold_lane2_after_jal_cycles);
    $display("dispatch0_rs_full         = %0d", dispatch0_rs_full_cycles);
    $display("dispatch0_rob_full        = %0d", dispatch0_rob_full_cycles);
    $display("dispatch0_no_rename_fire  = %0d", dispatch0_no_rename_fire_cycles);
    $display("dispatch0_no_accept       = %0d", dispatch0_no_dispatch_accept_cycles);
    $display("commit0_with_dispatch0    = %0d", commit0_with_dispatch0_cycles);
    $display("RENAME PROFILE:");
    $display("rename0_cycles = %0d", rename0_cycles);
    $display("rename1_cycles = %0d", rename1_cycles);
    $display("rename2_cycles = %0d", rename2_cycles);
    $display("ROB DRAIN PROFILE:");
    $display("rob_empty_cycles           = %0d", rob_empty_cycles);
    $display("rob_head_wait_cycles       = %0d", rob_head_wait_cycles);
    $display("rob_commit1_blocked_cycles = %0d", rob_commit1_blocked_cycles);
    $display("rob_full_cycles            = %0d", rob_full_cycles);
    $display("rob_near_full_cycles       = %0d", rob_near_full_cycles);
    $display("rob_max_used               = %0d", rob_max_used);
    if (scoreboard_cycle_count != 0) begin
      $display("rob_avg_used               = %0.2f",
               $itor(rob_used_sum) / $itor(scoreboard_cycle_count));
    end else if (cycle_count != 0) begin
      $display("rob_avg_used               = %0.2f",
               $itor(rob_used_sum) / $itor(cycle_count));
    end
    $display("ROB HEAD WAIT TYPE:");
    $display("rob_head_wait_alu     = %0d", rob_head_wait_alu_cycles);
    $display("rob_head_wait_mul     = %0d", rob_head_wait_mul_cycles);
    $display("rob_head_wait_div     = %0d", rob_head_wait_div_cycles);
    $display("rob_head_wait_branch  = %0d", rob_head_wait_branch_cycles);
    $display("rob_head_wait_load    = %0d", rob_head_wait_load_cycles);
    $display("rob_head_wait_store   = %0d", rob_head_wait_store_cycles);
    $display("rob_head_wait_non_mem = %0d", rob_head_wait_non_mem_cycles);
    $display("ISSUE / COMPLETE PROFILE:");
    $display("rs_issue0_cycles = %0d", rs_issue0_cycles);
    $display("rs_issue1_cycles = %0d", rs_issue1_cycles);
    $display("rs_issue2_cycles = %0d", rs_issue2_cycles);
    $display("complete0_cycles = %0d", complete0_cycles);
    $display("complete1_cycles = %0d", complete1_cycles);
    $display("complete2_cycles = %0d", complete2_cycles);
    $display("RS OCCUPANCY / READY PROFILE:");
    $display("rs_empty_cycles            = %0d", rs_empty_cycles);
    $display("rs_no_ready_cycles         = %0d", rs_no_ready_cycles);
    $display("rs_ready_but_issue0_cycles = %0d", rs_ready_but_issue0_cycles);
    $display("TRUE RS READY PROFILE:");
    $display("rs_true_ready2plus_cycles           = %0d", rs_true_ready2plus_cycles);
    $display("rs_true_ready2plus_issue0_cycles    = %0d", rs_true_ready2plus_issue0_cycles);
    $display("rs_true_ready2plus_issue1_cycles    = %0d", rs_true_ready2plus_issue1_cycles);
    $display("rs_true_ready2plus_issue2_cycles    = %0d", rs_true_ready2plus_issue2_cycles);
    $display("rs_true_ready2plus_selected_lt2     = %0d", rs_true_ready2plus_selected_lt2_cycles);
    $display("rs_true_ready2plus_is3_block        = %0d", rs_true_ready2plus_is3_block_cycles);
    $display("TRUE RS SELECT / QUEUE / ACCEPT:");
    $display("true_ready2_comb_select0 = %0d", rs_true_ready2plus_comb_select0_cycles);
    $display("true_ready2_comb_select1 = %0d", rs_true_ready2plus_comb_select1_cycles);
    $display("true_ready2_comb_select2 = %0d", rs_true_ready2plus_comb_select2_cycles);
    $display("true_ready2_issueq_load0 = %0d", rs_true_ready2plus_issueq_load0_cycles);
    $display("true_ready2_issueq_load1 = %0d", rs_true_ready2plus_issueq_load1_cycles);
    $display("true_ready2_issueq_load2 = %0d", rs_true_ready2plus_issueq_load2_cycles);
    $display("true_ready2_output0      = %0d", rs_true_ready2plus_output0_cycles);
    $display("true_ready2_output1      = %0d", rs_true_ready2plus_output1_cycles);
    $display("true_ready2_output2      = %0d", rs_true_ready2plus_output2_cycles);
    $display("true_ready2_accept0      = %0d", rs_true_ready2plus_accept0_cycles);
    $display("true_ready2_accept1      = %0d", rs_true_ready2plus_accept1_cycles);
    $display("true_ready2_accept2      = %0d", rs_true_ready2plus_accept2_cycles);
    $display("true_ready2_block_selector   = %0d", rs_true_ready2plus_block_selector_cycles);
    $display("true_ready2_block_issueq     = %0d", rs_true_ready2plus_block_issueq_cycles);
    $display("true_ready2_block_downstream = %0d", rs_true_ready2plus_block_downstream_cycles);
    $display("RS 2-WIDE READINESS:");
    $display("rs_ready0_cycles           = %0d", rs_ready0_cycles);
    $display("rs_ready1_cycles           = %0d", rs_ready1_cycles);
    $display("rs_ready2plus_cycles       = %0d", rs_ready2plus_cycles);
    $display("rs_ready1_issue0_cycles    = %0d", rs_ready1_issue0_cycles);
    $display("rs_ready1_issue1_cycles    = %0d", rs_ready1_issue1_cycles);
    $display("rs_ready2plus_issue0_cycles= %0d", rs_ready2plus_issue0_cycles);
    $display("rs_ready2plus_issue1_cycles= %0d", rs_ready2plus_issue1_cycles);
    $display("rs_ready2plus_issue2_cycles= %0d", rs_ready2plus_issue2_cycles);
    $display("rs_eff_ready2plus_cycles   = %0d", rs_effective_ready2plus_cycles);
    $display("rs_eff_ready2plus_issue_lt2= %0d", rs_effective_ready2plus_issue_lt2_cycles);
    $display("rs_max_valid_count         = %0d", rs_max_valid_count);
    $display("rs_max_ready_count         = %0d", rs_max_ready_count);
    $display("rs_max_effective_ready_count = %0d", rs_max_effective_ready_count);
    $display("rs_max_bypass_ready_count    = %0d", rs_max_bypass_ready_count);
    $display("rs_max_true_ready_count      = %0d", rs_max_true_ready_count);
    if (scoreboard_cycle_count != 0) begin
      $display("rs_avg_valid_count         = %0.2f",
               $itor(rs_valid_count_sum) / $itor(scoreboard_cycle_count));
      $display("rs_avg_ready_count         = %0.2f",
               $itor(rs_ready_count_sum) / $itor(scoreboard_cycle_count));
      $display("rs_avg_registered_ready_count = %0.2f",
               $itor(rs_ready_count_sum) / $itor(scoreboard_cycle_count));
      $display("rs_avg_effective_ready_count  = %0.2f",
               $itor(rs_effective_ready_count_sum) / $itor(scoreboard_cycle_count));
      $display("rs_avg_bypass_ready_count     = %0.2f",
               $itor(rs_bypass_ready_count_sum) / $itor(scoreboard_cycle_count));
      $display("rs_avg_true_ready_count       = %0.2f",
               $itor(rs_true_ready_count_sum) / $itor(scoreboard_cycle_count));
    end else if (cycle_count != 0) begin
      $display("rs_avg_valid_count         = %0.2f",
               $itor(rs_valid_count_sum) / $itor(cycle_count));
      $display("rs_avg_ready_count         = %0.2f",
               $itor(rs_ready_count_sum) / $itor(cycle_count));
      $display("rs_avg_registered_ready_count = %0.2f",
               $itor(rs_ready_count_sum) / $itor(cycle_count));
      $display("rs_avg_effective_ready_count  = %0.2f",
               $itor(rs_effective_ready_count_sum) / $itor(cycle_count));
      $display("rs_avg_bypass_ready_count     = %0.2f",
               $itor(rs_bypass_ready_count_sum) / $itor(cycle_count));
      $display("rs_avg_true_ready_count       = %0.2f",
               $itor(rs_true_ready_count_sum) / $itor(cycle_count));
    end
    $display("RS OPERAND WAIT PROFILE:");
    $display("rs_wait_rs_operand_sum   = %0d", rs_wait_rs_operand_sum);
    $display("rs_wait_rt_operand_sum   = %0d", rs_wait_rt_operand_sum);
    $display("rs_wait_both_operands_sum= %0d", rs_wait_both_operands_sum);
    $display("rs_wait_any_operand_sum  = %0d", rs_wait_any_operand_sum);
    $display("rs_wait_rs_operand_max   = %0d", rs_wait_rs_operand_max);
    $display("rs_wait_rt_operand_max   = %0d", rs_wait_rt_operand_max);
    $display("rs_wait_both_operands_max= %0d", rs_wait_both_operands_max);
    $display("RS WAKEUP PROFILE:");
    $display("rs_wakeup_es1_count  = %0d", rs_wakeup_es1_count);
    $display("rs_wakeup_es2_count  = %0d", rs_wakeup_es2_count);
    $display("rs_wakeup_mem1_count = %0d", rs_wakeup_mem1_count);
    $display("rs_wakeup_mem2_count = %0d", rs_wakeup_mem2_count);
    $display("ISSUE TO COMPLETE LATENCY:");
    $display("alu_issue_complete_count = %0d", alu_issue_complete_count);
    $display("alu_issue_complete_max   = %0d", alu_issue_complete_max);
    if (alu_issue_complete_count != 0) begin
      $display("alu_issue_complete_avg   = %0.2f",
               $itor(alu_issue_complete_sum) / $itor(alu_issue_complete_count));
    end
    $display("div_issue_complete_count = %0d", div_issue_complete_count);
    $display("div_issue_complete_max   = %0d", div_issue_complete_max);
    if (div_issue_complete_count != 0) begin
      $display("div_issue_complete_avg   = %0.2f",
               $itor(div_issue_complete_sum) / $itor(div_issue_complete_count));
    end
    $display("RS WAKEUP / ISSUE LATENCY:");
    $display("rs_wakeup_to_ready_count = %0d", rs_wakeup_to_ready_count);
    $display("rs_wakeup_to_ready_max   = %0d", rs_wakeup_to_ready_max);
    if (rs_wakeup_to_ready_count != 0) begin
      $display("rs_wakeup_to_ready_avg   = %0.2f",
               $itor(rs_wakeup_to_ready_sum) / $itor(rs_wakeup_to_ready_count));
    end
    $display("rs_ready_to_issue_count  = %0d", rs_ready_to_issue_count);
    $display("rs_ready_to_issue_max    = %0d", rs_ready_to_issue_max);
    if (rs_ready_to_issue_count != 0) begin
      $display("rs_ready_to_issue_avg    = %0.2f",
               $itor(rs_ready_to_issue_sum) / $itor(rs_ready_to_issue_count));
    end
    $display("EXECUTION STAGE BREAKDOWN:");
    if (alu_issue_exm_count != 0)
      $display("alu_issue_to_exm_avg     = %0.2f max=%0d count=%0d",
               $itor(alu_issue_exm_sum) / $itor(alu_issue_exm_count),
               alu_issue_exm_max, alu_issue_exm_count);
    if (alu_exm_cpl_count != 0)
      $display("alu_exm_to_cpl_avg       = %0.2f max=%0d count=%0d",
               $itor(alu_exm_cpl_sum) / $itor(alu_exm_cpl_count),
               alu_exm_cpl_max, alu_exm_cpl_count);
    if (alu_cpl_done_count != 0)
      $display("alu_cpl_to_done_avg      = %0.2f max=%0d count=%0d",
               $itor(alu_cpl_done_sum) / $itor(alu_cpl_done_count),
               alu_cpl_done_max, alu_cpl_done_count);
    if (alu_done_commit_count != 0)
      $display("alu_done_to_commit_avg   = %0.2f max=%0d count=%0d",
               $itor(alu_done_commit_sum) / $itor(alu_done_commit_count),
               alu_done_commit_max, alu_done_commit_count);
    $display("alu_done_to_commit_hist   <=1:%0d 2-4:%0d 5-16:%0d >16:%0d",
             alu_done_commit_le1_count,
             alu_done_commit_2to4_count,
             alu_done_commit_5to16_count,
             alu_done_commit_gt16_count);
    if (div_issue_exm_count != 0)
      $display("div_issue_to_exm_avg     = %0.2f max=%0d count=%0d",
               $itor(div_issue_exm_sum) / $itor(div_issue_exm_count),
               div_issue_exm_max, div_issue_exm_count);
    if (div_exm_cpl_count != 0)
      $display("div_exm_to_cpl_avg       = %0.2f max=%0d count=%0d",
               $itor(div_exm_cpl_sum) / $itor(div_exm_cpl_count),
               div_exm_cpl_max, div_exm_cpl_count);
    if (div_cpl_done_count != 0)
      $display("div_cpl_to_done_avg      = %0.2f max=%0d count=%0d",
               $itor(div_cpl_done_sum) / $itor(div_cpl_done_count),
               div_cpl_done_max, div_cpl_done_count);
    if (div_done_commit_count != 0)
      $display("div_done_to_commit_avg   = %0.2f max=%0d count=%0d",
               $itor(div_done_commit_sum) / $itor(div_done_commit_count),
               div_done_commit_max, div_done_commit_count);
    $display("div_done_to_commit_hist   <=1:%0d 2-4:%0d 5-16:%0d >16:%0d",
             div_done_commit_le1_count,
             div_done_commit_2to4_count,
             div_done_commit_5to16_count,
             div_done_commit_gt16_count);
    $display("ROB DONE-BUT-NOT-HEAD PROFILE:");
    $display("rob_done_not_head_cycles  = %0d", rob_done_not_head_cycles);
    $display("rob_done_not_head_max     = %0d", rob_done_not_head_max);
    if (scoreboard_cycle_count != 0) begin
      $display("rob_done_not_head_avg     = %0.2f",
               $itor(rob_done_not_head_sum) / $itor(scoreboard_cycle_count));
    end else if (cycle_count != 0) begin
      $display("rob_done_not_head_avg     = %0.2f",
               $itor(rob_done_not_head_sum) / $itor(cycle_count));
    end
    $display("younger_done_blocked_by_head = %0d", rob_younger_done_blocked_by_head_cycles);
    $display("blocked_head_alu     = %0d", rob_younger_done_blocked_by_alu_cycles);
    $display("blocked_head_mul     = %0d", rob_younger_done_blocked_by_mul_cycles);
    $display("blocked_head_div     = %0d", rob_younger_done_blocked_by_div_cycles);
    $display("blocked_head_branch  = %0d", rob_younger_done_blocked_by_branch_cycles);
    $display("blocked_head_load    = %0d", rob_younger_done_blocked_by_load_cycles);
    $display("blocked_head_store   = %0d", rob_younger_done_blocked_by_store_cycles);
    $display("ROB HEAD WAIT STAGE:");
    $display("head_wait_not_issued       = %0d", rob_head_wait_not_issued_cycles);
    $display("head_wait_issued_not_exm   = %0d", rob_head_wait_issued_not_exm_cycles);
    $display("head_wait_exm_not_cpl      = %0d", rob_head_wait_exm_not_cpl_cycles);
    $display("head_wait_cpl_same_cycle   = %0d", rob_head_wait_cpl_same_cycle_cycles);
    $display("head_wait_cpl_seen_not_done= %0d", rob_head_wait_cpl_seen_not_done_cycles);
    $display("head_wait_unknown          = %0d", rob_head_wait_unknown_cycles);
    $display("HEAD WAIT EFFECTIVE STAGE:");
    $display("head_real_not_issued       = %0d", rob_head_wait_real_not_issued_cycles);
    $display("head_issue_same_cycle      = %0d", rob_head_wait_issue_same_cycle_cycles);
    $display("head_real_issued_not_exm   = %0d", rob_head_wait_real_issued_not_exm_cycles);
    $display("head_exm_same_cycle        = %0d", rob_head_wait_exm_same_cycle_cycles);
    $display("ROB HEAD WAIT LOAD STAGE:");
    $display("load_head_not_issued       = %0d", rob_head_wait_load_not_issued_cycles);
    $display("load_head_issued_not_exm   = %0d", rob_head_wait_load_issued_not_exm_cycles);
    $display("load_head_exm_not_cpl      = %0d", rob_head_wait_load_exm_not_cpl_cycles);
    $display("load_head_cpl_same_cycle   = %0d", rob_head_wait_load_cpl_same_cycle_cycles);
    $display("load_head_cpl_seen_not_done= %0d", rob_head_wait_load_cpl_seen_not_done_cycles);
    $display("load_head_unknown          = %0d", rob_head_wait_load_unknown_cycles);
    $display("LOAD HEAD EFFECTIVE STAGE:");
    $display("load_real_not_issued       = %0d", rob_head_wait_load_real_not_issued_cycles);
    $display("load_issue_same_cycle      = %0d", rob_head_wait_load_issue_same_cycle_cycles);
    $display("load_real_issued_not_exm   = %0d", rob_head_wait_load_real_issued_not_exm_cycles);
    $display("load_exm_same_cycle        = %0d", rob_head_wait_load_exm_same_cycle_cycles);
    $display("LOAD HEAD LQ COMPLETE DETAIL:");
    $display("load_lq_not_done           = %0d", rob_head_wait_load_lq_not_done_cycles);
    $display("load_lq_query_wait         = %0d", rob_head_wait_load_lq_query_wait_cycles);
    $display("load_lq_mem_wait           = %0d", rob_head_wait_load_lq_mem_wait_cycles);
    $display("load_lq_done_not_sent      = %0d", rob_head_wait_load_lq_done_not_sent_cycles);
    $display("load_lq_done_no_out        = %0d", rob_head_wait_load_lq_done_no_out_cycles);
    $display("load_lq_out_other          = %0d", rob_head_wait_load_lq_out_other_cycles);
    $display("load_lq_complete_out       = %0d", rob_head_wait_load_lq_complete_out_cycles);
    $display("load_lq_complete_accept    = %0d", rob_head_wait_load_lq_complete_accept_cycles);
    $display("load_lq_complete_block     = %0d", rob_head_wait_load_lq_complete_block_cycles);
    $display("load_lq_block_two_pipe     = %0d", rob_head_wait_load_lq_block_two_pipe_cycles);
    $display("load_lq_block_one_pipe     = %0d", rob_head_wait_load_lq_block_one_pipe_cycles);
    $display("load_lq_block_no_pipe      = %0d", rob_head_wait_load_lq_block_no_pipe_cycles);
    $display("ROB HEAD LOAD NOT-ISSUED RS DETAIL:");
    $display("load_head_rs_found         = %0d", rob_head_load_rs_found_cycles);
    $display("load_head_rs_missing       = %0d", rob_head_load_rs_missing_cycles);
    $display("load_head_rs_ready         = %0d", rob_head_load_rs_ready_cycles);
    $display("load_head_rs_ready_issued  = %0d", rob_head_load_rs_ready_issued_cycles);
    $display("load_head_rs_ready_noissue = %0d", rob_head_load_rs_ready_not_issued_cycles);
    $display("load_head_rs_wait_rs_alu   = %0d", rob_head_load_rs_wait_rs_alu_cycles);
    $display("load_head_rs_wait_rs_load  = %0d", rob_head_load_rs_wait_rs_load_cycles);
    $display("load_head_rs_wait_rs_muldiv= %0d", rob_head_load_rs_wait_rs_muldiv_cycles);
    $display("load_head_rs_wait_rs_other = %0d", rob_head_load_rs_wait_rs_other_cycles);
    $display("load_head_rs_wait_rt_alu   = %0d", rob_head_load_rs_wait_rt_alu_cycles);
    $display("load_head_rs_wait_rt_load  = %0d", rob_head_load_rs_wait_rt_load_cycles);
    $display("load_head_rs_wait_rt_muldiv= %0d", rob_head_load_rs_wait_rt_muldiv_cycles);
    $display("load_head_rs_wait_rt_other = %0d", rob_head_load_rs_wait_rt_other_cycles);
    $display("ROB HEAD WAIT STORE/NONMEM STAGE:");
    $display("store_head_not_issued      = %0d", rob_head_wait_store_not_issued_cycles);
    $display("store_head_issued_not_exm  = %0d", rob_head_wait_store_issued_not_exm_cycles);
    $display("store_head_exm_not_cpl     = %0d", rob_head_wait_store_exm_not_cpl_cycles);
    $display("store_head_cpl_same_cycle  = %0d", rob_head_wait_store_cpl_same_cycle_cycles);
    $display("store_real_not_issued      = %0d", rob_head_wait_store_real_not_issued_cycles);
    $display("store_issue_same_cycle     = %0d", rob_head_wait_store_issue_same_cycle_cycles);
    $display("store_real_issued_not_exm  = %0d", rob_head_wait_store_real_issued_not_exm_cycles);
    $display("store_exm_same_cycle       = %0d", rob_head_wait_store_exm_same_cycle_cycles);
    $display("nonmem_head_not_issued     = %0d", rob_head_wait_nonmem_not_issued_cycles);
    $display("nonmem_head_issued_not_exm = %0d", rob_head_wait_nonmem_issued_not_exm_cycles);
    $display("nonmem_head_exm_not_cpl    = %0d", rob_head_wait_nonmem_exm_not_cpl_cycles);
    $display("nonmem_head_cpl_same_cycle = %0d", rob_head_wait_nonmem_cpl_same_cycle_cycles);
    $display("nonmem_real_not_issued     = %0d", rob_head_wait_nonmem_real_not_issued_cycles);
    $display("nonmem_issue_same_cycle    = %0d", rob_head_wait_nonmem_issue_same_cycle_cycles);
    $display("nonmem_real_issued_not_exm = %0d", rob_head_wait_nonmem_real_issued_not_exm_cycles);
    $display("nonmem_exm_same_cycle      = %0d", rob_head_wait_nonmem_exm_same_cycle_cycles);
    $display("NONMEM ISSUED-NOT-EXM OPCODE BREAKDOWN:");
    $display("nonmem_i2e_alu             = %0d", rob_head_wait_nonmem_issued_not_exm_alu_cycles);
    $display("nonmem_i2e_branch          = %0d", rob_head_wait_nonmem_issued_not_exm_branch_cycles);
    $display("nonmem_i2e_jal_jalr        = %0d", rob_head_wait_nonmem_issued_not_exm_jal_cycles);
    $display("nonmem_i2e_lui_auipc       = %0d", rob_head_wait_nonmem_issued_not_exm_u_cycles);
    $display("nonmem_i2e_mul             = %0d", rob_head_wait_nonmem_issued_not_exm_mul_cycles);
    $display("nonmem_i2e_div             = %0d", rob_head_wait_nonmem_issued_not_exm_div_cycles);
    $display("nonmem_i2e_other           = %0d", rob_head_wait_nonmem_issued_not_exm_other_cycles);
    $display("NONMEM I2E OTHER RAW OPCODE BREAKDOWN:");
    $display("nonmem_i2e_other_load_op   = %0d", rob_head_wait_nonmem_i2e_other_load_opcode_cycles);
    $display("nonmem_i2e_other_store_op  = %0d", rob_head_wait_nonmem_i2e_other_store_opcode_cycles);
    $display("nonmem_i2e_other_zero_op   = %0d", rob_head_wait_nonmem_i2e_other_zero_opcode_cycles);
    $display("nonmem_i2e_other_system_op = %0d", rob_head_wait_nonmem_i2e_other_system_opcode_cycles);
    $display("nonmem_i2e_other_fence_op  = %0d", rob_head_wait_nonmem_i2e_other_fence_opcode_cycles);
    $display("nonmem_i2e_other_unknown   = %0d", rob_head_wait_nonmem_i2e_other_unknown_opcode_cycles);
    $display("EFFECTIVE BOTTLENECK SUMMARY:");
    $display("eff_head_real_not_issued   = %0d", rob_head_wait_real_not_issued_cycles);
    $display("eff_head_real_i2e_wait     = %0d", rob_head_wait_real_issued_not_exm_cycles);
    $display("eff_load_mem_wait          = %0d", rob_head_wait_load_lq_mem_wait_cycles);
    $display("eff_load_complete_port_wait= %0d", rob_head_wait_load_lq_complete_block_cycles);
    $display("eff_lq_head_done_no_send   = %0d",
             rob_head_wait_load_lq_done_not_sent_cycles +
             rob_head_wait_load_lq_done_no_out_cycles +
             rob_head_wait_load_lq_out_other_cycles);
    $display("eff_nonmem_real_wait       = %0d",
             rob_head_wait_nonmem_real_not_issued_cycles +
             rob_head_wait_nonmem_real_issued_not_exm_cycles);
    $display("eff_branch_frontend_block  = %0d", branch_pending_blocks_fe_cycles);
    $display("eff_decode_spec_block      = %0d",
             dec_hold_l1_spec_barrier_cycles +
             dec_hold_l1_spec_save_cycles +
             dec_hold_l2_spec_barrier_cycles +
             dec_hold_l2_spec_save_cycles);
    $display("samecycle_head_accounting  = %0d",
             rob_head_wait_issue_same_cycle_cycles +
             rob_head_wait_exm_same_cycle_cycles +
             rob_head_wait_cpl_same_cycle_cycles);
    $display("samecycle_branch_i2e       = %0d", rob_head_wait_nonmem_issued_not_exm_branch_cycles);
    $display("issue2_limited_by_ready    = %0d", issue2_not_enough_ready_cycles);
    $display("LOAD QUEUE PROFILE:");
    $display("lq_head_valid              = %0d", lq_head_valid_cycles);
    $display("lq_head_query_wait         = %0d", lq_head_query_wait_cycles);
    $display("lq_head_mem_wait           = %0d", lq_head_mem_wait_cycles);
    $display("lq_head_done_not_sent      = %0d", lq_head_done_not_sent_cycles);
    $display("lq_head_complete_sent      = %0d", lq_head_complete_sent_cycles);
    $display("lq_head_plus1_valid        = %0d", lq_head_plus1_valid_cycles);
    $display("lq_head_plus1_query_wait   = %0d", lq_head_plus1_query_wait_cycles);
    $display("lq_head_plus1_mem_wait     = %0d", lq_head_plus1_mem_wait_cycles);
    $display("lq_mem_req0_cycles         = %0d", lq_mem_req0_cycles);
    $display("lq_mem_req1_cycles         = %0d", lq_mem_req1_cycles);
    $display("lq_mem_req2_cycles         = %0d", lq_mem_req2_cycles);
    $display("lq_complete0_cycles        = %0d", lq_complete0_cycles);
    $display("lq_complete1_cycles        = %0d", lq_complete1_cycles);
    $display("lq_complete2_cycles        = %0d", lq_complete2_cycles);
    $display("lq_complete_wait           = %0d", lq_complete_wait_cycles);
    $display("lq_complete_wait_both_pipe = %0d", lq_complete_wait_both_pipe_cycles);
    $display("lq_complete_wait_one_pipe  = %0d", lq_complete_wait_one_pipe_cycles);
    $display("lq_complete_wait_no_pipe   = %0d", lq_complete_wait_no_pipe_cycles);
    $display("RS ISSUE AGE PROFILE:");
    $display("rs_issue_age_count         = %0d", rs_issue_age_count);
    $display("rs_issue_age_max           = %0d", rs_issue_age_max);
    if (rs_issue_age_count != 0) begin
      $display("rs_issue_age_avg           = %0.2f",
               $itor(rs_issue_age_sum) / $itor(rs_issue_age_count));
    end
    $display("rs_issue_age_hist <=3:%0d 4-15:%0d >=16:%0d",
             rs_issue_age_le3_count,
             rs_issue_age_4to15_count,
             rs_issue_age_16plus_count);
    $display("rs_ready_oldest_age_count  = %0d", rs_ready_oldest_age_count);
    $display("rs_ready_oldest_age_max    = %0d", rs_ready_oldest_age_max);
    if (rs_ready_oldest_age_count != 0) begin
      $display("rs_ready_oldest_age_avg    = %0.2f",
               $itor(rs_ready_oldest_age_sum) / $itor(rs_ready_oldest_age_count));
    end
    $display("rs_issue_younger_than_oldest_ready_cycles = %0d",
             rs_issue_younger_than_oldest_ready_cycles);
    $display("rs_issue_younger_than_oldest_ready_count  = %0d",
             rs_issue_younger_than_oldest_ready_count);
    $display("rs_issue_younger_delta_max = %0d", rs_issue_younger_delta_max);
    if (rs_issue_younger_than_oldest_ready_cycles != 0) begin
      $display("rs_issue_younger_delta_avg = %0.2f",
               $itor(rs_issue_younger_delta_sum) /
               $itor(rs_issue_younger_than_oldest_ready_cycles));
    end
    $display("rs_head_wait_ready_cycles      = %0d", rs_head_wait_ready_cycles);
    $display("rs_head_wait_ready_issued      = %0d", rs_head_wait_ready_issued_cycles);
    $display("rs_head_wait_ready_not_issued  = %0d", rs_head_wait_ready_not_issued_cycles);
    $display("rs_head_wait_not_ready         = %0d", rs_head_wait_not_ready_cycles);
    $display("2-WIDE UTILIZATION DIAG:");
    $display("issue2_ready2_cycles           = %0d", issue2_ready2_cycles);
    $display("issue2_ready2_success_cycles   = %0d", issue2_ready2_success_cycles);
    $display("issue2_ready2_blocked_cycles   = %0d", issue2_ready2_blocked_cycles);
    $display("issue2_not_enough_ready_cycles = %0d", issue2_not_enough_ready_cycles);
    $display("issue2_accept_block_cycles     = %0d", issue2_accept_block_cycles);
    $display("ISSUE2 BLOCK REASON:");
    $display("issue2_block_has_alu           = %0d", issue2_block_has_alu_cycles);
    $display("issue2_block_has_mul           = %0d", issue2_block_has_mul_cycles);
    $display("issue2_block_has_div           = %0d", issue2_block_has_div_cycles);
    $display("issue2_block_has_lsu           = %0d", issue2_block_has_lsu_cycles);
    $display("issue2_block_has_branch        = %0d", issue2_block_has_branch_cycles);
    $display("issue2_block_has_other         = %0d", issue2_block_has_other_cycles);
    $display("issue2_block_selected_lt2      = %0d", issue2_block_selected_lt2_cycles);
    $display("issue2_block_is3_backpressure  = %0d", issue2_block_is3_backpressure_cycles);
    $display("issue2_block_is3_lane1_busy    = %0d", issue2_block_is3_lane1_busy_cycles);
    $display("issue2_block_is3_lane2_busy    = %0d", issue2_block_is3_lane2_busy_cycles);
    $display("EXECUTE READY / QUEUE PROFILE:");
    $display("es1_not_ready_cycles           = %0d", es1_not_ready_cycles);
    $display("es2_not_ready_cycles           = %0d", es2_not_ready_cycles);
    $display("es1_queue_full_cycles          = %0d", es1_queue_full_cycles);
    $display("es2_queue_full_cycles          = %0d", es2_queue_full_cycles);
    $display("es1_queue_any_cycles           = %0d", es1_queue_any_cycles);
    $display("es2_queue_any_cycles           = %0d", es2_queue_any_cycles);
    $display("issue2_block_es1_not_ready     = %0d", issue2_block_es1_not_ready_cycles);
    $display("issue2_block_es2_not_ready     = %0d", issue2_block_es2_not_ready_cycles);
    $display("issue2_block_es1_queue_full    = %0d", issue2_block_es1_queue_full_cycles);
    $display("issue2_block_es2_queue_full    = %0d", issue2_block_es2_queue_full_cycles);
    $display("commit2_possible_cycles        = %0d", commit2_possible_cycles);
    $display("commit2_success_cycles         = %0d", commit2_success_cycles);
    $display("commit2_block_next_not_done    = %0d", commit2_blocked_next_not_done_cycles);
    $display("commit2_block_next_invalid     = %0d", commit2_blocked_next_invalid_cycles);
  end
endtask

initial begin
  commit_count = 0;
  cycle_count = 0;
  scoreboard_commit_count = 0;
  scoreboard_cycle_count = 0;
  scoreboard_settle_i = 0;
  scoreboard_ipc = 0.0;
  scoreboard_seen = 1'b0;
  scoreboard_done = 1'b0;
  scoreboard_x31 = {`DWIDTH{1'b0}};
  scoreboard_x30 = {`DWIDTH{1'b0}};
  scoreboard_x30_shadow = {`DWIDTH{1'b0}};
  next_scoreboard_x30 = {`DWIDTH{1'b0}};
  fetch_stall_cycles = 0;
  decode_hold_cycles = 0;
  dispatch0_cycles = 0;
  dispatch1_cycles = 0;
  dispatch2_cycles = 0;
  commit0_cycles = 0;
  commit1_cycles = 0;
  commit2_cycles = 0;
  branch_flush_count = 0;
  flush_spec_restore_count = 0;
  flush_early_taken_count = 0;
  flush_btfnt_predict_count = 0;
  flush_ru_branch_count = 0;
  flush_ru_jal_count = 0;
  flush_btfnt_mispredict_nt_count = 0;
  flush_fast_branch_exec_count = 0;
  flush_registered_redirect_count = 0;
  flush_lane2_redirect_count = 0;
  fetch_btb_redirect_count = 0;
  fetch_btb_redirect_lane1_count = 0;
  fetch_btb_redirect_lane2_count = 0;
  jal_accept_count = 0;
  jal_accept_jal_count = 0;
  jal_accept_jalr_count = 0;
  branch_accept_count = 0;
  branch_dispatch_count = 0;
  branch_resolve_count = 0;
  branch_taken_count = 0;
  branch_not_taken_count = 0;
  early_branch_nt_count = 0;
  early_branch_nt_lane1_count = 0;
  early_branch_nt_lane2_count = 0;
  early_branch_taken_count = 0;
  early_branch_taken_lane1_count = 0;
  early_branch_taken_lane2_count = 0;
  early_branch_lane2_dep_count = 0;
  btfnt_predict_taken_count = 0;
  btfnt_predict_taken_lane1_count = 0;
  btfnt_predict_taken_lane2_count = 0;
  btfnt_mispredict_nt_count = 0;
  btfnt_pending_cycles = 0;
  spec_save_count = 0;
  spec_active_cycles = 0;
  spec_resolve_count = 0;
  spec_restore_count = 0;
  branch_decode_lane1_count = 0;
  branch_decode_lane2_count = 0;
  branch_decode_ready_lane1_count = 0;
  branch_decode_ready_lane2_count = 0;
  branch_decode_ready_taken_count = 0;
  branch_decode_ready_not_taken_count = 0;
  branch_decode_not_ready_rs_count = 0;
  branch_decode_not_ready_rt_count = 0;
  branch_decode_lane2_dep_rs_count = 0;
  branch_decode_lane2_dep_rt_count = 0;
  branch_rs_wait_rs_alu_cycles = 0;
  branch_rs_wait_rt_alu_cycles = 0;
  branch_rs_wait_rs_load_cycles = 0;
  branch_rs_wait_rt_load_cycles = 0;
  branch_rs_wait_rs_muldiv_cycles = 0;
  branch_rs_wait_rt_muldiv_cycles = 0;
  branch_rs_wait_rs_other_cycles = 0;
  branch_rs_wait_rt_other_cycles = 0;
  jal_pending_cycles = 0;
  branch_pending_cycles = 0;
  branch_pending_decode_cycles = 0;
  branch_pending_ru_cycles = 0;
  branch_pending_rs_wait_cycles = 0;
  branch_pending_rs_ready_cycles = 0;
  branch_pending_rs_ready_resolve_cycles = 0;
  branch_pending_rs_ready_no_resolve_cycles = 0;
  branch_pending_rs_ready_taken_cycles = 0;
  branch_pending_rs_ready_not_taken_cycles = 0;
  branch_pending_is3_cycles = 0;
  branch_pending_execute_cycles = 0;
  branch_pending_unknown_cycles = 0;
  branch_pending_blocks_fe_cycles = 0;
  branch_pending_not_block_fe_cycles = 0;
  branch_pending_ru_lane1_cycles = 0;
  branch_pending_ru_lane2_cycles = 0;
  branch_pending_ru_dispatch_fire_cycles = 0;
  branch_pending_ru_ready_cycles = 0;
  branch_pending_ru_ready_taken_cycles = 0;
  branch_pending_ru_ready_not_taken_cycles = 0;
  branch_pending_ru_l1_no_dispatch_cycles = 0;
  branch_pending_ru_l1_lane2_older_cycles = 0;
  branch_pending_ru_l2_pair_l1_block_cycles = 0;
  branch_pending_ru_l2_pair_credit_block_cycles = 0;
  branch_pending_set_btfnt_count = 0;
  branch_pending_set_btfnt_btb_hit_count = 0;
  branch_pending_set_accept_wait_count = 0;
  branch_pending_set_dispatch_wait_count = 0;
  branch_pending_ru_l2_solo_credit_block_cycles = 0;
  branch_pending_ru_l2_solo_order_block_cycles = 0;
  branch_load_wait_not_issued_cycles = 0;
  branch_load_wait_issued_not_exm_cycles = 0;
  branch_load_wait_exm_not_cpl_cycles = 0;
  branch_load_wait_cpl_not_done_cycles = 0;
  branch_load_wait_done_no_wakeup_cycles = 0;
  branch_load_wait_unknown_cycles = 0;
  branch_4a4_load_wait_total = 0;
  branch_4a4_wait_prs_count = 0;
  branch_4a4_wait_prt_count = 0;
  branch_4a4_prod_pc_4a0_count = 0;
  branch_4a4_prod_other_pc_count = 0;
  branch_4a4_prod_rs_found_count = 0;
  branch_4a4_prod_rs_missing_count = 0;
  branch_4a4_prod_rs_ready_vec_count = 0;
  branch_4a4_prod_rs_stored_ready_count = 0;
  branch_4a4_prod_rs_not_ready_count = 0;
  branch_4a4_prod_issue_same_cycle_count = 0;
  branch_4a4_prod_ready_no_issue_count = 0;
  branch_4a4_prod_ready_no_issue_issue0_count = 0;
  branch_4a4_prod_ready_no_issue_issue1_count = 0;
  branch_4a4_prod_ready_no_issue_issue2_count = 0;
  branch_4a4_load_base_wait_total = 0;
  branch_4a4_load_base_ready_count = 0;
  branch_4a4_load_base_not_ready_count = 0;
  branch_4a4_load_base_prod_pc_49c_count = 0;
  branch_4a4_load_base_prod_other_pc_count = 0;
  branch_4a4_load_base_prod_rs_found_count = 0;
  branch_4a4_load_base_prod_rs_missing_count = 0;
  branch_4a4_load_base_prod_rs_ready_count = 0;
  branch_4a4_load_base_prod_rs_not_ready_count = 0;
  branch_4a4_load_base_prod_issue_same_cycle_count = 0;
  branch_4a4_load_base_prod_issued_seen_count = 0;
  branch_4a4_load_base_prod_exm_seen_count = 0;
  branch_4a4_load_base_prod_cpl_seen_count = 0;
  branch_4a4_load_base_prod_done_seen_count = 0;
  branch_4a4_load_base_prod_cpl_same_cycle_count = 0;
  branch_4a4_load_base_prod_wakeup_same_cycle_count = 0;
  branch_4a4_load_base_not_ready_ready_vec_count = 0;
  branch_4a4_load_base_not_ready_wakeup_hold_count = 0;
  branch_4a4_load_base_not_ready_spec_active_count = 0;
  branch_4a4_load_base_not_ready_es_wakeup_count = 0;
  branch_4a4_load_base_not_ready_mem_wakeup_count = 0;
  branch_4a4_load_base_not_ready_no_wakeup_count = 0;
  branch_4a4_load_base_not_ready_opcode_load_count = 0;
  branch_4a4_load_base_not_ready_has_rt_unready_count = 0;
  branch_4a4_load_base_not_ready_prs_es_hit_count = 0;
  branch_4a4_load_base_not_ready_prs_mem_hit_count = 0;
  branch_4a4_load_base_not_ready_prt_es_hit_count = 0;
  branch_4a4_load_base_not_ready_prt_mem_hit_count = 0;
  for (branch_hot_i = 0; branch_hot_i < 6; branch_hot_i = branch_hot_i + 1) begin
    branch_hot_load_wait_total[branch_hot_i] = 0;
    branch_hot_load_wait_not_issued[branch_hot_i] = 0;
    branch_hot_load_wait_issued_not_exm[branch_hot_i] = 0;
    branch_hot_load_wait_exm_not_cpl[branch_hot_i] = 0;
    branch_hot_load_wait_cpl_not_done[branch_hot_i] = 0;
    branch_hot_load_wait_done_no_wakeup[branch_hot_i] = 0;
  end
  decode_hold_lane1_cycles = 0;
  decode_hold_lane2_cycles = 0;
  decode_hold_lane2_after_branch_cycles = 0;
  decode_hold_lane2_after_jal_cycles = 0;
  jal_accept_stall_cycles = 0;
  branch_accept_stall_cycles = 0;
  decode_hold_rs_full_cycles = 0;
  decode_hold_rob_full_cycles = 0;
  decode_hold_no_decode_load_cycles = 0;
  dec_hold_l1_req_no_ren_cycles = 0;
  dec_hold_l1_buf_full_cycles = 0;
  dec_hold_l1_lane2_older_cycles = 0;
  dec_hold_l1_spec_barrier_cycles = 0;
  dec_hold_l1_spec_save_cycles = 0;
  dec_hold_l1_branch_pending_cycles = 0;
  dec_hold_l1_jal_pending_cycles = 0;
  dec_hold_l1_rob_credit_cycles = 0;
  dec_hold_l1_freelist_cycles = 0;
  dec_hold_l1_rs_credit_cycles = 0;
  dec_hold_l1_sq_block_cycles = 0;
  dec_hold_l1_lq_block_cycles = 0;
  dec_hold_l1_pre_not_req_cycles = 0;
  dec_root_l1_lane2_older_cycles = 0;
  dec_root_l1_buf_full_cycles = 0;
  dec_root_l1_spec_barrier_cycles = 0;
  dec_root_l1_spec_save_cycles = 0;
  dec_root_l1_branch_pending_cycles = 0;
  dec_root_l1_jal_pending_cycles = 0;
  dec_root_l1_rob_credit_cycles = 0;
  dec_root_l1_freelist_cycles = 0;
  dec_root_l1_rs_credit_cycles = 0;
  dec_root_l1_sq_lq_cycles = 0;
  dec_root_l1_other_cycles = 0;
  dec_hold_l2_req_no_ren_cycles = 0;
  dec_hold_l2_buf_full_cycles = 0;
  dec_hold_l2_lane1_not_allow_cycles = 0;
  dec_hold_l2_lane1_buffer_cycles = 0;
  dec_hold_l2_after_ctrl_cycles = 0;
  dec_hold_l2_spec_barrier_cycles = 0;
  dec_hold_l2_spec_save_cycles = 0;
  dec_hold_l2_branch_pending_cycles = 0;
  dec_hold_l2_jal_pending_cycles = 0;
  dec_hold_l2_rob_credit_cycles = 0;
  dec_hold_l2_freelist_cycles = 0;
  dec_hold_l2_rs_credit_cycles = 0;
  dec_hold_l2_sq_block_cycles = 0;
  dec_hold_l2_lq_block_cycles = 0;
  dec_hold_l2_pre_not_req_cycles = 0;
  dec_root_l2_buf_full_cycles = 0;
  dec_root_l2_lane1_not_allow_cycles = 0;
  dec_root_l2_lane1_buffer_cycles = 0;
  dec_root_l2_after_ctrl_cycles = 0;
  dec_root_l2_spec_barrier_cycles = 0;
  dec_root_l2_spec_save_cycles = 0;
  dec_root_l2_branch_pending_cycles = 0;
  dec_root_l2_jal_pending_cycles = 0;
  dec_root_l2_rob_credit_cycles = 0;
  dec_root_l2_freelist_cycles = 0;
  dec_root_l2_rs_credit_cycles = 0;
  dec_root_l2_sq_lq_cycles = 0;
  dec_root_l2_other_cycles = 0;
  dec_root_l2_other_spec_ctrl_cycles = 0;
  dec_root_l2_other_pre_req_true_cycles = 0;
  dec_root_l2_other_pre_req_false_cycles = 0;
  dec_root_l2_other_pre_ok_false_cycles = 0;
  dec_root_l2_other_simple_cycles = 0;
  dec_root_l2_other_load_cycles = 0;
  dec_root_l2_other_store_cycles = 0;
  dec_root_l2_other_branch_cycles = 0;
  dec_root_l2_other_jal_cycles = 0;
  lane2_not_allow_l1_simple_cycles = 0;
  lane2_not_allow_l1_load_cycles = 0;
  lane2_not_allow_l1_store_cycles = 0;
  lane2_not_allow_l1_branch_cycles = 0;
  lane2_not_allow_l1_jal_cycles = 0;
  lane2_not_allow_l1_other_cycles = 0;
  lane2_not_allow_simple_indep_cycles = 0;
  lane2_not_allow_simple_dep_rs_cycles = 0;
  lane2_not_allow_simple_dep_rt_cycles = 0;
  lane2_not_allow_simple_dep_rd_cycles = 0;
  lane2_not_allow_simple_dep_any_cycles = 0;
  lane2_buffer_l1_simple_cycles = 0;
  lane2_buffer_l1_load_cycles = 0;
  lane2_buffer_l1_store_cycles = 0;
  lane2_buffer_l1_branch_cycles = 0;
  lane2_buffer_l1_jal_cycles = 0;
  lane2_buffer_l1_other_cycles = 0;
  lane2_can_take2_block_cycles = 0;
  lane2_can_take2_older_block_cycles = 0;
  lane2_can_take2_full_block_cycles = 0;
  lane2_older_pending_cycles = 0;
  lane2_older_dispatch_cycles = 0;
  lane2_older_dispatch_ds2_wait_cycles = 0;
  lane2_older_dispatch_l1_valid_cycles = 0;
  lane2_older_dispatch_l1_empty_cycles = 0;
  lane2_older_dispatch_l1_samefire_cycles = 0;
  lane2_older_dispatch_ds2_indep_cycles = 0;
  lane2_older_dispatch_ds2_dep_cycles = 0;
  lane2_older_dispatch_ds2_simple_cycles = 0;
  lane2_older_dispatch_ds2_load_cycles = 0;
  lane2_older_dispatch_ds2_store_cycles = 0;
  lane2_older_dispatch_ds2_branch_cycles = 0;
  lane2_older_dispatch_ds2_jal_cycles = 0;
  lane2_older_dispatch_ds2_other_cycles = 0;
  ckpt_barrier_cycles = 0;
  ckpt_barrier_decode_hold_cycles = 0;
  ckpt_barrier_l1_ready_cycles = 0;
  ckpt_barrier_l2_ready_cycles = 0;
  ckpt_barrier_l1_simple_cycles = 0;
  ckpt_barrier_l1_mem_cycles = 0;
  ckpt_barrier_l1_ctrl_cycles = 0;
  ckpt_barrier_l2_simple_cycles = 0;
  ckpt_barrier_l2_mem_cycles = 0;
  ckpt_barrier_l2_ctrl_cycles = 0;
  ckpt_save_raw_cycles = 0;
  ckpt_save_l1_ready_cycles = 0;
  ckpt_save_l2_ready_cycles = 0;
  ckpt_save_decode_hold_cycles = 0;
  dispatch0_rs_full_cycles = 0;
  dispatch0_rob_full_cycles = 0;
  dispatch0_no_rename_fire_cycles = 0;
  dispatch0_no_dispatch_accept_cycles = 0;
  rename0_cycles = 0;
  rename1_cycles = 0;
  rename2_cycles = 0;
  commit0_with_dispatch0_cycles = 0;
  rob_empty_cycles = 0;
  rob_head_wait_cycles = 0;
  rob_commit1_blocked_cycles = 0;
  rob_full_cycles = 0;
  rob_near_full_cycles = 0;
  rob_max_used = 0;
  rob_used_sum = 0;
  rob_head_wait_load_cycles = 0;
  rob_head_wait_store_cycles = 0;
  rob_head_wait_non_mem_cycles = 0;
  rob_head_wait_alu_cycles = 0;
  rob_head_wait_mul_cycles = 0;
  rob_head_wait_div_cycles = 0;
  rob_head_wait_branch_cycles = 0;
  rs_issue0_cycles = 0;
  rs_issue1_cycles = 0;
  rs_issue2_cycles = 0;
  complete0_cycles = 0;
  complete1_cycles = 0;
  complete2_cycles = 0;
  rs_profile_i = 0;
  rs_valid_count_cur = 0;
  rs_ready_count_cur = 0;
  rs_effective_ready_count_cur = 0;
  rs_bypass_ready_count_cur = 0;
  rs_true_ready_count_cur = 0;
  rs_issue_count_cur = 0;
  rs_valid_count_sum = 0;
  rs_ready_count_sum = 0;
  rs_effective_ready_count_sum = 0;
  rs_bypass_ready_count_sum = 0;
  rs_true_ready_count_sum = 0;
  rs_max_valid_count = 0;
  rs_max_ready_count = 0;
  rs_max_effective_ready_count = 0;
  rs_max_bypass_ready_count = 0;
  rs_max_true_ready_count = 0;
  rs_empty_cycles = 0;
  rs_no_ready_cycles = 0;
  rs_ready_but_issue0_cycles = 0;
  rs_true_ready2plus_cycles = 0;
  rs_true_ready2plus_issue0_cycles = 0;
  rs_true_ready2plus_issue1_cycles = 0;
  rs_true_ready2plus_issue2_cycles = 0;
  rs_true_ready2plus_selected_lt2_cycles = 0;
  rs_true_ready2plus_is3_block_cycles = 0;
  rs_true_ready2plus_comb_select0_cycles = 0;
  rs_true_ready2plus_comb_select1_cycles = 0;
  rs_true_ready2plus_comb_select2_cycles = 0;
  rs_true_ready2plus_issueq_load0_cycles = 0;
  rs_true_ready2plus_issueq_load1_cycles = 0;
  rs_true_ready2plus_issueq_load2_cycles = 0;
  rs_true_ready2plus_output0_cycles = 0;
  rs_true_ready2plus_output1_cycles = 0;
  rs_true_ready2plus_output2_cycles = 0;
  rs_true_ready2plus_accept0_cycles = 0;
  rs_true_ready2plus_accept1_cycles = 0;
  rs_true_ready2plus_accept2_cycles = 0;
  rs_true_ready2plus_block_selector_cycles = 0;
  rs_true_ready2plus_block_issueq_cycles = 0;
  rs_true_ready2plus_block_downstream_cycles = 0;
  rs_ready0_cycles = 0;
  rs_ready1_cycles = 0;
  rs_ready2plus_cycles = 0;
  rs_ready2plus_issue0_cycles = 0;
  rs_ready2plus_issue1_cycles = 0;
  rs_ready2plus_issue2_cycles = 0;
  rs_ready1_issue0_cycles = 0;
  rs_ready1_issue1_cycles = 0;
  rs_effective_ready2plus_cycles = 0;
  rs_effective_ready2plus_issue_lt2_cycles = 0;
  rs_wait_rs_operand_sum = 0;
  rs_wait_rt_operand_sum = 0;
  rs_wait_both_operands_sum = 0;
  rs_wait_any_operand_sum = 0;
  rs_wait_rs_operand_max = 0;
  rs_wait_rt_operand_max = 0;
  rs_wait_both_operands_max = 0;
  rs_wait_rs_count_cur = 0;
  rs_wait_rt_count_cur = 0;
  rs_wait_both_count_cur = 0;
  rs_wait_any_count_cur = 0;
  rs_wakeup_es1_count = 0;
  rs_wakeup_es2_count = 0;
  rs_wakeup_mem1_count = 0;
  rs_wakeup_mem2_count = 0;
  cpl_latency_tmp = 0;
  alu_issue_complete_count = 0;
  alu_issue_complete_sum = 0;
  alu_issue_complete_max = 0;
  div_issue_complete_count = 0;
  div_issue_complete_sum = 0;
  div_issue_complete_max = 0;
  rs_wakeup_to_ready_count = 0;
  rs_wakeup_to_ready_sum = 0;
  rs_wakeup_to_ready_max = 0;
  rs_ready_to_issue_count = 0;
  rs_ready_to_issue_sum = 0;
  rs_ready_to_issue_max = 0;
  stage_latency_tmp = 0;
  alu_issue_exm_count = 0; alu_issue_exm_sum = 0; alu_issue_exm_max = 0;
  alu_exm_cpl_count = 0; alu_exm_cpl_sum = 0; alu_exm_cpl_max = 0;
  alu_cpl_done_count = 0; alu_cpl_done_sum = 0; alu_cpl_done_max = 0;
  alu_done_commit_count = 0; alu_done_commit_sum = 0; alu_done_commit_max = 0;
  alu_done_commit_le1_count = 0;
  alu_done_commit_2to4_count = 0;
  alu_done_commit_5to16_count = 0;
  alu_done_commit_gt16_count = 0;
  div_issue_exm_count = 0; div_issue_exm_sum = 0; div_issue_exm_max = 0;
  div_exm_cpl_count = 0; div_exm_cpl_sum = 0; div_exm_cpl_max = 0;
  div_cpl_done_count = 0; div_cpl_done_sum = 0; div_cpl_done_max = 0;
  div_done_commit_count = 0; div_done_commit_sum = 0; div_done_commit_max = 0;
  div_done_commit_le1_count = 0;
  div_done_commit_2to4_count = 0;
  div_done_commit_5to16_count = 0;
  div_done_commit_gt16_count = 0;
  rob_done_count_cur = 0;
  rob_done_not_head_count_cur = 0;
  rob_done_not_head_cycles = 0;
  rob_done_not_head_sum = 0;
  rob_done_not_head_max = 0;
  rob_younger_done_blocked_by_head_cycles = 0;
  rob_younger_done_blocked_by_alu_cycles = 0;
  rob_younger_done_blocked_by_mul_cycles = 0;
  rob_younger_done_blocked_by_div_cycles = 0;
  rob_younger_done_blocked_by_branch_cycles = 0;
  rob_younger_done_blocked_by_load_cycles = 0;
  rob_younger_done_blocked_by_store_cycles = 0;
  rob_head_wait_not_issued_cycles = 0;
  rob_head_wait_issued_not_exm_cycles = 0;
  rob_head_wait_exm_not_cpl_cycles = 0;
  rob_head_wait_cpl_seen_not_done_cycles = 0;
  rob_head_wait_cpl_same_cycle_cycles = 0;
  rob_head_wait_unknown_cycles = 0;
  rob_head_wait_real_not_issued_cycles = 0;
  rob_head_wait_issue_same_cycle_cycles = 0;
  rob_head_wait_real_issued_not_exm_cycles = 0;
  rob_head_wait_exm_same_cycle_cycles = 0;
  rob_head_wait_load_not_issued_cycles = 0;
  rob_head_wait_load_issued_not_exm_cycles = 0;
  rob_head_wait_load_exm_not_cpl_cycles = 0;
  rob_head_wait_load_cpl_seen_not_done_cycles = 0;
  rob_head_wait_load_cpl_same_cycle_cycles = 0;
  rob_head_wait_load_unknown_cycles = 0;
  rob_head_wait_load_real_not_issued_cycles = 0;
  rob_head_wait_load_issue_same_cycle_cycles = 0;
  rob_head_wait_load_real_issued_not_exm_cycles = 0;
  rob_head_wait_load_exm_same_cycle_cycles = 0;
  rob_head_wait_load_lq_not_done_cycles = 0;
  rob_head_wait_load_lq_query_wait_cycles = 0;
  rob_head_wait_load_lq_mem_wait_cycles = 0;
  rob_head_wait_load_lq_done_not_sent_cycles = 0;
  rob_head_wait_load_lq_done_no_out_cycles = 0;
  rob_head_wait_load_lq_out_other_cycles = 0;
  rob_head_wait_load_lq_complete_out_cycles = 0;
  rob_head_wait_load_lq_complete_accept_cycles = 0;
  rob_head_wait_load_lq_complete_block_cycles = 0;
  rob_head_wait_load_lq_block_two_pipe_cycles = 0;
  rob_head_wait_load_lq_block_one_pipe_cycles = 0;
  rob_head_wait_load_lq_block_no_pipe_cycles = 0;
  rob_head_load_rs_found_cycles = 0;
  rob_head_load_rs_missing_cycles = 0;
  rob_head_load_rs_ready_cycles = 0;
  rob_head_load_rs_ready_issued_cycles = 0;
  rob_head_load_rs_ready_not_issued_cycles = 0;
  rob_head_load_rs_wait_rs_alu_cycles = 0;
  rob_head_load_rs_wait_rs_load_cycles = 0;
  rob_head_load_rs_wait_rs_muldiv_cycles = 0;
  rob_head_load_rs_wait_rs_other_cycles = 0;
  rob_head_load_rs_wait_rt_alu_cycles = 0;
  rob_head_load_rs_wait_rt_load_cycles = 0;
  rob_head_load_rs_wait_rt_muldiv_cycles = 0;
  rob_head_load_rs_wait_rt_other_cycles = 0;
  rob_head_wait_store_not_issued_cycles = 0;
  rob_head_wait_store_issued_not_exm_cycles = 0;
  rob_head_wait_store_exm_not_cpl_cycles = 0;
  rob_head_wait_store_cpl_same_cycle_cycles = 0;
  rob_head_wait_store_real_not_issued_cycles = 0;
  rob_head_wait_store_issue_same_cycle_cycles = 0;
  rob_head_wait_store_real_issued_not_exm_cycles = 0;
  rob_head_wait_store_exm_same_cycle_cycles = 0;
  rob_head_wait_nonmem_not_issued_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_cycles = 0;
  rob_head_wait_nonmem_exm_not_cpl_cycles = 0;
  rob_head_wait_nonmem_cpl_same_cycle_cycles = 0;
  rob_head_wait_nonmem_real_not_issued_cycles = 0;
  rob_head_wait_nonmem_issue_same_cycle_cycles = 0;
  rob_head_wait_nonmem_real_issued_not_exm_cycles = 0;
  rob_head_wait_nonmem_exm_same_cycle_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_alu_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_branch_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_jal_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_u_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_mul_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_div_cycles = 0;
  rob_head_wait_nonmem_issued_not_exm_other_cycles = 0;
  rob_head_wait_nonmem_i2e_other_load_opcode_cycles = 0;
  rob_head_wait_nonmem_i2e_other_store_opcode_cycles = 0;
  rob_head_wait_nonmem_i2e_other_zero_opcode_cycles = 0;
  rob_head_wait_nonmem_i2e_other_system_opcode_cycles = 0;
  rob_head_wait_nonmem_i2e_other_fence_opcode_cycles = 0;
  rob_head_wait_nonmem_i2e_other_unknown_opcode_cycles = 0;
  rob_head_wait_nonmem_i2e_other_sample_count = 0;
  lq_head_valid_cycles = 0;
  lq_head_query_wait_cycles = 0;
  lq_head_mem_wait_cycles = 0;
  lq_head_done_not_sent_cycles = 0;
  lq_head_complete_sent_cycles = 0;
  lq_head_plus1_valid_cycles = 0;
  lq_head_plus1_query_wait_cycles = 0;
  lq_head_plus1_mem_wait_cycles = 0;
  lq_mem_req0_cycles = 0;
  lq_mem_req1_cycles = 0;
  lq_mem_req2_cycles = 0;
  lq_complete0_cycles = 0;
  lq_complete1_cycles = 0;
  lq_complete2_cycles = 0;
  lq_complete_wait_cycles = 0;
  lq_complete_wait_both_pipe_cycles = 0;
  lq_complete_wait_one_pipe_cycles = 0;
  lq_complete_wait_no_pipe_cycles = 0;
  issue2_ready2_cycles = 0;
  issue2_ready2_success_cycles = 0;
  issue2_ready2_blocked_cycles = 0;
  issue2_not_enough_ready_cycles = 0;
  issue2_accept_block_cycles = 0;
  issue2_block_has_alu_cycles = 0;
  issue2_block_has_mul_cycles = 0;
  issue2_block_has_div_cycles = 0;
  issue2_block_has_lsu_cycles = 0;
  issue2_block_has_branch_cycles = 0;
  issue2_block_has_other_cycles = 0;
  issue2_block_selected_lt2_cycles = 0;
  issue2_block_is3_backpressure_cycles = 0;
  issue2_block_is3_lane1_busy_cycles = 0;
  issue2_block_is3_lane2_busy_cycles = 0;
  es1_not_ready_cycles = 0;
  es2_not_ready_cycles = 0;
  es1_queue_full_cycles = 0;
  es2_queue_full_cycles = 0;
  es1_queue_any_cycles = 0;
  es2_queue_any_cycles = 0;
  issue2_block_es1_not_ready_cycles = 0;
  issue2_block_es2_not_ready_cycles = 0;
  issue2_block_es1_queue_full_cycles = 0;
  issue2_block_es2_queue_full_cycles = 0;
  commit2_possible_cycles = 0;
  commit2_success_cycles = 0;
  commit2_blocked_next_not_done_cycles = 0;
  commit2_blocked_next_invalid_cycles = 0;
  rs_effective_ready_alu_cur = 0;
  rs_effective_ready_mul_cur = 0;
  rs_effective_ready_div_cur = 0;
  rs_effective_ready_lsu_cur = 0;
  rs_effective_ready_branch_cur = 0;
  rs_effective_ready_other_cur = 0;
  rs_selected_count_cur = 0;
  rs_ready_min_age_cur = 0;
  rs_ready_max_age_cur = 0;
  rs_issue_age_1_cur = 0;
  rs_issue_age_2_cur = 0;
  rs_issue_count_age_cur = 0;
  rs_issue_min_age_cur = 0;
  rs_issue_max_age_cur = 0;
  rs_head_ready_cur = 0;
  rs_head_issued_cur = 0;
  rs_issue_age_count = 0;
  rs_issue_age_sum = 0;
  rs_issue_age_max = 0;
  rs_issue_age_le3_count = 0;
  rs_issue_age_4to15_count = 0;
  rs_issue_age_16plus_count = 0;
  rs_ready_oldest_age_count = 0;
  rs_ready_oldest_age_sum = 0;
  rs_ready_oldest_age_max = 0;
  rs_issue_younger_than_oldest_ready_cycles = 0;
  rs_issue_younger_than_oldest_ready_count = 0;
  rs_issue_younger_delta_sum = 0;
  rs_issue_younger_delta_max = 0;
  rs_head_wait_ready_cycles = 0;
  rs_head_wait_ready_issued_cycles = 0;
  rs_head_wait_ready_not_issued_cycles = 0;
  rs_head_wait_not_ready_cycles = 0;
  for (lat_i = 0; lat_i < `ROB_SIZE; lat_i = lat_i + 1) begin
    issue_cycle_by_rob[lat_i] = 0;
    issue_kind_by_rob[lat_i] = 0;
    stage_kind_by_rob[lat_i] = 0;
    exm_cycle_by_rob[lat_i] = 0;
    cpl_cycle_by_rob[lat_i] = 0;
    done_cycle_by_rob[lat_i] = 0;
    pc_by_rob[lat_i] = {`PC_WIDTH{1'b0}};
    issue_seen_by_rob[lat_i] = 1'b0;
    exm_seen_by_rob[lat_i] = 1'b0;
    cpl_seen_by_rob[lat_i] = 1'b0;
    done_seen_by_rob[lat_i] = 1'b0;
  end
  for (prd_i = 0; prd_i < (2**`RAT_SIZE); prd_i = prd_i + 1) begin
    prd_producer_kind[prd_i] = 3'd0;
    prd_producer_rob_tag[prd_i] = {`ROB_IDX_W{1'b0}};
  end
  for (rs_lat_i = 0; rs_lat_i < `RS_SIZE; rs_lat_i = rs_lat_i + 1) begin
    rs_ready_start_cycle[rs_lat_i] = 0;
    rs_wakeup_rs_start_cycle[rs_lat_i] = 0;
    rs_wakeup_rt_start_cycle[rs_lat_i] = 0;
    rs_ready_tracking[rs_lat_i] = 1'b0;
    rs_wakeup_rs_tracking[rs_lat_i] = 1'b0;
    rs_wakeup_rt_tracking[rs_lat_i] = 1'b0;
  end
end

always @(posedge dp_clk) begin
  if (!dp_rstn) begin
    commit_count <= 0;
    cycle_count <= 0;
    scoreboard_commit_count <= 0;
    scoreboard_cycle_count <= 0;
    scoreboard_settle_i <= 0;
    scoreboard_seen <= 1'b0;
    scoreboard_done <= 1'b0;
    scoreboard_x31 <= {`DWIDTH{1'b0}};
    scoreboard_x30 <= {`DWIDTH{1'b0}};
    scoreboard_x30_shadow <= {`DWIDTH{1'b0}};
    beebs_done <= 1'b0;
    beebs_status <= {`DWIDTH{1'b0}};
    dhrystone_active <= 1'b0;
    dhrystone_done <= 1'b0;
    dhrystone_start_cycle <= 0;
    dhrystone_cycle_count <= 0;
    dhrystone_start_commit <= 0;
    dhrystone_commit_count <= 0;
    fetch_stall_cycles <= 0;
    decode_hold_cycles <= 0;
    dispatch0_cycles <= 0;
    dispatch1_cycles <= 0;
    dispatch2_cycles <= 0;
    commit0_cycles <= 0;
    commit1_cycles <= 0;
    commit2_cycles <= 0;
    branch_flush_count <= 0;
    flush_spec_restore_count <= 0;
    flush_early_taken_count <= 0;
    flush_btfnt_predict_count <= 0;
    flush_ru_branch_count <= 0;
    flush_ru_jal_count <= 0;
    flush_btfnt_mispredict_nt_count <= 0;
    flush_fast_branch_exec_count <= 0;
    flush_registered_redirect_count <= 0;
    flush_lane2_redirect_count <= 0;
    fetch_btb_redirect_count <= 0;
    fetch_btb_redirect_lane1_count <= 0;
    fetch_btb_redirect_lane2_count <= 0;
    jal_accept_count <= 0;
    jal_accept_jal_count <= 0;
    jal_accept_jalr_count <= 0;
    branch_accept_count <= 0;
    branch_dispatch_count <= 0;
    branch_resolve_count <= 0;
    branch_taken_count <= 0;
    branch_not_taken_count <= 0;
    early_branch_nt_count <= 0;
    early_branch_nt_lane1_count <= 0;
    early_branch_nt_lane2_count <= 0;
    early_branch_taken_count <= 0;
    early_branch_taken_lane1_count <= 0;
    early_branch_taken_lane2_count <= 0;
    early_branch_lane2_dep_count <= 0;
    btfnt_predict_taken_count <= 0;
    btfnt_predict_taken_lane1_count <= 0;
    btfnt_predict_taken_lane2_count <= 0;
    btfnt_mispredict_nt_count <= 0;
    btfnt_pending_cycles <= 0;
    spec_save_count <= 0;
    spec_active_cycles <= 0;
    spec_resolve_count <= 0;
    spec_restore_count <= 0;
    branch_decode_lane1_count <= 0;
    branch_decode_lane2_count <= 0;
    branch_decode_ready_lane1_count <= 0;
    branch_decode_ready_lane2_count <= 0;
    branch_decode_ready_taken_count <= 0;
    branch_decode_ready_not_taken_count <= 0;
    branch_decode_not_ready_rs_count <= 0;
    branch_decode_not_ready_rt_count <= 0;
    branch_decode_lane2_dep_rs_count <= 0;
    branch_decode_lane2_dep_rt_count <= 0;
    branch_rs_wait_rs_alu_cycles <= 0;
    branch_rs_wait_rt_alu_cycles <= 0;
    branch_rs_wait_rs_load_cycles <= 0;
    branch_rs_wait_rt_load_cycles <= 0;
    branch_rs_wait_rs_muldiv_cycles <= 0;
    branch_rs_wait_rt_muldiv_cycles <= 0;
    branch_rs_wait_rs_other_cycles <= 0;
    branch_rs_wait_rt_other_cycles <= 0;
    jal_pending_cycles <= 0;
    branch_pending_cycles <= 0;
    branch_pending_decode_cycles <= 0;
    branch_pending_ru_cycles <= 0;
    branch_pending_rs_wait_cycles <= 0;
    branch_pending_rs_ready_cycles <= 0;
    branch_pending_rs_ready_resolve_cycles <= 0;
    branch_pending_rs_ready_no_resolve_cycles <= 0;
    branch_pending_rs_ready_taken_cycles <= 0;
    branch_pending_rs_ready_not_taken_cycles <= 0;
    branch_pending_is3_cycles <= 0;
    branch_pending_execute_cycles <= 0;
    branch_pending_unknown_cycles <= 0;
    branch_pending_blocks_fe_cycles <= 0;
    branch_pending_not_block_fe_cycles <= 0;
    branch_pending_ru_lane1_cycles <= 0;
    branch_pending_ru_lane2_cycles <= 0;
    branch_pending_ru_dispatch_fire_cycles <= 0;
    branch_pending_ru_ready_cycles <= 0;
    branch_pending_ru_ready_taken_cycles <= 0;
    branch_pending_ru_ready_not_taken_cycles <= 0;
    branch_pending_ru_l1_no_dispatch_cycles <= 0;
    branch_pending_ru_l1_lane2_older_cycles <= 0;
    branch_pending_ru_l2_pair_l1_block_cycles <= 0;
    branch_pending_ru_l2_pair_credit_block_cycles <= 0;
    branch_pending_ru_l2_solo_credit_block_cycles <= 0;
    branch_pending_ru_l2_solo_order_block_cycles <= 0;
    branch_pending_set_btfnt_count <= 0;
    branch_pending_set_btfnt_btb_hit_count <= 0;
    branch_pending_set_accept_wait_count <= 0;
    branch_pending_set_dispatch_wait_count <= 0;
    branch_load_wait_not_issued_cycles <= 0;
    branch_load_wait_issued_not_exm_cycles <= 0;
    branch_load_wait_exm_not_cpl_cycles <= 0;
    branch_load_wait_cpl_not_done_cycles <= 0;
    branch_load_wait_done_no_wakeup_cycles <= 0;
    branch_load_wait_unknown_cycles <= 0;
    branch_4a4_load_wait_total <= 0;
    branch_4a4_wait_prs_count <= 0;
    branch_4a4_wait_prt_count <= 0;
    branch_4a4_prod_pc_4a0_count <= 0;
    branch_4a4_prod_other_pc_count <= 0;
    branch_4a4_prod_rs_found_count <= 0;
    branch_4a4_prod_rs_missing_count <= 0;
    branch_4a4_prod_rs_ready_vec_count <= 0;
    branch_4a4_prod_rs_stored_ready_count <= 0;
    branch_4a4_prod_rs_not_ready_count <= 0;
    branch_4a4_prod_issue_same_cycle_count <= 0;
    branch_4a4_prod_ready_no_issue_count <= 0;
    branch_4a4_prod_ready_no_issue_issue0_count <= 0;
    branch_4a4_prod_ready_no_issue_issue1_count <= 0;
    branch_4a4_prod_ready_no_issue_issue2_count <= 0;
    branch_4a4_load_base_wait_total <= 0;
    branch_4a4_load_base_ready_count <= 0;
    branch_4a4_load_base_not_ready_count <= 0;
    branch_4a4_load_base_prod_pc_49c_count <= 0;
    branch_4a4_load_base_prod_other_pc_count <= 0;
    branch_4a4_load_base_prod_rs_found_count <= 0;
    branch_4a4_load_base_prod_rs_missing_count <= 0;
    branch_4a4_load_base_prod_rs_ready_count <= 0;
    branch_4a4_load_base_prod_rs_not_ready_count <= 0;
    branch_4a4_load_base_prod_issue_same_cycle_count <= 0;
    branch_4a4_load_base_prod_issued_seen_count <= 0;
    branch_4a4_load_base_prod_exm_seen_count <= 0;
    branch_4a4_load_base_prod_cpl_seen_count <= 0;
    branch_4a4_load_base_prod_done_seen_count <= 0;
    branch_4a4_load_base_prod_cpl_same_cycle_count <= 0;
    branch_4a4_load_base_prod_wakeup_same_cycle_count <= 0;
    branch_4a4_load_base_not_ready_ready_vec_count <= 0;
    branch_4a4_load_base_not_ready_wakeup_hold_count <= 0;
    branch_4a4_load_base_not_ready_spec_active_count <= 0;
    branch_4a4_load_base_not_ready_es_wakeup_count <= 0;
    branch_4a4_load_base_not_ready_mem_wakeup_count <= 0;
    branch_4a4_load_base_not_ready_no_wakeup_count <= 0;
    branch_4a4_load_base_not_ready_opcode_load_count <= 0;
    branch_4a4_load_base_not_ready_has_rt_unready_count <= 0;
    branch_4a4_load_base_not_ready_prs_es_hit_count <= 0;
    branch_4a4_load_base_not_ready_prs_mem_hit_count <= 0;
    branch_4a4_load_base_not_ready_prt_es_hit_count <= 0;
    branch_4a4_load_base_not_ready_prt_mem_hit_count <= 0;
    for (branch_hot_i = 0; branch_hot_i < 6; branch_hot_i = branch_hot_i + 1) begin
      branch_hot_load_wait_total[branch_hot_i] <= 0;
      branch_hot_load_wait_not_issued[branch_hot_i] <= 0;
      branch_hot_load_wait_issued_not_exm[branch_hot_i] <= 0;
      branch_hot_load_wait_exm_not_cpl[branch_hot_i] <= 0;
      branch_hot_load_wait_cpl_not_done[branch_hot_i] <= 0;
      branch_hot_load_wait_done_no_wakeup[branch_hot_i] <= 0;
    end
    jal_accept_stall_cycles <= 0;
    branch_accept_stall_cycles <= 0;
    decode_hold_rs_full_cycles <= 0;
    decode_hold_rob_full_cycles <= 0;
    decode_hold_no_decode_load_cycles <= 0;
    dec_hold_l1_req_no_ren_cycles <= 0;
    dec_hold_l1_buf_full_cycles <= 0;
    dec_hold_l1_lane2_older_cycles <= 0;
    dec_hold_l1_spec_barrier_cycles <= 0;
    dec_hold_l1_spec_save_cycles <= 0;
    dec_hold_l1_branch_pending_cycles <= 0;
    dec_hold_l1_jal_pending_cycles <= 0;
    dec_hold_l1_rob_credit_cycles <= 0;
    dec_hold_l1_freelist_cycles <= 0;
    dec_hold_l1_rs_credit_cycles <= 0;
    dec_hold_l1_sq_block_cycles <= 0;
    dec_hold_l1_lq_block_cycles <= 0;
    dec_hold_l1_pre_not_req_cycles <= 0;
    dec_root_l1_lane2_older_cycles <= 0;
    dec_root_l1_buf_full_cycles <= 0;
    dec_root_l1_spec_barrier_cycles <= 0;
    dec_root_l1_spec_save_cycles <= 0;
    dec_root_l1_branch_pending_cycles <= 0;
    dec_root_l1_jal_pending_cycles <= 0;
    dec_root_l1_rob_credit_cycles <= 0;
    dec_root_l1_freelist_cycles <= 0;
    dec_root_l1_rs_credit_cycles <= 0;
    dec_root_l1_sq_lq_cycles <= 0;
    dec_root_l1_other_cycles <= 0;
    dec_hold_l2_req_no_ren_cycles <= 0;
    dec_hold_l2_buf_full_cycles <= 0;
    dec_hold_l2_lane1_not_allow_cycles <= 0;
    dec_hold_l2_lane1_buffer_cycles <= 0;
    dec_hold_l2_after_ctrl_cycles <= 0;
    dec_hold_l2_spec_barrier_cycles <= 0;
    dec_hold_l2_spec_save_cycles <= 0;
    dec_hold_l2_branch_pending_cycles <= 0;
    dec_hold_l2_jal_pending_cycles <= 0;
    dec_hold_l2_rob_credit_cycles <= 0;
    dec_hold_l2_freelist_cycles <= 0;
    dec_hold_l2_rs_credit_cycles <= 0;
    dec_hold_l2_sq_block_cycles <= 0;
    dec_hold_l2_lq_block_cycles <= 0;
    dec_hold_l2_pre_not_req_cycles <= 0;
    dec_root_l2_buf_full_cycles <= 0;
    dec_root_l2_lane1_not_allow_cycles <= 0;
    dec_root_l2_lane1_buffer_cycles <= 0;
    dec_root_l2_after_ctrl_cycles <= 0;
    dec_root_l2_spec_barrier_cycles <= 0;
    dec_root_l2_spec_save_cycles <= 0;
    dec_root_l2_branch_pending_cycles <= 0;
    dec_root_l2_jal_pending_cycles <= 0;
    dec_root_l2_rob_credit_cycles <= 0;
    dec_root_l2_freelist_cycles <= 0;
    dec_root_l2_rs_credit_cycles <= 0;
    dec_root_l2_sq_lq_cycles <= 0;
    dec_root_l2_other_cycles <= 0;
    dec_root_l2_other_spec_ctrl_cycles <= 0;
    dec_root_l2_other_pre_req_true_cycles <= 0;
    dec_root_l2_other_pre_req_false_cycles <= 0;
    dec_root_l2_other_pre_ok_false_cycles <= 0;
    dec_root_l2_other_simple_cycles <= 0;
    dec_root_l2_other_load_cycles <= 0;
    dec_root_l2_other_store_cycles <= 0;
    dec_root_l2_other_branch_cycles <= 0;
    dec_root_l2_other_jal_cycles <= 0;
    lane2_not_allow_l1_simple_cycles <= 0;
    lane2_not_allow_l1_load_cycles <= 0;
    lane2_not_allow_l1_store_cycles <= 0;
    lane2_not_allow_l1_branch_cycles <= 0;
    lane2_not_allow_l1_jal_cycles <= 0;
    lane2_not_allow_l1_other_cycles <= 0;
    lane2_not_allow_simple_indep_cycles <= 0;
    lane2_not_allow_simple_dep_rs_cycles <= 0;
    lane2_not_allow_simple_dep_rt_cycles <= 0;
    lane2_not_allow_simple_dep_rd_cycles <= 0;
    lane2_not_allow_simple_dep_any_cycles <= 0;
    lane2_buffer_l1_simple_cycles <= 0;
    lane2_buffer_l1_load_cycles <= 0;
    lane2_buffer_l1_store_cycles <= 0;
    lane2_buffer_l1_branch_cycles <= 0;
    lane2_buffer_l1_jal_cycles <= 0;
    lane2_buffer_l1_other_cycles <= 0;
    lane2_can_take2_block_cycles <= 0;
    lane2_can_take2_older_block_cycles <= 0;
    lane2_can_take2_full_block_cycles <= 0;
    lane2_older_pending_cycles <= 0;
    lane2_older_dispatch_cycles <= 0;
    lane2_older_dispatch_ds2_wait_cycles <= 0;
    lane2_older_dispatch_l1_valid_cycles <= 0;
    lane2_older_dispatch_l1_empty_cycles <= 0;
    lane2_older_dispatch_l1_samefire_cycles <= 0;
    lane2_older_dispatch_ds2_indep_cycles <= 0;
    lane2_older_dispatch_ds2_dep_cycles <= 0;
    lane2_older_dispatch_ds2_simple_cycles <= 0;
    lane2_older_dispatch_ds2_load_cycles <= 0;
    lane2_older_dispatch_ds2_store_cycles <= 0;
    lane2_older_dispatch_ds2_branch_cycles <= 0;
    lane2_older_dispatch_ds2_jal_cycles <= 0;
    lane2_older_dispatch_ds2_other_cycles <= 0;
    ckpt_barrier_cycles <= 0;
    ckpt_barrier_decode_hold_cycles <= 0;
    ckpt_barrier_l1_ready_cycles <= 0;
    ckpt_barrier_l2_ready_cycles <= 0;
    ckpt_barrier_l1_simple_cycles <= 0;
    ckpt_barrier_l1_mem_cycles <= 0;
    ckpt_barrier_l1_ctrl_cycles <= 0;
    ckpt_barrier_l2_simple_cycles <= 0;
    ckpt_barrier_l2_mem_cycles <= 0;
    ckpt_barrier_l2_ctrl_cycles <= 0;
    ckpt_save_raw_cycles <= 0;
    ckpt_save_l1_ready_cycles <= 0;
    ckpt_save_l2_ready_cycles <= 0;
    ckpt_save_decode_hold_cycles <= 0;
    dispatch0_rs_full_cycles <= 0;
    dispatch0_rob_full_cycles <= 0;
    dispatch0_no_rename_fire_cycles <= 0;
    dispatch0_no_dispatch_accept_cycles <= 0;
    rename0_cycles <= 0;
    rename1_cycles <= 0;
    rename2_cycles <= 0;
    commit0_with_dispatch0_cycles <= 0;
    rob_empty_cycles <= 0;
    rob_head_wait_cycles <= 0;
    rob_commit1_blocked_cycles <= 0;
    rob_full_cycles <= 0;
    rob_near_full_cycles <= 0;
    rob_max_used <= 0;
    rob_used_sum <= 0;
    rob_head_wait_load_cycles <= 0;
    rob_head_wait_store_cycles <= 0;
    rob_head_wait_non_mem_cycles <= 0;
    rob_head_wait_alu_cycles <= 0;
    rob_head_wait_mul_cycles <= 0;
    rob_head_wait_div_cycles <= 0;
    rob_head_wait_branch_cycles <= 0;
    rs_issue0_cycles <= 0;
    rs_issue1_cycles <= 0;
    rs_issue2_cycles <= 0;
    complete0_cycles <= 0;
    complete1_cycles <= 0;
    complete2_cycles <= 0;
    rs_valid_count_cur = 0;
    rs_ready_count_cur = 0;
    rs_effective_ready_count_cur = 0;
    rs_bypass_ready_count_cur = 0;
    rs_true_ready_count_cur = 0;
    rs_issue_count_cur = 0;
    rs_valid_count_sum <= 0;
    rs_ready_count_sum <= 0;
    rs_effective_ready_count_sum <= 0;
    rs_bypass_ready_count_sum <= 0;
    rs_true_ready_count_sum <= 0;
    rs_max_valid_count <= 0;
    rs_max_ready_count <= 0;
    rs_max_effective_ready_count <= 0;
    rs_max_bypass_ready_count <= 0;
    rs_max_true_ready_count <= 0;
    rs_empty_cycles <= 0;
    rs_no_ready_cycles <= 0;
    rs_ready_but_issue0_cycles <= 0;
    rs_true_ready2plus_cycles <= 0;
    rs_true_ready2plus_issue0_cycles <= 0;
    rs_true_ready2plus_issue1_cycles <= 0;
    rs_true_ready2plus_issue2_cycles <= 0;
    rs_true_ready2plus_selected_lt2_cycles <= 0;
    rs_true_ready2plus_is3_block_cycles <= 0;
    rs_true_ready2plus_comb_select0_cycles <= 0;
    rs_true_ready2plus_comb_select1_cycles <= 0;
    rs_true_ready2plus_comb_select2_cycles <= 0;
    rs_true_ready2plus_issueq_load0_cycles <= 0;
    rs_true_ready2plus_issueq_load1_cycles <= 0;
    rs_true_ready2plus_issueq_load2_cycles <= 0;
    rs_true_ready2plus_output0_cycles <= 0;
    rs_true_ready2plus_output1_cycles <= 0;
    rs_true_ready2plus_output2_cycles <= 0;
    rs_true_ready2plus_accept0_cycles <= 0;
    rs_true_ready2plus_accept1_cycles <= 0;
    rs_true_ready2plus_accept2_cycles <= 0;
    rs_true_ready2plus_block_selector_cycles <= 0;
    rs_true_ready2plus_block_issueq_cycles <= 0;
    rs_true_ready2plus_block_downstream_cycles <= 0;
    rs_ready0_cycles <= 0;
    rs_ready1_cycles <= 0;
    rs_ready2plus_cycles <= 0;
    rs_ready2plus_issue0_cycles <= 0;
    rs_ready2plus_issue1_cycles <= 0;
    rs_ready2plus_issue2_cycles <= 0;
    rs_ready1_issue0_cycles <= 0;
    rs_ready1_issue1_cycles <= 0;
    rs_effective_ready2plus_cycles <= 0;
    rs_effective_ready2plus_issue_lt2_cycles <= 0;
    rs_wait_rs_operand_sum <= 0;
    rs_wait_rt_operand_sum <= 0;
    rs_wait_both_operands_sum <= 0;
    rs_wait_any_operand_sum <= 0;
    rs_wait_rs_operand_max <= 0;
    rs_wait_rt_operand_max <= 0;
    rs_wait_both_operands_max <= 0;
    rs_wakeup_es1_count <= 0;
    rs_wakeup_es2_count <= 0;
    rs_wakeup_mem1_count <= 0;
    rs_wakeup_mem2_count <= 0;
    cpl_latency_tmp = 0;
    alu_issue_complete_count <= 0;
    alu_issue_complete_sum <= 0;
    alu_issue_complete_max <= 0;
    div_issue_complete_count <= 0;
    div_issue_complete_sum <= 0;
    div_issue_complete_max <= 0;
    rs_wakeup_to_ready_count <= 0;
    rs_wakeup_to_ready_sum <= 0;
    rs_wakeup_to_ready_max <= 0;
    rs_ready_to_issue_count <= 0;
    rs_ready_to_issue_sum <= 0;
    rs_ready_to_issue_max <= 0;
    stage_latency_tmp = 0;
    alu_issue_exm_count <= 0; alu_issue_exm_sum <= 0; alu_issue_exm_max <= 0;
    alu_exm_cpl_count <= 0; alu_exm_cpl_sum <= 0; alu_exm_cpl_max <= 0;
    alu_cpl_done_count <= 0; alu_cpl_done_sum <= 0; alu_cpl_done_max <= 0;
    alu_done_commit_count <= 0; alu_done_commit_sum <= 0; alu_done_commit_max <= 0;
    alu_done_commit_le1_count <= 0;
    alu_done_commit_2to4_count <= 0;
    alu_done_commit_5to16_count <= 0;
    alu_done_commit_gt16_count <= 0;
    div_issue_exm_count <= 0; div_issue_exm_sum <= 0; div_issue_exm_max <= 0;
    div_exm_cpl_count <= 0; div_exm_cpl_sum <= 0; div_exm_cpl_max <= 0;
    div_cpl_done_count <= 0; div_cpl_done_sum <= 0; div_cpl_done_max <= 0;
    div_done_commit_count <= 0; div_done_commit_sum <= 0; div_done_commit_max <= 0;
    div_done_commit_le1_count <= 0;
    div_done_commit_2to4_count <= 0;
    div_done_commit_5to16_count <= 0;
    div_done_commit_gt16_count <= 0;
    rob_done_count_cur <= 0;
    rob_done_not_head_count_cur <= 0;
    rob_done_not_head_cycles <= 0;
    rob_done_not_head_sum <= 0;
    rob_done_not_head_max <= 0;
    rob_younger_done_blocked_by_head_cycles <= 0;
    rob_younger_done_blocked_by_alu_cycles <= 0;
    rob_younger_done_blocked_by_mul_cycles <= 0;
    rob_younger_done_blocked_by_div_cycles <= 0;
    rob_younger_done_blocked_by_branch_cycles <= 0;
    rob_younger_done_blocked_by_load_cycles <= 0;
    rob_younger_done_blocked_by_store_cycles <= 0;
    rob_head_wait_not_issued_cycles <= 0;
    rob_head_wait_issued_not_exm_cycles <= 0;
    rob_head_wait_exm_not_cpl_cycles <= 0;
    rob_head_wait_cpl_seen_not_done_cycles <= 0;
    rob_head_wait_cpl_same_cycle_cycles <= 0;
    rob_head_wait_unknown_cycles <= 0;
    rob_head_wait_real_not_issued_cycles <= 0;
    rob_head_wait_issue_same_cycle_cycles <= 0;
    rob_head_wait_real_issued_not_exm_cycles <= 0;
    rob_head_wait_exm_same_cycle_cycles <= 0;
    rob_head_wait_load_not_issued_cycles <= 0;
    rob_head_wait_load_issued_not_exm_cycles <= 0;
    rob_head_wait_load_exm_not_cpl_cycles <= 0;
    rob_head_wait_load_cpl_seen_not_done_cycles <= 0;
    rob_head_wait_load_cpl_same_cycle_cycles <= 0;
    rob_head_wait_load_unknown_cycles <= 0;
    rob_head_wait_load_real_not_issued_cycles <= 0;
    rob_head_wait_load_issue_same_cycle_cycles <= 0;
    rob_head_wait_load_real_issued_not_exm_cycles <= 0;
    rob_head_wait_load_exm_same_cycle_cycles <= 0;
    rob_head_wait_load_lq_not_done_cycles <= 0;
    rob_head_wait_load_lq_query_wait_cycles <= 0;
    rob_head_wait_load_lq_mem_wait_cycles <= 0;
    rob_head_wait_load_lq_done_not_sent_cycles <= 0;
    rob_head_wait_load_lq_done_no_out_cycles <= 0;
    rob_head_wait_load_lq_out_other_cycles <= 0;
    rob_head_wait_load_lq_complete_out_cycles <= 0;
    rob_head_wait_load_lq_complete_accept_cycles <= 0;
    rob_head_wait_load_lq_complete_block_cycles <= 0;
    rob_head_wait_load_lq_block_two_pipe_cycles <= 0;
    rob_head_wait_load_lq_block_one_pipe_cycles <= 0;
    rob_head_wait_load_lq_block_no_pipe_cycles <= 0;
    rob_head_load_rs_found_cycles <= 0;
    rob_head_load_rs_missing_cycles <= 0;
    rob_head_load_rs_ready_cycles <= 0;
    rob_head_load_rs_ready_issued_cycles <= 0;
    rob_head_load_rs_ready_not_issued_cycles <= 0;
    rob_head_load_rs_wait_rs_alu_cycles <= 0;
    rob_head_load_rs_wait_rs_load_cycles <= 0;
    rob_head_load_rs_wait_rs_muldiv_cycles <= 0;
    rob_head_load_rs_wait_rs_other_cycles <= 0;
    rob_head_load_rs_wait_rt_alu_cycles <= 0;
    rob_head_load_rs_wait_rt_load_cycles <= 0;
    rob_head_load_rs_wait_rt_muldiv_cycles <= 0;
    rob_head_load_rs_wait_rt_other_cycles <= 0;
    rob_head_wait_store_not_issued_cycles <= 0;
    rob_head_wait_store_issued_not_exm_cycles <= 0;
    rob_head_wait_store_exm_not_cpl_cycles <= 0;
    rob_head_wait_store_cpl_same_cycle_cycles <= 0;
    rob_head_wait_store_real_not_issued_cycles <= 0;
    rob_head_wait_store_issue_same_cycle_cycles <= 0;
    rob_head_wait_store_real_issued_not_exm_cycles <= 0;
    rob_head_wait_store_exm_same_cycle_cycles <= 0;
    rob_head_wait_nonmem_not_issued_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_cycles <= 0;
    rob_head_wait_nonmem_exm_not_cpl_cycles <= 0;
    rob_head_wait_nonmem_cpl_same_cycle_cycles <= 0;
    rob_head_wait_nonmem_real_not_issued_cycles <= 0;
    rob_head_wait_nonmem_issue_same_cycle_cycles <= 0;
    rob_head_wait_nonmem_real_issued_not_exm_cycles <= 0;
    rob_head_wait_nonmem_exm_same_cycle_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_alu_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_branch_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_jal_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_u_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_mul_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_div_cycles <= 0;
    rob_head_wait_nonmem_issued_not_exm_other_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_load_opcode_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_store_opcode_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_zero_opcode_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_system_opcode_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_fence_opcode_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_unknown_opcode_cycles <= 0;
    rob_head_wait_nonmem_i2e_other_sample_count <= 0;
    lq_head_valid_cycles <= 0;
    lq_head_query_wait_cycles <= 0;
    lq_head_mem_wait_cycles <= 0;
    lq_head_done_not_sent_cycles <= 0;
    lq_head_complete_sent_cycles <= 0;
    lq_head_plus1_valid_cycles <= 0;
    lq_head_plus1_query_wait_cycles <= 0;
    lq_head_plus1_mem_wait_cycles <= 0;
    lq_mem_req0_cycles <= 0;
    lq_mem_req1_cycles <= 0;
    lq_mem_req2_cycles <= 0;
    lq_complete0_cycles <= 0;
    lq_complete1_cycles <= 0;
    lq_complete2_cycles <= 0;
    lq_complete_wait_cycles <= 0;
    lq_complete_wait_both_pipe_cycles <= 0;
    lq_complete_wait_one_pipe_cycles <= 0;
    lq_complete_wait_no_pipe_cycles <= 0;
    issue2_ready2_cycles <= 0;
    issue2_ready2_success_cycles <= 0;
    issue2_ready2_blocked_cycles <= 0;
    issue2_not_enough_ready_cycles <= 0;
    issue2_accept_block_cycles <= 0;
    issue2_block_has_alu_cycles <= 0;
    issue2_block_has_mul_cycles <= 0;
    issue2_block_has_div_cycles <= 0;
    issue2_block_has_lsu_cycles <= 0;
    issue2_block_has_branch_cycles <= 0;
    issue2_block_has_other_cycles <= 0;
    issue2_block_selected_lt2_cycles <= 0;
    issue2_block_is3_backpressure_cycles <= 0;
    issue2_block_is3_lane1_busy_cycles <= 0;
    issue2_block_is3_lane2_busy_cycles <= 0;
    es1_not_ready_cycles <= 0;
    es2_not_ready_cycles <= 0;
    es1_queue_full_cycles <= 0;
    es2_queue_full_cycles <= 0;
    es1_queue_any_cycles <= 0;
    es2_queue_any_cycles <= 0;
    issue2_block_es1_not_ready_cycles <= 0;
    issue2_block_es2_not_ready_cycles <= 0;
    issue2_block_es1_queue_full_cycles <= 0;
    issue2_block_es2_queue_full_cycles <= 0;
    commit2_possible_cycles <= 0;
    commit2_success_cycles <= 0;
    commit2_blocked_next_not_done_cycles <= 0;
    commit2_blocked_next_invalid_cycles <= 0;
    rs_effective_ready_alu_cur = 0;
    rs_effective_ready_mul_cur = 0;
    rs_effective_ready_div_cur = 0;
    rs_effective_ready_lsu_cur = 0;
    rs_effective_ready_branch_cur = 0;
    rs_effective_ready_other_cur = 0;
    rs_selected_count_cur = 0;
    rs_ready_min_age_cur = 0;
    rs_ready_max_age_cur = 0;
    rs_issue_age_1_cur = 0;
    rs_issue_age_2_cur = 0;
    rs_issue_count_age_cur = 0;
    rs_issue_min_age_cur = 0;
    rs_issue_max_age_cur = 0;
    rs_head_ready_cur = 0;
    rs_head_issued_cur = 0;
    rs_issue_age_count <= 0;
    rs_issue_age_sum <= 0;
    rs_issue_age_max <= 0;
    rs_issue_age_le3_count <= 0;
    rs_issue_age_4to15_count <= 0;
    rs_issue_age_16plus_count <= 0;
    rs_ready_oldest_age_count <= 0;
    rs_ready_oldest_age_sum <= 0;
    rs_ready_oldest_age_max <= 0;
    rs_issue_younger_than_oldest_ready_cycles <= 0;
    rs_issue_younger_than_oldest_ready_count <= 0;
    rs_issue_younger_delta_sum <= 0;
    rs_issue_younger_delta_max <= 0;
    rs_head_wait_ready_cycles <= 0;
    rs_head_wait_ready_issued_cycles <= 0;
    rs_head_wait_ready_not_issued_cycles <= 0;
    rs_head_wait_not_ready_cycles <= 0;
    for (lat_i = 0; lat_i < `ROB_SIZE; lat_i = lat_i + 1) begin
      issue_cycle_by_rob[lat_i] <= 0;
      issue_kind_by_rob[lat_i] <= 0;
      stage_kind_by_rob[lat_i] <= 0;
      exm_cycle_by_rob[lat_i] <= 0;
      cpl_cycle_by_rob[lat_i] <= 0;
      done_cycle_by_rob[lat_i] <= 0;
      issue_seen_by_rob[lat_i] <= 1'b0;
      exm_seen_by_rob[lat_i] <= 1'b0;
      cpl_seen_by_rob[lat_i] <= 1'b0;
      done_seen_by_rob[lat_i] <= 1'b0;
    end
    for (prd_i = 0; prd_i < (2**`RAT_SIZE); prd_i = prd_i + 1) begin
      prd_producer_kind[prd_i] <= 3'd0;
      prd_producer_rob_tag[prd_i] <= {`ROB_IDX_W{1'b0}};
    end
    for (rs_lat_i = 0; rs_lat_i < `RS_SIZE; rs_lat_i = rs_lat_i + 1) begin
      rs_ready_start_cycle[rs_lat_i] <= 0;
      rs_wakeup_rs_start_cycle[rs_lat_i] <= 0;
      rs_wakeup_rt_start_cycle[rs_lat_i] <= 0;
      rs_ready_tracking[rs_lat_i] <= 1'b0;
      rs_wakeup_rs_tracking[rs_lat_i] <= 1'b0;
      rs_wakeup_rt_tracking[rs_lat_i] <= 1'b0;
    end
  end else begin
    next_commit_count = commit_count;
    next_scoreboard_x30 = scoreboard_x30_shadow;
    if (dp_i_ce && !scoreboard_done) begin
      cycle_count <= cycle_count + 1;
    end

    if (dp_i_ce && !scoreboard_seen) begin

      if (!dut.fe_ce) begin
        fetch_stall_cycles <= fetch_stall_cycles + 1;
      end

      if (dut.spec_checkpoint_barrier) begin
        ckpt_barrier_cycles <= ckpt_barrier_cycles + 1;
        if (dut.decode_hold) begin
          ckpt_barrier_decode_hold_cycles <= ckpt_barrier_decode_hold_cycles + 1;
        end
        if (dut.rs_alloc_valid_1 && dut.dispatch_can_take_1 &&
            !dut.ru_rs_lane2_older_pending &&
            !(dut.spec_active && dut.ru_rs_jal_1)) begin
          ckpt_barrier_l1_ready_cycles <= ckpt_barrier_l1_ready_cycles + 1;
          if (dut.ru_rs_memwrite_1 || dut.ru_rs_memtoreg_1) begin
            ckpt_barrier_l1_mem_cycles <= ckpt_barrier_l1_mem_cycles + 1;
          end else if (dut.ru_rs_jal_1 || (dut.ru_rs_opcode_1 == `BTYPE)) begin
            ckpt_barrier_l1_ctrl_cycles <= ckpt_barrier_l1_ctrl_cycles + 1;
          end else begin
            ckpt_barrier_l1_simple_cycles <= ckpt_barrier_l1_simple_cycles + 1;
          end
        end
        if (dut.rs_alloc_valid_2 && !(dut.spec_active && dut.ru_rs_jal_2) &&
            (((dut.rs_alloc_valid_1 && !dut.ru_rs_lane2_older_pending) &&
              dut.dispatch_can_take_1 && dut.dispatch_can_take_2_pair &&
              !dut.ru_rs_lane2_older_pending &&
              !(dut.spec_active && dut.ru_rs_jal_1)) ||
             ((!(dut.rs_alloc_valid_1 && !dut.ru_rs_lane2_older_pending)) &&
              dut.dispatch_can_take_2_solo && dut.lane2_solo_order_ok))) begin
          ckpt_barrier_l2_ready_cycles <= ckpt_barrier_l2_ready_cycles + 1;
          if (dut.ru_rs_memwrite_2 || dut.ru_rs_memtoreg_2) begin
            ckpt_barrier_l2_mem_cycles <= ckpt_barrier_l2_mem_cycles + 1;
          end else if (dut.ru_rs_jal_2 || (dut.ru_rs_opcode_2 == `BTYPE)) begin
            ckpt_barrier_l2_ctrl_cycles <= ckpt_barrier_l2_ctrl_cycles + 1;
          end else begin
            ckpt_barrier_l2_simple_cycles <= ckpt_barrier_l2_simple_cycles + 1;
          end
        end
      end

      if (dut.spec_checkpoint_save_raw) begin
        ckpt_save_raw_cycles <= ckpt_save_raw_cycles + 1;
        if (dut.decode_hold) begin
          ckpt_save_decode_hold_cycles <= ckpt_save_decode_hold_cycles + 1;
        end
        if (dut.rs_alloc_valid_1 && dut.dispatch_can_take_1 &&
            !dut.ru_rs_lane2_older_pending &&
            !(dut.spec_active && dut.ru_rs_jal_1)) begin
          ckpt_save_l1_ready_cycles <= ckpt_save_l1_ready_cycles + 1;
        end
        if (dut.rs_alloc_valid_2 && !(dut.spec_active && dut.ru_rs_jal_2) &&
            (((dut.rs_alloc_valid_1 && !dut.ru_rs_lane2_older_pending) &&
              dut.dispatch_can_take_1 && dut.dispatch_can_take_2_pair &&
              !dut.ru_rs_lane2_older_pending &&
              !(dut.spec_active && dut.ru_rs_jal_1)) ||
             ((!(dut.rs_alloc_valid_1 && !dut.ru_rs_lane2_older_pending)) &&
              dut.dispatch_can_take_2_solo && dut.lane2_solo_order_ok))) begin
          ckpt_save_l2_ready_cycles <= ckpt_save_l2_ready_cycles + 1;
        end
      end

      if (dut.decode_hold) begin
        decode_hold_cycles <= decode_hold_cycles + 1;
        if (dut.rs_o_full) begin
          decode_hold_rs_full_cycles <= decode_hold_rs_full_cycles + 1;
        end
        if (dut.rob_o_full) begin
          decode_hold_rob_full_cycles <= decode_hold_rob_full_cycles + 1;
        end
        if (!dut.decode_can_load) begin
          decode_hold_no_decode_load_cycles <= decode_hold_no_decode_load_cycles + 1;
        end
        if (dut.ds1_rs_o_ce && dut.ds_req_1 && !dut.ren_fire_1) begin
          dec_hold_l1_req_no_ren_cycles <= dec_hold_l1_req_no_ren_cycles + 1;
          if (!dut.ru_rs_can_take_1) begin
            dec_hold_l1_buf_full_cycles <= dec_hold_l1_buf_full_cycles + 1;
          end
          if (dut.ru_rs_lane2_older_pending) begin
            dec_hold_l1_lane2_older_cycles <= dec_hold_l1_lane2_older_cycles + 1;
          end
          if (dut.spec_checkpoint_barrier) begin
            dec_hold_l1_spec_barrier_cycles <= dec_hold_l1_spec_barrier_cycles + 1;
          end
          if (dut.spec_checkpoint_save_raw) begin
            dec_hold_l1_spec_save_cycles <= dec_hold_l1_spec_save_cycles + 1;
          end
          if (dut.branch_pending && !dut.spec_active) begin
            dec_hold_l1_branch_pending_cycles <= dec_hold_l1_branch_pending_cycles + 1;
          end
          if (dut.jal_pending) begin
            dec_hold_l1_jal_pending_cycles <= dec_hold_l1_jal_pending_cycles + 1;
          end
          if (dut.pre_req_1 && !dut.pre_ok_1) begin
            dec_hold_l1_rob_credit_cycles <= dec_hold_l1_rob_credit_cycles + 1;
          end
          if (dut.pre_ok_1 && dut.ds_need_prd_1 && !dut.ru_o_ce_1) begin
            dec_hold_l1_freelist_cycles <= dec_hold_l1_freelist_cycles + 1;
          end
          if (!dut.rs_credit_can_alloc_1) begin
            dec_hold_l1_rs_credit_cycles <= dec_hold_l1_rs_credit_cycles + 1;
          end
          if (!dut.sq_lane1_ok) begin
            dec_hold_l1_sq_block_cycles <= dec_hold_l1_sq_block_cycles + 1;
          end
          if (!dut.lq_lane1_ok) begin
            dec_hold_l1_lq_block_cycles <= dec_hold_l1_lq_block_cycles + 1;
          end
          if (!dut.pre_req_1) begin
            dec_hold_l1_pre_not_req_cycles <= dec_hold_l1_pre_not_req_cycles + 1;
          end
          if (dut.ru_rs_lane2_older_pending) begin
            dec_root_l1_lane2_older_cycles <= dec_root_l1_lane2_older_cycles + 1;
          end else if (!dut.ru_rs_can_take_1) begin
            dec_root_l1_buf_full_cycles <= dec_root_l1_buf_full_cycles + 1;
          end else if (dut.spec_checkpoint_barrier) begin
            dec_root_l1_spec_barrier_cycles <= dec_root_l1_spec_barrier_cycles + 1;
          end else if (dut.spec_checkpoint_save_raw) begin
            dec_root_l1_spec_save_cycles <= dec_root_l1_spec_save_cycles + 1;
          end else if (dut.branch_pending && !dut.spec_active) begin
            dec_root_l1_branch_pending_cycles <= dec_root_l1_branch_pending_cycles + 1;
          end else if (dut.jal_pending) begin
            dec_root_l1_jal_pending_cycles <= dec_root_l1_jal_pending_cycles + 1;
          end else if (dut.pre_req_1 && !dut.pre_ok_1) begin
            dec_root_l1_rob_credit_cycles <= dec_root_l1_rob_credit_cycles + 1;
          end else if (dut.pre_ok_1 && dut.ds_need_prd_1 && !dut.ru_o_ce_1) begin
            dec_root_l1_freelist_cycles <= dec_root_l1_freelist_cycles + 1;
          end else if (!dut.rs_credit_can_alloc_1) begin
            dec_root_l1_rs_credit_cycles <= dec_root_l1_rs_credit_cycles + 1;
          end else if (!dut.sq_lane1_ok || !dut.lq_lane1_ok) begin
            dec_root_l1_sq_lq_cycles <= dec_root_l1_sq_lq_cycles + 1;
          end else begin
            dec_root_l1_other_cycles <= dec_root_l1_other_cycles + 1;
          end
        end
        if (dut.ds2_rs_o_ce && dut.ds_req_2 && !dut.ren_fire_2) begin
          dec_hold_l2_req_no_ren_cycles <= dec_hold_l2_req_no_ren_cycles + 1;
          if (!dut.ru_rs_can_take_2) begin
            dec_hold_l2_buf_full_cycles <= dec_hold_l2_buf_full_cycles + 1;
            lane2_can_take2_block_cycles <= lane2_can_take2_block_cycles + 1;
            if (dut.ru_rs_lane2_older_pending) begin
              lane2_can_take2_older_block_cycles <= lane2_can_take2_older_block_cycles + 1;
            end else begin
              lane2_can_take2_full_block_cycles <= lane2_can_take2_full_block_cycles + 1;
            end
          end
          if (!dut.lane1_allows_lane2_pre) begin
            dec_hold_l2_lane1_not_allow_cycles <= dec_hold_l2_lane1_not_allow_cycles + 1;
            if (dut.ds_branch_1) begin
              lane2_not_allow_l1_branch_cycles <= lane2_not_allow_l1_branch_cycles + 1;
            end else if (dut.ds_jal_req_1) begin
              lane2_not_allow_l1_jal_cycles <= lane2_not_allow_l1_jal_cycles + 1;
            end else if (dut.ds1_rs_o_memwrite) begin
              lane2_not_allow_l1_store_cycles <= lane2_not_allow_l1_store_cycles + 1;
            end else if (dut.ds1_rs_o_memtoreg) begin
              lane2_not_allow_l1_load_cycles <= lane2_not_allow_l1_load_cycles + 1;
            end else if (dut.ds_need_prd_1 || dut.ds_req_1) begin
              lane2_not_allow_l1_simple_cycles <= lane2_not_allow_l1_simple_cycles + 1;
              if (dut.ds_need_prd_1 &&
                  (dut.ds1_rs_o_addr_rd != {`AWIDTH{1'b0}}) &&
                  (dut.ds2_rs_o_addr_rs == dut.ds1_rs_o_addr_rd)) begin
                lane2_not_allow_simple_dep_rs_cycles <= lane2_not_allow_simple_dep_rs_cycles + 1;
              end
              if (dut.ds_need_prd_1 &&
                  (dut.ds1_rs_o_addr_rd != {`AWIDTH{1'b0}}) &&
                  ((dut.ds2_rs_o_opcode == `RTYPE) ||
                   dut.ds_store_2 || dut.ds_branch_2) &&
                  (dut.ds2_rs_o_addr_rt == dut.ds1_rs_o_addr_rd)) begin
                lane2_not_allow_simple_dep_rt_cycles <= lane2_not_allow_simple_dep_rt_cycles + 1;
              end
              if (dut.ds_need_prd_1 && dut.ds_need_prd_2 &&
                  (dut.ds1_rs_o_addr_rd != {`AWIDTH{1'b0}}) &&
                  (dut.ds2_rs_o_addr_rd == dut.ds1_rs_o_addr_rd)) begin
                lane2_not_allow_simple_dep_rd_cycles <= lane2_not_allow_simple_dep_rd_cycles + 1;
              end
              if (dut.ds_need_prd_1 &&
                  (dut.ds1_rs_o_addr_rd != {`AWIDTH{1'b0}}) &&
                  (((dut.ds2_rs_o_addr_rs == dut.ds1_rs_o_addr_rd)) ||
                   (((dut.ds2_rs_o_opcode == `RTYPE) ||
                     dut.ds_store_2 || dut.ds_branch_2) &&
                    (dut.ds2_rs_o_addr_rt == dut.ds1_rs_o_addr_rd)) ||
                   (dut.ds_need_prd_2 &&
                    (dut.ds2_rs_o_addr_rd == dut.ds1_rs_o_addr_rd)))) begin
                lane2_not_allow_simple_dep_any_cycles <= lane2_not_allow_simple_dep_any_cycles + 1;
              end else begin
                lane2_not_allow_simple_indep_cycles <= lane2_not_allow_simple_indep_cycles + 1;
              end
            end else begin
              lane2_not_allow_l1_other_cycles <= lane2_not_allow_l1_other_cycles + 1;
            end
          end
          if (dut.lane1_buffer_blocks_lane2_pre) begin
            dec_hold_l2_lane1_buffer_cycles <= dec_hold_l2_lane1_buffer_cycles + 1;
            if (dut.ru_rs_opcode_1 == `BTYPE) begin
              lane2_buffer_l1_branch_cycles <= lane2_buffer_l1_branch_cycles + 1;
            end else if (dut.ru_rs_jal_1) begin
              lane2_buffer_l1_jal_cycles <= lane2_buffer_l1_jal_cycles + 1;
            end else if (dut.ru_rs_memwrite_1) begin
              lane2_buffer_l1_store_cycles <= lane2_buffer_l1_store_cycles + 1;
            end else if (dut.ru_rs_memtoreg_1) begin
              lane2_buffer_l1_load_cycles <= lane2_buffer_l1_load_cycles + 1;
            end else if (dut.ru_rs_alloc_valid_1) begin
              lane2_buffer_l1_simple_cycles <= lane2_buffer_l1_simple_cycles + 1;
            end else begin
              lane2_buffer_l1_other_cycles <= lane2_buffer_l1_other_cycles + 1;
            end
          end
          if (dut.ds_branch_1 || dut.ds_jal_req_1) begin
            dec_hold_l2_after_ctrl_cycles <= dec_hold_l2_after_ctrl_cycles + 1;
          end
          if (dut.spec_checkpoint_barrier) begin
            dec_hold_l2_spec_barrier_cycles <= dec_hold_l2_spec_barrier_cycles + 1;
          end
          if (dut.spec_checkpoint_save_raw) begin
            dec_hold_l2_spec_save_cycles <= dec_hold_l2_spec_save_cycles + 1;
          end
          if (dut.branch_pending && !dut.spec_active) begin
            dec_hold_l2_branch_pending_cycles <= dec_hold_l2_branch_pending_cycles + 1;
          end
          if (dut.jal_pending) begin
            dec_hold_l2_jal_pending_cycles <= dec_hold_l2_jal_pending_cycles + 1;
          end
          if (dut.pre_req_2 && !dut.pre_ok_2) begin
            dec_hold_l2_rob_credit_cycles <= dec_hold_l2_rob_credit_cycles + 1;
          end
          if (dut.pre_ok_2 && dut.ds_need_prd_2 && !dut.ru_o_ce_2) begin
            dec_hold_l2_freelist_cycles <= dec_hold_l2_freelist_cycles + 1;
          end
          if (!dut.rs_credit_can_alloc_1) begin
            dec_hold_l2_rs_credit_cycles <= dec_hold_l2_rs_credit_cycles + 1;
          end
          if (!dut.sq_lane2_solo_ok) begin
            dec_hold_l2_sq_block_cycles <= dec_hold_l2_sq_block_cycles + 1;
          end
          if (!dut.lq_lane2_solo_ok) begin
            dec_hold_l2_lq_block_cycles <= dec_hold_l2_lq_block_cycles + 1;
          end
          if (!dut.pre_req_2) begin
            dec_hold_l2_pre_not_req_cycles <= dec_hold_l2_pre_not_req_cycles + 1;
          end
          if (!dut.ru_rs_can_take_2) begin
            dec_root_l2_buf_full_cycles <= dec_root_l2_buf_full_cycles + 1;
          end else if (!dut.lane1_allows_lane2_pre) begin
            dec_root_l2_lane1_not_allow_cycles <= dec_root_l2_lane1_not_allow_cycles + 1;
          end else if (dut.lane1_buffer_blocks_lane2_pre) begin
            dec_root_l2_lane1_buffer_cycles <= dec_root_l2_lane1_buffer_cycles + 1;
          end else if (dut.ds_branch_1 || dut.ds_jal_req_1) begin
            dec_root_l2_after_ctrl_cycles <= dec_root_l2_after_ctrl_cycles + 1;
          end else if (dut.spec_checkpoint_barrier) begin
            dec_root_l2_spec_barrier_cycles <= dec_root_l2_spec_barrier_cycles + 1;
          end else if (dut.spec_checkpoint_save_raw) begin
            dec_root_l2_spec_save_cycles <= dec_root_l2_spec_save_cycles + 1;
          end else if (dut.branch_pending && !dut.spec_active) begin
            dec_root_l2_branch_pending_cycles <= dec_root_l2_branch_pending_cycles + 1;
          end else if (dut.jal_pending) begin
            dec_root_l2_jal_pending_cycles <= dec_root_l2_jal_pending_cycles + 1;
          end else if (dut.pre_req_2 && !dut.pre_ok_2) begin
            dec_root_l2_rob_credit_cycles <= dec_root_l2_rob_credit_cycles + 1;
          end else if (dut.pre_ok_2 && dut.ds_need_prd_2 && !dut.ru_o_ce_2) begin
            dec_root_l2_freelist_cycles <= dec_root_l2_freelist_cycles + 1;
          end else if (!dut.rs_credit_can_alloc_1) begin
            dec_root_l2_rs_credit_cycles <= dec_root_l2_rs_credit_cycles + 1;
          end else if (!dut.sq_lane2_solo_ok || !dut.lq_lane2_solo_ok) begin
            dec_root_l2_sq_lq_cycles <= dec_root_l2_sq_lq_cycles + 1;
          end else begin
            dec_root_l2_other_cycles <= dec_root_l2_other_cycles + 1;
            if (dut.spec_active && (dut.ds_branch_2 || dut.ds_jal_req_2)) begin
              dec_root_l2_other_spec_ctrl_cycles <= dec_root_l2_other_spec_ctrl_cycles + 1;
            end
            if (dut.pre_req_2) begin
              dec_root_l2_other_pre_req_true_cycles <= dec_root_l2_other_pre_req_true_cycles + 1;
            end else begin
              dec_root_l2_other_pre_req_false_cycles <= dec_root_l2_other_pre_req_false_cycles + 1;
            end
            if (dut.pre_req_2 && !dut.pre_ok_2) begin
              dec_root_l2_other_pre_ok_false_cycles <= dec_root_l2_other_pre_ok_false_cycles + 1;
            end
            if (dut.ds_branch_2) begin
              dec_root_l2_other_branch_cycles <= dec_root_l2_other_branch_cycles + 1;
            end else if (dut.ds_jal_req_2) begin
              dec_root_l2_other_jal_cycles <= dec_root_l2_other_jal_cycles + 1;
            end else if (dut.ds2_rs_o_memwrite) begin
              dec_root_l2_other_store_cycles <= dec_root_l2_other_store_cycles + 1;
            end else if (dut.ds2_rs_o_memtoreg) begin
              dec_root_l2_other_load_cycles <= dec_root_l2_other_load_cycles + 1;
            end else begin
              dec_root_l2_other_simple_cycles <= dec_root_l2_other_simple_cycles + 1;
            end
          end
        end

        if (dut.ru_rs_lane2_older_pending) begin
          lane2_older_pending_cycles <= lane2_older_pending_cycles + 1;
          if (dut.ru_rs_dispatch_fire_2) begin
            lane2_older_dispatch_cycles <= lane2_older_dispatch_cycles + 1;
            if (dut.ru_rs_valid_1) begin
              lane2_older_dispatch_l1_valid_cycles <= lane2_older_dispatch_l1_valid_cycles + 1;
            end else begin
              lane2_older_dispatch_l1_empty_cycles <= lane2_older_dispatch_l1_empty_cycles + 1;
            end
            if (dut.ru_rs_dispatch_fire_1) begin
              lane2_older_dispatch_l1_samefire_cycles <= lane2_older_dispatch_l1_samefire_cycles + 1;
            end
            if (dut.ds2_rs_o_ce && dut.ds_req_2 && !dut.ren_fire_2) begin
              lane2_older_dispatch_ds2_wait_cycles <= lane2_older_dispatch_ds2_wait_cycles + 1;
              if (dut.ds_branch_2) begin
                lane2_older_dispatch_ds2_branch_cycles <= lane2_older_dispatch_ds2_branch_cycles + 1;
              end else if (dut.ds_jal_req_2) begin
                lane2_older_dispatch_ds2_jal_cycles <= lane2_older_dispatch_ds2_jal_cycles + 1;
              end else if (dut.ds2_rs_o_memwrite) begin
                lane2_older_dispatch_ds2_store_cycles <= lane2_older_dispatch_ds2_store_cycles + 1;
              end else if (dut.ds2_rs_o_memtoreg) begin
                lane2_older_dispatch_ds2_load_cycles <= lane2_older_dispatch_ds2_load_cycles + 1;
              end else if (dut.ds_need_prd_2 || dut.ds_req_2) begin
                lane2_older_dispatch_ds2_simple_cycles <= lane2_older_dispatch_ds2_simple_cycles + 1;
              end else begin
                lane2_older_dispatch_ds2_other_cycles <= lane2_older_dispatch_ds2_other_cycles + 1;
              end
              if (dut.ds_req_1 && dut.ds_need_prd_1 &&
                  (dut.ds1_rs_o_addr_rd != {`AWIDTH{1'b0}}) &&
                  (((dut.ds2_rs_o_addr_rs == dut.ds1_rs_o_addr_rd)) ||
                   (((dut.ds2_rs_o_opcode == `RTYPE) ||
                     dut.ds_store_2 || dut.ds_branch_2) &&
                    (dut.ds2_rs_o_addr_rt == dut.ds1_rs_o_addr_rd)) ||
                   (dut.ds_need_prd_2 &&
                    (dut.ds2_rs_o_addr_rd == dut.ds1_rs_o_addr_rd)))) begin
                lane2_older_dispatch_ds2_dep_cycles <= lane2_older_dispatch_ds2_dep_cycles + 1;
              end else begin
                lane2_older_dispatch_ds2_indep_cycles <= lane2_older_dispatch_ds2_indep_cycles + 1;
              end
            end
          end
        end
      end

      case ({dut.ru_rs_dispatch_fire_2, dut.ru_rs_dispatch_fire_1})
        2'b00: dispatch0_cycles <= dispatch0_cycles + 1;
        2'b01,
        2'b10: dispatch1_cycles <= dispatch1_cycles + 1;
        2'b11: dispatch2_cycles <= dispatch2_cycles + 1;
      endcase

      if (dut.ru_rs_dispatch_fire_1) begin
        pc_by_rob[dut.rob_o_alloc_tag_1] <= dut.ru_rs_pc_1;
        if (dut.ru_rs_new_prd_1 != {`RAT_SIZE{1'b0}}) begin
          prd_producer_kind[dut.ru_rs_new_prd_1] <= producer_kind(dut.ru_rs_opcode_1,
                                                                  dut.ru_rs_funct3_1,
                                                                  dut.ru_rs_funct7_1);
          prd_producer_rob_tag[dut.ru_rs_new_prd_1] <= dut.rob_o_alloc_tag_1;
        end
      end

      if (dut.ru_rs_dispatch_fire_2) begin
        pc_by_rob[dut.rob_o_alloc_tag_2] <= dut.ru_rs_pc_2;
        if (dut.ru_rs_new_prd_2 != {`RAT_SIZE{1'b0}}) begin
          prd_producer_kind[dut.ru_rs_new_prd_2] <= producer_kind(dut.ru_rs_opcode_2,
                                                                  dut.ru_rs_funct3_2,
                                                                  dut.ru_rs_funct7_2);
          prd_producer_rob_tag[dut.ru_rs_new_prd_2] <= dut.rob_o_alloc_tag_2;
        end
      end

      if (!dut.es1_o_ready) begin
        es1_not_ready_cycles <= es1_not_ready_cycles + 1;
      end
      if (!dut.es2_o_ready) begin
        es2_not_ready_cycles <= es2_not_ready_cycles + 1;
      end
      if (dut.u_es1.q0_valid || dut.u_es1.q1_valid) begin
        es1_queue_any_cycles <= es1_queue_any_cycles + 1;
      end
      if (dut.u_es2.q0_valid || dut.u_es2.q1_valid) begin
        es2_queue_any_cycles <= es2_queue_any_cycles + 1;
      end
      if (dut.u_es1.q0_valid && dut.u_es1.q1_valid) begin
        es1_queue_full_cycles <= es1_queue_full_cycles + 1;
      end
      if (dut.u_es2.q0_valid && dut.u_es2.q1_valid) begin
        es2_queue_full_cycles <= es2_queue_full_cycles + 1;
      end

      case ({dut.ren_fire_2, dut.ren_fire_1})
        2'b00: rename0_cycles <= rename0_cycles + 1;
        2'b01,
        2'b10: rename1_cycles <= rename1_cycles + 1;
        2'b11: rename2_cycles <= rename2_cycles + 1;
      endcase

      if (!dut.ru_rs_dispatch_fire_1 && !dut.ru_rs_dispatch_fire_2) begin
        if (dut.rs_o_full) begin
          dispatch0_rs_full_cycles <= dispatch0_rs_full_cycles + 1;
        end
        if (dut.rob_o_full) begin
          dispatch0_rob_full_cycles <= dispatch0_rob_full_cycles + 1;
        end
        if (!dut.ren_fire_1 && !dut.ren_fire_2) begin
          dispatch0_no_rename_fire_cycles <= dispatch0_no_rename_fire_cycles + 1;
        end
        if (!dut.dispatch_can_take_1 &&
            !dut.dispatch_can_take_2_pair &&
            !dut.dispatch_can_take_2_solo) begin
          dispatch0_no_dispatch_accept_cycles <= dispatch0_no_dispatch_accept_cycles + 1;
        end
      end

      case ({dut.rob_o_commit_valid_2, dut.rob_o_commit_valid_1})
        2'b00: commit0_cycles <= commit0_cycles + 1;
        2'b01,
        2'b10: commit1_cycles <= commit1_cycles + 1;
        2'b11: commit2_cycles <= commit2_cycles + 1;
      endcase

      if (!dut.rob_o_commit_valid_1 && !dut.rob_o_commit_valid_2 &&
          !dut.ru_rs_dispatch_fire_1 && !dut.ru_rs_dispatch_fire_2) begin
        commit0_with_dispatch0_cycles <= commit0_with_dispatch0_cycles + 1;
      end

      if (dut.es_pc_flush) begin
        branch_flush_count <= branch_flush_count + 1;
        if (dut.spec_restore_redirect) begin
          flush_spec_restore_count <= flush_spec_restore_count + 1;
        end
        if (dut.early_branch_taken_now) begin
          flush_early_taken_count <= flush_early_taken_count + 1;
        end
        if (dut.btfnt_predict_taken_now) begin
          flush_btfnt_predict_count <= flush_btfnt_predict_count + 1;
        end
        if (dut.ru_rs_branch_taken_now) begin
          flush_ru_branch_count <= flush_ru_branch_count + 1;
        end
        if (dut.ru_rs_jal_redirect_now) begin
          flush_ru_jal_count <= flush_ru_jal_count + 1;
        end
        if (dut.btfnt_mispredict_nt_now) begin
          flush_btfnt_mispredict_nt_count <= flush_btfnt_mispredict_nt_count + 1;
        end
        if (dut.fast_branch_exec_redirect_1 || dut.fast_branch_exec_redirect_2) begin
          flush_fast_branch_exec_count <= flush_fast_branch_exec_count + 1;
        end
        if (dut.es_pc_redirect_1 || dut.es_pc_redirect_2) begin
          flush_registered_redirect_count <= flush_registered_redirect_count + 1;
        end
        if (dut.pc_redirect_2) begin
          flush_lane2_redirect_count <= flush_lane2_redirect_count + 1;
        end
      end

      if (dut.fetch_btb_redirect_1 || dut.fetch_btb_redirect_2) begin
        fetch_btb_redirect_count <= fetch_btb_redirect_count + 1;
        if (dut.fetch_btb_redirect_1) begin
          fetch_btb_redirect_lane1_count <= fetch_btb_redirect_lane1_count + 1;
        end
        if (dut.fetch_btb_redirect_2) begin
          fetch_btb_redirect_lane2_count <= fetch_btb_redirect_lane2_count + 1;
        end
      end

`ifdef USE_DHRYSTONE_SRC_COPY
      if (dut.jal_accept_now) begin
        jal_accept_count <= jal_accept_count + 1;
      end
      if (dut.dec_consume_1 && dut.ds1_rs_o_jal) begin
        if (dut.ds1_rs_o_opcode == `JALR) begin
          jal_accept_jalr_count <= jal_accept_jalr_count + 1;
        end
        else if (dut.ds1_rs_o_opcode == `JAL) begin
          jal_accept_jal_count <= jal_accept_jal_count + 1;
        end
      end
      if (dut.dec_consume_2 && dut.ds2_rs_o_jal) begin
        if (dut.ds2_rs_o_opcode == `JALR) begin
          jal_accept_jalr_count <= jal_accept_jalr_count + 1;
        end
        else if (dut.ds2_rs_o_opcode == `JAL) begin
          jal_accept_jal_count <= jal_accept_jal_count + 1;
        end
      end

      if (dut.branch_accept_now) begin
        branch_accept_count <= branch_accept_count + 1;
      end
      if (dut.branch_dispatch_now) begin
        branch_dispatch_count <= branch_dispatch_count + 1;
      end
      if (dut.branch_resolve_now) begin
        branch_resolve_count <= branch_resolve_count + 1;
      end
      if (dut.es1_o_ce && (dut.es1_o_opcode == `BTYPE)) begin
        if (dut.es1_o_change_pc) begin
          branch_taken_count <= branch_taken_count + 1;
        end
        else begin
          branch_not_taken_count <= branch_not_taken_count + 1;
        end
      end
      if (dut.es2_o_ce && (dut.es2_o_opcode == `BTYPE)) begin
        if (dut.es2_o_change_pc) begin
          branch_taken_count <= branch_taken_count + 1;
        end
        else begin
          branch_not_taken_count <= branch_not_taken_count + 1;
        end
      end
      if (dut.early_branch_nt_now) begin
        early_branch_nt_count <= early_branch_nt_count + 1;
      end
      if (dut.early_branch_nt_1) begin
        early_branch_nt_lane1_count <= early_branch_nt_lane1_count + 1;
      end
      if (dut.early_branch_nt_2) begin
        early_branch_nt_lane2_count <= early_branch_nt_lane2_count + 1;
      end
      if (dut.early_branch_taken_now) begin
        early_branch_taken_count <= early_branch_taken_count + 1;
      end
      if (dut.early_branch_taken_1) begin
        early_branch_taken_lane1_count <= early_branch_taken_lane1_count + 1;
      end
      if (dut.early_branch_taken_2) begin
        early_branch_taken_lane2_count <= early_branch_taken_lane2_count + 1;
      end
      if (dut.early_branch_2_depends_lane1) begin
        early_branch_lane2_dep_count <= early_branch_lane2_dep_count + 1;
      end
      if (dut.btfnt_predict_taken_now) begin
        btfnt_predict_taken_count <= btfnt_predict_taken_count + 1;
      end
      if (dut.btfnt_predict_taken_1) begin
        btfnt_predict_taken_lane1_count <= btfnt_predict_taken_lane1_count + 1;
      end
      if (dut.btfnt_predict_taken_2) begin
        btfnt_predict_taken_lane2_count <= btfnt_predict_taken_lane2_count + 1;
      end
      if (dut.btfnt_mispredict_nt_now) begin
        btfnt_mispredict_nt_count <= btfnt_mispredict_nt_count + 1;
      end
      if (dut.btfnt_predict_pending) begin
        btfnt_pending_cycles <= btfnt_pending_cycles + 1;
      end
      if (dut.spec_checkpoint_save) begin
        spec_save_count <= spec_save_count + 1;
      end
      if (dut.spec_active) begin
        spec_active_cycles <= spec_active_cycles + 1;
      end
      if (dut.spec_resolve) begin
        spec_resolve_count <= spec_resolve_count + 1;
      end
      if (dut.spec_restore) begin
        spec_restore_count <= spec_restore_count + 1;
      end
      if (dut.dbg_branch_decode_1) begin
        branch_decode_lane1_count <= branch_decode_lane1_count + 1;
        if (dut.dbg_branch_ready_1) begin
          branch_decode_ready_lane1_count <= branch_decode_ready_lane1_count + 1;
        end
        else begin
          if (!dut.dbg_branch_ready_rs_1) begin
            branch_decode_not_ready_rs_count <= branch_decode_not_ready_rs_count + 1;
          end
          if (!dut.dbg_branch_ready_rt_1) begin
            branch_decode_not_ready_rt_count <= branch_decode_not_ready_rt_count + 1;
          end
        end
        if (dut.dbg_branch_taken_1) begin
          branch_decode_ready_taken_count <= branch_decode_ready_taken_count + 1;
        end
        if (dut.dbg_branch_not_taken_1) begin
          branch_decode_ready_not_taken_count <= branch_decode_ready_not_taken_count + 1;
        end
      end
      if (dut.dbg_branch_decode_2) begin
        branch_decode_lane2_count <= branch_decode_lane2_count + 1;
        if (dut.dbg_branch_ready_2) begin
          branch_decode_ready_lane2_count <= branch_decode_ready_lane2_count + 1;
        end
        else begin
          if (!dut.early_branch2_rs_ready) begin
            branch_decode_not_ready_rs_count <= branch_decode_not_ready_rs_count + 1;
          end
          if (!dut.early_branch2_rt_ready) begin
            branch_decode_not_ready_rt_count <= branch_decode_not_ready_rt_count + 1;
          end
        end
        if (dut.dbg_branch_taken_2) begin
          branch_decode_ready_taken_count <= branch_decode_ready_taken_count + 1;
        end
        if (dut.dbg_branch_not_taken_2) begin
          branch_decode_ready_not_taken_count <= branch_decode_ready_not_taken_count + 1;
        end
        if (dut.early_branch_2_depends_lane1_rs) begin
          branch_decode_lane2_dep_rs_count <= branch_decode_lane2_dep_rs_count + 1;
        end
        if (dut.early_branch_2_depends_lane1_rt) begin
          branch_decode_lane2_dep_rt_count <= branch_decode_lane2_dep_rt_count + 1;
        end
      end
      if (dut.jal_pending) begin
        jal_pending_cycles <= jal_pending_cycles + 1;
      end
      if (!dut.branch_pending &&
          !(dut.es_pc_flush || dut.spec_resolve ||
            dut.branch_resolve_now || dut.ru_rs_branch_resolve_now)) begin
        if (dut.btfnt_predict_taken_now) begin
          branch_pending_set_btfnt_count <= branch_pending_set_btfnt_count + 1;
          if (dut.btfnt_predict_already_fetch_1 || dut.btfnt_predict_already_fetch_2) begin
            branch_pending_set_btfnt_btb_hit_count <= branch_pending_set_btfnt_btb_hit_count + 1;
          end
        end
        else begin
          if (dut.branch_accept_now && !dut.branch_accept_spec_now &&
              !(dut.early_branch_nt_now || dut.early_branch_taken_now)) begin
            branch_pending_set_accept_wait_count <= branch_pending_set_accept_wait_count + 1;
          end
          if (dut.branch_dispatch_wait_now && !dut.branch_dispatch_spec_now) begin
            branch_pending_set_dispatch_wait_count <= branch_pending_set_dispatch_wait_count + 1;
          end
        end
      end
      if (dut.branch_pending) begin
        branch_pending_cycles <= branch_pending_cycles + 1;
`ifdef USE_DHRYSTONE_SRC_COPY
        if (dut.branch_pending_blocks_fe) begin
          branch_pending_blocks_fe_cycles <= branch_pending_blocks_fe_cycles + 1;
        end
        else begin
          branch_pending_not_block_fe_cycles <= branch_pending_not_block_fe_cycles + 1;
        end
`else
        branch_pending_blocks_fe_cycles <= branch_pending_blocks_fe_cycles + 1;
`endif
        branch_pending_rs_found = 1'b0;
        branch_pending_rs_ready_found = 1'b0;
        for (branch_pending_rs_scan_i = 0;
             branch_pending_rs_scan_i < `RS_SIZE;
             branch_pending_rs_scan_i = branch_pending_rs_scan_i + 1) begin
          if (dut.u_rs.ent_valid[branch_pending_rs_scan_i] &&
              (dut.u_rs.ent_opcode[branch_pending_rs_scan_i] == `BTYPE)) begin
            branch_pending_rs_found = 1'b1;
            if (dut.u_rs.ready_vec[branch_pending_rs_scan_i]) begin
              branch_pending_rs_ready_found = 1'b1;
            end
          end
        end

        if (dut.ds_branch_1 || dut.ds_branch_2) begin
          branch_pending_decode_cycles <= branch_pending_decode_cycles + 1;
        end
        else if ((dut.ru_rs_valid_1 && (dut.ru_rs_opcode_1 == `BTYPE)) ||
                 (dut.ru_rs_valid_2 && (dut.ru_rs_opcode_2 == `BTYPE))) begin
          branch_pending_ru_cycles <= branch_pending_ru_cycles + 1;
            if (dut.ru_rs_valid_1 && (dut.ru_rs_opcode_1 == `BTYPE)) begin
              branch_pending_ru_lane1_cycles <= branch_pending_ru_lane1_cycles + 1;
              if (dut.ru_rs_dispatch_fire_1) begin
                branch_pending_ru_dispatch_fire_cycles <= branch_pending_ru_dispatch_fire_cycles + 1;
                if (dut.ru_rs_prs_ready_1 && dut.ru_rs_prt_ready_1) begin
                  branch_pending_ru_ready_cycles <= branch_pending_ru_ready_cycles + 1;
                  if (dut.branch_is_taken(dut.ru_rs_funct3_1, dut.ru_rs_data_rs_to_rs_1, dut.ru_rs_data_rt_to_rs_1)) begin
                    branch_pending_ru_ready_taken_cycles <= branch_pending_ru_ready_taken_cycles + 1;
                  end
                  else begin
                    branch_pending_ru_ready_not_taken_cycles <= branch_pending_ru_ready_not_taken_cycles + 1;
                  end
                end
              end
            else begin
              if (!dut.dispatch_can_take_1) begin
                branch_pending_ru_l1_no_dispatch_cycles <= branch_pending_ru_l1_no_dispatch_cycles + 1;
              end
              if (dut.ru_rs_lane2_older_pending) begin
                branch_pending_ru_l1_lane2_older_cycles <= branch_pending_ru_l1_lane2_older_cycles + 1;
              end
            end
          end
            if (dut.ru_rs_valid_2 && (dut.ru_rs_opcode_2 == `BTYPE)) begin
              branch_pending_ru_lane2_cycles <= branch_pending_ru_lane2_cycles + 1;
              if (dut.ru_rs_dispatch_fire_2) begin
                branch_pending_ru_dispatch_fire_cycles <= branch_pending_ru_dispatch_fire_cycles + 1;
                if (dut.ru_rs_prs_ready_2 && dut.ru_rs_prt_ready_2) begin
                  branch_pending_ru_ready_cycles <= branch_pending_ru_ready_cycles + 1;
                  if (dut.branch_is_taken(dut.ru_rs_funct3_2, dut.ru_rs_data_rs_to_rs_2, dut.ru_rs_data_rt_to_rs_2)) begin
                    branch_pending_ru_ready_taken_cycles <= branch_pending_ru_ready_taken_cycles + 1;
                  end
                  else begin
                    branch_pending_ru_ready_not_taken_cycles <= branch_pending_ru_ready_not_taken_cycles + 1;
                  end
                end
              end
            else if (dut.rs_alloc_valid_1 && !dut.ru_rs_lane2_older_pending) begin
              if (!dut.ru_rs_dispatch_fire_1) begin
                branch_pending_ru_l2_pair_l1_block_cycles <= branch_pending_ru_l2_pair_l1_block_cycles + 1;
              end
              if (!dut.dispatch_can_take_2_pair) begin
                branch_pending_ru_l2_pair_credit_block_cycles <= branch_pending_ru_l2_pair_credit_block_cycles + 1;
              end
            end
            else begin
              if (!dut.dispatch_can_take_2_solo) begin
                branch_pending_ru_l2_solo_credit_block_cycles <= branch_pending_ru_l2_solo_credit_block_cycles + 1;
              end
              if (!dut.lane2_solo_order_ok) begin
                branch_pending_ru_l2_solo_order_block_cycles <= branch_pending_ru_l2_solo_order_block_cycles + 1;
              end
            end
          end
        end
        else if (branch_pending_rs_found) begin
          if (branch_pending_rs_ready_found) begin
            branch_pending_rs_ready_cycles <= branch_pending_rs_ready_cycles + 1;
`ifdef USE_DHRYSTONE_SRC_COPY
            if (dut.branch_resolve_now) begin
              branch_pending_rs_ready_resolve_cycles <= branch_pending_rs_ready_resolve_cycles + 1;
              if (dut.branch_taken_now) begin
                branch_pending_rs_ready_taken_cycles <= branch_pending_rs_ready_taken_cycles + 1;
              end
              else begin
                branch_pending_rs_ready_not_taken_cycles <= branch_pending_rs_ready_not_taken_cycles + 1;
              end
            end
            else begin
              branch_pending_rs_ready_no_resolve_cycles <= branch_pending_rs_ready_no_resolve_cycles + 1;
            end
`endif
          end
          else begin
            branch_pending_rs_wait_cycles <= branch_pending_rs_wait_cycles + 1;
          end
        end
        else if ((dut.is3_valid_1 && (dut.is3_opcode_1 == `BTYPE)) ||
                 (dut.is3_valid_2 && (dut.is3_opcode_2 == `BTYPE))) begin
          branch_pending_is3_cycles <= branch_pending_is3_cycles + 1;
        end
        else if ((dut.es1_o_ce && (dut.es1_o_opcode == `BTYPE)) ||
                 (dut.es2_o_ce && (dut.es2_o_opcode == `BTYPE))) begin
          branch_pending_execute_cycles <= branch_pending_execute_cycles + 1;
        end
        else begin
          branch_pending_unknown_cycles <= branch_pending_unknown_cycles + 1;
        end
      end
      if (!dut.fe_ce && dut.jal_accept_now) begin
        jal_accept_stall_cycles <= jal_accept_stall_cycles + 1;
      end
      if (!dut.fe_ce && dut.branch_accept_now) begin
        branch_accept_stall_cycles <= branch_accept_stall_cycles + 1;
      end
      if (dut.decode_hold) begin
        if (!dut.dec_lane_done_1) begin
          decode_hold_lane1_cycles <= decode_hold_lane1_cycles + 1;
        end
        if (!dut.dec_lane_done_2) begin
          decode_hold_lane2_cycles <= decode_hold_lane2_cycles + 1;
        end
        if (!dut.dec_lane_done_2 && dut.ds_branch_1 && !dut.early_branch_nt_1) begin
          decode_hold_lane2_after_branch_cycles <= decode_hold_lane2_after_branch_cycles + 1;
        end
        if (!dut.dec_lane_done_2 && dut.ds_jal_req_1) begin
          decode_hold_lane2_after_jal_cycles <= decode_hold_lane2_after_jal_cycles + 1;
        end
      end

      if (dut.u_load_queue.ent_valid[dut.u_load_queue.head_ptr]) begin
        lq_head_valid_cycles <= lq_head_valid_cycles + 1;
        if (dut.u_load_queue.ent_query_wait[dut.u_load_queue.head_ptr]) begin
          lq_head_query_wait_cycles <= lq_head_query_wait_cycles + 1;
        end
        if (dut.u_load_queue.ent_mem_wait[dut.u_load_queue.head_ptr]) begin
          lq_head_mem_wait_cycles <= lq_head_mem_wait_cycles + 1;
        end
        if (dut.u_load_queue.ent_done[dut.u_load_queue.head_ptr] &&
            !dut.u_load_queue.ent_complete_sent[dut.u_load_queue.head_ptr]) begin
          lq_head_done_not_sent_cycles <= lq_head_done_not_sent_cycles + 1;
        end
        if (dut.u_load_queue.ent_complete_sent[dut.u_load_queue.head_ptr]) begin
          lq_head_complete_sent_cycles <= lq_head_complete_sent_cycles + 1;
        end
      end

      if (dut.u_load_queue.ent_valid[dut.u_load_queue.head_plus_1]) begin
        lq_head_plus1_valid_cycles <= lq_head_plus1_valid_cycles + 1;
        if (dut.u_load_queue.ent_query_wait[dut.u_load_queue.head_plus_1]) begin
          lq_head_plus1_query_wait_cycles <= lq_head_plus1_query_wait_cycles + 1;
        end
        if (dut.u_load_queue.ent_mem_wait[dut.u_load_queue.head_plus_1]) begin
          lq_head_plus1_mem_wait_cycles <= lq_head_plus1_mem_wait_cycles + 1;
        end
      end

      case ({dut.lq_o_mem_req_valid_2, dut.lq_o_mem_req_valid_1})
        2'b00: lq_mem_req0_cycles <= lq_mem_req0_cycles + 1;
        2'b01,
        2'b10: lq_mem_req1_cycles <= lq_mem_req1_cycles + 1;
        2'b11: lq_mem_req2_cycles <= lq_mem_req2_cycles + 1;
      endcase

      case ({dut.lq_o_complete_valid_2, dut.lq_o_complete_valid_1})
        2'b00: lq_complete0_cycles <= lq_complete0_cycles + 1;
        2'b01,
        2'b10: lq_complete1_cycles <= lq_complete1_cycles + 1;
        2'b11: lq_complete2_cycles <= lq_complete2_cycles + 1;
      endcase
      if ((dut.lq_o_complete_valid_1 && !dut.lq_i_complete_accept_1) ||
          (dut.lq_o_complete_valid_2 && !dut.lq_i_complete_accept_2)) begin
        lq_complete_wait_cycles <= lq_complete_wait_cycles + 1;
        if (dut.mwb_valid_1 && dut.mwb_valid_2) begin
          lq_complete_wait_both_pipe_cycles <= lq_complete_wait_both_pipe_cycles + 1;
        end
        else if (dut.mwb_valid_1 || dut.mwb_valid_2) begin
          lq_complete_wait_one_pipe_cycles <= lq_complete_wait_one_pipe_cycles + 1;
        end
        else begin
          lq_complete_wait_no_pipe_cycles <= lq_complete_wait_no_pipe_cycles + 1;
        end
      end

`ifdef USE_DHRYSTONE_SRC_COPY
      if (spec_lq_debug && (dut.spec_restore || dut.spec_checkpoint_save || dut.spec_resolve) &&
          (spec_lq_restore_sample_count < 40)) begin
        spec_lq_restore_sample_count <= spec_lq_restore_sample_count + 1;
        $display("SPEC_EVENT sample=%0d kind=%s",
                 spec_lq_restore_sample_count,
                 dut.spec_restore ? "restore" :
                 dut.spec_checkpoint_save ? "save" :
                 "resolve");
        print_spec_lq_state();
      end
`endif
`endif

      case ({prof_issue_valid_2, prof_issue_valid_1})
        2'b00: rs_issue0_cycles <= rs_issue0_cycles + 1;
        2'b01,
        2'b10: rs_issue1_cycles <= rs_issue1_cycles + 1;
        2'b11: rs_issue2_cycles <= rs_issue2_cycles + 1;
      endcase

      case ({dut.cpl_valid_2, dut.cpl_valid_1})
        2'b00: complete0_cycles <= complete0_cycles + 1;
        2'b01,
        2'b10: complete1_cycles <= complete1_cycles + 1;
        2'b11: complete2_cycles <= complete2_cycles + 1;
      endcase

        if (prof_issue_valid_1) begin
          issue_cycle_by_rob[prof_issue_rob_tag_1] <= cycle_count;
          issue_seen_by_rob[prof_issue_rob_tag_1] <= 1'b1;
          exm_seen_by_rob[prof_issue_rob_tag_1] <= 1'b0;
          cpl_seen_by_rob[prof_issue_rob_tag_1] <= 1'b0;
          done_seen_by_rob[prof_issue_rob_tag_1] <= 1'b0;
          if ((prof_issue_opcode_1 == `RTYPE) &&
              (prof_issue_funct7_1 == `MUL_7) &&
              ((prof_issue_funct3_1 == `DIV) ||
               (prof_issue_funct3_1 == `DIVU) ||
               (prof_issue_funct3_1 == `REM) ||
               (prof_issue_funct3_1 == `REMU))) begin
            issue_kind_by_rob[prof_issue_rob_tag_1] <= 2;
            stage_kind_by_rob[prof_issue_rob_tag_1] <= 2;
          end
          else if ((prof_issue_opcode_1 == `RTYPE) || (prof_issue_opcode_1 == `ITYPE)) begin
            issue_kind_by_rob[prof_issue_rob_tag_1] <= 1;
            stage_kind_by_rob[prof_issue_rob_tag_1] <= 1;
          end
          else begin
            issue_kind_by_rob[prof_issue_rob_tag_1] <= 0;
            stage_kind_by_rob[prof_issue_rob_tag_1] <= 0;
          end
        end

        if (prof_issue_valid_2) begin
          issue_cycle_by_rob[prof_issue_rob_tag_2] <= cycle_count;
          issue_seen_by_rob[prof_issue_rob_tag_2] <= 1'b1;
          exm_seen_by_rob[prof_issue_rob_tag_2] <= 1'b0;
          cpl_seen_by_rob[prof_issue_rob_tag_2] <= 1'b0;
          done_seen_by_rob[prof_issue_rob_tag_2] <= 1'b0;
          if ((prof_issue_opcode_2 == `RTYPE) &&
              (prof_issue_funct7_2 == `MUL_7) &&
              ((prof_issue_funct3_2 == `DIV) ||
               (prof_issue_funct3_2 == `DIVU) ||
               (prof_issue_funct3_2 == `REM) ||
               (prof_issue_funct3_2 == `REMU))) begin
            issue_kind_by_rob[prof_issue_rob_tag_2] <= 2;
            stage_kind_by_rob[prof_issue_rob_tag_2] <= 2;
          end
          else if ((prof_issue_opcode_2 == `RTYPE) || (prof_issue_opcode_2 == `ITYPE)) begin
            issue_kind_by_rob[prof_issue_rob_tag_2] <= 1;
            stage_kind_by_rob[prof_issue_rob_tag_2] <= 1;
          end
          else begin
            issue_kind_by_rob[prof_issue_rob_tag_2] <= 0;
            stage_kind_by_rob[prof_issue_rob_tag_2] <= 0;
          end
        end

        if (dut.exm_valid_1) begin
          exm_cycle_by_rob[dut.exm_rob_idx_1] <= cycle_count;
          exm_seen_by_rob[dut.exm_rob_idx_1] <= 1'b1;
          stage_latency_tmp = cycle_count - issue_cycle_by_rob[dut.exm_rob_idx_1];
          record_stage_latency(stage_kind_by_rob[dut.exm_rob_idx_1], 0, stage_latency_tmp);
        end

        if (dut.exm_valid_2) begin
          exm_cycle_by_rob[dut.exm_rob_idx_2] <= cycle_count;
          exm_seen_by_rob[dut.exm_rob_idx_2] <= 1'b1;
          stage_latency_tmp = cycle_count - issue_cycle_by_rob[dut.exm_rob_idx_2];
          record_stage_latency(stage_kind_by_rob[dut.exm_rob_idx_2], 0, stage_latency_tmp);
        end

      if (dut.cpl_valid_1) begin
        cpl_cycle_by_rob[dut.cpl_tag_1] <= cycle_count;
        cpl_seen_by_rob[dut.cpl_tag_1] <= 1'b1;
        stage_latency_tmp = cycle_count - exm_cycle_by_rob[dut.cpl_tag_1];
        record_stage_latency(stage_kind_by_rob[dut.cpl_tag_1], 1, stage_latency_tmp);
        cpl_latency_tmp = cycle_count - issue_cycle_by_rob[dut.cpl_tag_1];
        if (issue_kind_by_rob[dut.cpl_tag_1] == 1) begin
          alu_issue_complete_count = alu_issue_complete_count + 1;
          alu_issue_complete_sum = alu_issue_complete_sum + cpl_latency_tmp;
          if (cpl_latency_tmp > alu_issue_complete_max) begin
            alu_issue_complete_max = cpl_latency_tmp;
          end
        end
        else if (issue_kind_by_rob[dut.cpl_tag_1] == 2) begin
          div_issue_complete_count = div_issue_complete_count + 1;
          div_issue_complete_sum = div_issue_complete_sum + cpl_latency_tmp;
          if (cpl_latency_tmp > div_issue_complete_max) begin
            div_issue_complete_max = cpl_latency_tmp;
          end
        end
        issue_kind_by_rob[dut.cpl_tag_1] <= 0;
      end

        if (dut.cpl_valid_2) begin
          cpl_cycle_by_rob[dut.cpl_tag_2] <= cycle_count;
          cpl_seen_by_rob[dut.cpl_tag_2] <= 1'b1;
          stage_latency_tmp = cycle_count - exm_cycle_by_rob[dut.cpl_tag_2];
          record_stage_latency(stage_kind_by_rob[dut.cpl_tag_2], 1, stage_latency_tmp);
          cpl_latency_tmp = cycle_count - issue_cycle_by_rob[dut.cpl_tag_2];
          if (issue_kind_by_rob[dut.cpl_tag_2] == 1) begin
            alu_issue_complete_count = alu_issue_complete_count + 1;
          alu_issue_complete_sum = alu_issue_complete_sum + cpl_latency_tmp;
          if (cpl_latency_tmp > alu_issue_complete_max) begin
            alu_issue_complete_max = cpl_latency_tmp;
          end
        end
        else if (issue_kind_by_rob[dut.cpl_tag_2] == 2) begin
          div_issue_complete_count = div_issue_complete_count + 1;
          div_issue_complete_sum = div_issue_complete_sum + cpl_latency_tmp;
          if (cpl_latency_tmp > div_issue_complete_max) begin
            div_issue_complete_max = cpl_latency_tmp;
          end
          end
          issue_kind_by_rob[dut.cpl_tag_2] <= 0;
        end

        for (lat_i = 0; lat_i < `ROB_SIZE; lat_i = lat_i + 1) begin
          if (dut.u_rob.ent_valid[lat_i] &&
              dut.u_rob.ent_done[lat_i] &&
              !done_seen_by_rob[lat_i]) begin
            done_seen_by_rob[lat_i] <= 1'b1;
            done_cycle_by_rob[lat_i] <= cycle_count;
            stage_latency_tmp = cycle_count - cpl_cycle_by_rob[lat_i];
            record_stage_latency(stage_kind_by_rob[lat_i], 2, stage_latency_tmp);
          end
        end

        for (rs_profile_i = 0; rs_profile_i < `RS_SIZE; rs_profile_i = rs_profile_i + 1) begin
          if (!dut.u_rs.ent_valid[rs_profile_i]) begin
            rs_ready_tracking[rs_profile_i] = 1'b0;
            rs_wakeup_rs_tracking[rs_profile_i] = 1'b0;
            rs_wakeup_rt_tracking[rs_profile_i] = 1'b0;
          end
          else begin
            if (rs_wakeup_rs_tracking[rs_profile_i] &&
                dut.u_rs.ent_rs_ready[rs_profile_i]) begin
              rs_wakeup_to_ready_tmp = cycle_count - rs_wakeup_rs_start_cycle[rs_profile_i];
              rs_wakeup_to_ready_count = rs_wakeup_to_ready_count + 1;
              rs_wakeup_to_ready_sum = rs_wakeup_to_ready_sum + rs_wakeup_to_ready_tmp;
              if (rs_wakeup_to_ready_tmp > rs_wakeup_to_ready_max) begin
                rs_wakeup_to_ready_max = rs_wakeup_to_ready_tmp;
              end
              rs_wakeup_rs_tracking[rs_profile_i] = 1'b0;
            end

            if (rs_wakeup_rt_tracking[rs_profile_i] &&
                dut.u_rs.ent_rt_ready[rs_profile_i]) begin
              rs_wakeup_to_ready_tmp = cycle_count - rs_wakeup_rt_start_cycle[rs_profile_i];
              rs_wakeup_to_ready_count = rs_wakeup_to_ready_count + 1;
              rs_wakeup_to_ready_sum = rs_wakeup_to_ready_sum + rs_wakeup_to_ready_tmp;
              if (rs_wakeup_to_ready_tmp > rs_wakeup_to_ready_max) begin
                rs_wakeup_to_ready_max = rs_wakeup_to_ready_tmp;
              end
              rs_wakeup_rt_tracking[rs_profile_i] = 1'b0;
            end

            if (dut.u_rs.ent_has_rs[rs_profile_i] &&
                !dut.u_rs.ent_rs_ready[rs_profile_i] &&
                !rs_wakeup_rs_tracking[rs_profile_i] &&
                ((dut.u_rs.rs_i_es_valid_1 && (dut.u_rs.ent_prs[rs_profile_i] == dut.u_rs.rs_i_es_prd_1)) ||
                 (dut.u_rs.rs_i_es_valid_2 && (dut.u_rs.ent_prs[rs_profile_i] == dut.u_rs.rs_i_es_prd_2)) ||
                 (dut.u_rs.rs_i_mem_valid_1 && (dut.u_rs.ent_prs[rs_profile_i] == dut.u_rs.rs_i_mem_prd_1)) ||
                 (dut.u_rs.rs_i_mem_valid_2 && (dut.u_rs.ent_prs[rs_profile_i] == dut.u_rs.rs_i_mem_prd_2)))) begin
              rs_wakeup_rs_tracking[rs_profile_i] = 1'b1;
              rs_wakeup_rs_start_cycle[rs_profile_i] = cycle_count;
            end

            if (dut.u_rs.ent_has_rt[rs_profile_i] &&
                !dut.u_rs.ent_rt_ready[rs_profile_i] &&
                !rs_wakeup_rt_tracking[rs_profile_i] &&
                ((dut.u_rs.rs_i_es_valid_1 && (dut.u_rs.ent_prt[rs_profile_i] == dut.u_rs.rs_i_es_prd_1)) ||
                 (dut.u_rs.rs_i_es_valid_2 && (dut.u_rs.ent_prt[rs_profile_i] == dut.u_rs.rs_i_es_prd_2)) ||
                 (dut.u_rs.rs_i_mem_valid_1 && (dut.u_rs.ent_prt[rs_profile_i] == dut.u_rs.rs_i_mem_prd_1)) ||
                 (dut.u_rs.rs_i_mem_valid_2 && (dut.u_rs.ent_prt[rs_profile_i] == dut.u_rs.rs_i_mem_prd_2)))) begin
              rs_wakeup_rt_tracking[rs_profile_i] = 1'b1;
              rs_wakeup_rt_start_cycle[rs_profile_i] = cycle_count;
            end

            if (rs_ready_tracking[rs_profile_i] &&
                ((dut.u_rs.issue1_valid && (dut.u_rs.issue1_idx == rs_profile_i)) ||
                 (dut.u_rs.issue2_valid && (dut.u_rs.issue2_idx == rs_profile_i)))) begin
              rs_ready_to_issue_tmp = cycle_count - rs_ready_start_cycle[rs_profile_i];
              rs_ready_to_issue_count = rs_ready_to_issue_count + 1;
              rs_ready_to_issue_sum = rs_ready_to_issue_sum + rs_ready_to_issue_tmp;
              if (rs_ready_to_issue_tmp > rs_ready_to_issue_max) begin
                rs_ready_to_issue_max = rs_ready_to_issue_tmp;
              end
              rs_ready_tracking[rs_profile_i] = 1'b0;
            end

            if (!rs_ready_tracking[rs_profile_i] &&
                dut.u_rs.ready_vec[rs_profile_i]) begin
              rs_ready_tracking[rs_profile_i] = 1'b1;
              rs_ready_start_cycle[rs_profile_i] = cycle_count;
            end
          end
        end

        rs_valid_count_cur = 0;
        rs_ready_count_cur = 0;
        rs_effective_ready_count_cur = 0;
        rs_bypass_ready_count_cur = 0;
        rs_true_ready_count_cur = 0;
        rs_issue_count_cur = {31'd0, prof_issue_valid_1} + {31'd0, prof_issue_valid_2};
        rs_selected_count_cur = {31'd0, dut.u_rs.issue1_valid} +
                                {31'd0, dut.u_rs.issue2_valid};
        rs_comb_select_count_cur = {31'd0, dut.u_rs.issue1_valid} +
                                   {31'd0, dut.u_rs.issue2_valid};
        rs_issueq_can_load_count_cur = 0;
        rs_issueq_output_valid_count_cur = 0;
        rs_issueq_accept_count_cur = 0;
        rs_effective_ready_alu_cur = 0;
        rs_effective_ready_mul_cur = 0;
        rs_effective_ready_div_cur = 0;
        rs_effective_ready_lsu_cur = 0;
        rs_effective_ready_branch_cur = 0;
        rs_effective_ready_other_cur = 0;
        rs_wait_rs_count_cur = 0;
        rs_wait_rt_count_cur = 0;
        rs_wait_both_count_cur = 0;
        rs_wait_any_count_cur = 0;
        rs_ready_min_age_cur = `ROB_SIZE;
        rs_ready_max_age_cur = 0;
        rs_head_ready_cur = 0;
        rs_head_issued_cur = 0;
        rs_issue_count_age_cur = 0;
        rs_issue_min_age_cur = `ROB_SIZE;
        rs_issue_max_age_cur = 0;

        if (prof_issue_valid_1) begin
          rs_issue_age_1_cur = rob_age_distance(prof_issue_rob_tag_1, dut.u_rob.head_ptr);
          rs_issue_count_age_cur = rs_issue_count_age_cur + 1;
          if (rs_issue_age_1_cur < rs_issue_min_age_cur)
            rs_issue_min_age_cur = rs_issue_age_1_cur;
          if (rs_issue_age_1_cur > rs_issue_max_age_cur)
            rs_issue_max_age_cur = rs_issue_age_1_cur;
          rs_issue_age_count = rs_issue_age_count + 1;
          rs_issue_age_sum = rs_issue_age_sum + rs_issue_age_1_cur;
          if (rs_issue_age_1_cur > rs_issue_age_max)
            rs_issue_age_max = rs_issue_age_1_cur;
          if (rs_issue_age_1_cur <= 3)
            rs_issue_age_le3_count = rs_issue_age_le3_count + 1;
          else if (rs_issue_age_1_cur <= 15)
            rs_issue_age_4to15_count = rs_issue_age_4to15_count + 1;
          else
            rs_issue_age_16plus_count = rs_issue_age_16plus_count + 1;
          if (prof_issue_rob_tag_1 == dut.u_rob.head_ptr)
            rs_head_issued_cur = 1;
        end

        if (prof_issue_valid_2) begin
          rs_issue_age_2_cur = rob_age_distance(prof_issue_rob_tag_2, dut.u_rob.head_ptr);
          rs_issue_count_age_cur = rs_issue_count_age_cur + 1;
          if (rs_issue_age_2_cur < rs_issue_min_age_cur)
            rs_issue_min_age_cur = rs_issue_age_2_cur;
          if (rs_issue_age_2_cur > rs_issue_max_age_cur)
            rs_issue_max_age_cur = rs_issue_age_2_cur;
          rs_issue_age_count = rs_issue_age_count + 1;
          rs_issue_age_sum = rs_issue_age_sum + rs_issue_age_2_cur;
          if (rs_issue_age_2_cur > rs_issue_age_max)
            rs_issue_age_max = rs_issue_age_2_cur;
          if (rs_issue_age_2_cur <= 3)
            rs_issue_age_le3_count = rs_issue_age_le3_count + 1;
          else if (rs_issue_age_2_cur <= 15)
            rs_issue_age_4to15_count = rs_issue_age_4to15_count + 1;
          else
            rs_issue_age_16plus_count = rs_issue_age_16plus_count + 1;
          if (prof_issue_rob_tag_2 == dut.u_rob.head_ptr)
            rs_head_issued_cur = 1;
        end

      for (rs_profile_i = 0; rs_profile_i < `RS_SIZE; rs_profile_i = rs_profile_i + 1) begin
        if (dut.u_rs.ent_valid[rs_profile_i]) begin
          rs_valid_count_cur = rs_valid_count_cur + 1;
          if ((!dut.u_rs.ent_has_rs[rs_profile_i] || dut.u_rs.ent_rs_ready[rs_profile_i]) &&
              (!dut.u_rs.ent_has_rt[rs_profile_i] || dut.u_rs.ent_rt_ready[rs_profile_i])) begin
            rs_ready_count_cur = rs_ready_count_cur + 1;
          end
          if (dut.u_rs.ready_vec[rs_profile_i]) begin
            rs_true_ready_count_cur = rs_true_ready_count_cur + 1;
            rs_ready_to_issue_tmp = rob_age_distance(dut.u_rs.ent_rob_tag[rs_profile_i],
                                                     dut.u_rob.head_ptr);
            if (rs_ready_to_issue_tmp < rs_ready_min_age_cur)
              rs_ready_min_age_cur = rs_ready_to_issue_tmp;
            if (rs_ready_to_issue_tmp > rs_ready_max_age_cur)
              rs_ready_max_age_cur = rs_ready_to_issue_tmp;
            if (dut.u_rs.ent_rob_tag[rs_profile_i] == dut.u_rob.head_ptr)
              rs_head_ready_cur = 1;
          end
          if ((!dut.u_rs.ent_has_rs[rs_profile_i] ||
               dut.u_rs.ent_rs_ready[rs_profile_i] ||
               (dut.u_rs.rs_i_es_valid_1 &&
                ((dut.u_rs.rs_i_es_opcode_1 == `RTYPE) || (dut.u_rs.rs_i_es_opcode_1 == `ITYPE)) &&
                (dut.u_rs.ent_prs[rs_profile_i] == dut.u_rs.rs_i_es_prd_1)) ||
               (dut.u_rs.rs_i_es_valid_2 &&
                ((dut.u_rs.rs_i_es_opcode_2 == `RTYPE) || (dut.u_rs.rs_i_es_opcode_2 == `ITYPE)) &&
                (dut.u_rs.ent_prs[rs_profile_i] == dut.u_rs.rs_i_es_prd_2))) &&
              (!dut.u_rs.ent_has_rt[rs_profile_i] ||
               dut.u_rs.ent_rt_ready[rs_profile_i] ||
               (dut.u_rs.rs_i_es_valid_1 &&
                ((dut.u_rs.rs_i_es_opcode_1 == `RTYPE) || (dut.u_rs.rs_i_es_opcode_1 == `ITYPE)) &&
                (dut.u_rs.ent_prt[rs_profile_i] == dut.u_rs.rs_i_es_prd_1)) ||
               (dut.u_rs.rs_i_es_valid_2 &&
                ((dut.u_rs.rs_i_es_opcode_2 == `RTYPE) || (dut.u_rs.rs_i_es_opcode_2 == `ITYPE)) &&
                (dut.u_rs.ent_prt[rs_profile_i] == dut.u_rs.rs_i_es_prd_2)))) begin
            rs_effective_ready_count_cur = rs_effective_ready_count_cur + 1;
            if ((dut.u_rs.ent_opcode[rs_profile_i] == `RTYPE) &&
                (dut.u_rs.ent_funct7[rs_profile_i] == `MUL_7) &&
                ((dut.u_rs.ent_funct3[rs_profile_i] == `DIV) ||
                 (dut.u_rs.ent_funct3[rs_profile_i] == `DIVU) ||
                 (dut.u_rs.ent_funct3[rs_profile_i] == `REM) ||
                 (dut.u_rs.ent_funct3[rs_profile_i] == `REMU))) begin
              rs_effective_ready_div_cur = rs_effective_ready_div_cur + 1;
            end
            else if ((dut.u_rs.ent_opcode[rs_profile_i] == `RTYPE) &&
                     (dut.u_rs.ent_funct7[rs_profile_i] == `MUL_7) &&
                     ((dut.u_rs.ent_funct3[rs_profile_i] == `MUL) ||
                      (dut.u_rs.ent_funct3[rs_profile_i] == `MULH) ||
                      (dut.u_rs.ent_funct3[rs_profile_i] == `MULHSU) ||
                      (dut.u_rs.ent_funct3[rs_profile_i] == `MULHU))) begin
              rs_effective_ready_mul_cur = rs_effective_ready_mul_cur + 1;
            end
            else if ((dut.u_rs.ent_opcode[rs_profile_i] == `LOAD) ||
                     (dut.u_rs.ent_opcode[rs_profile_i] == `STORE)) begin
              rs_effective_ready_lsu_cur = rs_effective_ready_lsu_cur + 1;
            end
            else if (dut.u_rs.ent_opcode[rs_profile_i] == `BTYPE) begin
              rs_effective_ready_branch_cur = rs_effective_ready_branch_cur + 1;
            end
            else if ((dut.u_rs.ent_opcode[rs_profile_i] == `RTYPE) ||
                     (dut.u_rs.ent_opcode[rs_profile_i] == `ITYPE)) begin
              rs_effective_ready_alu_cur = rs_effective_ready_alu_cur + 1;
            end
            else begin
              rs_effective_ready_other_cur = rs_effective_ready_other_cur + 1;
            end
            if (!((!dut.u_rs.ent_has_rs[rs_profile_i] || dut.u_rs.ent_rs_ready[rs_profile_i]) &&
                  (!dut.u_rs.ent_has_rt[rs_profile_i] || dut.u_rs.ent_rt_ready[rs_profile_i]))) begin
              rs_bypass_ready_count_cur = rs_bypass_ready_count_cur + 1;
            end
          end
          if (dut.u_rs.ent_has_rs[rs_profile_i] && !dut.u_rs.ent_rs_ready[rs_profile_i]) begin
            rs_wait_rs_count_cur = rs_wait_rs_count_cur + 1;
          end
          if (dut.u_rs.ent_has_rt[rs_profile_i] && !dut.u_rs.ent_rt_ready[rs_profile_i]) begin
            rs_wait_rt_count_cur = rs_wait_rt_count_cur + 1;
          end
          if ((dut.u_rs.ent_has_rs[rs_profile_i] && !dut.u_rs.ent_rs_ready[rs_profile_i]) &&
              (dut.u_rs.ent_has_rt[rs_profile_i] && !dut.u_rs.ent_rt_ready[rs_profile_i])) begin
            rs_wait_both_count_cur = rs_wait_both_count_cur + 1;
          end
          if ((dut.u_rs.ent_has_rs[rs_profile_i] && !dut.u_rs.ent_rs_ready[rs_profile_i]) ||
              (dut.u_rs.ent_has_rt[rs_profile_i] && !dut.u_rs.ent_rt_ready[rs_profile_i])) begin
            rs_wait_any_count_cur = rs_wait_any_count_cur + 1;
          end
          if (dut.u_rs.ent_opcode[rs_profile_i] == `BTYPE) begin
            if (dut.u_rs.ent_has_rs[rs_profile_i] && !dut.u_rs.ent_rs_ready[rs_profile_i]) begin
              case (prd_producer_kind[dut.u_rs.ent_prs[rs_profile_i]])
                3'd1: branch_rs_wait_rs_alu_cycles <= branch_rs_wait_rs_alu_cycles + 1;
                3'd2: begin
                  branch_rs_wait_rs_load_cycles <= branch_rs_wait_rs_load_cycles + 1;
                  record_branch_load_wait_stage(dut.u_rs.ent_pc[rs_profile_i],
                                                dut.u_rs.ent_prs[rs_profile_i],
                                                1'b0);
                end
                3'd3: branch_rs_wait_rs_muldiv_cycles <= branch_rs_wait_rs_muldiv_cycles + 1;
                default: branch_rs_wait_rs_other_cycles <= branch_rs_wait_rs_other_cycles + 1;
              endcase
            end
            if (dut.u_rs.ent_has_rt[rs_profile_i] && !dut.u_rs.ent_rt_ready[rs_profile_i]) begin
              case (prd_producer_kind[dut.u_rs.ent_prt[rs_profile_i]])
                3'd1: branch_rs_wait_rt_alu_cycles <= branch_rs_wait_rt_alu_cycles + 1;
                3'd2: begin
                  branch_rs_wait_rt_load_cycles <= branch_rs_wait_rt_load_cycles + 1;
                  record_branch_load_wait_stage(dut.u_rs.ent_pc[rs_profile_i],
                                                dut.u_rs.ent_prt[rs_profile_i],
                                                1'b1);
                end
                3'd3: branch_rs_wait_rt_muldiv_cycles <= branch_rs_wait_rt_muldiv_cycles + 1;
                default: branch_rs_wait_rt_other_cycles <= branch_rs_wait_rt_other_cycles + 1;
              endcase
            end
          end
        end
      end

      if (rs_true_ready_count_cur != 0) begin
        rs_ready_oldest_age_count = rs_ready_oldest_age_count + 1;
        rs_ready_oldest_age_sum = rs_ready_oldest_age_sum + rs_ready_min_age_cur;
        if (rs_ready_min_age_cur > rs_ready_oldest_age_max)
          rs_ready_oldest_age_max = rs_ready_min_age_cur;
      end

      if ((rs_true_ready_count_cur != 0) &&
          (rs_issue_count_age_cur != 0) &&
          (rs_issue_min_age_cur > rs_ready_min_age_cur)) begin
        rs_issue_younger_than_oldest_ready_cycles =
          rs_issue_younger_than_oldest_ready_cycles + 1;
        rs_issue_younger_than_oldest_ready_count =
          rs_issue_younger_than_oldest_ready_count + rs_issue_count_age_cur;
        rs_issue_younger_delta_sum =
          rs_issue_younger_delta_sum + (rs_issue_min_age_cur - rs_ready_min_age_cur);
        if ((rs_issue_min_age_cur - rs_ready_min_age_cur) > rs_issue_younger_delta_max)
          rs_issue_younger_delta_max = rs_issue_min_age_cur - rs_ready_min_age_cur;
      end

      if (dut.u_rob.head_valid &&
          !dut.u_rob.head_done &&
          !issue_seen_by_rob[dut.u_rob.head_ptr]) begin
        if (rs_head_ready_cur) begin
          rs_head_wait_ready_cycles = rs_head_wait_ready_cycles + 1;
          if (rs_head_issued_cur)
            rs_head_wait_ready_issued_cycles = rs_head_wait_ready_issued_cycles + 1;
          else
            rs_head_wait_ready_not_issued_cycles = rs_head_wait_ready_not_issued_cycles + 1;
        end
        else begin
          rs_head_wait_not_ready_cycles = rs_head_wait_not_ready_cycles + 1;
        end
      end

      rs_valid_count_sum <= rs_valid_count_sum + rs_valid_count_cur;
      rs_ready_count_sum <= rs_ready_count_sum + rs_ready_count_cur;
      rs_effective_ready_count_sum <= rs_effective_ready_count_sum + rs_effective_ready_count_cur;
      rs_bypass_ready_count_sum <= rs_bypass_ready_count_sum + rs_bypass_ready_count_cur;
      rs_true_ready_count_sum <= rs_true_ready_count_sum + rs_true_ready_count_cur;
      rs_wait_rs_operand_sum <= rs_wait_rs_operand_sum + rs_wait_rs_count_cur;
      rs_wait_rt_operand_sum <= rs_wait_rt_operand_sum + rs_wait_rt_count_cur;
      rs_wait_both_operands_sum <= rs_wait_both_operands_sum + rs_wait_both_count_cur;
      rs_wait_any_operand_sum <= rs_wait_any_operand_sum + rs_wait_any_count_cur;

      if (rs_valid_count_cur > rs_max_valid_count) begin
        rs_max_valid_count <= rs_valid_count_cur;
      end

      if (rs_ready_count_cur > rs_max_ready_count) begin
        rs_max_ready_count <= rs_ready_count_cur;
      end

      if (rs_effective_ready_count_cur > rs_max_effective_ready_count) begin
        rs_max_effective_ready_count <= rs_effective_ready_count_cur;
      end

      if (rs_bypass_ready_count_cur > rs_max_bypass_ready_count) begin
        rs_max_bypass_ready_count <= rs_bypass_ready_count_cur;
      end

      if (rs_true_ready_count_cur > rs_max_true_ready_count) begin
        rs_max_true_ready_count <= rs_true_ready_count_cur;
      end

      if (rs_wait_rs_count_cur > rs_wait_rs_operand_max) begin
        rs_wait_rs_operand_max <= rs_wait_rs_count_cur;
      end

      if (rs_wait_rt_count_cur > rs_wait_rt_operand_max) begin
        rs_wait_rt_operand_max <= rs_wait_rt_count_cur;
      end

      if (rs_wait_both_count_cur > rs_wait_both_operands_max) begin
        rs_wait_both_operands_max <= rs_wait_both_count_cur;
      end

      if (rs_valid_count_cur == 0) begin
        rs_empty_cycles <= rs_empty_cycles + 1;
      end

      if ((rs_valid_count_cur != 0) && (rs_ready_count_cur == 0)) begin
        rs_no_ready_cycles <= rs_no_ready_cycles + 1;
      end

      if ((rs_ready_count_cur != 0) && !prof_issue_valid_1 && !prof_issue_valid_2) begin
        rs_ready_but_issue0_cycles <= rs_ready_but_issue0_cycles + 1;
      end

      if (rs_ready_count_cur == 0) begin
        rs_ready0_cycles <= rs_ready0_cycles + 1;
      end
      else if (rs_ready_count_cur == 1) begin
        rs_ready1_cycles <= rs_ready1_cycles + 1;
        if (rs_issue_count_cur == 0) begin
          rs_ready1_issue0_cycles <= rs_ready1_issue0_cycles + 1;
        end
        else begin
          rs_ready1_issue1_cycles <= rs_ready1_issue1_cycles + 1;
        end
      end
      else begin
        rs_ready2plus_cycles <= rs_ready2plus_cycles + 1;
        if (rs_issue_count_cur == 0) begin
          rs_ready2plus_issue0_cycles <= rs_ready2plus_issue0_cycles + 1;
        end
        else if (rs_issue_count_cur == 1) begin
          rs_ready2plus_issue1_cycles <= rs_ready2plus_issue1_cycles + 1;
        end
        else begin
          rs_ready2plus_issue2_cycles <= rs_ready2plus_issue2_cycles + 1;
        end
      end

      if (rs_effective_ready_count_cur >= 2) begin
        rs_effective_ready2plus_cycles <= rs_effective_ready2plus_cycles + 1;
        if (rs_issue_count_cur < 2) begin
          rs_effective_ready2plus_issue_lt2_cycles <=
            rs_effective_ready2plus_issue_lt2_cycles + 1;
        end
      end

      if (rs_true_ready_count_cur >= 2) begin
        rs_true_ready2plus_cycles <= rs_true_ready2plus_cycles + 1;
        if (rs_comb_select_count_cur == 0) begin
          rs_true_ready2plus_comb_select0_cycles <= rs_true_ready2plus_comb_select0_cycles + 1;
        end
        else if (rs_comb_select_count_cur == 1) begin
          rs_true_ready2plus_comb_select1_cycles <= rs_true_ready2plus_comb_select1_cycles + 1;
        end
        else begin
          rs_true_ready2plus_comb_select2_cycles <= rs_true_ready2plus_comb_select2_cycles + 1;
        end

        if (rs_issueq_can_load_count_cur == 0) begin
          rs_true_ready2plus_issueq_load0_cycles <= rs_true_ready2plus_issueq_load0_cycles + 1;
        end
        else if (rs_issueq_can_load_count_cur == 1) begin
          rs_true_ready2plus_issueq_load1_cycles <= rs_true_ready2plus_issueq_load1_cycles + 1;
        end
        else begin
          rs_true_ready2plus_issueq_load2_cycles <= rs_true_ready2plus_issueq_load2_cycles + 1;
        end

        if (rs_issueq_output_valid_count_cur == 0) begin
          rs_true_ready2plus_output0_cycles <= rs_true_ready2plus_output0_cycles + 1;
        end
        else if (rs_issueq_output_valid_count_cur == 1) begin
          rs_true_ready2plus_output1_cycles <= rs_true_ready2plus_output1_cycles + 1;
        end
        else begin
          rs_true_ready2plus_output2_cycles <= rs_true_ready2plus_output2_cycles + 1;
        end

        if (rs_issueq_accept_count_cur == 0) begin
          rs_true_ready2plus_accept0_cycles <= rs_true_ready2plus_accept0_cycles + 1;
        end
        else if (rs_issueq_accept_count_cur == 1) begin
          rs_true_ready2plus_accept1_cycles <= rs_true_ready2plus_accept1_cycles + 1;
        end
        else begin
          rs_true_ready2plus_accept2_cycles <= rs_true_ready2plus_accept2_cycles + 1;
        end

        if (rs_issue_count_cur == 0) begin
          rs_true_ready2plus_issue0_cycles <= rs_true_ready2plus_issue0_cycles + 1;
        end
        else if (rs_issue_count_cur == 1) begin
          rs_true_ready2plus_issue1_cycles <= rs_true_ready2plus_issue1_cycles + 1;
        end
        else begin
          rs_true_ready2plus_issue2_cycles <= rs_true_ready2plus_issue2_cycles + 1;
        end
        if (rs_selected_count_cur < 2) begin
          rs_true_ready2plus_selected_lt2_cycles <= rs_true_ready2plus_selected_lt2_cycles + 1;
        end
        if (rs_selected_count_cur >= 2 && rs_issue_count_cur < 2) begin
          rs_true_ready2plus_is3_block_cycles <= rs_true_ready2plus_is3_block_cycles + 1;
        end
        if (rs_comb_select_count_cur < 2) begin
          rs_true_ready2plus_block_selector_cycles <= rs_true_ready2plus_block_selector_cycles + 1;
        end
        if ((rs_comb_select_count_cur >= 2) && (rs_issueq_can_load_count_cur < 2)) begin
          rs_true_ready2plus_block_issueq_cycles <= rs_true_ready2plus_block_issueq_cycles + 1;
        end
        if ((rs_issueq_output_valid_count_cur != 0) &&
            (rs_issueq_accept_count_cur < rs_issueq_output_valid_count_cur)) begin
          rs_true_ready2plus_block_downstream_cycles <= rs_true_ready2plus_block_downstream_cycles + 1;
        end
      end

      if (rs_true_ready_count_cur >= 2) begin
        issue2_ready2_cycles <= issue2_ready2_cycles + 1;
        if (rs_issue_count_cur >= 2) begin
          issue2_ready2_success_cycles <= issue2_ready2_success_cycles + 1;
        end
        else begin
          issue2_ready2_blocked_cycles <= issue2_ready2_blocked_cycles + 1;
          if (rs_effective_ready_alu_cur != 0) begin
            issue2_block_has_alu_cycles <= issue2_block_has_alu_cycles + 1;
          end
          if (rs_effective_ready_mul_cur != 0) begin
            issue2_block_has_mul_cycles <= issue2_block_has_mul_cycles + 1;
          end
          if (rs_effective_ready_div_cur != 0) begin
            issue2_block_has_div_cycles <= issue2_block_has_div_cycles + 1;
          end
          if (rs_effective_ready_lsu_cur != 0) begin
            issue2_block_has_lsu_cycles <= issue2_block_has_lsu_cycles + 1;
          end
          if (rs_effective_ready_branch_cur != 0) begin
            issue2_block_has_branch_cycles <= issue2_block_has_branch_cycles + 1;
          end
          if (rs_effective_ready_other_cur != 0) begin
            issue2_block_has_other_cycles <= issue2_block_has_other_cycles + 1;
          end
          if (rs_selected_count_cur < 2) begin
            issue2_block_selected_lt2_cycles <= issue2_block_selected_lt2_cycles + 1;
          end
          if (rs_selected_count_cur >= 2 && rs_issue_count_cur < 2) begin
            issue2_block_is3_backpressure_cycles <= issue2_block_is3_backpressure_cycles + 1;
          end
          if (!dut.is3_can_take_1) begin
            issue2_block_is3_lane1_busy_cycles <= issue2_block_is3_lane1_busy_cycles + 1;
          end
          if (!dut.is3_can_take_2) begin
            issue2_block_is3_lane2_busy_cycles <= issue2_block_is3_lane2_busy_cycles + 1;
          end
          if (!dut.es1_o_ready) begin
            issue2_block_es1_not_ready_cycles <= issue2_block_es1_not_ready_cycles + 1;
          end
          if (!dut.es2_o_ready) begin
            issue2_block_es2_not_ready_cycles <= issue2_block_es2_not_ready_cycles + 1;
          end
          if (dut.u_es1.q0_valid && dut.u_es1.q1_valid) begin
            issue2_block_es1_queue_full_cycles <= issue2_block_es1_queue_full_cycles + 1;
          end
          if (dut.u_es2.q0_valid && dut.u_es2.q1_valid) begin
            issue2_block_es2_queue_full_cycles <= issue2_block_es2_queue_full_cycles + 1;
          end
          if (rs_issue_count_cur == 0) begin
            issue2_accept_block_cycles <= issue2_accept_block_cycles + 1;
          end
        end
      end
      else begin
        issue2_not_enough_ready_cycles <= issue2_not_enough_ready_cycles + 1;
      end

      if (dut.u_rs.rs_i_es_valid_1) begin
        rs_wakeup_es1_count <= rs_wakeup_es1_count + 1;
      end
      if (dut.u_rs.rs_i_es_valid_2) begin
        rs_wakeup_es2_count <= rs_wakeup_es2_count + 1;
      end
      if (dut.u_rs.rs_i_mem_valid_1) begin
        rs_wakeup_mem1_count <= rs_wakeup_mem1_count + 1;
      end
      if (dut.u_rs.rs_i_mem_valid_2) begin
        rs_wakeup_mem2_count <= rs_wakeup_mem2_count + 1;
      end

      rob_done_count_cur = 0;
      rob_done_not_head_count_cur = 0;
      for (lat_i = 0; lat_i < `ROB_SIZE; lat_i = lat_i + 1) begin
        if (dut.u_rob.ent_valid[lat_i] && dut.u_rob.ent_done[lat_i]) begin
          rob_done_count_cur = rob_done_count_cur + 1;
          if (lat_i != dut.u_rob.head_ptr) begin
            rob_done_not_head_count_cur = rob_done_not_head_count_cur + 1;
          end
        end
      end

      if (rob_done_not_head_count_cur != 0) begin
        rob_done_not_head_cycles <= rob_done_not_head_cycles + 1;
        rob_done_not_head_sum <= rob_done_not_head_sum + rob_done_not_head_count_cur;
        if (rob_done_not_head_count_cur > rob_done_not_head_max) begin
          rob_done_not_head_max <= rob_done_not_head_count_cur;
        end
      end

      if (dut.u_rob.head_valid &&
          !dut.u_rob.head_done &&
          (rob_done_not_head_count_cur != 0)) begin
        rob_younger_done_blocked_by_head_cycles <= rob_younger_done_blocked_by_head_cycles + 1;
        if (dut.u_rob.ent_is_load[dut.u_rob.head_ptr]) begin
          rob_younger_done_blocked_by_load_cycles <= rob_younger_done_blocked_by_load_cycles + 1;
        end
        else if (dut.u_rob.ent_is_store[dut.u_rob.head_ptr]) begin
          rob_younger_done_blocked_by_store_cycles <= rob_younger_done_blocked_by_store_cycles + 1;
        end
        else if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `BTYPE) begin
          rob_younger_done_blocked_by_branch_cycles <= rob_younger_done_blocked_by_branch_cycles + 1;
        end
        else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) &&
                 (dut.u_rob.ent_funct7[dut.u_rob.head_ptr] == `MUL_7) &&
                 ((dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `DIV) ||
                  (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `DIVU) ||
                  (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `REM) ||
                  (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `REMU))) begin
          rob_younger_done_blocked_by_div_cycles <= rob_younger_done_blocked_by_div_cycles + 1;
        end
        else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) &&
                 (dut.u_rob.ent_funct7[dut.u_rob.head_ptr] == `MUL_7) &&
                 ((dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MUL) ||
                  (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULH) ||
                  (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULHSU) ||
                  (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULHU))) begin
          rob_younger_done_blocked_by_mul_cycles <= rob_younger_done_blocked_by_mul_cycles + 1;
        end
        else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) ||
                 (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `ITYPE)) begin
          rob_younger_done_blocked_by_alu_cycles <= rob_younger_done_blocked_by_alu_cycles + 1;
        end
      end

      rob_used_sum <= rob_used_sum + dut.u_rob.used_count;

      if (dut.u_rob.used_count > rob_max_used) begin
        rob_max_used <= dut.u_rob.used_count;
      end

      if (dut.u_rob.used_count == 0) begin
        rob_empty_cycles <= rob_empty_cycles + 1;
      end

      if (dut.u_rob.head_valid && !dut.u_rob.head_done) begin
        rob_head_wait_cycles <= rob_head_wait_cycles + 1;
        if (beebs_debug_head &&
            ((cycle_count < 80) || ((cycle_count % 500) == 0))) begin
          print_beebs_head_debug();
        end
        rob_head_issue_same_cycle_cur =
          (prof_issue_valid_1 && (prof_issue_rob_tag_1 == dut.u_rob.head_ptr)) ||
          (prof_issue_valid_2 && (prof_issue_rob_tag_2 == dut.u_rob.head_ptr));
        rob_head_exm_same_cycle_cur =
          (dut.exm_valid_1 && (dut.exm_rob_idx_1 == dut.u_rob.head_ptr)) ||
          (dut.exm_valid_2 && (dut.exm_rob_idx_2 == dut.u_rob.head_ptr));
        if ((dut.cpl_valid_1 && (dut.cpl_tag_1 == dut.u_rob.head_ptr)) ||
            (dut.cpl_valid_2 && (dut.cpl_tag_2 == dut.u_rob.head_ptr))) begin
          rob_head_wait_cpl_same_cycle_cycles <= rob_head_wait_cpl_same_cycle_cycles + 1;
        end
        else if (!issue_seen_by_rob[dut.u_rob.head_ptr]) begin
          rob_head_wait_not_issued_cycles <= rob_head_wait_not_issued_cycles + 1;
          if (rob_head_issue_same_cycle_cur) begin
            rob_head_wait_issue_same_cycle_cycles <= rob_head_wait_issue_same_cycle_cycles + 1;
          end
          else begin
            rob_head_wait_real_not_issued_cycles <= rob_head_wait_real_not_issued_cycles + 1;
          end
        end
        else if (!exm_seen_by_rob[dut.u_rob.head_ptr]) begin
          rob_head_wait_issued_not_exm_cycles <= rob_head_wait_issued_not_exm_cycles + 1;
          if (rob_head_exm_same_cycle_cur) begin
            rob_head_wait_exm_same_cycle_cycles <= rob_head_wait_exm_same_cycle_cycles + 1;
          end
          else begin
            rob_head_wait_real_issued_not_exm_cycles <= rob_head_wait_real_issued_not_exm_cycles + 1;
          end
        end
        else if (!cpl_seen_by_rob[dut.u_rob.head_ptr]) begin
          rob_head_wait_exm_not_cpl_cycles <= rob_head_wait_exm_not_cpl_cycles + 1;
        end
        else if (!done_seen_by_rob[dut.u_rob.head_ptr]) begin
          rob_head_wait_cpl_seen_not_done_cycles <= rob_head_wait_cpl_seen_not_done_cycles + 1;
        end
        else begin
          rob_head_wait_unknown_cycles <= rob_head_wait_unknown_cycles + 1;
        end
        if (dut.u_rob.ent_is_load[dut.u_rob.head_ptr]) begin
          rob_head_wait_load_cycles <= rob_head_wait_load_cycles + 1;
          if ((dut.cpl_valid_1 && (dut.cpl_tag_1 == dut.u_rob.head_ptr)) ||
              (dut.cpl_valid_2 && (dut.cpl_tag_2 == dut.u_rob.head_ptr))) begin
            rob_head_wait_load_cpl_same_cycle_cycles <= rob_head_wait_load_cpl_same_cycle_cycles + 1;
          end
          else if (!issue_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_load_not_issued_cycles <= rob_head_wait_load_not_issued_cycles + 1;
            if (rob_head_issue_same_cycle_cur) begin
              rob_head_wait_load_issue_same_cycle_cycles <= rob_head_wait_load_issue_same_cycle_cycles + 1;
            end
            else begin
              rob_head_wait_load_real_not_issued_cycles <= rob_head_wait_load_real_not_issued_cycles + 1;
            end
            load_head_rs_found_cur = 1'b0;
            load_head_rs_ready_cur = 1'b0;
            for (load_head_rs_scan_i = 0; load_head_rs_scan_i < `RS_SIZE; load_head_rs_scan_i = load_head_rs_scan_i + 1) begin
              if (dut.u_rs.ent_valid[load_head_rs_scan_i] &&
                  (dut.u_rs.ent_rob_tag[load_head_rs_scan_i] == dut.u_rob.head_ptr)) begin
                load_head_rs_found_cur = 1'b1;
                if (dut.u_rs.ready_vec[load_head_rs_scan_i]) begin
                  load_head_rs_ready_cur = 1'b1;
                end
                else begin
                  if (dut.u_rs.ent_has_rs[load_head_rs_scan_i] &&
                      !dut.u_rs.ent_rs_ready[load_head_rs_scan_i]) begin
                    case (prd_producer_kind[dut.u_rs.ent_prs[load_head_rs_scan_i]])
                      3'd1: rob_head_load_rs_wait_rs_alu_cycles <= rob_head_load_rs_wait_rs_alu_cycles + 1;
                      3'd2: rob_head_load_rs_wait_rs_load_cycles <= rob_head_load_rs_wait_rs_load_cycles + 1;
                      3'd3: rob_head_load_rs_wait_rs_muldiv_cycles <= rob_head_load_rs_wait_rs_muldiv_cycles + 1;
                      default: rob_head_load_rs_wait_rs_other_cycles <= rob_head_load_rs_wait_rs_other_cycles + 1;
                    endcase
                  end
                  if (dut.u_rs.ent_has_rt[load_head_rs_scan_i] &&
                      !dut.u_rs.ent_rt_ready[load_head_rs_scan_i]) begin
                    case (prd_producer_kind[dut.u_rs.ent_prt[load_head_rs_scan_i]])
                      3'd1: rob_head_load_rs_wait_rt_alu_cycles <= rob_head_load_rs_wait_rt_alu_cycles + 1;
                      3'd2: rob_head_load_rs_wait_rt_load_cycles <= rob_head_load_rs_wait_rt_load_cycles + 1;
                      3'd3: rob_head_load_rs_wait_rt_muldiv_cycles <= rob_head_load_rs_wait_rt_muldiv_cycles + 1;
                      default: rob_head_load_rs_wait_rt_other_cycles <= rob_head_load_rs_wait_rt_other_cycles + 1;
                    endcase
                  end
                end
              end
            end
            if (load_head_rs_found_cur) begin
              rob_head_load_rs_found_cycles <= rob_head_load_rs_found_cycles + 1;
              if (load_head_rs_ready_cur) begin
                rob_head_load_rs_ready_cycles <= rob_head_load_rs_ready_cycles + 1;
                if (rob_head_issue_same_cycle_cur) begin
                  rob_head_load_rs_ready_issued_cycles <= rob_head_load_rs_ready_issued_cycles + 1;
                end
                else begin
                  rob_head_load_rs_ready_not_issued_cycles <= rob_head_load_rs_ready_not_issued_cycles + 1;
                end
              end
            end
            else begin
              rob_head_load_rs_missing_cycles <= rob_head_load_rs_missing_cycles + 1;
            end
          end
          else if (!exm_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_load_issued_not_exm_cycles <= rob_head_wait_load_issued_not_exm_cycles + 1;
            if (rob_head_exm_same_cycle_cur) begin
              rob_head_wait_load_exm_same_cycle_cycles <= rob_head_wait_load_exm_same_cycle_cycles + 1;
            end
            else begin
              rob_head_wait_load_real_issued_not_exm_cycles <= rob_head_wait_load_real_issued_not_exm_cycles + 1;
            end
          end
          else if (!cpl_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_load_exm_not_cpl_cycles <= rob_head_wait_load_exm_not_cpl_cycles + 1;
            if (dut.u_load_queue.ent_valid[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]]) begin
              if (dut.u_load_queue.ent_query_wait[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]]) begin
                rob_head_wait_load_lq_query_wait_cycles <= rob_head_wait_load_lq_query_wait_cycles + 1;
              end
              if (dut.u_load_queue.ent_mem_wait[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]]) begin
                rob_head_wait_load_lq_mem_wait_cycles <= rob_head_wait_load_lq_mem_wait_cycles + 1;
              end
              if (!dut.u_load_queue.ent_done[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]]) begin
                rob_head_wait_load_lq_not_done_cycles <= rob_head_wait_load_lq_not_done_cycles + 1;
              end
              else if (!dut.u_load_queue.ent_complete_sent[dut.u_rob.ent_ld_idx[dut.u_rob.head_ptr]]) begin
                rob_head_wait_load_lq_done_not_sent_cycles <= rob_head_wait_load_lq_done_not_sent_cycles + 1;
                if ((dut.lq_o_complete_valid_1 &&
                     (dut.lq_o_complete_rob_tag_1 == dut.u_rob.head_ptr)) ||
                    (dut.lq_o_complete_valid_2 &&
                     (dut.lq_o_complete_rob_tag_2 == dut.u_rob.head_ptr))) begin
                  rob_head_wait_load_lq_complete_out_cycles <= rob_head_wait_load_lq_complete_out_cycles + 1;
                  if ((dut.lq_o_complete_valid_1 &&
                       (dut.lq_o_complete_rob_tag_1 == dut.u_rob.head_ptr) &&
                       dut.lq_i_complete_accept_1) ||
                      (dut.lq_o_complete_valid_2 &&
                       (dut.lq_o_complete_rob_tag_2 == dut.u_rob.head_ptr) &&
                       dut.lq_i_complete_accept_2)) begin
                    rob_head_wait_load_lq_complete_accept_cycles <= rob_head_wait_load_lq_complete_accept_cycles + 1;
                  end
                  else begin
                    rob_head_wait_load_lq_complete_block_cycles <= rob_head_wait_load_lq_complete_block_cycles + 1;
                    if (dut.pipe_cpl_valid_1 && dut.pipe_cpl_valid_2) begin
                      rob_head_wait_load_lq_block_two_pipe_cycles <= rob_head_wait_load_lq_block_two_pipe_cycles + 1;
                    end
                    else if (dut.pipe_cpl_valid_1 || dut.pipe_cpl_valid_2) begin
                      rob_head_wait_load_lq_block_one_pipe_cycles <= rob_head_wait_load_lq_block_one_pipe_cycles + 1;
                    end
                    else begin
                      rob_head_wait_load_lq_block_no_pipe_cycles <= rob_head_wait_load_lq_block_no_pipe_cycles + 1;
                    end
                  end
                end
                else begin
                  rob_head_wait_load_lq_done_no_out_cycles <= rob_head_wait_load_lq_done_no_out_cycles + 1;
                  if (dut.lq_o_complete_valid_1 || dut.lq_o_complete_valid_2) begin
                    rob_head_wait_load_lq_out_other_cycles <= rob_head_wait_load_lq_out_other_cycles + 1;
                  end
                end
              end
            end
          end
          else if (!done_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_load_cpl_seen_not_done_cycles <= rob_head_wait_load_cpl_seen_not_done_cycles + 1;
          end
          else begin
            rob_head_wait_load_unknown_cycles <= rob_head_wait_load_unknown_cycles + 1;
            if (spec_lq_debug &&
                (spec_lq_unknown_sample_count < 30) &&
                ((spec_lq_unknown_sample_count < 10) || ((cycle_count % 1000) == 0))) begin
              spec_lq_unknown_sample_count <= spec_lq_unknown_sample_count + 1;
              $display("SPEC_LQ_UNKNOWN_SAMPLE sample=%0d", spec_lq_unknown_sample_count);
              print_spec_lq_state();
            end
          end
        end
        else if (dut.u_rob.ent_is_store[dut.u_rob.head_ptr]) begin
          rob_head_wait_store_cycles <= rob_head_wait_store_cycles + 1;
          if ((dut.cpl_valid_1 && (dut.cpl_tag_1 == dut.u_rob.head_ptr)) ||
              (dut.cpl_valid_2 && (dut.cpl_tag_2 == dut.u_rob.head_ptr))) begin
            rob_head_wait_store_cpl_same_cycle_cycles <= rob_head_wait_store_cpl_same_cycle_cycles + 1;
          end
          else if (!issue_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_store_not_issued_cycles <= rob_head_wait_store_not_issued_cycles + 1;
            if (rob_head_issue_same_cycle_cur) begin
              rob_head_wait_store_issue_same_cycle_cycles <= rob_head_wait_store_issue_same_cycle_cycles + 1;
            end
            else begin
              rob_head_wait_store_real_not_issued_cycles <= rob_head_wait_store_real_not_issued_cycles + 1;
            end
          end
          else if (!exm_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_store_issued_not_exm_cycles <= rob_head_wait_store_issued_not_exm_cycles + 1;
            if (rob_head_exm_same_cycle_cur) begin
              rob_head_wait_store_exm_same_cycle_cycles <= rob_head_wait_store_exm_same_cycle_cycles + 1;
            end
            else begin
              rob_head_wait_store_real_issued_not_exm_cycles <= rob_head_wait_store_real_issued_not_exm_cycles + 1;
            end
          end
          else if (!cpl_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_store_exm_not_cpl_cycles <= rob_head_wait_store_exm_not_cpl_cycles + 1;
          end
        end
        else begin
          rob_head_wait_non_mem_cycles <= rob_head_wait_non_mem_cycles + 1;
          if ((dut.cpl_valid_1 && (dut.cpl_tag_1 == dut.u_rob.head_ptr)) ||
              (dut.cpl_valid_2 && (dut.cpl_tag_2 == dut.u_rob.head_ptr))) begin
            rob_head_wait_nonmem_cpl_same_cycle_cycles <= rob_head_wait_nonmem_cpl_same_cycle_cycles + 1;
          end
          else if (!issue_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_nonmem_not_issued_cycles <= rob_head_wait_nonmem_not_issued_cycles + 1;
            if (rob_head_issue_same_cycle_cur) begin
              rob_head_wait_nonmem_issue_same_cycle_cycles <= rob_head_wait_nonmem_issue_same_cycle_cycles + 1;
            end
            else begin
              rob_head_wait_nonmem_real_not_issued_cycles <= rob_head_wait_nonmem_real_not_issued_cycles + 1;
            end
          end
          else if (!exm_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_nonmem_issued_not_exm_cycles <= rob_head_wait_nonmem_issued_not_exm_cycles + 1;
            if (rob_head_exm_same_cycle_cur) begin
              rob_head_wait_nonmem_exm_same_cycle_cycles <= rob_head_wait_nonmem_exm_same_cycle_cycles + 1;
            end
            else begin
              rob_head_wait_nonmem_real_issued_not_exm_cycles <= rob_head_wait_nonmem_real_issued_not_exm_cycles + 1;
            end
            if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) &&
                (dut.u_rob.ent_funct7[dut.u_rob.head_ptr] == `MUL_7) &&
                ((dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `DIV) ||
                 (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `DIVU) ||
                 (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `REM) ||
                 (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `REMU))) begin
              rob_head_wait_nonmem_issued_not_exm_div_cycles <= rob_head_wait_nonmem_issued_not_exm_div_cycles + 1;
            end
            else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) &&
                     (dut.u_rob.ent_funct7[dut.u_rob.head_ptr] == `MUL_7) &&
                     ((dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MUL) ||
                      (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULH) ||
                      (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULHSU) ||
                      (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULHU))) begin
              rob_head_wait_nonmem_issued_not_exm_mul_cycles <= rob_head_wait_nonmem_issued_not_exm_mul_cycles + 1;
            end
            else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) ||
                     (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `ITYPE)) begin
              rob_head_wait_nonmem_issued_not_exm_alu_cycles <= rob_head_wait_nonmem_issued_not_exm_alu_cycles + 1;
            end
            else if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `BTYPE) begin
              rob_head_wait_nonmem_issued_not_exm_branch_cycles <= rob_head_wait_nonmem_issued_not_exm_branch_cycles + 1;
            end
            else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `JAL) ||
                     (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `JALR)) begin
              rob_head_wait_nonmem_issued_not_exm_jal_cycles <= rob_head_wait_nonmem_issued_not_exm_jal_cycles + 1;
            end
            else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `LUI) ||
                     (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `AUIPC)) begin
              rob_head_wait_nonmem_issued_not_exm_u_cycles <= rob_head_wait_nonmem_issued_not_exm_u_cycles + 1;
            end
            else begin
              rob_head_wait_nonmem_issued_not_exm_other_cycles <= rob_head_wait_nonmem_issued_not_exm_other_cycles + 1;
              if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `LOAD) begin
                rob_head_wait_nonmem_i2e_other_load_opcode_cycles <= rob_head_wait_nonmem_i2e_other_load_opcode_cycles + 1;
              end
              else if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `STORE) begin
                rob_head_wait_nonmem_i2e_other_store_opcode_cycles <= rob_head_wait_nonmem_i2e_other_store_opcode_cycles + 1;
              end
              else if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == 7'b0000000) begin
                rob_head_wait_nonmem_i2e_other_zero_opcode_cycles <= rob_head_wait_nonmem_i2e_other_zero_opcode_cycles + 1;
              end
              else if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == 7'b1110011) begin
                rob_head_wait_nonmem_i2e_other_system_opcode_cycles <= rob_head_wait_nonmem_i2e_other_system_opcode_cycles + 1;
              end
              else if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == 7'b0001111) begin
                rob_head_wait_nonmem_i2e_other_fence_opcode_cycles <= rob_head_wait_nonmem_i2e_other_fence_opcode_cycles + 1;
              end
              else begin
                rob_head_wait_nonmem_i2e_other_unknown_opcode_cycles <= rob_head_wait_nonmem_i2e_other_unknown_opcode_cycles + 1;
                if (rob_head_wait_nonmem_i2e_other_sample_count < 12) begin
                  rob_head_wait_nonmem_i2e_other_sample_count <= rob_head_wait_nonmem_i2e_other_sample_count + 1;
                  $display("NONMEM_I2E_UNKNOWN_SAMPLE #%0d cycle=%0d tag=%0d pc=0x%08h opcode=%07b funct3=%03b funct7=%07b rd=%0d issued=%0d exm=%0d cpl=%0d done=%0d is_load=%0d is_store=%0d",
                           rob_head_wait_nonmem_i2e_other_sample_count,
                           cycle_count,
                           dut.u_rob.head_ptr,
                           pc_by_rob[dut.u_rob.head_ptr],
                           dut.u_rob.ent_opcode[dut.u_rob.head_ptr],
                           dut.u_rob.ent_funct3[dut.u_rob.head_ptr],
                           dut.u_rob.ent_funct7[dut.u_rob.head_ptr],
                           dut.u_rob.ent_arch_rd[dut.u_rob.head_ptr],
                           issue_seen_by_rob[dut.u_rob.head_ptr],
                           exm_seen_by_rob[dut.u_rob.head_ptr],
                           cpl_seen_by_rob[dut.u_rob.head_ptr],
                           done_seen_by_rob[dut.u_rob.head_ptr],
                           dut.u_rob.ent_is_load[dut.u_rob.head_ptr],
                           dut.u_rob.ent_is_store[dut.u_rob.head_ptr]);
                end
              end
            end
          end
          else if (!cpl_seen_by_rob[dut.u_rob.head_ptr]) begin
            rob_head_wait_nonmem_exm_not_cpl_cycles <= rob_head_wait_nonmem_exm_not_cpl_cycles + 1;
          end
          if (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `BTYPE) begin
            rob_head_wait_branch_cycles <= rob_head_wait_branch_cycles + 1;
          end
          else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) &&
                   (dut.u_rob.ent_funct7[dut.u_rob.head_ptr] == `MUL_7) &&
                   ((dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `DIV) ||
                    (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `DIVU) ||
                    (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `REM) ||
                    (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `REMU))) begin
            rob_head_wait_div_cycles <= rob_head_wait_div_cycles + 1;
          end
          else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) &&
                   (dut.u_rob.ent_funct7[dut.u_rob.head_ptr] == `MUL_7) &&
                   ((dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MUL) ||
                    (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULH) ||
                    (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULHSU) ||
                    (dut.u_rob.ent_funct3[dut.u_rob.head_ptr] == `MULHU))) begin
            rob_head_wait_mul_cycles <= rob_head_wait_mul_cycles + 1;
          end
          else if ((dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `RTYPE) ||
                   (dut.u_rob.ent_opcode[dut.u_rob.head_ptr] == `ITYPE)) begin
            rob_head_wait_alu_cycles <= rob_head_wait_alu_cycles + 1;
          end
        end
      end

`ifdef USE_DHRYSTONE_SRC_COPY
      if (beebs_debug_head && (dut.es_pc_flush || dut.es_backend_flush)) begin
        $display("REDIRECT_EVENT cycle=%0d r1=%b br1=%b pc1=0x%08h target1=0x%08h r2=%b br2=%b pc2=0x%08h target2=0x%08h pipe_flush=%b backend_flush=%b",
                 cycle_count,
                 dut.es_pc_redirect_1,
                 dut.es_pc_redirect_is_branch_1,
                 dut.es_pc_redirect_pc_1,
                 dut.es_pc_redirect_target_1,
                 dut.es_pc_redirect_2,
                 dut.es_pc_redirect_is_branch_2,
                 dut.es_pc_redirect_pc_2,
                 dut.es_pc_redirect_target_2,
                 dut.es_pipe_flush,
                 dut.es_backend_flush);
      end
`endif

      if (dut.rob_o_commit_valid_1 &&
          !dut.rob_o_commit_valid_2 &&
          dut.u_rob.next_valid &&
          !dut.u_rob.next_done) begin
        rob_commit1_blocked_cycles <= rob_commit1_blocked_cycles + 1;
      end

      if (dut.u_rob.head_valid && dut.u_rob.head_done) begin
        if (dut.u_rob.next_valid && dut.u_rob.next_done) begin
          commit2_possible_cycles <= commit2_possible_cycles + 1;
          if (dut.rob_o_commit_valid_1 && dut.rob_o_commit_valid_2) begin
            commit2_success_cycles <= commit2_success_cycles + 1;
          end
        end
        else if (dut.u_rob.next_valid && !dut.u_rob.next_done) begin
          commit2_blocked_next_not_done_cycles <= commit2_blocked_next_not_done_cycles + 1;
        end
        else begin
          commit2_blocked_next_invalid_cycles <= commit2_blocked_next_invalid_cycles + 1;
        end
      end

      if (dut.rob_o_full) begin
        rob_full_cycles <= rob_full_cycles + 1;
      end

    if (dut.u_rob.used_count >= (`ROB_SIZE - 2)) begin
        rob_near_full_cycles <= rob_near_full_cycles + 1;
      end

      if (debug_store_flow) begin
        if (dut.ren_fire_1) begin
          $display("%0t REN1 pc=0x%08h opcode=0x%02h branch=%b jal=%b rd=%0d",
                   $time,
                   dut.ds1_rs_o_pc,
                   dut.ds1_rs_o_opcode,
                   dut.ds1_rs_o_branch,
                   dut.ds1_rs_o_jal,
                   dut.ds1_rs_o_addr_rd);
        end
        if (dut.ren_fire_2) begin
          $display("%0t REN2 pc=0x%08h opcode=0x%02h branch=%b jal=%b rd=%0d",
                   $time,
                   dut.ds2_rs_o_pc,
                   dut.ds2_rs_o_opcode,
                   dut.ds2_rs_o_branch,
                   dut.ds2_rs_o_jal,
                   dut.ds2_rs_o_addr_rd);
        end
        if (dut.exm_valid_1 && dut.exm_memwrite_1) begin
`ifdef USE_DHRYSTONE_SRC_COPY
          $display("%0t STORE_FILL1 pc=0x%08h sq=%0d addr=0x%08h data=0x%08h mask=%b es_data_rt=0x%08h is3_vrt=0x%08h",
                   $time,
                   dut.is3_pc_1,
                   dut.exm_sq_idx_1,
                   dut.exm_alu_value_1,
                   dut.exm_store_data_1,
                   dut.exm_store_mask_1,
                   dut.es1_o_data_rt,
                   dut.is3_vrt_1);
`else
          $display("%0t STORE_FILL1 pc=0x%08h sq=%0d addr=0x%08h data=0x%08h mask=%b is3_vrt=0x%08h",
                   $time,
                   dut.is3_pc_1,
                   dut.exm_sq_idx_1,
                   dut.exm_alu_value_1,
                   dut.exm_store_data_1,
                   dut.exm_store_mask_1,
                   dut.is3_vrt_1);
`endif
        end
        if (dut.exm_valid_2 && dut.exm_memwrite_2) begin
`ifdef USE_DHRYSTONE_SRC_COPY
          $display("%0t STORE_FILL2 pc=0x%08h sq=%0d addr=0x%08h data=0x%08h mask=%b es_data_rt=0x%08h is3_vrt=0x%08h",
                   $time,
                   dut.is3_pc_2,
                   dut.exm_sq_idx_2,
                   dut.exm_alu_value_2,
                   dut.exm_store_data_2,
                   dut.exm_store_mask_2,
                   dut.es2_o_data_rt,
                   dut.is3_vrt_2);
`else
          $display("%0t STORE_FILL2 pc=0x%08h sq=%0d addr=0x%08h data=0x%08h mask=%b is3_vrt=0x%08h",
                   $time,
                   dut.is3_pc_2,
                   dut.exm_sq_idx_2,
                   dut.exm_alu_value_2,
                   dut.exm_store_data_2,
                   dut.exm_store_mask_2,
                   dut.is3_vrt_2);
`endif
        end
        if (dut.sq_o_mem_ce_1) begin
          $display("%0t STORE_COMMIT1 addr=0x%08h data=0x%08h mask=%b",
                   $time,
                   dut.sq_o_mem_addr_1,
                   dut.sq_o_mem_data_1,
                   dut.sq_o_mem_mask_1);
        end
        if (dut.sq_o_mem_ce_2) begin
          $display("%0t STORE_COMMIT2 addr=0x%08h data=0x%08h mask=%b",
                   $time,
                   dut.sq_o_mem_addr_2,
                   dut.sq_o_mem_data_2,
                   dut.sq_o_mem_mask_2);
        end
      end
    end

    if (dut.rob_o_commit_valid_1) begin
      stage_latency_tmp = cycle_count - done_cycle_by_rob[dut.rob_o_commit_tag_1];
      record_stage_latency(stage_kind_by_rob[dut.rob_o_commit_tag_1], 3, stage_latency_tmp);
      stage_kind_by_rob[dut.rob_o_commit_tag_1] <= 0;
      issue_seen_by_rob[dut.rob_o_commit_tag_1] <= 1'b0;
      exm_seen_by_rob[dut.rob_o_commit_tag_1] <= 1'b0;
      cpl_seen_by_rob[dut.rob_o_commit_tag_1] <= 1'b0;
      done_seen_by_rob[dut.rob_o_commit_tag_1] <= 1'b0;
      next_commit_count = next_commit_count + 1;
      if (print_commits) begin
        $display("%0t COMMIT1 #%0d pc=0x%08h rd=%0d data=%0d",
                 $time,
                 next_commit_count,
                 pc_by_rob[dut.rob_o_commit_tag_1],
                 dut.rob_o_commit_arch_rd_1,
                 dut.rob_o_commit_data_1);
      end
      if (print_markers &&
          ((dut.rob_o_commit_arch_rd_1 == 5'd28) ||
           (dut.rob_o_commit_arch_rd_1 == 5'd29) ||
           (dut.rob_o_commit_arch_rd_1 == 5'd30))) begin
        $display("%0t MARKER1 #%0d pc=0x%08h rd=x%0d data=%0d",
                 $time,
                 next_commit_count,
                 pc_by_rob[dut.rob_o_commit_tag_1],
                 dut.rob_o_commit_arch_rd_1,
                 dut.rob_o_commit_data_1);
      end
      if (dut.rob_o_commit_arch_rd_1 == 5'd30) begin
        next_scoreboard_x30 = dut.rob_o_commit_data_1;
        if (dhrystone_report && (dut.rob_o_commit_data_1 == 32'd1) && !dhrystone_active) begin
          dhrystone_active <= 1'b1;
          dhrystone_done <= 1'b0;
          dhrystone_start_cycle <= cycle_count + 1;
          dhrystone_start_commit <= next_commit_count;
        end else if (dhrystone_report && (dut.rob_o_commit_data_1 == 32'd2) && dhrystone_active) begin
          dhrystone_active <= 1'b0;
          dhrystone_done <= 1'b1;
          dhrystone_cycle_count <= (cycle_count + 1) - dhrystone_start_cycle;
          dhrystone_commit_count <= next_commit_count - dhrystone_start_commit;
        end
      end
      if (beebs_stop_on_x29 &&
          (dut.rob_o_commit_arch_rd_1 == 5'd29) &&
          ((dut.rob_o_commit_data_1 == 32'd1) ||
           (dut.rob_o_commit_data_1 == 32'hffffffff))) begin
        beebs_done <= 1'b1;
        beebs_status <= dut.rob_o_commit_data_1;
      end
      if (!ignore_scoreboard &&
          (dut.rob_o_commit_arch_rd_1 == 5'd31) &&
          (dut.rob_o_commit_data_1 == 32'hffffffff)) begin
        scoreboard_seen <= 1'b1;
        scoreboard_x31 <= dut.rob_o_commit_data_1;
        scoreboard_x30 <= next_scoreboard_x30;
        scoreboard_commit_count <= next_commit_count;
        scoreboard_cycle_count <= cycle_count + 1;
        scoreboard_done <= 1'b1;
      end else if (!ignore_scoreboard &&
                   !scoreboard_seen &&
                   (dut.rob_o_commit_arch_rd_1 == 5'd31) &&
                   (dut.rob_o_commit_data_1 == 32'd1)) begin
        scoreboard_seen <= 1'b1;
        scoreboard_x31 <= dut.rob_o_commit_data_1;
        scoreboard_x30 <= next_scoreboard_x30;
        scoreboard_commit_count <= next_commit_count;
        scoreboard_cycle_count <= cycle_count + 1;
      end
    end

    if (dut.rob_o_commit_valid_2) begin
      stage_latency_tmp = cycle_count - done_cycle_by_rob[dut.rob_o_commit_tag_2];
      record_stage_latency(stage_kind_by_rob[dut.rob_o_commit_tag_2], 3, stage_latency_tmp);
      stage_kind_by_rob[dut.rob_o_commit_tag_2] <= 0;
      issue_seen_by_rob[dut.rob_o_commit_tag_2] <= 1'b0;
      exm_seen_by_rob[dut.rob_o_commit_tag_2] <= 1'b0;
      cpl_seen_by_rob[dut.rob_o_commit_tag_2] <= 1'b0;
      done_seen_by_rob[dut.rob_o_commit_tag_2] <= 1'b0;
      next_commit_count = next_commit_count + 1;
      if (print_commits) begin
        $display("%0t COMMIT2 #%0d pc=0x%08h rd=%0d data=%0d",
                 $time,
                 next_commit_count,
                 pc_by_rob[dut.rob_o_commit_tag_2],
                 dut.rob_o_commit_arch_rd_2,
                 dut.rob_o_commit_data_2);
      end
      if (print_markers &&
          ((dut.rob_o_commit_arch_rd_2 == 5'd28) ||
           (dut.rob_o_commit_arch_rd_2 == 5'd29) ||
           (dut.rob_o_commit_arch_rd_2 == 5'd30))) begin
        $display("%0t MARKER2 #%0d pc=0x%08h rd=x%0d data=%0d",
                 $time,
                 next_commit_count,
                 pc_by_rob[dut.rob_o_commit_tag_2],
                 dut.rob_o_commit_arch_rd_2,
                 dut.rob_o_commit_data_2);
      end
      if (dut.rob_o_commit_arch_rd_2 == 5'd30) begin
        next_scoreboard_x30 = dut.rob_o_commit_data_2;
        if (dhrystone_report && (dut.rob_o_commit_data_2 == 32'd1) && !dhrystone_active) begin
          dhrystone_active <= 1'b1;
          dhrystone_done <= 1'b0;
          dhrystone_start_cycle <= cycle_count + 1;
          dhrystone_start_commit <= next_commit_count;
        end else if (dhrystone_report && (dut.rob_o_commit_data_2 == 32'd2) && dhrystone_active) begin
          dhrystone_active <= 1'b0;
          dhrystone_done <= 1'b1;
          dhrystone_cycle_count <= (cycle_count + 1) - dhrystone_start_cycle;
          dhrystone_commit_count <= next_commit_count - dhrystone_start_commit;
        end
      end
      if (beebs_stop_on_x29 &&
          (dut.rob_o_commit_arch_rd_2 == 5'd29) &&
          ((dut.rob_o_commit_data_2 == 32'd1) ||
           (dut.rob_o_commit_data_2 == 32'hffffffff))) begin
        beebs_done <= 1'b1;
        beebs_status <= dut.rob_o_commit_data_2;
      end
      if (!ignore_scoreboard &&
          (dut.rob_o_commit_arch_rd_2 == 5'd31) &&
          (dut.rob_o_commit_data_2 == 32'hffffffff)) begin
        scoreboard_seen <= 1'b1;
        scoreboard_x31 <= dut.rob_o_commit_data_2;
        scoreboard_x30 <= next_scoreboard_x30;
        scoreboard_commit_count <= next_commit_count;
        scoreboard_cycle_count <= cycle_count + 1;
        scoreboard_done <= 1'b1;
      end else if (!ignore_scoreboard &&
                   !scoreboard_seen &&
                   (dut.rob_o_commit_arch_rd_2 == 5'd31) &&
                   (dut.rob_o_commit_data_2 == 32'd1)) begin
        scoreboard_seen <= 1'b1;
        scoreboard_x31 <= dut.rob_o_commit_data_2;
        scoreboard_x30 <= next_scoreboard_x30;
        scoreboard_commit_count <= next_commit_count;
        scoreboard_cycle_count <= cycle_count + 1;
      end
    end

    if (scoreboard_seen &&
        (scoreboard_x31 == 32'd1) &&
        (scoreboard_settle_i >= SCOREBOARD_SETTLE_CYCLES)) begin
      scoreboard_done <= 1'b1;
    end

    scoreboard_x30_shadow <= next_scoreboard_x30;
    commit_count <= next_commit_count;
  end
end

always @(posedge dp_clk) begin
  if (dp_rstn && debug_load_flow) begin
    if (dut.ru_rs_dispatch_fire_1 && (dut.ru_rs_pc_1 <= 32'h00000090)) begin
      $display("%0t DISP1 pc=0x%08h op=%b rd=x%0d prs=%0d prt=%0d prd=%0d ready=(%b,%b) data=(%0d,%0d) rob=%0d",
               $time,
               dut.ru_rs_pc_1,
               dut.ru_rs_opcode_1,
               dut.ru_rs_addr_rd_1,
               dut.ru_rs_prs_1,
               dut.ru_rs_prt_1,
               dut.ru_rs_new_prd_1,
               dut.ru_rs_prs_ready_1,
               dut.ru_rs_prt_ready_1,
               dut.ru_rs_data_rs_1,
               dut.ru_rs_data_rt_1,
               dut.rob_o_alloc_tag_1);
    end

    if (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 <= 32'h00000090)) begin
      $display("%0t DISP2 pc=0x%08h op=%b rd=x%0d prs=%0d prt=%0d prd=%0d ready=(%b,%b) data=(%0d,%0d) rob=%0d",
               $time,
               dut.ru_rs_pc_2,
               dut.ru_rs_opcode_2,
               dut.ru_rs_addr_rd_2,
               dut.ru_rs_prs_2,
               dut.ru_rs_prt_2,
               dut.ru_rs_new_prd_2,
               dut.ru_rs_prs_ready_2,
               dut.ru_rs_prt_ready_2,
               dut.ru_rs_data_rs_2,
               dut.ru_rs_data_rt_2,
               dut.rob_o_alloc_tag_2);
    end

    if (dut.is3_valid_1 && (dut.is3_pc_1 <= 32'h00000090)) begin
      $display("%0t ISSUE1 pc=0x%08h op=%b prd=%0d rob=%0d vrs=%0d vrt=%0d imm=0x%08h",
               $time,
               dut.is3_pc_1,
               dut.is3_opcode_1,
               dut.is3_prd_1,
               dut.is3_rob_tag_1,
               dut.is3_vrs_1,
               dut.is3_vrt_1,
               dut.is3_imm_1);
    end

    if (dut.is3_valid_2 && (dut.is3_pc_2 <= 32'h00000090)) begin
      $display("%0t ISSUE2 pc=0x%08h op=%b prd=%0d rob=%0d vrs=%0d vrt=%0d imm=0x%08h",
               $time,
               dut.is3_pc_2,
               dut.is3_opcode_2,
               dut.is3_prd_2,
               dut.is3_rob_tag_2,
               dut.is3_vrs_2,
               dut.is3_vrt_2,
               dut.is3_imm_2);
    end

    if (dut.lq_o_complete_valid_1 || dut.lq_o_complete_valid_2) begin
      $display("%0t LQOUT v=(%b,%b) acc=(%b,%b) rob=(%0d,%0d) prd=(%0d,%0d) addr=(0x%08h,0x%08h) raw=(%0d,%0d)",
               $time,
               dut.lq_o_complete_valid_1,
               dut.lq_o_complete_valid_2,
               dut.lq_i_complete_accept_1,
               dut.lq_i_complete_accept_2,
               dut.lq_o_complete_rob_tag_1,
               dut.lq_o_complete_rob_tag_2,
               dut.lq_o_complete_prd_1,
               dut.lq_o_complete_prd_2,
               dut.lq_o_complete_addr_1,
               dut.lq_o_complete_addr_2,
               dut.lq_o_complete_raw_data_1,
               dut.lq_o_complete_raw_data_2);
    end

    if (dut.lq_mwb_complete_valid_1 || dut.lq_mwb_complete_valid_2) begin
      $display("%0t LQMWB v=(%b,%b) mwb_accept=(%b,%b) rob=(%0d,%0d) prd=(%0d,%0d) addr=(0x%08h,0x%08h) raw=(%0d,%0d)",
               $time,
               dut.lq_mwb_complete_valid_1,
               dut.lq_mwb_complete_valid_2,
               dut.lq_mwb_accept_1,
               dut.lq_mwb_accept_2,
               dut.lq_mwb_complete_rob_tag_1,
               dut.lq_mwb_complete_rob_tag_2,
               dut.lq_mwb_complete_prd_1,
               dut.lq_mwb_complete_prd_2,
               dut.lq_mwb_complete_addr_1,
               dut.lq_mwb_complete_addr_2,
               dut.lq_mwb_complete_raw_data_1,
               dut.lq_mwb_complete_raw_data_2);
    end

    if (dut.cpl_valid_1 || dut.cpl_valid_2) begin
      $display("%0t CPL v=(%b,%b) op=(%b,%b) rob=(%0d,%0d) prd=(%0d,%0d) data=(%0d,%0d)",
               $time,
               dut.cpl_valid_1,
               dut.cpl_valid_2,
               dut.cpl_opcode_1,
               dut.cpl_opcode_2,
               dut.cpl_tag_1,
               dut.cpl_tag_2,
               dut.cpl_prd_1,
               dut.cpl_prd_2,
               dut.cpl_data_1,
               dut.cpl_data_2);
    end

    if (dut.rs_wakeup_mem_valid_1 || dut.rs_wakeup_mem_valid_2) begin
      $display("%0t MEMWU v=(%b,%b) prd=(%0d,%0d) data=(%0d,%0d)",
               $time,
               dut.rs_wakeup_mem_valid_1,
               dut.rs_wakeup_mem_valid_2,
               dut.rs_wakeup_mem_prd_1,
               dut.rs_wakeup_mem_prd_2,
               dut.rs_wakeup_mem_data_1,
               dut.rs_wakeup_mem_data_2);
    end
  end

  if (dp_rstn && debug_verbose) begin
    if ((dut.pc_im_o_pc_1 >= debug_pc_lo && dut.pc_im_o_pc_1 <= debug_pc_hi) ||
        (dut.pc_im_o_pc_2 >= debug_pc_lo && dut.pc_im_o_pc_2 <= debug_pc_hi) ||
        (dut.pc_o_pc_1 >= debug_pc_lo && dut.pc_o_pc_1 <= debug_pc_hi) ||
        (dut.pc_o_pc_2 >= debug_pc_lo && dut.pc_o_pc_2 <= debug_pc_hi)) begin
      $display("%0t FE pc_ce=%b fe_ce=%b hold=%b dec_load=%b pc=(%h,%h) pcim_ce=%b pcim=(%h,%h) im_ce=%b",
               $time,
               dut.pc_ce,
               dut.fe_ce,
               dut.decode_hold,
               dut.decode_can_load,
               dut.pc_o_pc_1,
               dut.pc_o_pc_2,
               dut.pc_im_o_ce,
               dut.pc_im_o_pc_1,
               dut.pc_im_o_pc_2,
               dut.im_o_ce);
    end

    if (dut.is3_valid_1 && (dut.is3_opcode_1 == `BTYPE) &&
        (dut.is3_pc_1 >= debug_pc_lo) &&
        (dut.is3_pc_1 <= debug_pc_hi)) begin
      $display("%0t BRDEBUG1 pc=%h funct3=%b rs_val=%0d rt_val=%0d imm=%h change_pc=%b target=%h",
               $time,
               dut.is3_pc_1,
               dut.is3_funct3_1,
               dut.is3_vrs_1,
               dut.is3_vrt_1,
               dut.is3_imm_1,
               dut.es1_o_change_pc,
               dut.es1_o_alu_pc);
    end

    if (dut.is3_valid_2 && (dut.is3_opcode_2 == `BTYPE) &&
        (dut.is3_pc_2 >= debug_pc_lo) &&
        (dut.is3_pc_2 <= debug_pc_hi)) begin
      $display("%0t BRDEBUG2 pc=%h funct3=%b rs_val=%0d rt_val=%0d imm=%h change_pc=%b target=%h",
               $time,
               dut.is3_pc_2,
               dut.is3_funct3_2,
               dut.is3_vrs_2,
               dut.is3_vrt_2,
               dut.is3_imm_2,
               dut.es2_o_change_pc,
               dut.es2_o_alu_pc);
    end

    if (dut.ru_rs_dispatch_fire_1 && (dut.ru_rs_opcode_1 == `BTYPE) &&
        (dut.ru_rs_pc_1 >= debug_pc_lo) &&
        (dut.ru_rs_pc_1 <= debug_pc_hi)) begin
      $display("%0t RSDISPATCH1 pc=%h funct3=%b ars=%0d art=%0d prs=%0d prt=%0d prs_ready=%b prt_ready=%b rs_data=%0d rt_data=%0d",
               $time,
               dut.ru_rs_pc_1,
               dut.ru_rs_funct3_1,
               dut.ru_rs_addr_rs_1,
               dut.ru_rs_addr_rt_1,
               dut.ru_rs_prs_1,
               dut.ru_rs_prt_1,
               dut.ru_rs_prs_ready_1,
               dut.ru_rs_prt_ready_1,
               dut.ru_rs_data_rs_1,
               dut.ru_rs_data_rt_1);
    end

    if (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_opcode_2 == `BTYPE) &&
        (dut.ru_rs_pc_2 >= debug_pc_lo) &&
        (dut.ru_rs_pc_2 <= debug_pc_hi)) begin
      $display("%0t RSDISPATCH2 pc=%h funct3=%b ars=%0d art=%0d prs=%0d prt=%0d prs_ready=%b prt_ready=%b rs_data=%0d rt_data=%0d",
               $time,
               dut.ru_rs_pc_2,
               dut.ru_rs_funct3_2,
               dut.ru_rs_addr_rs_2,
               dut.ru_rs_addr_rt_2,
               dut.ru_rs_prs_2,
               dut.ru_rs_prt_2,
               dut.ru_rs_prs_ready_2,
               dut.ru_rs_prt_ready_2,
               dut.ru_rs_data_rs_2,
               dut.ru_rs_data_rt_2);
    end

    if (dut.ren_fire_1 &&
        (dut.ds1_rs_o_pc >= debug_pc_lo) &&
        (dut.ds1_rs_o_pc <= debug_pc_hi) &&
        ((dut.ds1_rs_o_addr_rd == 5'd7) ||
         (dut.ds1_rs_o_addr_rd == 5'd11) ||
         (dut.ds1_rs_o_addr_rd == 5'd12) ||
         (dut.ds1_rs_o_addr_rd == 5'd13) ||
         (dut.ds1_rs_o_addr_rd == 5'd14))) begin
      $display("%0t RENDEBUG1 pc=%h rd=x%0d old_prd=%0d new_prd=%0d regwrite=%b opcode=%b funct3=%b",
               $time,
               dut.ds1_rs_o_pc,
               dut.ds1_rs_o_addr_rd,
               dut.ru_o_old_prd_1,
               dut.ru_o_new_prd_1,
               dut.ds1_rs_o_regwrite,
               dut.ds1_rs_o_opcode,
               dut.ds1_rs_o_funct3);
    end

    if (dut.ren_fire_2 &&
        (dut.ds2_rs_o_pc >= debug_pc_lo) &&
        (dut.ds2_rs_o_pc <= debug_pc_hi) &&
        ((dut.ds2_rs_o_addr_rd == 5'd7) ||
         (dut.ds2_rs_o_addr_rd == 5'd11) ||
         (dut.ds2_rs_o_addr_rd == 5'd12) ||
         (dut.ds2_rs_o_addr_rd == 5'd13) ||
         (dut.ds2_rs_o_addr_rd == 5'd14))) begin
      $display("%0t RENDEBUG2 pc=%h rd=x%0d old_prd=%0d new_prd=%0d regwrite=%b opcode=%b funct3=%b",
               $time,
               dut.ds2_rs_o_pc,
               dut.ds2_rs_o_addr_rd,
               dut.ru_o_old_prd_2,
               dut.ru_o_new_prd_2,
               dut.ds2_rs_o_regwrite,
               dut.ds2_rs_o_opcode,
               dut.ds2_rs_o_funct3);
    end

    if (dut.ren_fire_1 &&
        (dut.ds1_rs_o_pc >= debug_pc_lo) &&
        (dut.ds1_rs_o_pc <= debug_pc_hi)) begin
      $display("%0t T9REN1 pc=%h rd=x%0d rs=x%0d rt=x%0d old_prd=%0d new_prd=%0d opcode=%b funct3=%b",
               $time,
               dut.ds1_rs_o_pc,
               dut.ds1_rs_o_addr_rd,
               dut.ds1_rs_o_addr_rs,
               dut.ds1_rs_o_addr_rt,
               dut.ru_o_old_prd_1,
               dut.ru_o_new_prd_1,
               dut.ds1_rs_o_opcode,
               dut.ds1_rs_o_funct3);
    end

    if (dut.ren_fire_2 &&
        (dut.ds2_rs_o_pc >= debug_pc_lo) &&
        (dut.ds2_rs_o_pc <= debug_pc_hi)) begin
      $display("%0t T9REN2 pc=%h rd=x%0d rs=x%0d rt=x%0d old_prd=%0d new_prd=%0d opcode=%b funct3=%b",
               $time,
               dut.ds2_rs_o_pc,
               dut.ds2_rs_o_addr_rd,
               dut.ds2_rs_o_addr_rs,
               dut.ds2_rs_o_addr_rt,
               dut.ru_o_old_prd_2,
               dut.ru_o_new_prd_2,
               dut.ds2_rs_o_opcode,
               dut.ds2_rs_o_funct3);
    end

    if ((dut.ren_fire_1 && (dut.ds1_rs_o_pc == DEBUG_ADD_T5_PC)) ||
        (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC))) begin
      $display("%0t PRFDBG pc84 ren1=%b ren2=%b lane=%0d prs=%0d prt=%0d data_rs=%0d data_rt=%0d wb1=(%b,%0d,%0d) wb2=(%b,%0d,%0d) ready_rs=%b ready_rt=%b",
               $time,
               dut.ren_fire_1,
               dut.ren_fire_2,
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? 2 : 1,
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? dut.ru_o_prs_2 : dut.ru_o_prs_1,
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? dut.ru_o_prt_2 : dut.ru_o_prt_1,
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? dut.ru_o_data_rs_2 : dut.ru_o_data_rs_1,
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? dut.ru_o_data_rt_2 : dut.ru_o_data_rt_1,
               dut.wb_valid_1,
               dut.wb_tag_1,
               dut.wb_data_1,
               dut.wb_valid_2,
               dut.wb_tag_2,
               dut.wb_data_2,
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? dut.prd_ready[dut.ru_o_prs_2] : dut.prd_ready[dut.ru_o_prs_1],
               (dut.ren_fire_2 && (dut.ds2_rs_o_pc == DEBUG_ADD_T5_PC)) ? dut.prd_ready[dut.ru_o_prt_2] : dut.prd_ready[dut.ru_o_prt_1]);
    end

    if ((dut.ru_rs_dispatch_fire_1 && (dut.ru_rs_pc_1 == DEBUG_ADD_T5_PC)) ||
        (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC))) begin
      $display("%0t B2DBG pc84 disp1=%b disp2=%b lane=%0d prs=%0d prt=%0d data_rs=%0d data_rt=%0d ready_rs=%b ready_rt=%b",
               $time,
               dut.ru_rs_dispatch_fire_1,
               dut.ru_rs_dispatch_fire_2,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? 2 : 1,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? dut.ru_rs_prs_2 : dut.ru_rs_prs_1,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? dut.ru_rs_prt_2 : dut.ru_rs_prt_1,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? dut.ru_rs_data_rs_2 : dut.ru_rs_data_rs_1,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? dut.ru_rs_data_rt_2 : dut.ru_rs_data_rt_1,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? dut.ru_rs_prs_ready_2 : dut.ru_rs_prs_ready_1,
               (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_pc_2 == DEBUG_ADD_T5_PC)) ? dut.ru_rs_prt_ready_2 : dut.ru_rs_prt_ready_1);
    end

    if (dut.ru_rs_dispatch_fire_1 &&
        (dut.ru_rs_pc_1 >= debug_pc_lo) &&
        (dut.ru_rs_pc_1 <= debug_pc_hi)) begin
      $display("%0t T9DISP1 pc=%h rd=x%0d prs=%0d prt=%0d prd=%0d prs_ready=%b prt_ready=%b rs_data=%0d rt_data=%0d rob=%0d opcode=%b funct3=%b",
               $time,
               dut.ru_rs_pc_1,
               dut.ru_rs_addr_rd_1,
               dut.ru_rs_prs_1,
               dut.ru_rs_prt_1,
               dut.ru_rs_new_prd_1,
               dut.ru_rs_prs_ready_1,
               dut.ru_rs_prt_ready_1,
               dut.ru_rs_data_rs_1,
               dut.ru_rs_data_rt_1,
                dut.rs_rob_tag_1,
               dut.ru_rs_opcode_1,
               dut.ru_rs_funct3_1);
    end

    if (dut.ru_rs_dispatch_fire_2 &&
        (dut.ru_rs_pc_2 >= debug_pc_lo) &&
        (dut.ru_rs_pc_2 <= debug_pc_hi)) begin
      $display("%0t T9DISP2 pc=%h rd=x%0d prs=%0d prt=%0d prd=%0d prs_ready=%b prt_ready=%b rs_data=%0d rt_data=%0d rob=%0d opcode=%b funct3=%b",
               $time,
               dut.ru_rs_pc_2,
               dut.ru_rs_addr_rd_2,
               dut.ru_rs_prs_2,
               dut.ru_rs_prt_2,
               dut.ru_rs_new_prd_2,
               dut.ru_rs_prs_ready_2,
               dut.ru_rs_prt_ready_2,
               dut.ru_rs_data_rs_2,
               dut.ru_rs_data_rt_2,
                dut.rs_rob_tag_2,
               dut.ru_rs_opcode_2,
               dut.ru_rs_funct3_2);
    end

    if (dut.is3_valid_1 &&
        (dut.is3_pc_1 >= debug_pc_lo) &&
        (dut.is3_pc_1 <= debug_pc_hi)) begin
      $display("%0t T9ISS1 pc=%h prd=%0d rob=%0d vrs=%0d vrt=%0d imm=%h opcode=%b funct3=%b",
               $time,
               dut.is3_pc_1,
               dut.is3_prd_1,
               dut.is3_rob_tag_1,
               dut.is3_vrs_1,
               dut.is3_vrt_1,
               dut.is3_imm_1,
               dut.is3_opcode_1,
               dut.is3_funct3_1);
    end

    if (dut.is3_valid_2 &&
        (dut.is3_pc_2 >= debug_pc_lo) &&
        (dut.is3_pc_2 <= debug_pc_hi)) begin
      $display("%0t T9ISS2 pc=%h prd=%0d rob=%0d vrs=%0d vrt=%0d imm=%h opcode=%b funct3=%b",
               $time,
               dut.is3_pc_2,
               dut.is3_prd_2,
               dut.is3_rob_tag_2,
               dut.is3_vrs_2,
               dut.is3_vrt_2,
               dut.is3_imm_2,
               dut.is3_opcode_2,
               dut.is3_funct3_2);
    end

    if (dut.wb_valid_1) begin
      $display("%0t WBDEBUG1 prd=%0d data=%0d",
               $time,
               dut.wb_tag_1,
               dut.wb_data_1);
    end

    if (dut.wb_valid_2) begin
      $display("%0t WBDEBUG2 prd=%0d data=%0d",
               $time,
               dut.wb_tag_2,
               dut.wb_data_2);
    end

    if (dut.rob_o_commit_valid_1 &&
        ((dut.rob_o_commit_arch_rd_1 == 5'd7) ||
         (dut.rob_o_commit_arch_rd_1 == 5'd11) ||
         (dut.rob_o_commit_arch_rd_1 == 5'd12) ||
         (dut.rob_o_commit_arch_rd_1 == 5'd13) ||
         (dut.rob_o_commit_arch_rd_1 == 5'd14) ||
         (dut.rob_o_commit_arch_rd_1 == 5'd30) ||
         (dut.rob_o_commit_arch_rd_1 == 5'd31))) begin
      $display("%0t WATCH1 rd=%0d data=%0d",
               $time,
               dut.rob_o_commit_arch_rd_1,
               dut.rob_o_commit_data_1);
    end

    if (dut.rob_o_commit_valid_2 &&
        ((dut.rob_o_commit_arch_rd_2 == 5'd7) ||
         (dut.rob_o_commit_arch_rd_2 == 5'd11) ||
         (dut.rob_o_commit_arch_rd_2 == 5'd12) ||
         (dut.rob_o_commit_arch_rd_2 == 5'd13) ||
         (dut.rob_o_commit_arch_rd_2 == 5'd14) ||
         (dut.rob_o_commit_arch_rd_2 == 5'd30) ||
         (dut.rob_o_commit_arch_rd_2 == 5'd31))) begin
      $display("%0t WATCH2 rd=%0d data=%0d",
               $time,
               dut.rob_o_commit_arch_rd_2,
               dut.rob_o_commit_data_2);
    end
  end
end
endmodule
