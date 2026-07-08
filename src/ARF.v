// 32 architectural registers.
// Commit-only architectural state.
`include "header_nomul.vh"
`timescale 1ns/1ps

module ARF (
  input ar_clk,
  input ar_rstn,

  input [`AWIDTH - 1 : 0] ar_display_addr_1,
  output [`DWIDTH - 1 : 0] ar_display_data_1,
  input [`AWIDTH - 1 : 0] ar_display_addr_2,
  output [`DWIDTH - 1 : 0] ar_display_data_2,

  input ar_commit_we_1,
  input [`AWIDTH - 1 : 0] ar_commit_addr_1,
  input [`DWIDTH - 1 : 0] ar_commit_data_1,
  input ar_commit_we_2,
  input [`AWIDTH - 1 : 0] ar_commit_addr_2,
  input [`DWIDTH - 1 : 0] ar_commit_data_2
);
  integer ar_init_i;
  reg [`DWIDTH - 1 : 0] arf_value [0 : (2 ** `AWIDTH) - 1];

  always @(posedge ar_clk or negedge ar_rstn) begin
    if (!ar_rstn) begin
      for (ar_init_i = 0; ar_init_i < (2 ** `AWIDTH); ar_init_i = ar_init_i + 1) begin
        arf_value[ar_init_i] <= {`DWIDTH{1'b0}};
      end
    end
    else begin
      if (ar_commit_we_1 && (ar_commit_addr_1 != {`AWIDTH{1'b0}})) begin
        arf_value[ar_commit_addr_1] <= ar_commit_data_1;
      end
      if (ar_commit_we_2 && (ar_commit_addr_2 != {`AWIDTH{1'b0}})) begin
        arf_value[ar_commit_addr_2] <= ar_commit_data_2;
      end
    end
  end

  assign ar_display_data_1 =
      (ar_display_addr_1 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} :
                                                arf_value[ar_display_addr_1];
  assign ar_display_data_2 =
      (ar_display_addr_2 == {`AWIDTH{1'b0}}) ? {`DWIDTH{1'b0}} :
                                                arf_value[ar_display_addr_2];
endmodule
