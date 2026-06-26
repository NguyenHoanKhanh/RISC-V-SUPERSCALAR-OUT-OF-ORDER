`include "./source/datapath.v"

module tb;
    reg d_clk, d_rst;
    reg d_i_ce;
    wire [`DWIDTH - 1 : 0] wb_ds1_o_data_rd, wb_ds2_o_data_rd;
    wire [`PC_WIDTH - 1 : 0] pc_o_pc_1, pc_o_pc_2;

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
        $dumpfile("./waveform/datapath.vcd");
        $dumpvars(0, tb);
    end
    
    initial begin
        d_clk = 1'b0;
    end
    always #5 d_clk = ~d_clk;

    task reset (input integer counter);
        begin
            d_rst = 1'b0;
            repeat(counter) @(posedge d_clk);
            d_rst = 1'b1;
        end
    endtask

    initial begin
        reset(2);
        @(posedge d_clk);
        d_i_ce = 1'b1;
        repeat(10) @(posedge d_clk);
        $finish;
    end

    initial begin  
        $monitor("%0t: PC_1 = %0d, PC_2 = %0d, instr_1 = %h, instr_2 = %h, wb_ds1_o_data_rd = %d, wb_ds2_o_data_rd = %d", 
            $time, pc_o_pc_1, pc_o_pc_2, d.im_ds1_o_instr, d.im_ds2_o_instr, wb_ds1_o_data_rd, wb_ds2_o_data_rd);
    end
endmodule