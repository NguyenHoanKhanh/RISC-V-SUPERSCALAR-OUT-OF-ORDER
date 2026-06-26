`timescale 1ns/1ps

module memory(
    m_clk, m_rst,
    m_i_ce_1, m_i_wr_en_1, m_i_store_data_1, m_i_store_mask_1, m_i_alu_value_1, 
    m_o_load_data_1,  
    m_i_ce_2, m_i_wr_en_2, m_i_store_data_2, m_i_store_mask_2, m_i_alu_value_2, 
    m_o_load_data_2
);
    input m_clk, m_rst;

    input m_i_ce_1;
    input m_i_wr_en_1;
    input [3 : 0] m_i_store_mask_1;
    input [`DWIDTH - 1 : 0] m_i_alu_value_1;
    input [`DWIDTH - 1 : 0] m_i_store_data_1;
    output reg [`DWIDTH - 1 : 0] m_o_load_data_1;

    input m_i_ce_2;
    input m_i_wr_en_2;
    input [3 : 0] m_i_store_mask_2;
    input [`DWIDTH - 1 : 0] m_i_alu_value_2;
    input [`DWIDTH - 1 : 0] m_i_store_data_2;
    output reg [`DWIDTH - 1 : 0] m_o_load_data_2;

    // `AWIDTH_MEM` is a legacy name; it is used as memory depth here.
    localparam MEM_DEPTH = `AWIDTH_MEM;
    localparam MEM_IDX_W = $clog2(MEM_DEPTH);
    wire [MEM_IDX_W - 1 : 0] m_addr_idx_1;
    wire [MEM_IDX_W - 1 : 0] m_addr_idx_2;
    assign m_addr_idx_1 = m_i_alu_value_1[MEM_IDX_W + 1 : 2];
    assign m_addr_idx_2 = m_i_alu_value_2[MEM_IDX_W + 1 : 2];

    (* ramstyle = "M10K" *) reg [`DWIDTH - 1 : 0] data_mem [0 : MEM_DEPTH - 1];

    // // ============================================================
    // // Debug internal memory words for waveform only
    // // Add dbg_data_mem[*] to waveform to observe data_mem[*]
    // // ============================================================
    // wire [`DWIDTH - 1 : 0] dbg_data_mem [0 : MEM_DEPTH - 1];

    // genvar dbg_i;
    // generate
    //     for (dbg_i = 0; dbg_i < MEM_DEPTH; dbg_i = dbg_i + 1) begin : GEN_DBG_DATA_MEM
    //         assign dbg_data_mem[dbg_i] = data_mem[dbg_i];
    //     end
    // endgenerate

    always @(posedge m_clk, negedge m_rst) begin
        if (!m_rst) begin
            m_o_load_data_1 <= {`DWIDTH{1'b0}};
            m_o_load_data_2 <= {`DWIDTH{1'b0}};
        end
        else begin
            if (m_i_ce_1 && m_i_wr_en_1) begin
                if (m_i_store_mask_1[0]) data_mem[m_addr_idx_1][7  : 0 ] <= m_i_store_data_1[7  : 0 ];
                if (m_i_store_mask_1[1]) data_mem[m_addr_idx_1][15 : 8 ] <= m_i_store_data_1[15 : 8 ];
                if (m_i_store_mask_1[2]) data_mem[m_addr_idx_1][23 : 16] <= m_i_store_data_1[23 : 16];
                if (m_i_store_mask_1[3]) data_mem[m_addr_idx_1][31 : 24] <= m_i_store_data_1[31 : 24];
            end
            if (m_i_ce_2 && m_i_wr_en_2) begin
                if (m_i_store_mask_2[0]) data_mem[m_addr_idx_2][7  : 0 ] <= m_i_store_data_2[7  : 0 ];
                if (m_i_store_mask_2[1]) data_mem[m_addr_idx_2][15 : 8 ] <= m_i_store_data_2[15 : 8 ];
                if (m_i_store_mask_2[2]) data_mem[m_addr_idx_2][23 : 16] <= m_i_store_data_2[23 : 16];
                if (m_i_store_mask_2[3]) data_mem[m_addr_idx_2][31 : 24] <= m_i_store_data_2[31 : 24];
            end

            if (m_i_ce_1) begin
                m_o_load_data_1 <= data_mem[m_addr_idx_1];
            end
            if (m_i_ce_2) begin
                m_o_load_data_2 <= data_mem[m_addr_idx_2];
            end
        end
    end

endmodule