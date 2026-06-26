`timescale 1ns/1ps
`include "./source/data.v"

module tb;
    reg d_clk;
    reg d_rst;
    reg d_i_ce;
    wire [`DWIDTH - 1 : 0] wb_ds1_o_data_rd;
    wire [`DWIDTH - 1 : 0] wb_ds2_o_data_rd;
    wire [`PC_WIDTH - 1 : 0] pc_o_pc_1;
    wire [`PC_WIDTH - 1 : 0] pc_o_pc_2;

    integer cycles;
    integer commits;
    integer max_cycles;
    integer program_instrs;
    integer expected_commits;
    integer drain_cycles;
    integer raw_mode;
    integer print_commits;
    integer scoreboard_seen;
    integer scoreboard_x31;
    integer scoreboard_x30;
    integer raw_program_end_seen;
    integer raw_drain_count;
    integer queue_full_cycles;
    integer queue_conflict_cycles;
    integer queue_write_attempts;
    integer frontend_stall_cycles;
    integer queue_max_used;
    integer fetched_instr;
    integer nop_instr;
    integer useful_commit;
    integer i;

    localparam [`IWIDTH - 1 : 0] NOP_INSTR = 32'h00000013;

    datapath d (
        .d_clk(d_clk),
        .d_rst(d_rst),
        .d_i_ce(d_i_ce),
        .wb_ds1_o_data_rd(wb_ds1_o_data_rd),
        .wb_ds2_o_data_rd(wb_ds2_o_data_rd),
        .pc_o_pc_1(pc_o_pc_1),
        .pc_o_pc_2(pc_o_pc_2)
    );

    initial begin
        $dumpfile("./waveform/mips_benchmark.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        d_clk = 1'b0;
    end
    always #5 d_clk = ~d_clk;

    task reset(input integer counter);
        begin
            d_rst = 1'b1;
            @(posedge d_clk);
            d_rst = 1'b0;
            repeat(counter) @(posedge d_clk);
            d_rst = 1'b1;
        end
    endtask

    initial begin
        d_rst = 1'b1;
        d_i_ce = 1'b0;
        cycles = 0;
        commits = 0;
        scoreboard_seen = 0;
        scoreboard_x31 = 0;
        scoreboard_x30 = 0;
        raw_program_end_seen = 0;
        raw_drain_count = 0;
        queue_full_cycles = 0;
        queue_conflict_cycles = 0;
        queue_write_attempts = 0;
        frontend_stall_cycles = 0;
        queue_max_used = 0;
        fetched_instr = 0;
        nop_instr = 0;
        useful_commit = 0;
        max_cycles = 5000;
        program_instrs = 50;
        expected_commits = 50;
        drain_cycles = 200;
        raw_mode = 0;
        print_commits = 0;

        void_plusargs();
        reset(2);
        @(posedge d_clk);
        d_i_ce = 1'b1;
    end

    task void_plusargs;
        begin
            if (!$value$plusargs("MIPS_MAX_CYCLES=%d", max_cycles)) max_cycles = 5000;
            if (!$value$plusargs("MIPS_PROGRAM_INSTRS=%d", program_instrs)) program_instrs = 50;
            if (!$value$plusargs("MIPS_EXPECTED_COMMITS=%d", expected_commits)) expected_commits = program_instrs;
            if (!$value$plusargs("MIPS_DRAIN_CYCLES=%d", drain_cycles)) drain_cycles = 200;
            if ($test$plusargs("RAW_RESULT")) raw_mode = 1;
            if ($test$plusargs("PRINT_COMMITS")) print_commits = 1;
        end
    endtask

    always @(posedge d_clk or negedge d_rst) begin
        if (!d_rst) begin
            cycles <= 0;
            commits <= 0;
            scoreboard_seen <= 0;
            scoreboard_x31 <= 0;
            scoreboard_x30 <= 0;
            raw_program_end_seen <= 0;
            raw_drain_count <= 0;
            queue_full_cycles <= 0;
            queue_conflict_cycles <= 0;
            queue_write_attempts <= 0;
            frontend_stall_cycles <= 0;
            queue_max_used <= 0;
            fetched_instr <= 0;
            nop_instr <= 0;
            useful_commit <= 0;
        end
        else if (d_i_ce) begin
            cycles <= cycles + 1;
            update_raw_program_end;
            update_queue_profile;
            update_fetch_profile;

            if (print_commits && cycles < 80) begin
                $display("%0t MIPS CYCLE pc1=%0d pc2=%0d instr1=%h instr2=%h wb1=%0d rd1=%0d rw1=%0d wb2=%0d rd2=%0d rw2=%0d",
                    $time, pc_o_pc_1, pc_o_pc_2, d.im_ds1_o_instr, d.im_ds2_o_instr,
                    wb_ds1_o_data_rd, d.ms_wb1_o_addr_rd, d.ms_wb1_o_regwrite,
                    wb_ds2_o_data_rd, d.ms_wb2_o_addr_rd, d.ms_wb2_o_regwrite);
            end

            if (d.ms_wb1_o_regwrite && d.ms_wb1_o_addr_rd != 5'd0) begin
                commits = commits + 1;
                useful_commit = useful_commit + 1;
                if (print_commits) begin
                    $display("%0t MIPS COMMIT1 #%0d rd=%0d data=%0d regwrite=%0d",
                        $time, commits, d.ms_wb1_o_addr_rd, wb_ds1_o_data_rd, d.ms_wb1_o_regwrite);
                end
                check_scoreboard(d.ms_wb1_o_addr_rd, wb_ds1_o_data_rd);
            end

            if (d.ms_wb2_o_regwrite && d.ms_wb2_o_addr_rd != 5'd0) begin
                commits = commits + 1;
                useful_commit = useful_commit + 1;
                if (print_commits) begin
                    $display("%0t MIPS COMMIT2 #%0d rd=%0d data=%0d regwrite=%0d",
                        $time, commits, d.ms_wb2_o_addr_rd, wb_ds2_o_data_rd, d.ms_wb2_o_regwrite);
                end
                check_scoreboard(d.ms_wb2_o_addr_rd, wb_ds2_o_data_rd);
            end

            if (print_commits && (d.es1_ms_o_addr_rd != 5'd0 || d.es2_ms_o_addr_rd != 5'd0 ||
                d.ms_wb1_o_addr_rd != 5'd0 || d.ms_wb2_o_addr_rd != 5'd0)) begin
                $display("%0t MIPS WBDBG es1_rw=%0d es1_rd=%0d es2_rw=%0d es2_rd=%0d ms1_rw=%0d ms1_rd=%0d ms2_rw=%0d ms2_rd=%0d",
                    $time,
                    d.es1_ms_o_regwrite, d.es1_ms_o_addr_rd,
                    d.es2_ms_o_regwrite, d.es2_ms_o_addr_rd,
                    d.ms_wb1_o_regwrite, d.ms_wb1_o_addr_rd,
                    d.ms_wb2_o_regwrite, d.ms_wb2_o_addr_rd);
            end

            if (scoreboard_seen || cycles >= max_cycles ||
                (raw_mode && raw_program_end_seen && raw_drain_count >= drain_cycles)) begin
                finish_report;
            end
        end
    end

    task update_queue_profile;
        begin
            if (d.q.counter > queue_max_used) begin
                queue_max_used <= d.q.counter;
            end
            if (d.q.counter > (`QUEUE_SIZE - 2)) begin
                queue_full_cycles <= queue_full_cycles + 1;
            end
            if (d.q.conflict_1) begin
                queue_conflict_cycles <= queue_conflict_cycles + 1;
            end
            if (d.frontend_stall) begin
                frontend_stall_cycles <= frontend_stall_cycles + 1;
            end
            queue_write_attempts <= queue_write_attempts +
                (d.ds1_es1_o_ce ? 1 : 0) + (d.ds2_es2_o_ce ? 1 : 0);
        end
    endtask

    task update_fetch_profile;
        begin
            if (d.im_ds1_o_ce) begin
                fetched_instr <= fetched_instr + 1;
                if (d.im_ds1_o_instr == NOP_INSTR) begin
                    nop_instr <= nop_instr + 1;
                end
            end
            if (d.im_ds2_o_ce) begin
                fetched_instr <= fetched_instr + 1;
                if (d.im_ds2_o_instr == NOP_INSTR) begin
                    nop_instr <= nop_instr + 1;
                end
            end
        end
    endtask

    task update_raw_program_end;
        integer program_end_pc;
        begin
            program_end_pc = program_instrs * 4;
            if (raw_mode && !raw_program_end_seen &&
                (pc_o_pc_1 >= program_end_pc) && (pc_o_pc_2 >= program_end_pc)) begin
                raw_program_end_seen <= 1;
                raw_drain_count <= 0;
            end
            else if (raw_mode && raw_program_end_seen) begin
                raw_drain_count <= raw_drain_count + 1;
            end
        end
    endtask

    task check_scoreboard(input [`AWIDTH - 1 : 0] rd, input [`DWIDTH - 1 : 0] data);
        begin
            if (!scoreboard_seen && rd == 5'd31 && (data == 32'd1 || data == 32'hffffffff)) begin
                scoreboard_seen = 1;
                scoreboard_x31 = data;
                scoreboard_x30 = d.r_eg.data_reg[30];
            end
        end
    endtask

    task finish_report;
        real ipc;
        real fetch_ipc;
        real useful_fetch_ratio;
        real nop_ratio;
        begin
            ipc = (cycles > 0) ? (commits * 1.0 / cycles) : 0.0;
            fetch_ipc = (cycles > 0) ? (fetched_instr * 1.0 / cycles) : 0.0;
            nop_ratio = (fetched_instr > 0) ? (nop_instr * 100.0 / fetched_instr) : 0.0;
            useful_fetch_ratio = (fetched_instr > 0) ? (useful_commit * 100.0 / fetched_instr) : 0.0;
            $display("==========================================");
            $display("MIPS_SUPERSCALAR scoreboard: x31=%0d x30=%0d commits=%0d",
                d.r_eg.data_reg[31], d.r_eg.data_reg[30], commits);
            $display("MIPS_SUPERSCALAR PERF: cycles=%0d commits=%0d IPC=%0.3f", cycles, commits, ipc);
            $display("MIPS_SUPERSCALAR FETCH PROFILE: fetched_instr=%0d nop_instr=%0d non_nop_instr=%0d fetch_IPC=%0.3f nop_ratio=%0.2f%% useful_commit_ratio=%0.2f%%",
                fetched_instr, nop_instr, fetched_instr - nop_instr, fetch_ipc, nop_ratio, useful_fetch_ratio);
            if (raw_mode) begin
                $display("MIPS_SUPERSCALAR RAW PROGRAM: instrs=%0d expected_commits=%0d fetched_end=%0d drain_cycles=%0d",
                    program_instrs, expected_commits, raw_program_end_seen, raw_drain_count);
                $display("MIPS_SUPERSCALAR QUEUE PROFILE: max_used=%0d near_full_cycles=%0d conflict_cycles=%0d frontend_stall_cycles=%0d write_attempts=%0d",
                    queue_max_used, queue_full_cycles, queue_conflict_cycles, frontend_stall_cycles, queue_write_attempts);
            end
            if (scoreboard_seen && scoreboard_x31 == 32'd1) begin
                $display("MIPS_SUPERSCALAR RESULT: PASS");
            end
            else if (scoreboard_seen && scoreboard_x31 == 32'hffffffff) begin
                $display("MIPS_SUPERSCALAR RESULT: FAIL test_id=%0d", scoreboard_x30);
            end
            else if (raw_mode) begin
                $display("MIPS_SUPERSCALAR RAW RESULT MODE");
                if (commits < expected_commits) begin
                    $display("MIPS_SUPERSCALAR RAW WARNING: committed %0d / expected %0d regwrite instructions",
                        commits, expected_commits);
                end
                for (i = 0; i < 32; i = i + 1) begin
                    $display("x%0d = %0d (0x%08h)", i, d.r_eg.data_reg[i], d.r_eg.data_reg[i]);
                end
                $display("MIPS_SUPERSCALAR RESULT: RAW RUN COMPLETE, NO PASS/FAIL CHECK");
            end
            else begin
                $display("MIPS_SUPERSCALAR RESULT: INCOMPLETE or NO SCOREBOARD UPDATE");
            end
            $display("==========================================");
            $finish;
        end
    endtask
endmodule
