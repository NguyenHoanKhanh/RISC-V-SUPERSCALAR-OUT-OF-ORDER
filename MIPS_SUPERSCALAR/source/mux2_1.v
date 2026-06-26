`ifndef MUX2_1_V
`define MUX2_1_V
`include "./source/header.vh"

module mux2_1(
    mx_i_addr_rd, mx_i_addr_rt, mx_i_reg_dst, mx_o_addr_rd
);
    input mx_i_reg_dst;
    input [`AWIDTH - 1 : 0] mx_i_addr_rd, mx_i_addr_rt;
    output [`AWIDTH - 1 : 0] mx_o_addr_rd;

    assign mx_o_addr_rd = (mx_i_reg_dst) ? mx_i_addr_rd : mx_i_addr_rt;
endmodule
`endif 