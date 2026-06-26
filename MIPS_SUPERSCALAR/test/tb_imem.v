`include "./source/imem.v"

module tb_imem;
    reg im_clk, im_rst;
    reg im_i_ce;
    reg [`PC_WIDTH - 1 : 0] im_i_addr_1, im_i_addr_2;
    reg im_i_change_instr;
    wire [`IWIDTH - 1 : 0] im_o_instr_1, im_o_instr_2;
    wire im_o_ce;

    imem im (
        .im_clk(im_clk), 
        .im_rst(im_rst), 
        .im_i_ce(im_i_ce), 
        .im_i_addr_1(im_i_addr_1), 
        .im_o_instr_1(im_o_instr_1), 
        .im_o_instr_2(im_o_instr_2), 
        .im_o_ce(im_o_ce)
    );

    initial begin
        $dumpfile("./waveform/imem.vcd");
        $dumpvars(0, tb_imem);
    end

    initial begin
        im_clk = 1'b0;
        im_i_ce = 1'b0;
        im_i_addr_1 = {`PC_WIDTH{1'b0}};
        im_i_addr_2 = {`PC_WIDTH{1'b0}};
        im_i_change_instr = 1'b0;
    end
    always #5 im_clk = ~im_clk;

    task reset (input integer counter);
        begin
            im_rst = 1'b0;
            repeat(counter) @(posedge im_clk);
            im_rst = 1'b1;
        end
    endtask
    
    initial begin
        reset(2);
        @(posedge im_clk);
        im_i_ce = 1'b1;
        im_i_addr_1 = 0;
        @(posedge im_clk);
        im_i_change_instr = 1'b1;
        im_i_addr_1 = 12;
        @(posedge im_clk);
        im_i_change_instr = 1'b0;
        #20; $finish;
    end

    initial begin 
        $monitor($time, " ", " im_o_instr_1 = %h, im_o_instr_2 = %h, im_o_ce = %b", im_o_instr_1, im_o_instr_2, im_o_ce);
    end
endmodule