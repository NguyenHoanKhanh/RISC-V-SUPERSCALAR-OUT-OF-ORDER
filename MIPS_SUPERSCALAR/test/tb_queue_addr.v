`include "./source/queue_addr.v"

module tb;
    reg qa_clk, qa_rst;
    reg qa_i_we, qa_i_re;
    reg [`AWIDTH - 1 : 0] qa_i_addr_rs, qa_i_addr_rt;
    wire [`AWIDTH - 1 : 0] qa_o_addr_rs, qa_o_addr_rt;

    integer i;
    queue_addr q (
        .qa_clk(qa_clk), 
        .qa_rst(qa_rst), 
        .qa_i_addr_rs(qa_i_addr_rs), 
        .qa_i_addr_rt(qa_i_addr_rt), 
        .qa_i_we(qa_i_we), 
        .qa_i_re(qa_i_re), 
        .qa_o_addr_rs(qa_o_addr_rs), 
        .qa_o_addr_rt(qa_o_addr_rt)
    );

    initial begin
        i = 0;
        qa_clk = 1'b0;
        qa_i_we = 1'b0;
        qa_i_re = 1'b0;
        qa_i_addr_rs = {`AWIDTH{1'b0}};
        qa_i_addr_rt = {`AWIDTH{1'b0}};
    end
    always #5 qa_clk = ~qa_clk;

    task reset (input integer counter);
        begin
            qa_rst = 1'b0;
            repeat(counter) @(posedge qa_clk);
            qa_rst = 1'b1;
        end
    endtask

    task load (input integer counter);
        begin
            qa_i_we = 1'b1;
            for (i = 0; i < counter; i = i + 1) begin
                @(posedge qa_clk);
                qa_i_addr_rs = i;
                qa_i_addr_rt = i;
            end
            qa_i_we = 1'b0;
            @(posedge qa_clk);
        end
    endtask

    task display (input integer counter);
        begin
            qa_i_re = 1'b1;
            for (i = 0; i < counter; i = i + 1) begin
                @(posedge qa_clk);
                $display($time, " ", " qa_i_re = %b, qa_o_addr_rs = %d, qa_o_addr_rt = %d", qa_i_re, qa_o_addr_rs, qa_o_addr_rt);
            end
            qa_i_re = 1'b0;
            @(posedge qa_clk);
        end
    endtask 

    initial begin
        reset(2);
        load(10);
        @(posedge qa_clk);
        display(10);
        @(posedge qa_clk);
        $finish;
    end
endmodule