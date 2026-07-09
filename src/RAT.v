`include "header_nomul.vh"
`include "free_list.v"
`timescale 1ns/1ps

module RAT (
  input rat_clk, 
  input rat_rstn,
  input rat_i_ce,
  input [`AWIDTH - 1 : 0] rat_i_addr_rs_1,
  input [`AWIDTH - 1 : 0] rat_i_addr_rt_1,
  input [`AWIDTH - 1 : 0] rat_i_addr_rd_1,
  input [`AWIDTH - 1 : 0] rat_i_addr_rs_2,
  input [`AWIDTH - 1 : 0] rat_i_addr_rt_2,
  input [`AWIDTH - 1 : 0] rat_i_addr_rd_2,
  output [`RAT_SIZE - 1 : 0] rat_o_prs_1,
  output [`RAT_SIZE - 1 : 0] rat_o_prt_1,
  output [`RAT_SIZE - 1 : 0] rat_o_prs_1_prf,
  output [`RAT_SIZE - 1 : 0] rat_o_prt_1_prf,
  output [`RAT_SIZE - 1 : 0] rat_o_old_prd_1,
  output [`RAT_SIZE - 1 : 0] rat_o_new_prd_1,
  output rat_o_alloc_valid_1,
  output rat_o_ce_1,
  output [`RAT_SIZE - 1 : 0] rat_o_prs_2,
  output [`RAT_SIZE - 1 : 0] rat_o_prt_2,
  output [`RAT_SIZE - 1 : 0] rat_o_prs_2_prf,
  output [`RAT_SIZE - 1 : 0] rat_o_prt_2_prf,
  output [`RAT_SIZE - 1 : 0] rat_o_old_prd_2,
  output [`RAT_SIZE - 1 : 0] rat_o_new_prd_2,
  output rat_o_alloc_valid_2,
  output rat_o_ce_2,

  input rat_i_rel_valid_1,
  input [`RAT_SIZE - 1 : 0] rat_i_rel_prd_1,
  input rat_i_rel_valid_2,
  input [`RAT_SIZE - 1 : 0] rat_i_rel_prd_2
);
  integer i;
  localparam [`RAT_SIZE - 1 : 0] RAT_ZERO = {`RAT_SIZE{1'b0}};
  reg [`RAT_SIZE - 1 : 0] mem_prd [0 : (2 ** `AWIDTH) - 1];

  wire rat_o_req_1, rat_o_req_2;
  assign rat_o_req_1 = rat_i_ce && (rat_i_addr_rd_1 != {`AWIDTH{1'b0}});
  assign rat_o_req_2 = rat_i_ce && (rat_i_addr_rd_2 != {`AWIDTH{1'b0}});
  wire [`RAT_SIZE : 0] rat_i_prd_1;
  wire [`RAT_SIZE : 0] rat_i_prd_2;

  free_list u_free_list (
    .fl_clk(rat_clk),
    .fl_rstn(rat_rstn),
    .fl_req_1(rat_o_req_1),
    .fl_prd_1(rat_i_prd_1),
    .fl_req_2(rat_o_req_2),
    .fl_prd_2(rat_i_prd_2),
    .fl_rel_1(rat_i_rel_valid_1),
    .fl_rel_id_1(rat_i_rel_prd_1),
    .fl_rel_2(rat_i_rel_valid_2),
    .fl_rel_id_2(rat_i_rel_prd_2)
  );

  always @(posedge rat_clk or negedge rat_rstn) begin
    if (!rat_rstn) begin
      for (i = 0; i < 2 ** `AWIDTH; i = i + 1) begin
        mem_prd[i] <= {1'b0, i[`AWIDTH - 1 : 0]};
      end
    end
    else begin
      if (rat_i_ce && rat_i_prd_1[`RAT_SIZE]) begin
        mem_prd[rat_i_addr_rd_1] <= rat_i_prd_1[`RAT_SIZE - 1 : 0];
      end
      if (rat_i_ce && rat_i_prd_2[`RAT_SIZE]) begin
        mem_prd[rat_i_addr_rd_2] <= rat_i_prd_2[`RAT_SIZE - 1 : 0];
      end
    end
  end

  assign rat_o_old_prd_1 = rat_i_ce ? mem_prd[rat_i_addr_rd_1] : RAT_ZERO;
  assign rat_o_old_prd_2 = !rat_i_ce ? RAT_ZERO : (rat_i_addr_rd_1 == rat_i_addr_rd_2 && rat_i_prd_1[`RAT_SIZE]) ? rat_o_new_prd_1 : mem_prd[rat_i_addr_rd_2];
  assign rat_o_new_prd_1 = rat_i_ce ? rat_i_prd_1[`RAT_SIZE - 1 : 0] : RAT_ZERO;
  assign rat_o_new_prd_2 = rat_i_ce ? rat_i_prd_2[`RAT_SIZE - 1 : 0] : RAT_ZERO;
  assign rat_o_alloc_valid_1 = rat_i_ce && rat_i_prd_1[`RAT_SIZE];
  assign rat_o_alloc_valid_2 = rat_i_ce && rat_i_prd_2[`RAT_SIZE];
  assign rat_o_ce_1 = rat_o_alloc_valid_1;
  assign rat_o_ce_2 = rat_o_alloc_valid_2;
  assign rat_o_prs_1 = rat_i_ce ? mem_prd[rat_i_addr_rs_1] : RAT_ZERO;
  assign rat_o_prt_1 = rat_i_ce ? mem_prd[rat_i_addr_rt_1] : RAT_ZERO;
  // PRF read tags intentionally use the current RAT mapping, not the
  // same-packet lane1 bypass. If lane2 depends on lane1, RS marks it not-ready
  // and ignores the captured value until wakeup; this keeps the lane1 rd
  // compare out of the PRF data timing path.
  assign rat_o_prs_1_prf = mem_prd[rat_i_addr_rs_1];
  assign rat_o_prt_1_prf = mem_prd[rat_i_addr_rt_1];
  assign rat_o_prs_2_prf = mem_prd[rat_i_addr_rs_2];
  assign rat_o_prt_2_prf = mem_prd[rat_i_addr_rt_2];
  assign rat_o_prs_2 = !rat_i_ce ? RAT_ZERO :
((rat_i_addr_rs_2 == rat_i_addr_rd_1 && rat_i_prd_1[`RAT_SIZE]) ?
                        rat_i_prd_1[`RAT_SIZE - 1 : 0] : mem_prd[rat_i_addr_rs_2]);
  assign rat_o_prt_2 = !rat_i_ce ? RAT_ZERO :
                       ((rat_i_addr_rt_2 == rat_i_addr_rd_1 && rat_i_prd_1[`RAT_SIZE]) ?
                        rat_i_prd_1[`RAT_SIZE - 1 : 0] : mem_prd[rat_i_addr_rt_2]);
endmodule
