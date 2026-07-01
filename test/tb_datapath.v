`ifdef USE_1CYCLE
`include "./src/datapath.v"
`elsif USE_SRC2
`include "./src_2/datapath_fix.v"
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
    localparam [`PC_WIDTH - 1 : 0] DEBUG_PC_LO = 32'h00000000;
    localparam [`PC_WIDTH - 1 : 0] DEBUG_PC_HI = 32'h000000c0;
    localparam [`PC_WIDTH - 1 : 0] DEBUG_ADD_T5_PC = 32'h00000084;
    reg print_commits;
    reg print_profile;
    reg print_raw_regs;
    reg debug_verbose;
    reg raw_result;
    reg ignore_scoreboard;
    reg no_commit_limit;
    reg beebs_stop_on_x29;
    reg beebs_debug_head;
    reg beebs_done;
    reg [`DWIDTH - 1 : 0] beebs_status;
    integer max_drain_cycles;
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
        debug_verbose = 1'b0;
        raw_result = 1'b0;
        ignore_scoreboard = 1'b0;
        no_commit_limit = 1'b0;
        beebs_stop_on_x29 = 1'b0;
        beebs_debug_head = 1'b0;
        beebs_done = 1'b0;
        beebs_status = {`DWIDTH{1'b0}};
        max_drain_cycles = DRAIN_CYCLES;
        arf_display_addr_1 = {`AWIDTH{1'b0}};
        arf_display_addr_2 = {`AWIDTH{1'b0}};
        print_commits = $test$plusargs("PRINT_COMMITS");
        print_profile = $test$plusargs("PRINT_PROFILE");
        print_raw_regs = $test$plusargs("PRINT_RAW_REGS");
        debug_verbose = $test$plusargs("DEBUG_VERBOSE");
        raw_result = $test$plusargs("RAW_RESULT");
        ignore_scoreboard = $test$plusargs("IGNORE_SCOREBOARD");
        no_commit_limit = $test$plusargs("NO_COMMIT_LIMIT");
        beebs_stop_on_x29 = $test$plusargs("BEEBS_STOP_ON_X29");
        beebs_debug_head = $test$plusargs("BEEBS_DEBUG_HEAD");
        if (!$value$plusargs("MAX_CYCLES=%d", max_drain_cycles)) begin
          max_drain_cycles = DRAIN_CYCLES;
        end
    end

    always #5 dp_clk = ~dp_clk;

    initial begin
        $dumpfile("sim/datapath.vcd");
        $dumpvars(0, tb_datapath);
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
      $display("==========================================");
      $finish;
    end

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
        $display("BEEBS_HEAD_DEBUG cycle=%0d pc1=0x%08h pc2=0x%08h head=%0d valid=%0d done=%0d opcode=%07b funct3=%03b funct7=%07b rd=%0d new_prd=%0d used=%0d",
                 cycle_count,
                 dp_o_pc_1,
                 dp_o_pc_2,
                 dut.u_rob.head_ptr,
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
integer decode_hold_rs_full_cycles;
integer decode_hold_rob_full_cycles;
integer decode_hold_no_decode_load_cycles;
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
integer cpl_latency_tmp;
integer issue_cycle_by_rob [0:`ROB_SIZE-1];
integer issue_kind_by_rob [0:`ROB_SIZE-1];
integer stage_kind_by_rob [0:`ROB_SIZE-1];
integer exm_cycle_by_rob [0:`ROB_SIZE-1];
integer cpl_cycle_by_rob [0:`ROB_SIZE-1];
integer done_cycle_by_rob [0:`ROB_SIZE-1];
reg issue_seen_by_rob [0:`ROB_SIZE-1];
reg exm_seen_by_rob [0:`ROB_SIZE-1];
reg cpl_seen_by_rob [0:`ROB_SIZE-1];
reg done_seen_by_rob [0:`ROB_SIZE-1];
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
    $display("STALL BREAKDOWN:");
    $display("decode_hold_rs_full       = %0d", decode_hold_rs_full_cycles);
    $display("decode_hold_rob_full      = %0d", decode_hold_rob_full_cycles);
    $display("decode_hold_no_dec_load   = %0d", decode_hold_no_decode_load_cycles);
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
  decode_hold_rs_full_cycles = 0;
  decode_hold_rob_full_cycles = 0;
  decode_hold_no_decode_load_cycles = 0;
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
    issue_seen_by_rob[lat_i] = 1'b0;
    exm_seen_by_rob[lat_i] = 1'b0;
    cpl_seen_by_rob[lat_i] = 1'b0;
    done_seen_by_rob[lat_i] = 1'b0;
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
    fetch_stall_cycles <= 0;
    decode_hold_cycles <= 0;
    dispatch0_cycles <= 0;
    dispatch1_cycles <= 0;
    dispatch2_cycles <= 0;
    commit0_cycles <= 0;
    commit1_cycles <= 0;
    commit2_cycles <= 0;
    branch_flush_count <= 0;
    decode_hold_rs_full_cycles <= 0;
    decode_hold_rob_full_cycles <= 0;
    decode_hold_no_decode_load_cycles <= 0;
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
      end

      case ({dut.ru_rs_dispatch_fire_2, dut.ru_rs_dispatch_fire_1})
        2'b00: dispatch0_cycles <= dispatch0_cycles + 1;
        2'b01,
        2'b10: dispatch1_cycles <= dispatch1_cycles + 1;
        2'b11: dispatch2_cycles <= dispatch2_cycles + 1;
      endcase

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
      end

      case ({dut.is3_valid_2, dut.is3_valid_1})
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

        if (dut.is3_valid_1) begin
          issue_cycle_by_rob[dut.is3_rob_tag_1] <= cycle_count;
          issue_seen_by_rob[dut.is3_rob_tag_1] <= 1'b1;
          exm_seen_by_rob[dut.is3_rob_tag_1] <= 1'b0;
          cpl_seen_by_rob[dut.is3_rob_tag_1] <= 1'b0;
          done_seen_by_rob[dut.is3_rob_tag_1] <= 1'b0;
          if ((dut.is3_opcode_1 == `RTYPE) &&
              (dut.is3_funct7_1 == `MUL_7) &&
              ((dut.is3_funct3_1 == `DIV) ||
             (dut.is3_funct3_1 == `DIVU) ||
               (dut.is3_funct3_1 == `REM) ||
               (dut.is3_funct3_1 == `REMU))) begin
            issue_kind_by_rob[dut.is3_rob_tag_1] <= 2;
            stage_kind_by_rob[dut.is3_rob_tag_1] <= 2;
          end
          else if ((dut.is3_opcode_1 == `RTYPE) || (dut.is3_opcode_1 == `ITYPE)) begin
            issue_kind_by_rob[dut.is3_rob_tag_1] <= 1;
            stage_kind_by_rob[dut.is3_rob_tag_1] <= 1;
          end
          else begin
            issue_kind_by_rob[dut.is3_rob_tag_1] <= 0;
            stage_kind_by_rob[dut.is3_rob_tag_1] <= 0;
          end
        end

        if (dut.is3_valid_2) begin
          issue_cycle_by_rob[dut.is3_rob_tag_2] <= cycle_count;
          issue_seen_by_rob[dut.is3_rob_tag_2] <= 1'b1;
          exm_seen_by_rob[dut.is3_rob_tag_2] <= 1'b0;
          cpl_seen_by_rob[dut.is3_rob_tag_2] <= 1'b0;
          done_seen_by_rob[dut.is3_rob_tag_2] <= 1'b0;
          if ((dut.is3_opcode_2 == `RTYPE) &&
              (dut.is3_funct7_2 == `MUL_7) &&
              ((dut.is3_funct3_2 == `DIV) ||
             (dut.is3_funct3_2 == `DIVU) ||
               (dut.is3_funct3_2 == `REM) ||
               (dut.is3_funct3_2 == `REMU))) begin
            issue_kind_by_rob[dut.is3_rob_tag_2] <= 2;
            stage_kind_by_rob[dut.is3_rob_tag_2] <= 2;
          end
          else if ((dut.is3_opcode_2 == `RTYPE) || (dut.is3_opcode_2 == `ITYPE)) begin
            issue_kind_by_rob[dut.is3_rob_tag_2] <= 1;
            stage_kind_by_rob[dut.is3_rob_tag_2] <= 1;
          end
          else begin
            issue_kind_by_rob[dut.is3_rob_tag_2] <= 0;
            stage_kind_by_rob[dut.is3_rob_tag_2] <= 0;
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
        rs_issue_count_cur = {31'd0, dut.is3_valid_1} + {31'd0, dut.is3_valid_2};
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

        if (dut.is3_valid_1) begin
          rs_issue_age_1_cur = rob_age_distance(dut.is3_rob_tag_1, dut.u_rob.head_ptr);
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
          if (dut.is3_rob_tag_1 == dut.u_rob.head_ptr)
            rs_head_issued_cur = 1;
        end

        if (dut.is3_valid_2) begin
          rs_issue_age_2_cur = rob_age_distance(dut.is3_rob_tag_2, dut.u_rob.head_ptr);
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
          if (dut.is3_rob_tag_2 == dut.u_rob.head_ptr)
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

      if ((rs_ready_count_cur != 0) && !dut.is3_valid_1 && !dut.is3_valid_2) begin
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
        if ((dut.cpl_valid_1 && (dut.cpl_tag_1 == dut.u_rob.head_ptr)) ||
            (dut.cpl_valid_2 && (dut.cpl_tag_2 == dut.u_rob.head_ptr))) begin
          rob_head_wait_cpl_same_cycle_cycles <= rob_head_wait_cpl_same_cycle_cycles + 1;
        end
        else if (!issue_seen_by_rob[dut.u_rob.head_ptr]) begin
          rob_head_wait_not_issued_cycles <= rob_head_wait_not_issued_cycles + 1;
        end
        else if (!exm_seen_by_rob[dut.u_rob.head_ptr]) begin
          rob_head_wait_issued_not_exm_cycles <= rob_head_wait_issued_not_exm_cycles + 1;
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
        end
        else if (dut.u_rob.ent_is_store[dut.u_rob.head_ptr]) begin
          rob_head_wait_store_cycles <= rob_head_wait_store_cycles + 1;
        end
        else begin
          rob_head_wait_non_mem_cycles <= rob_head_wait_non_mem_cycles + 1;
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
        $display("%0t COMMIT1 #%0d rd=%0d data=%0d",
                 $time,
                 next_commit_count,
                 dut.rob_o_commit_arch_rd_1,
                 dut.rob_o_commit_data_1);
      end
      if (dut.rob_o_commit_arch_rd_1 == 5'd30) begin
        next_scoreboard_x30 = dut.rob_o_commit_data_1;
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
        $display("%0t COMMIT2 #%0d rd=%0d data=%0d",
                 $time,
                 next_commit_count,
                 dut.rob_o_commit_arch_rd_2,
                 dut.rob_o_commit_data_2);
      end
      if (dut.rob_o_commit_arch_rd_2 == 5'd30) begin
        next_scoreboard_x30 = dut.rob_o_commit_data_2;
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
  if (dp_rstn && debug_verbose) begin
    if ((dut.pc_im_o_pc_1 >= DEBUG_PC_LO && dut.pc_im_o_pc_1 <= DEBUG_PC_HI) ||
        (dut.pc_im_o_pc_2 >= DEBUG_PC_LO && dut.pc_im_o_pc_2 <= DEBUG_PC_HI) ||
        (dut.pc_o_pc_1 >= DEBUG_PC_LO && dut.pc_o_pc_1 <= DEBUG_PC_HI) ||
        (dut.pc_o_pc_2 >= DEBUG_PC_LO && dut.pc_o_pc_2 <= DEBUG_PC_HI)) begin
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

    if (dut.is3_valid_1 && (dut.is3_opcode_1 == `BTYPE)) begin
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

    if (dut.is3_valid_2 && (dut.is3_opcode_2 == `BTYPE)) begin
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

    if (dut.ru_rs_dispatch_fire_1 && (dut.ru_rs_opcode_1 == `BTYPE)) begin
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

    if (dut.ru_rs_dispatch_fire_2 && (dut.ru_rs_opcode_2 == `BTYPE)) begin
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
        (dut.ds1_rs_o_pc >= DEBUG_PC_LO) &&
        (dut.ds1_rs_o_pc <= DEBUG_PC_HI)) begin
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
        (dut.ds2_rs_o_pc >= DEBUG_PC_LO) &&
        (dut.ds2_rs_o_pc <= DEBUG_PC_HI)) begin
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
        (dut.ru_rs_pc_1 >= DEBUG_PC_LO) &&
        (dut.ru_rs_pc_1 <= DEBUG_PC_HI)) begin
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
               dut.rob_o_alloc_tag_1,
               dut.ru_rs_opcode_1,
               dut.ru_rs_funct3_1);
    end

    if (dut.ru_rs_dispatch_fire_2 &&
        (dut.ru_rs_pc_2 >= DEBUG_PC_LO) &&
        (dut.ru_rs_pc_2 <= DEBUG_PC_HI)) begin
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
               dut.rob_o_alloc_tag_2,
               dut.ru_rs_opcode_2,
               dut.ru_rs_funct3_2);
    end

    if (dut.is3_valid_1 &&
        (dut.is3_pc_1 >= DEBUG_PC_LO) &&
        (dut.is3_pc_1 <= DEBUG_PC_HI)) begin
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
        (dut.is3_pc_2 >= DEBUG_PC_LO) &&
        (dut.is3_pc_2 <= DEBUG_PC_HI)) begin
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
