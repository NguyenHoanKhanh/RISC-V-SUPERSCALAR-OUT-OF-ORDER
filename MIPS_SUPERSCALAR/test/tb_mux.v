`include "./source/mux_des.v"

module tb_mux;
    reg md_reg_dst;
    reg [`AWIDTH - 1 : 0] md_i_addr_rd, md_i_addr_rt;
    wire [`AWIDTH - 1 : 0] md_o_addr_rd;

    mux_des md (
        .md_reg_dst(md_reg_dst), 
        .md_i_addr_rd(md_i_addr_rd), 
        .md_i_addr_rt(md_i_addr_rt),
        .md_o_addr_rd(md_o_addr_rd)
    );

    initial begin
        #10;
        md_reg_dst = 1'b0;
        md_i_addr_rt = 10;
        #10;
        md_reg_dst = 1'b1;
        md_i_addr_rd = 5;
        #10; $finish;
    end

    initial begin
        $monitor($time, " ", " md_o_addr_rd = %d", md_o_addr_rd);
    end
endmodule