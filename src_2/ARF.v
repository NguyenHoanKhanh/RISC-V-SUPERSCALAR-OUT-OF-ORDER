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
  // Waveform-only debug mirrors for direct ARF inspection.
  wire [`DWIDTH - 1 : 0] ar_dbg_x0;
  wire [`DWIDTH - 1 : 0] ar_dbg_x1;
  wire [`DWIDTH - 1 : 0] ar_dbg_x2;
  wire [`DWIDTH - 1 : 0] ar_dbg_x3;
  wire [`DWIDTH - 1 : 0] ar_dbg_x4;
  wire [`DWIDTH - 1 : 0] ar_dbg_x5;
  wire [`DWIDTH - 1 : 0] ar_dbg_x6;
  wire [`DWIDTH - 1 : 0] ar_dbg_x7;
  wire [`DWIDTH - 1 : 0] ar_dbg_x8;
  wire [`DWIDTH - 1 : 0] ar_dbg_x9;
  wire [`DWIDTH - 1 : 0] ar_dbg_x10;
  wire [`DWIDTH - 1 : 0] ar_dbg_x11;
  wire [`DWIDTH - 1 : 0] ar_dbg_x12;
  wire [`DWIDTH - 1 : 0] ar_dbg_x13;
  wire [`DWIDTH - 1 : 0] ar_dbg_x14;
  wire [`DWIDTH - 1 : 0] ar_dbg_x15;
  wire [`DWIDTH - 1 : 0] ar_dbg_x16;
  wire [`DWIDTH - 1 : 0] ar_dbg_x17;
  wire [`DWIDTH - 1 : 0] ar_dbg_x18;
  wire [`DWIDTH - 1 : 0] ar_dbg_x19;
  wire [`DWIDTH - 1 : 0] ar_dbg_x20;
  wire [`DWIDTH - 1 : 0] ar_dbg_x21;
  wire [`DWIDTH - 1 : 0] ar_dbg_x22;
  wire [`DWIDTH - 1 : 0] ar_dbg_x23;
  wire [`DWIDTH - 1 : 0] ar_dbg_x24;
  wire [`DWIDTH - 1 : 0] ar_dbg_x25;
  wire [`DWIDTH - 1 : 0] ar_dbg_x26;
  wire [`DWIDTH - 1 : 0] ar_dbg_x27;
  wire [`DWIDTH - 1 : 0] ar_dbg_x28;
  wire [`DWIDTH - 1 : 0] ar_dbg_x29;
  wire [`DWIDTH - 1 : 0] ar_dbg_x30;
  wire [`DWIDTH - 1 : 0] ar_dbg_x31;

  assign ar_dbg_x0  = {`DWIDTH{1'b0}};
  assign ar_dbg_x1  = arf_value[1];
  assign ar_dbg_x2  = arf_value[2];
  assign ar_dbg_x3  = arf_value[3];
  assign ar_dbg_x4  = arf_value[4];
  assign ar_dbg_x5  = arf_value[5];
  assign ar_dbg_x6  = arf_value[6];
  assign ar_dbg_x7  = arf_value[7];
  assign ar_dbg_x8  = arf_value[8];
  assign ar_dbg_x9  = arf_value[9];
  assign ar_dbg_x10 = arf_value[10];
  assign ar_dbg_x11 = arf_value[11];
  assign ar_dbg_x12 = arf_value[12];
  assign ar_dbg_x13 = arf_value[13];
  assign ar_dbg_x14 = arf_value[14];
  assign ar_dbg_x15 = arf_value[15];
  assign ar_dbg_x16 = arf_value[16];
  assign ar_dbg_x17 = arf_value[17];
  assign ar_dbg_x18 = arf_value[18];
  assign ar_dbg_x19 = arf_value[19];
  assign ar_dbg_x20 = arf_value[20];
  assign ar_dbg_x21 = arf_value[21];
  assign ar_dbg_x22 = arf_value[22];
  assign ar_dbg_x23 = arf_value[23];
  assign ar_dbg_x24 = arf_value[24];
  assign ar_dbg_x25 = arf_value[25];
  assign ar_dbg_x26 = arf_value[26];
  assign ar_dbg_x27 = arf_value[27];
  assign ar_dbg_x28 = arf_value[28];
  assign ar_dbg_x29 = arf_value[29];
  assign ar_dbg_x30 = arf_value[30];
  assign ar_dbg_x31 = arf_value[31];

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
