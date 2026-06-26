`ifndef REGIS_V
`define REGIS_V
`include "./source/header.vh"
module regis (
    r_clk, r_rst, r_wr_en_1, r_wr_en_2, r_i_addr_rd_1, r_i_addr_rd_2, r_i_data_rd_1, r_i_data_rd_2, 
    r_i_addr_rs_1, r_i_addr_rt_1, r_i_addr_rs_2, r_i_addr_rt_2, r_o_data_rs_1, r_o_data_rs_2, r_o_data_rt_1, 
    r_o_data_rt_2, r_i_issue_addr_rs_1, r_i_issue_addr_rt_1, r_i_issue_addr_rs_2, r_i_issue_addr_rt_2,
    r_o_issue_data_rs_1, r_o_issue_data_rt_1, r_o_issue_data_rs_2, r_o_issue_data_rt_2
);
    input r_clk, r_rst;
    input r_wr_en_1, r_wr_en_2;
    input [`AWIDTH - 1 : 0] r_i_addr_rd_1, r_i_addr_rd_2;
    input [`DWIDTH - 1 : 0] r_i_data_rd_1, r_i_data_rd_2;
    input [`AWIDTH - 1 : 0] r_i_addr_rs_1, r_i_addr_rs_2;
    input [`AWIDTH - 1 : 0] r_i_addr_rt_1, r_i_addr_rt_2;
    input [`AWIDTH - 1 : 0] r_i_issue_addr_rs_1, r_i_issue_addr_rt_1;
    input [`AWIDTH - 1 : 0] r_i_issue_addr_rs_2, r_i_issue_addr_rt_2;
    output [`DWIDTH - 1 : 0] r_o_data_rs_1, r_o_data_rs_2;
    output [`DWIDTH - 1 : 0] r_o_data_rt_1, r_o_data_rt_2;
    output [`DWIDTH - 1 : 0] r_o_issue_data_rs_1, r_o_issue_data_rt_1;
    output [`DWIDTH - 1 : 0] r_o_issue_data_rs_2, r_o_issue_data_rt_2;

    integer i;
    reg [`DWIDTH - 1 : 0] data_reg [(2 ** `AWIDTH) - 1 : 0];

    always @(negedge r_clk, negedge r_rst) begin
        if (!r_rst) begin
            for (i = 0; i < 1 << `AWIDTH; i = i + 1) begin
                data_reg[i] <= i;
            end
        end
        else begin
            if (r_wr_en_1 && (r_i_addr_rd_1 != {`AWIDTH{1'b0}})) begin
                data_reg[r_i_addr_rd_1] <= r_i_data_rd_1;
            end
            if (r_wr_en_2 && (r_i_addr_rd_2 != {`AWIDTH{1'b0}})) begin
                data_reg[r_i_addr_rd_2] <= r_i_data_rd_2;
            end
            data_reg[0] <= {`DWIDTH{1'b0}};
        end
    end

    assign r_o_data_rs_1 = (r_i_addr_rs_1 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_addr_rs_1];
    assign r_o_data_rt_1 = (r_i_addr_rt_1 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_addr_rt_1];
    assign r_o_data_rs_2 = (r_i_addr_rs_2 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_addr_rs_2];
    assign r_o_data_rt_2 = (r_i_addr_rt_2 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_addr_rt_2];
    assign r_o_issue_data_rs_1 = (r_i_issue_addr_rs_1 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_issue_addr_rs_1];
    assign r_o_issue_data_rt_1 = (r_i_issue_addr_rt_1 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_issue_addr_rt_1];
    assign r_o_issue_data_rs_2 = (r_i_issue_addr_rs_2 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_issue_addr_rs_2];
    assign r_o_issue_data_rt_2 = (r_i_issue_addr_rt_2 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} : data_reg[r_i_issue_addr_rt_2];
endmodule
`endif 
