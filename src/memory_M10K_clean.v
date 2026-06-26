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
    output [`DWIDTH - 1 : 0] m_o_load_data_1;

    input m_i_ce_2;
    input m_i_wr_en_2;
    input [3 : 0] m_i_store_mask_2;
    input [`DWIDTH - 1 : 0] m_i_alu_value_2;
    input [`DWIDTH - 1 : 0] m_i_store_data_2;
    output [`DWIDTH - 1 : 0] m_o_load_data_2;
    
    localparam MEM_IDX_W = $clog2(`MEM_DEPTH);

    wire [MEM_IDX_W - 1 : 0] m_addr_idx_1;
    wire [MEM_IDX_W - 1 : 0] m_addr_idx_2;
    assign m_addr_idx_1 = m_i_alu_value_1[MEM_IDX_W + 1 : 2];
    assign m_addr_idx_2 = m_i_alu_value_2[MEM_IDX_W + 1 : 2];

    wire [31:0] wr_data_1;
    wire [31:0] wr_data_2;
    wire [3:0] byteena_1;
    wire [3:0] byteena_2;

    assign wr_data_1 = m_i_store_data_1;
    assign wr_data_2 = m_i_store_data_2;
    assign byteena_1 = (m_i_ce_1 && m_i_wr_en_1) ? m_i_store_mask_1 : 4'b0000;
    assign byteena_2 = (m_i_ce_2 && m_i_wr_en_2) ? m_i_store_mask_2 : 4'b0000;

    wire [`DWIDTH - 1 : 0] q_a;
    wire [`DWIDTH - 1 : 0] q_b;

    assign m_o_load_data_1 = q_a;
    assign m_o_load_data_2 = q_b;

    altsyncram #(
        .operation_mode("BIDIR_DUAL_PORT"),
        .ram_block_type("M10K"),
        .width_a(`DWIDTH),
        .widthad_a(MEM_IDX_W),
        .numwords_a(`MEM_DEPTH),
        .width_byteena_a(4),
        .width_b(`DWIDTH),
        .widthad_b(MEM_IDX_W),
        .numwords_b(`MEM_DEPTH),
        .width_byteena_b(4),
        .outdata_reg_a("UNREGISTERED"),
        .outdata_reg_b("UNREGISTERED"),
        .indata_reg_a("CLOCK0"),
        .wrcontrol_wraddress_reg_a("CLOCK0"),
        .address_reg_a("CLOCK0"),
        .byteena_reg_a("CLOCK0"),
        .indata_reg_b("CLOCK0"),
        .wrcontrol_wraddress_reg_b("CLOCK0"),
        .address_reg_b("CLOCK0"),
        .byteena_reg_b("CLOCK0"),
        .read_during_write_mode_mixed_ports("DONT_CARE"),
        .power_up_uninitialized("FALSE"),
        .lpm_type("altsyncram")
    ) u_data_mem (
        .clock0(m_clk),

        .address_a(m_addr_idx_1),
        .data_a(wr_data_1),
        .wren_a(m_i_ce_1 && m_i_wr_en_1),
        .byteena_a(byteena_1),
        .q_a(q_a),

        .address_b(m_addr_idx_2),
        .data_b(wr_data_2),
        .wren_b(m_i_ce_2 && m_i_wr_en_2),
        .byteena_b(byteena_2),
        .q_b(q_b),

        .aclr0(1'b0),
        .aclr1(1'b0),
        .addressstall_a(1'b0),
        .addressstall_b(1'b0),
        .clock1(1'b1),
        .clocken0(1'b1),
        .clocken1(1'b1),
        .clocken2(1'b1),
        .clocken3(1'b1),
        .eccstatus()
    );
endmodule