`include "./source/queue.v"

module tb_queue;
    reg qc_i_clk, qc_i_rst;
    reg qc_i_we_1, qc_i_we_2;
    reg qc_i_re_1, qc_i_re_2;

    reg qc_i_ce_1;
    reg qc_i_reg_dst_1;
    reg qc_i_alu_src_1;
    reg qc_i_memtoreg_1;
    reg qc_i_memwrite_1;
    reg qc_i_reg_write_1;
    reg qc_i_jr_1, qc_i_jal_1;
    reg [`IMM_WIDTH - 1 : 0] qc_i_imm_1;
    reg [`FUNCT_WIDTH - 1 : 0] qc_i_funct_1;
    reg [`OPCODE_WIDTH - 1 : 0] qc_i_opcode_1;
    reg [`JUMP_WIDTH - 1 : 0] qc_i_jal_addr_1;
    reg [`DWIDTH - 1 : 0] qc_i_data_rs_1, qc_i_data_rt_1;
    reg [`AWIDTH - 1 : 0] qc_i_addr_rd_1, qc_i_addr_rs_1, qc_i_addr_rt_1;
    
    reg qc_i_ce_2;
    reg qc_i_reg_dst_2;
    reg qc_i_alu_src_2;
    reg qc_i_memtoreg_2;
    reg qc_i_memwrite_2;
    reg qc_i_reg_write_2;
    reg qc_i_jr_2, qc_i_jal_2;
    reg [`IMM_WIDTH - 1 : 0] qc_i_imm_2;
    reg [`FUNCT_WIDTH - 1 : 0] qc_i_funct_2;
    reg [`OPCODE_WIDTH - 1 : 0] qc_i_opcode_2;
    reg [`JUMP_WIDTH - 1 : 0] qc_i_jal_addr_2;
    reg [`DWIDTH - 1 : 0] qc_i_data_rs_2, qc_i_data_rt_2;
    reg [`AWIDTH - 1 : 0] qc_i_addr_rd_2, qc_i_addr_rs_2, qc_i_addr_rt_2;
    
    wire qc_o_ce_1;
    wire qc_o_reg_dst_1;
    wire qc_o_alu_src_1;
    wire qc_o_memtoreg_1;
    wire qc_o_memwrite_1;
    wire qc_o_reg_write_1;
    wire qc_o_jr_1, qc_o_jal_1;
    wire [`IMM_WIDTH - 1 : 0] qc_o_imm_1;
    wire [`FUNCT_WIDTH - 1 : 0] qc_o_funct_1;
    wire [`OPCODE_WIDTH - 1 : 0] qc_o_opcode_1;
    wire [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr_1;
    wire [`DWIDTH - 1 : 0] qc_o_data_rs_1, qc_o_data_rt_1;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rd_1, qc_o_addr_rs_1, qc_o_addr_rt_1;
    
    wire qc_o_ce_2;
    wire qc_o_reg_dst_2;
    wire qc_o_alu_src_2;
    wire qc_o_memtoreg_2;
    wire qc_o_memwrite_2;
    wire qc_o_reg_write_2;
    wire qc_o_jr_2, qc_o_jal_2;
    wire [`IMM_WIDTH - 1 : 0] qc_o_imm_2;
    wire [`FUNCT_WIDTH - 1 : 0] qc_o_funct_2;
    wire [`OPCODE_WIDTH - 1 : 0] qc_o_opcode_2;
    wire [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr_2;
    wire [`DWIDTH - 1 : 0] qc_o_data_rs_2, qc_o_data_rt_2;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rd_2, qc_o_addr_rs_2, qc_o_addr_rt_2;

    integer i;

    queue q (
        .qc_i_clk(qc_i_clk), 
        .qc_i_rst(qc_i_rst), 
        .qc_i_we_1(qc_i_we_1), 
        .qc_i_we_2(qc_i_we_2), 
        .qc_i_re_1(qc_i_re_1), 
        .qc_i_re_2(qc_i_re_2),
        .qc_i_ce_1(qc_i_ce_1), 
        .qc_i_jr_1(qc_i_jr_1), 
        .qc_i_jal_1(qc_i_jal_1), 
        .qc_i_imm_1(qc_i_imm_1), 
        .qc_i_funct_1(qc_i_funct_1), 
        .qc_i_opcode_1(qc_i_opcode_1), 
        .qc_i_addr_rd_1(qc_i_addr_rd_1), 
        .qc_i_addr_rs_1(qc_i_addr_rs_1), 
        .qc_i_addr_rt_1(qc_i_addr_rt_1), 
        .qc_i_reg_dst_1(qc_i_reg_dst_1), 
        .qc_i_alu_src_1(qc_i_alu_src_1), 
        .qc_i_data_rs_1(qc_i_data_rs_1), 
        .qc_i_data_rt_1(qc_i_data_rt_1),
        .qc_i_jal_addr_1(qc_i_jal_addr_1), 
        .qc_i_memtoreg_1(qc_i_memtoreg_1),
        .qc_i_memwrite_1(qc_i_memwrite_1), 
        .qc_i_reg_write_1(qc_i_reg_write_1), 
        .qc_i_ce_2(qc_i_ce_2), 
        .qc_i_jr_2(qc_i_jr_2), 
        .qc_i_jal_2(qc_i_jal_2), 
        .qc_i_imm_2(qc_i_imm_2), 
        .qc_i_funct_2(qc_i_funct_2), 
        .qc_i_opcode_2(qc_i_opcode_2), 
        .qc_i_addr_rd_2(qc_i_addr_rd_2), 
        .qc_i_addr_rs_2(qc_i_addr_rs_2), 
        .qc_i_addr_rt_2(qc_i_addr_rt_2),
        .qc_i_reg_dst_2(qc_i_reg_dst_2), 
        .qc_i_alu_src_2(qc_i_alu_src_2), 
        .qc_i_data_rs_2(qc_i_data_rs_2), 
        .qc_i_data_rt_2(qc_i_data_rt_2),
        .qc_i_jal_addr_2(qc_i_jal_addr_2), 
        .qc_i_memtoreg_2(qc_i_memtoreg_2),
        .qc_i_memwrite_2(qc_i_memwrite_2), 
        .qc_i_reg_write_2(qc_i_reg_write_2), 
        .qc_o_ce_1(qc_o_ce_1), 
        .qc_o_jr_1(qc_o_jr_1), 
        .qc_o_jal_1(qc_o_jal_1), 
        .qc_o_imm_1(qc_o_imm_1), 
        .qc_o_funct_1(qc_o_funct_1), 
        .qc_o_opcode_1(qc_o_opcode_1), 
        .qc_o_addr_rd_1(qc_o_addr_rd_1), 
        .qc_o_addr_rs_1(qc_o_addr_rs_1), 
        .qc_o_addr_rt_1(qc_o_addr_rt_1), 
        .qc_o_reg_dst_1(qc_o_reg_dst_1), 
        .qc_o_alu_src_1(qc_o_alu_src_1), 
        .qc_o_data_rs_1(qc_o_data_rs_1), 
        .qc_o_data_rt_1(qc_o_data_rt_1),
        .qc_o_jal_addr_1(qc_o_jal_addr_1), 
        .qc_o_memtoreg_1(qc_o_memtoreg_1),
        .qc_o_memwrite_1(qc_o_memwrite_1), 
        .qc_o_reg_write_1(qc_o_reg_write_1), 
        .qc_o_ce_2(qc_o_ce_2), 
        .qc_o_jr_2(qc_o_jr_2), 
        .qc_o_jal_2(qc_o_jal_2), 
        .qc_o_imm_2(qc_o_imm_2), 
        .qc_o_funct_2(qc_o_funct_2), 
        .qc_o_opcode_2(qc_o_opcode_2), 
        .qc_o_addr_rd_2(qc_o_addr_rd_2), 
        .qc_o_addr_rs_2(qc_o_addr_rs_2), 
        .qc_o_addr_rt_2(qc_o_addr_rt_2), 
        .qc_o_reg_dst_2(qc_o_reg_dst_2), 
        .qc_o_alu_src_2(qc_o_alu_src_2), 
        .qc_o_data_rs_2(qc_o_data_rs_2), 
        .qc_o_data_rt_2(qc_o_data_rt_2),
        .qc_o_jal_addr_2(qc_o_jal_addr_2), 
        .qc_o_memtoreg_2(qc_o_memtoreg_2),
        .qc_o_memwrite_2(qc_o_memwrite_2), 
        .qc_o_reg_write_2(qc_o_reg_write_2)
    );

    initial begin
        i = 0;
        qc_i_clk = 1'b0;
    end
    always #5 qc_i_clk = ~qc_i_clk;

    initial begin
        $dumpfile("./waveform/queue.vcd");
        $dumpvars(0, tb_queue);
    end

    task reset (input integer counter);
        begin
            qc_i_rst = 1'b0;
            repeat(counter) @(posedge qc_i_clk);
            qc_i_rst = 1'b1;
        end
    endtask

    task load_1 (input integer counter);
        begin
            qc_i_we_1 = 1'b1;
            qc_i_we_2 = 1'b1;
            for (i = 0; i < counter; i = i + 1) begin
                @(posedge qc_i_clk);
                qc_i_addr_rd_1 = i;
                qc_i_addr_rs_1 = i;
                qc_i_addr_rt_1 = i;
                qc_i_addr_rd_2 = i;
                qc_i_addr_rs_2 = i;
                qc_i_addr_rt_2 = i;
            end
            qc_i_we_1 = 1'b0;
            qc_i_we_2 = 1'b0;
            @(posedge qc_i_clk);
        end
    endtask

    task display (input integer counter);
        begin
            qc_i_re_1 = 1'b1;
            for (i = 0; i < counter; i = i + 1) begin
                @(posedge qc_i_clk);
                $display($time, " ", " qc_o_addr_rd_1 = %d, qc_o_addr_rs_1 = %d, qc_o_addr_rt_1 = %d", 
                        qc_o_addr_rd_1, qc_o_addr_rs_1, qc_o_addr_rt_1);
            end
            qc_i_re_1 = 1'b0;
            @(posedge qc_i_clk);
        end
    endtask

    initial begin
        reset(2);
        @(posedge qc_i_clk);
        load_1(10);
        @(posedge qc_i_clk);
        display(10);
        #20; $finish;
    end

    // initial begin
    //     $monitor($time, " ", " qc_i_addr_rd_1 = %d, qc_i_addr_rs_1 = %d, qc_i_addr_rt_1 = %d, qc_i_addr_rd_2 = %d, qc_i_addr_rs_2 = %d, qc_i_addr_rt_2 = %d",
    //             qc_i_addr_rd_1, qc_i_addr_rs_1, qc_i_addr_rt_1, qc_i_addr_rd_2, qc_i_addr_rs_2, qc_i_addr_rt_2);
    // end
endmodule