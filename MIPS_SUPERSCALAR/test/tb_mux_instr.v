`include "./source/mux2_1_check_queue.v"

module tb_mux_instr;
    reg mx_i_check_queue;
    reg [`IWIDTH - 1 : 0] mx_i_queue_instr;
    reg [`IWIDTH - 1 : 0] mx_i_mem_instr;
    wire [`IWIDTH - 1 : 0] mx_o_instr;

    mux2_1_check_queue m (
        .mx_i_queue_instr(mx_i_queue_instr), 
        .mx_i_mem_instr(mx_i_mem_instr), 
        .mx_i_check_queue(mx_i_check_queue), 
        .mx_o_instr(mx_o_instr)
    );

    initial begin
        #5; 
        mx_i_check_queue = 1'b1;
        mx_i_queue_instr = 32'hcafecafe;
        mx_i_mem_instr = 32'hfafafafa;
        #5;
        mx_i_check_queue = 1'b0;
        mx_i_queue_instr = 32'hcafecafe;
        mx_i_mem_instr = 32'hfafafafa;
    end

    initial begin
        $monitor($time, " ", " mx_o_instr = %h", mx_o_instr);
    end
endmodule