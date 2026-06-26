`include "./source/memory.v"

module tb;
    reg m_i_ce;
    reg m_i_wr_en_1;
    reg m_i_wr_en_2;
    reg m_clk, m_rst;
    reg [3 : 0] m_i_mask_1;
    reg [3 : 0] m_i_mask_2;
    reg [`DWIDTH - 1 : 0] m_i_data_rs_1;
    reg [`DWIDTH - 1 : 0] m_i_data_rs_2;
    reg [`AWIDTH_MEM - 1 : 0] m_i_alu_value_1;
    reg [`AWIDTH_MEM - 1 : 0] m_i_alu_value_2;
    wire [`DWIDTH - 1 : 0] m_o_load_data_1;
    wire [`DWIDTH - 1 : 0] m_o_load_data_2;
    integer i;

    memory m (
        .m_clk(m_clk), 
        .m_rst(m_rst), 
        .m_i_ce(m_i_ce), 
        .m_i_wr_en_1(m_i_wr_en_1), 
        .m_i_mask_1(m_i_mask_1), 
        .m_i_alu_value_1(m_i_alu_value_1), 
        .m_i_data_rs_1(m_i_data_rs_1), 
        .m_o_load_data_1(m_o_load_data_1),
        .m_i_wr_en_2(m_i_wr_en_2), 
        .m_i_mask_2(m_i_mask_2), 
        .m_i_alu_value_2(m_i_alu_value_2), 
        .m_i_data_rs_2(m_i_data_rs_2), 
        .m_o_load_data_2(m_o_load_data_2)
    );

    // Clock 10ns
    initial begin
        m_clk = 1'b0;
        forever #5 m_clk = ~m_clk;
    end

    // Dump waveform
    initial begin
        $dumpfile("./waveform/memory.vcd");
        $dumpvars(0, tb);
    end

    // Reset task
    task reset (input integer cycles);
        begin
            m_rst = 1'b0;
            repeat(cycles) @(posedge m_clk);
            m_rst = 1'b1;
            @(posedge m_clk);
        end
    endtask

    // Task ghi dữ liệu với mask
    task store_data_1(input [3:0] mask, input [31:0] data, input [31:0] addr);
        begin
            @(posedge m_clk);
            m_i_ce = 1'b1;
            m_i_wr_en_1 = 1'b1;
            m_i_mask_1 = mask;
            m_i_alu_value_1 = addr;
            m_i_data_rs_1 = data;
            @(posedge m_clk);
            m_i_wr_en_1 = 1'b0;
        end
    endtask

    task store_data_2(input [3:0] mask, input [31:0] data, input [31:0] addr);
        begin
            @(posedge m_clk);
            m_i_ce = 1'b1;
            m_i_wr_en_2 = 1'b1;
            m_i_mask_2 = mask;
            m_i_alu_value_2 = addr;
            m_i_data_rs_2 = data;
            @(posedge m_clk);
            m_i_wr_en_2 = 1'b0;
        end
    endtask

    // Task đọc dữ liệu
    task load_data_1(input [31:0] addr);
        begin
            @(posedge m_clk);
            m_i_ce = 1'b1;
            m_i_alu_value_1 = addr;
            @(posedge m_clk);
            $display("[%0t] Addr=%0d => Load Data=0x%08h", $time, m_i_alu_value_1, m_o_load_data_1);
        end
    endtask

    task load_data_2(input [31:0] addr);
        begin
            @(posedge m_clk);
            m_i_ce = 1'b1;
            m_i_alu_value_2 = addr;
            @(posedge m_clk);
            $display("[%0t] Addr=%0d => Load Data=0x%08h", $time, m_i_alu_value_2, m_o_load_data_2);
        end
    endtask

    initial begin
        // Reset memory
        reset(2);

        // --- TEST 1: STORE WORD (ghi đủ 4 byte) ---
        $display("\n==== TEST 1: STORE WORD ====");
        store_data_1(4'b1111, 32'hAABBCCDD, 3);
        load_data_1(3);

        // --- TEST 2: STORE HALF (ghi 2 byte thấp) ---
        $display("\n==== TEST 2: STORE HALF ====");
        store_data_2(4'b0011, 32'h0000EEFF, 4);
        load_data_2(4);

        // --- TEST 3: STORE BYTE (ghi 1 byte thấp) ---
        $display("\n==== TEST 3: STORE BYTE ====");
        store_data_1(4'b0001, 32'h00000099, 5);
        load_data_1(5);

        // --- TEST 4: GHI NHIỀU GIÁ TRỊ ---
        $display("\n==== TEST 4: MULTI WRITE LOOP ====");
        for (i = 0; i < 8; i = i + 1) begin
            store_data_1(4'b1111, i * 16 + 8, i);
            store_data_2(4'b1111, i * 16 + 8, i);
        end
        for (i = 0; i < 8; i = i + 1) begin
            load_data_1(i);
            load_data_2(i);
        end

        $display("\nSimulation Done.\n");
        #50 $finish;
    end
endmodule