`include "header_nomul.vh"
`timescale 1ns/1ps

module PRF (
  input pr_clk, 
  input pr_rstn,
  
  input [`RAT_SIZE - 1 : 0] pr_id_rs_1,
  input [`RAT_SIZE - 1 : 0] pr_id_rt_1,
  input [`RAT_SIZE - 1 : 0] pr_id_rs_2,
  input [`RAT_SIZE - 1 : 0] pr_id_rt_2,
  output [`DWIDTH - 1 : 0] pr_data_rs_1,
  output [`DWIDTH - 1 : 0] pr_data_rt_1,
  output [`DWIDTH - 1 : 0] pr_data_rs_2,
  output [`DWIDTH - 1 : 0] pr_data_rt_2,

  input pr_reg_write_1,
  input [`RAT_SIZE - 1 : 0] pr_tag_rd_1,
  input [`DWIDTH - 1 : 0] pr_data_wb_1,
  input pr_reg_write_2,
  input [`RAT_SIZE - 1 : 0] pr_tag_rd_2,
  input [`DWIDTH - 1 : 0] pr_data_wb_2
);

  reg [`DWIDTH - 1 : 0] reg_value [0 : (2**`RAT_SIZE) - 1];
  integer i;

  always @(posedge pr_clk, negedge pr_rstn) begin
    if (!pr_rstn) begin
      for (i = 0; i < 2**`RAT_SIZE; i = i + 1) begin
        reg_value[i] <= i;
      end
    end
    else begin
      if (pr_reg_write_1 && (pr_tag_rd_1 != {`RAT_SIZE{1'b0}})) begin
        reg_value[pr_tag_rd_1] <= pr_data_wb_1;
      end
      if (pr_reg_write_2 && (pr_tag_rd_2 != {`RAT_SIZE{1'b0}})) begin
        reg_value[pr_tag_rd_2] <= pr_data_wb_2;
      end
    end
  end

  assign pr_data_rs_1 =
    (pr_id_rs_1 == {`RAT_SIZE{1'b0}}) ? {`DWIDTH{1'b0}} :
    (pr_reg_write_1 && (pr_tag_rd_1 == pr_id_rs_1)) ? pr_data_wb_1 :
    (pr_reg_write_2 && (pr_tag_rd_2 == pr_id_rs_1)) ? pr_data_wb_2 :
    reg_value[pr_id_rs_1];

  assign pr_data_rt_1 =
    (pr_id_rt_1 == {`RAT_SIZE{1'b0}}) ? {`DWIDTH{1'b0}} :
    (pr_reg_write_1 && (pr_tag_rd_1 == pr_id_rt_1)) ? pr_data_wb_1 :
    (pr_reg_write_2 && (pr_tag_rd_2 == pr_id_rt_1)) ? pr_data_wb_2 :
    reg_value[pr_id_rt_1];

  assign pr_data_rs_2 =
    (pr_id_rs_2 == {`RAT_SIZE{1'b0}}) ? {`DWIDTH{1'b0}} :
    (pr_reg_write_1 && (pr_tag_rd_1 == pr_id_rs_2)) ? pr_data_wb_1 :
    (pr_reg_write_2 && (pr_tag_rd_2 == pr_id_rs_2)) ? pr_data_wb_2 :
    reg_value[pr_id_rs_2];

  assign pr_data_rt_2 =
    (pr_id_rt_2 == {`RAT_SIZE{1'b0}}) ? {`DWIDTH{1'b0}} :
    (pr_reg_write_1 && (pr_tag_rd_1 == pr_id_rt_2)) ? pr_data_wb_1 :
    (pr_reg_write_2 && (pr_tag_rd_2 == pr_id_rt_2)) ? pr_data_wb_2 :
    reg_value[pr_id_rt_2];
endmodule