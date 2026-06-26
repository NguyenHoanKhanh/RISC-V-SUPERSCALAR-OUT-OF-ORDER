`ifndef MEMORY_V
`define MEMORY_V
`include "./source/header.vh"

module memory (
    m_clk, m_rst, m_i_ce_1, m_i_ce_2, m_i_wr_en_1, m_i_mask_1, m_i_alu_value_1, m_i_data_rs_1, m_o_load_data_1,
    m_i_wr_en_2, m_i_mask_2, m_i_alu_value_2, m_i_data_rs_2, m_o_load_data_2
);
    input m_i_wr_en_1;
    input m_i_wr_en_2;
    input m_clk, m_rst;
    input m_i_ce_1, m_i_ce_2;
    input [3 : 0] m_i_mask_1;
    input [3 : 0] m_i_mask_2;
    input [`DWIDTH - 1 : 0] m_i_data_rs_1;
    input [`DWIDTH - 1 : 0] m_i_data_rs_2;
    input [`AWIDTH_MEM - 1 : 0] m_i_alu_value_1;
    input [`AWIDTH_MEM - 1 : 0] m_i_alu_value_2;
    output [`DWIDTH - 1 : 0] m_o_load_data_1;
    output [`DWIDTH - 1 : 0] m_o_load_data_2;

    localparam MEM_DEPTH = `AWIDTH_MEM;
    localparam MEM_IDX_W = 5;
    wire [MEM_IDX_W - 1 : 0] m_addr_idx_1;
    wire [MEM_IDX_W - 1 : 0] m_addr_idx_2;
    assign m_addr_idx_1 = m_i_alu_value_1[MEM_IDX_W + 1 : 2];
    assign m_addr_idx_2 = m_i_alu_value_2[MEM_IDX_W + 1 : 2];

    reg [`DWIDTH - 1 : 0] data_mem [0 : MEM_DEPTH - 1];
    integer i;

    always @(negedge m_clk, negedge m_rst) begin
        if (!m_rst) begin
            for (i = 0; i < MEM_DEPTH; i = i + 1) begin
                data_mem[i] <= i;
            end
        end
        else begin
            if (m_i_ce_1 && m_i_wr_en_1) begin
                if (m_i_mask_1[0]) data_mem[m_addr_idx_1][7  : 0 ] <= m_i_data_rs_1[7  : 0 ];
                if (m_i_mask_1[1]) data_mem[m_addr_idx_1][15 : 8 ] <= m_i_data_rs_1[15 : 8 ];
                if (m_i_mask_1[2]) data_mem[m_addr_idx_1][23 : 16] <= m_i_data_rs_1[23 : 16];
                if (m_i_mask_1[3]) data_mem[m_addr_idx_1][31 : 24] <= m_i_data_rs_1[31 : 24];
            end
            if (m_i_ce_2 && m_i_wr_en_2) begin
                if (m_i_mask_2[0]) data_mem[m_addr_idx_2][7  : 0 ] <= m_i_data_rs_2[7  : 0 ];
                if (m_i_mask_2[1]) data_mem[m_addr_idx_2][15 : 8 ] <= m_i_data_rs_2[15 : 8 ];
                if (m_i_mask_2[2]) data_mem[m_addr_idx_2][23 : 16] <= m_i_data_rs_2[23 : 16];
                if (m_i_mask_2[3]) data_mem[m_addr_idx_2][31 : 24] <= m_i_data_rs_2[31 : 24];
            end
        end
    end
    assign m_o_load_data_1 = data_mem[m_addr_idx_1];
    assign m_o_load_data_2 = data_mem[m_addr_idx_2];
endmodule
`endif 
