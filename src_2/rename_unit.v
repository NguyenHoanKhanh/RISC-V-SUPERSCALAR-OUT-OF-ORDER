`timescale 1ns/1ps
`include "./src/RAT.v"
`include "./src/PRF.v"
// Add request signal for the write in ARF
module rename_unit (
  input ru_clk, 
  input ru_rstn,
  input ru_i_ce,

  input [`AWIDTH - 1 : 0] ru_i_addr_rs_1,
  input [`AWIDTH - 1 : 0] ru_i_addr_rt_1,
  input [`AWIDTH - 1 : 0] ru_i_addr_rd_1,
  input [`AWIDTH - 1 : 0] ru_i_addr_rs_2,
  input [`AWIDTH - 1 : 0] ru_i_addr_rt_2,
  input [`AWIDTH - 1 : 0] ru_i_addr_rd_2,

  output [`DWIDTH - 1 : 0] ru_o_data_rs_1,
  output [`DWIDTH - 1 : 0] ru_o_data_rt_1,
  output [`DWIDTH - 1 : 0] ru_o_data_rs_2,
  output [`DWIDTH - 1 : 0] ru_o_data_rt_2,
  output [`RAT_SIZE - 1 : 0] ru_o_prs_1,
  output [`RAT_SIZE - 1 : 0] ru_o_prt_1,
  output [`RAT_SIZE - 1 : 0] ru_o_old_prd_1,
  output [`RAT_SIZE - 1 : 0] ru_o_new_prd_1,
  output ru_o_alloc_valid_1,
  output ru_o_ce_1,
  output [`RAT_SIZE - 1 : 0] ru_o_prs_2,
  output [`RAT_SIZE - 1 : 0] ru_o_prt_2,
  output [`RAT_SIZE - 1 : 0] ru_o_old_prd_2,
  output [`RAT_SIZE - 1 : 0] ru_o_new_prd_2,  
  output ru_o_alloc_valid_2,
  output ru_o_ce_2,

  input ru_i_rel_valid_1,
  input [`RAT_SIZE - 1 : 0] ru_i_rel_prd_1,
  input ru_i_wb_valid_1,
  input [`RAT_SIZE - 1 : 0] ru_i_wb_prd_1,
  input [`DWIDTH - 1 : 0] ru_i_wb_data_1,
  input ru_i_rel_valid_2,
  input [`RAT_SIZE - 1 : 0] ru_i_rel_prd_2,
  input ru_i_wb_valid_2,
  input [`RAT_SIZE - 1 : 0] ru_i_wb_prd_2,
  input [`DWIDTH - 1 : 0] ru_i_wb_data_2
);

  RAT u_rat (
    .rat_clk(ru_clk), 
    .rat_rstn(ru_rstn),
    .rat_i_ce(ru_i_ce),
    .rat_i_addr_rs_1(ru_i_addr_rs_1),
    .rat_i_addr_rt_1(ru_i_addr_rt_1),
    .rat_i_addr_rd_1(ru_i_addr_rd_1),
    .rat_i_addr_rs_2(ru_i_addr_rs_2),
    .rat_i_addr_rt_2(ru_i_addr_rt_2),
    .rat_i_addr_rd_2(ru_i_addr_rd_2),
    .rat_o_prs_1(ru_o_prs_1),
    .rat_o_prt_1(ru_o_prt_1),
    .rat_o_old_prd_1(ru_o_old_prd_1),
    .rat_o_new_prd_1(ru_o_new_prd_1),
    .rat_o_alloc_valid_1(ru_o_alloc_valid_1),
	.rat_o_ce_1(ru_o_ce_1),
    .rat_o_prs_2(ru_o_prs_2),
    .rat_o_prt_2(ru_o_prt_2),
    .rat_o_old_prd_2(ru_o_old_prd_2),
    .rat_o_new_prd_2(ru_o_new_prd_2),
    .rat_o_alloc_valid_2(ru_o_alloc_valid_2),
    .rat_o_ce_2(ru_o_ce_2),
    .rat_i_rel_valid_1(ru_i_rel_valid_1),
    .rat_i_rel_prd_1(ru_i_rel_prd_1),
    .rat_i_rel_valid_2(ru_i_rel_valid_2),
    .rat_i_rel_prd_2(ru_i_rel_prd_2)
  );

  PRF u_prf (
    .pr_clk(ru_clk), 
    .pr_rstn(ru_rstn),
    
    .pr_id_rs_1(ru_o_prs_1),
    .pr_id_rt_1(ru_o_prt_1),
    .pr_id_rs_2(ru_o_prs_2),
    .pr_id_rt_2(ru_o_prt_2),
    .pr_data_rs_1(ru_o_data_rs_1),
    .pr_data_rt_1(ru_o_data_rt_1),
    .pr_data_rs_2(ru_o_data_rs_2),
    .pr_data_rt_2(ru_o_data_rt_2),

    .pr_reg_write_1(ru_i_wb_valid_1),
    .pr_tag_rd_1(ru_i_wb_prd_1),
    .pr_data_wb_1(ru_i_wb_data_1),
    .pr_reg_write_2(ru_i_wb_valid_2),
    .pr_tag_rd_2(ru_i_wb_prd_2),
    .pr_data_wb_2(ru_i_wb_data_2)
  );
endmodule