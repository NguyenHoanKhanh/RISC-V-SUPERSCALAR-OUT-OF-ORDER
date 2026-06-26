`include "./source/prog_counter.v"
module tb_pc;
    reg pc_i_clk, pc_i_rst;
    reg pc_i_ce;
    reg [`PC_WIDTH - 1 : 0] pc_i_pc_1, pc_i_pc_2;
    reg pc_i_change_instr;
    reg pc_i_change_pc_1, pc_i_change_pc_2;
    wire [`PC_WIDTH - 1 : 0] pc_o_pc_1, pc_o_pc_2;
    wire pc_o_ce;

    program_counter pc (
        .pc_i_clk(pc_i_clk), 
        .pc_i_rst(pc_i_rst), 
        .pc_i_ce(pc_i_ce), 
        .pc_i_pc_1(pc_i_pc_1),
        .pc_i_pc_2(pc_i_pc_2),
        .pc_i_change_pc_1(pc_i_change_pc_1),
        .pc_i_change_pc_2(pc_i_change_pc_2), 
        .pc_i_change_instr(pc_i_change_instr),
        .pc_o_pc_1(pc_o_pc_1),
        .pc_o_pc_2(pc_o_pc_2),
        .pc_o_ce(pc_o_ce)
    );

    initial begin
        $dumpfile("./waveform/pc.vcd");
        $dumpvars(0, tb_pc);
    end

    initial begin
        pc_i_clk = 1'b0;
        pc_i_ce = 1'b0;
        pc_i_change_pc_1 = 1'b0;
        pc_i_change_pc_2 = 1'b0;
        pc_i_pc_1 = {`PC_WIDTH{1'b0}};
        pc_i_pc_2 = {`PC_WIDTH{1'b0}};
    end
    always #5 pc_i_clk = ~pc_i_clk;

    task reset (input integer counter);
        begin   
            pc_i_rst = 1'b0;
            repeat(counter) @(posedge pc_i_clk);
            pc_i_rst = 1'b1;
        end
    endtask

    initial begin
        reset(2);
        pc_i_ce = 1'b1;
        @(posedge pc_i_clk);
        pc_i_change_instr = 1'b1;
        @(posedge pc_i_clk);
        @(posedge pc_i_clk)
        pc_i_change_instr = 1'b0;
        #200; $finish;
    end

    initial begin
        $monitor($time, " ", " pc_1 = %d, pc_2 = %d, ce = %b", pc_o_pc_1, pc_o_pc_2, pc_o_ce);
    end
endmodule