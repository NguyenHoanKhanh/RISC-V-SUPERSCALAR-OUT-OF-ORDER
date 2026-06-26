`include "./source/verify.v"

module tb_verify;
    reg v_clk, v_rst;
    reg v_i_ce;
    wire [`PC_WIDTH - 1 : 0] v_o_pc_1, v_o_pc_2;
    wire [`IWIDTH - 1 : 0] v_o_instr_1, v_o_instr_2;
    // wire v_o_change_instr;

    verify v (
        .v_clk(v_clk), 
        .v_rst(v_rst), 
        .v_i_ce(v_i_ce), 
        .v_o_pc_1(v_o_pc_1), 
        .v_o_pc_2(v_o_pc_2),
        .v_o_instr_1(v_o_instr_1), 
        .v_o_instr_2(v_o_instr_2)
        // .v_o_change_instr(v_o_change_instr)
    );
    
    initial begin
        v_clk = 1'b0;
        v_i_ce = 1'b0;
    end
    always #5 v_clk = ~v_clk;

    initial begin
        $dumpfile("./waveform/verify.vcd");
        $dumpvars(0, tb_verify);
    end

    task reset (input integer counter);
        begin
            v_rst = 1'b0;
            repeat(counter) @(posedge v_clk);
            v_rst = 1'b1;
        end
    endtask

    initial begin
        reset(2);
        v_i_ce = 1'b1;
        #30; $finish;
    end

    initial begin
        $monitor($time, " ", " v_o_pc_1 = %d, v_o_instr_1 = %h, ds1_mx1_o_addr_rd = %d, ds1_mx1_o_addr_rt = %d, ds1_mx1_o_addr_rs = %d\n, v_o_pc_2 = %d,  v_o_instr_2 = %h, ds2_mx2_o_addr_rd = %d, ds2_mx2_o_addr_rt = %d, ds2_mx2_o_addr_rs = %d\n, v_o_change_instr = %b", 
            v_o_pc_1, v_o_instr_1, v.ds1_mx1_o_addr_rd, v.ds1_mx1_o_addr_rt, v.ds1_o_addr_rs, v_o_pc_2, v_o_instr_2, v.ds2_mx2_o_addr_rd, v.ds2_mx2_o_addr_rt, v.ds2_o_addr_rs, v.v_o_change_instr);
    end
endmodule