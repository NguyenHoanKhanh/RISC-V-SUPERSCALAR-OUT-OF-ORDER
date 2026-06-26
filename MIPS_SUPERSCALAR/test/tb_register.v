`include "./source/register.v"

module tb_register;
    reg r_clk, r_rst;
    reg r_wr_en;
    reg [`AWIDTH - 1 : 0] r_i_addr_rd;
    reg [`DWIDTH - 1 : 0] r_i_data_rd; 
    reg [`AWIDTH - 1 : 0] r_i_addr_rs, r_i_addr_rt;
    wire [`DWIDTH - 1 : 0] r_o_data_rs, r_o_data_rt; 

    integer i;
    register r_eg (
        .r_clk(r_clk), 
        .r_rst(r_rst), 
        .r_wr_en(r_wr_en), 
        .r_i_addr_rd(r_i_addr_rd), 
        .r_i_data_rd(r_i_data_rd), 
        .r_i_addr_rs(r_i_addr_rs), 
        .r_i_addr_rt(r_i_addr_rt), 
        .r_o_data_rs(r_o_data_rs), 
        .r_o_data_rt(r_o_data_rt) 
    );

    initial begin
        $dumpfile("./waveform/register.vcd");
        $dumpvars(0, tb_register);
    end

    initial begin
        i = 0;
        r_clk = 1'b0; 
        
    end
    always #5 r_clk = ~r_clk;

    task reset (input integer counter);
        begin
            r_rst = 1'b1;
            repeat(counter) @(posedge r_clk);
            r_rst = 1'b0;
        end
    endtask

    task load_1 (input integer counter);
        begin
            r_wr_en = 1'b1;
            for (i = 0; i < counter; i = i + 1) begin
                @(posedge r_clk);
                r_i_addr_rd = i;
                r_i_data_rd = i;
            end
            @(posedge r_clk);
            r_wr_en = 1'b0;
        end
    endtask
    
    task display (input integer counter);
        begin   
            for (i = 0; i < counter; i = i + 1) begin
                r_i_addr_rs = i;
                r_i_addr_rt = i;
                @(posedge r_clk);
                $display($time, " ", " r_i_addr_rs = %d, r_o_data_rs = %d\n", r_i_addr_rs, r_o_data_rs);
            end
        end
    endtask

    initial begin
        reset(2);
        load_1(20);
        @(posedge r_clk);
        display(20);
        @(posedge r_clk);
        $finish;
    end
endmodule