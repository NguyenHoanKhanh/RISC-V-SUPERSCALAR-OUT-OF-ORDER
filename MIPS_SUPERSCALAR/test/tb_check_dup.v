`include "./source/check_dup_rd.v"

module tb;
    reg [`AWIDTH - 1 : 0] cd_i_addr_rd_1, cd_i_addr_rs_2, cd_i_addr_rt_2;
    wire cd_o_change_instr;

    check_dup cd (
        .cd_i_addr_rd_1(cd_i_addr_rd_1), 
        .cd_i_addr_rs_2(cd_i_addr_rs_2), 
        .cd_i_addr_rt_2(cd_i_addr_rt_2), 
        .cd_o_change_instr(cd_o_change_instr)
    );

    initial begin 
        cd_i_addr_rd_1 = 0;
        cd_i_addr_rs_2 = 0;
        cd_i_addr_rt_2 = 0;
    end

    initial begin
        #5;
        cd_i_addr_rd_1 = 5;
        #5;
        cd_i_addr_rs_2 = 9;
        cd_i_addr_rt_2 = 10;
        #5;
        cd_i_addr_rs_2 = 5;
        cd_i_addr_rt_2 = 10;
        #5;
        cd_i_addr_rs_2 = 9;
        cd_i_addr_rt_2 = 5;
        #5;
        cd_i_addr_rs_2 = 5;
        cd_i_addr_rt_2 = 5;
        #20; $finish;
    end

    initial begin
        $monitor($time, " ", " cd_o_change_instr = %b", cd_o_change_instr);
    end
endmodule