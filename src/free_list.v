`timescale 1ns/1ps

module free_list (
  input fl_clk,
  input fl_rstn,

  input fl_req_1,
  output [`RAT_SIZE : 0] fl_prd_1,
  input fl_req_2,
  output [`RAT_SIZE : 0] fl_prd_2,

  input fl_rel_1,
  input [`RAT_SIZE - 1 : 0] fl_rel_id_1,
  input fl_rel_2,
  input [`RAT_SIZE - 1 : 0] fl_rel_id_2
);

  integer i;

  localparam integer ARCH_REGS = (2 ** `AWIDTH);
  localparam integer PHYS_REGS = (2 ** `RAT_SIZE);
  localparam integer FREE_REGS = PHYS_REGS - ARCH_REGS;

  // Kho free ban dau: p32..p(PHYS_REGS-1)
  reg [`RAT_SIZE - 1 : 0] provide [0 : FREE_REGS - 1];

  // count can chua duoc 0..FREE_REGS
  reg [`RAT_SIZE : 0] count;

  wire can_alloc_1;
  wire can_alloc_2;
  wire [1:0] num_req;
  wire [1:0] num_rel;
  wire [`RAT_SIZE:0] count_after_req;
  wire [`RAT_SIZE:0] next_count;

  wire [`RAT_SIZE-1:0] idx_pop_1;
  wire [`RAT_SIZE-1:0] idx_pop_2;
  wire [`RAT_SIZE-1:0] idx_push_1;
  wire [`RAT_SIZE-1:0] idx_push_2;

  assign can_alloc_1 = (count >= 1);
  assign can_alloc_2 = (count >= 2);

  assign num_req = (fl_req_1 && fl_req_2 && can_alloc_2) ? 2'd2 :
                   ((fl_req_1 || fl_req_2) && can_alloc_1) ? 2'd1 :
                                                              2'd0;

  assign num_rel = (fl_rel_1 && fl_rel_2) ? 2'd2 :
                   (fl_rel_1 || fl_rel_2) ? 2'd1 :
                                             2'd0;

  assign count_after_req = count - num_req;
  assign next_count = count_after_req + num_rel;

  assign idx_pop_1  = count[`RAT_SIZE-1:0] - {{(`RAT_SIZE-1){1'b0}}, 1'b1};
  assign idx_pop_2  = count[`RAT_SIZE-1:0] - {{(`RAT_SIZE-2){1'b0}}, 2'd2};
  assign idx_push_1 = count_after_req[`RAT_SIZE-1:0];
  assign idx_push_2 = count_after_req[`RAT_SIZE-1:0] + {{(`RAT_SIZE-1){1'b0}}, 1'b1};

  assign fl_prd_1 =
      (count > 0 && fl_req_1) ? {1'b1, provide[idx_pop_1]} :
                                {1'b0, {`RAT_SIZE{1'b0}}};

  assign fl_prd_2 =
      (fl_req_2 && fl_req_1  && count > 1) ? {1'b1, provide[idx_pop_2]} :
      (fl_req_2 && !fl_req_1 && count > 0) ? {1'b1, provide[idx_pop_1]} :
                                             {1'b0, {`RAT_SIZE{1'b0}}};

  always @(posedge fl_clk or negedge fl_rstn) begin
    if (!fl_rstn) begin
      for (i = 0; i < FREE_REGS; i = i + 1) begin
        provide[i] <= i + ARCH_REGS;
      end
      count <= FREE_REGS;
    end
    else begin
      count <= next_count;

      if (fl_rel_1 && fl_rel_2) begin
        provide[idx_push_1] <= fl_rel_id_1;
        provide[idx_push_2] <= fl_rel_id_2;
      end
      else if (fl_rel_1) begin
        provide[idx_push_1] <= fl_rel_id_1;
      end
      else if (fl_rel_2) begin
        provide[idx_push_1] <= fl_rel_id_2;
      end
    end
  end

endmodule
