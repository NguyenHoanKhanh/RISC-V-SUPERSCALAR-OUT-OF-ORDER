`ifndef QUEUE_V
`define QUEUE_V
`include "./source/header.vh"

module queue (
    qc_i_clk, qc_i_rst, qc_i_we_1, qc_i_we_2, qc_i_re_1, qc_i_re_2, qc_i_busy_1, qc_i_busy_2,
    qc_i_ce_1, qc_i_jr_1, qc_i_jal_1, qc_i_imm_1, qc_i_funct3_1, qc_i_funct7_1, qc_i_opcode_1, qc_i_addr_rd_1, 
    qc_i_addr_rs_1, qc_i_addr_rt_1, qc_i_reg_dst_1, qc_i_alu_src_1, qc_i_jal_addr_1, qc_i_memtoreg_1,
    qc_i_memwrite_1, qc_i_reg_write_1, qc_i_data_rs_1, qc_i_data_rt_1,
    qc_i_ce_2, qc_i_jr_2, qc_i_jal_2, qc_i_imm_2, qc_i_funct3_2, qc_i_funct7_2, qc_i_opcode_2, qc_i_addr_rd_2, 
    qc_i_addr_rs_2, qc_i_addr_rt_2, qc_i_reg_dst_2, qc_i_alu_src_2, qc_i_jal_addr_2, qc_i_memtoreg_2,
    qc_i_memwrite_2, qc_i_reg_write_2, qc_i_data_rs_2, qc_i_data_rt_2,
    qc_o_ce_1, qc_o_jr_1, qc_o_jal_1, qc_o_imm_1, qc_o_funct3_1, qc_o_funct7_1, qc_o_opcode_1, qc_o_addr_rd_1, 
    qc_o_addr_rs_1, qc_o_addr_rt_1, qc_o_reg_dst_1, qc_o_alu_src_1, qc_o_jal_addr_1, qc_o_memtoreg_1,
    qc_o_memwrite_1, qc_o_reg_write_1, qc_o_data_rs_1, qc_o_data_rt_1, qc_o_active_fetch_1,
    qc_o_ce_2, qc_o_jr_2, qc_o_jal_2, qc_o_imm_2, qc_o_funct3_2, qc_o_funct7_2, qc_o_opcode_2, qc_o_addr_rd_2, 
    qc_o_addr_rs_2, qc_o_addr_rt_2, qc_o_reg_dst_2, qc_o_alu_src_2, qc_o_jal_addr_2, qc_o_memtoreg_2,
    qc_o_memwrite_2, qc_o_reg_write_2, qc_o_data_rs_2, qc_o_data_rt_2, qc_o_active_fetch_2, qc_o_full
);
    // Control signal
    input qc_i_clk, qc_i_rst;
    // Read/Write enable 
    input qc_i_we_1, qc_i_we_2;
    input qc_i_re_1, qc_i_re_2;
    // Busy enable
    input qc_i_busy_1, qc_i_busy_2;
    // Data input signal 
    // Stream 1 : 
    input qc_i_ce_1;
    input qc_i_reg_dst_1;
    input qc_i_alu_src_1;
    input qc_i_memtoreg_1;
    input qc_i_memwrite_1;
    input qc_i_reg_write_1;
    input qc_i_jr_1, qc_i_jal_1;
    input [`IMM_WIDTH - 1 : 0] qc_i_imm_1;
    input [`FUNCT3_WIDTH - 1 : 0] qc_i_funct3_1;
    input [`FUNCT7_WIDTH - 1 : 0] qc_i_funct7_1;
    input [`JUMP_WIDTH - 1 : 0] qc_i_jal_addr_1;
    input [`OPCODE_WIDTH - 1 : 0] qc_i_opcode_1;
    input [`DWIDTH - 1 : 0] qc_i_data_rs_1, qc_i_data_rt_1;
    input [`AWIDTH - 1 : 0] qc_i_addr_rd_1, qc_i_addr_rs_1, qc_i_addr_rt_1;
    // Stream 2 : 
    input qc_i_ce_2;
    input qc_i_reg_dst_2;
    input qc_i_alu_src_2;
    input qc_i_memtoreg_2;
    input qc_i_memwrite_2;
    input qc_i_reg_write_2;
    input qc_i_jr_2, qc_i_jal_2;
    input [`IMM_WIDTH - 1 : 0] qc_i_imm_2;
    input [`FUNCT3_WIDTH - 1 : 0] qc_i_funct3_2;
    input [`FUNCT7_WIDTH - 1 : 0] qc_i_funct7_2;
    input [`JUMP_WIDTH - 1 : 0] qc_i_jal_addr_2;
    input [`OPCODE_WIDTH - 1 : 0] qc_i_opcode_2;
    input [`DWIDTH - 1 : 0] qc_i_data_rs_2, qc_i_data_rt_2;
    input [`AWIDTH - 1 : 0] qc_i_addr_rd_2, qc_i_addr_rs_2, qc_i_addr_rt_2;
    // Data output signal 
    // Stream 1 : 
    output qc_o_ce_1;
    output qc_o_reg_dst_1;
    output qc_o_alu_src_1;
    output qc_o_memtoreg_1;
    output qc_o_memwrite_1;
    output qc_o_reg_write_1;
    output qc_o_active_fetch_1;
    output qc_o_jr_1, qc_o_jal_1;
    output [`IMM_WIDTH - 1 : 0] qc_o_imm_1;
    output [`FUNCT3_WIDTH - 1 : 0] qc_o_funct3_1;
    output [`FUNCT7_WIDTH - 1 : 0] qc_o_funct7_1;
    output [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr_1;
    output [`OPCODE_WIDTH - 1 : 0] qc_o_opcode_1;
    output [`DWIDTH - 1 : 0] qc_o_data_rs_1, qc_o_data_rt_1;
    output [`AWIDTH - 1 : 0] qc_o_addr_rd_1, qc_o_addr_rs_1, qc_o_addr_rt_1;
    // Stream 2 : 
    output qc_o_ce_2;
    output qc_o_reg_dst_2;
    output qc_o_alu_src_2;
    output qc_o_memtoreg_2;
    output qc_o_memwrite_2;
    output qc_o_reg_write_2;
    output qc_o_active_fetch_2;
    output qc_o_full;
    output qc_o_jr_2, qc_o_jal_2;
    output [`IMM_WIDTH - 1 : 0] qc_o_imm_2;
    output [`FUNCT3_WIDTH - 1 : 0] qc_o_funct3_2;
    output [`FUNCT7_WIDTH - 1 : 0] qc_o_funct7_2;
    output [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr_2;
    output [`OPCODE_WIDTH - 1 : 0] qc_o_opcode_2;
    output [`DWIDTH - 1 : 0] qc_o_data_rs_2, qc_o_data_rt_2;
    output [`AWIDTH - 1 : 0] qc_o_addr_rd_2, qc_o_addr_rs_2, qc_o_addr_rt_2;

    reg temp_ce [`QUEUE_SIZE - 1 : 0];
    reg temp_jr [`QUEUE_SIZE - 1 : 0];
    reg temp_jal [`QUEUE_SIZE - 1 : 0];
    reg temp_reg_dst [`QUEUE_SIZE - 1 : 0];
    reg temp_alu_src [`QUEUE_SIZE - 1 : 0];
    reg temp_memtoreg [`QUEUE_SIZE - 1 : 0];
    reg temp_memwrite [`QUEUE_SIZE - 1 : 0];
    reg temp_reg_write [`QUEUE_SIZE - 1 : 0];
    reg [`IMM_WIDTH - 1 : 0] temp_imm [`QUEUE_SIZE - 1 : 0];
    reg [`FUNCT3_WIDTH - 1 : 0] temp_funct3 [`QUEUE_SIZE - 1 : 0];
    reg [`FUNCT7_WIDTH - 1 : 0] temp_funct7 [`QUEUE_SIZE - 1 : 0];
    reg [`JUMP_WIDTH - 1 : 0] temp_jal_addr [`QUEUE_SIZE - 1 : 0];
    reg [`OPCODE_WIDTH - 1 : 0] temp_opcode [`QUEUE_SIZE - 1 : 0];
    reg [`DWIDTH - 1 : 0] temp_data_rs [`QUEUE_SIZE - 1 : 0], temp_data_rt [`QUEUE_SIZE - 1 : 0];
    reg [`AWIDTH - 1 : 0] temp_addr_rd [`QUEUE_SIZE - 1 : 0], temp_addr_rs [`QUEUE_SIZE - 1 : 0], temp_addr_rt [`QUEUE_SIZE - 1 : 0];

    integer i;
    integer j;
    reg [`QUEUE_PTR_WIDTH : 0] counter;
    reg [`QUEUE_PTR_WIDTH - 1 : 0] from_begin, from_end;
    wire [`QUEUE_PTR_WIDTH - 1 : 0] next_write_ptr_for_1 = from_begin + 1'b1;
    wire [`QUEUE_PTR_WIDTH - 1 : 0] next_read_ptr_for_1 = from_end + 1'b1;
    wire [`QUEUE_PTR_WIDTH - 1 : 0] next_write_ptr_for_2 = from_begin + 2'd2;
    wire [`QUEUE_PTR_WIDTH - 1 : 0] next_read_ptr_for_2 = from_end + 2'd2;

    reg conflict_1;
    reg conflict_2;
    reg [1 : 0] write_count;
    reg [1 : 0] read_count;
    wire valid_fetch_1 = (counter >= 1) && !conflict_2;
    wire valid_fetch_2 = (counter >= 2) && !conflict_1;
    assign qc_o_full = counter > (`QUEUE_SIZE - 2);

    assign qc_o_active_fetch_1 = valid_fetch_1; 
    assign qc_o_ce_1 = valid_fetch_1 ? temp_ce[from_end] : 1'b0;
    assign qc_o_jr_1 = valid_fetch_1 ? temp_jr[from_end] : 1'b0;
    assign qc_o_jal_1 = valid_fetch_1 ? temp_jal[from_end] : 1'b0;
    assign qc_o_reg_dst_1 = valid_fetch_1 ? temp_reg_dst[from_end] : 1'b0;
    assign qc_o_alu_src_1 = valid_fetch_1 ? temp_alu_src[from_end] : 1'b0;
    assign qc_o_memtoreg_1 = valid_fetch_1 ? temp_memtoreg[from_end] : 1'b0;
    assign qc_o_memwrite_1 = valid_fetch_1 ? temp_memwrite[from_end] : 1'b0;
    assign qc_o_reg_write_1 = valid_fetch_1 ? temp_reg_write[from_end] : 1'b0;
    assign qc_o_imm_1 = valid_fetch_1 ? temp_imm[from_end] : {`IMM_WIDTH{1'b0}};
    assign qc_o_data_rs_1 = valid_fetch_1 ? temp_data_rs[from_end] : {`DWIDTH{1'b0}};
    assign qc_o_data_rt_1 = valid_fetch_1 ? temp_data_rt[from_end] : {`DWIDTH{1'b0}};
    assign qc_o_addr_rd_1 = valid_fetch_1 ? temp_addr_rd[from_end] : {`AWIDTH{1'b0}};
    assign qc_o_addr_rs_1 = valid_fetch_1 ? temp_addr_rs[from_end] : {`AWIDTH{1'b0}};
    assign qc_o_addr_rt_1 = valid_fetch_1 ? temp_addr_rt[from_end] : {`AWIDTH{1'b0}};
    assign qc_o_funct3_1 = valid_fetch_1 ? temp_funct3[from_end] : {`FUNCT3_WIDTH{1'b0}};
    assign qc_o_funct7_1 = valid_fetch_1 ? temp_funct7[from_end] : {`FUNCT7_WIDTH{1'b0}};
    assign qc_o_opcode_1 = valid_fetch_1 ? temp_opcode[from_end] : {`OPCODE_WIDTH{1'b0}};
    assign qc_o_jal_addr_1 = valid_fetch_1 ? temp_jal_addr[from_end] : {`JUMP_WIDTH{1'b0}};

    assign qc_o_active_fetch_2 = valid_fetch_2;
    assign qc_o_ce_2 = valid_fetch_2 ? temp_ce[next_read_ptr_for_1] : 1'b0;
    assign qc_o_jr_2 = valid_fetch_2 ? temp_jr[next_read_ptr_for_1] : 1'b0;
    assign qc_o_jal_2 = valid_fetch_2 ? temp_jal[next_read_ptr_for_1] : 1'b0;
    assign qc_o_reg_dst_2 = valid_fetch_2 ? temp_reg_dst[next_read_ptr_for_1] : 1'b0;
    assign qc_o_alu_src_2 = valid_fetch_2 ? temp_alu_src[next_read_ptr_for_1] : 1'b0;
    assign qc_o_memtoreg_2 = valid_fetch_2 ? temp_memtoreg[next_read_ptr_for_1] : 1'b0;
    assign qc_o_memwrite_2 = valid_fetch_2 ? temp_memwrite[next_read_ptr_for_1] : 1'b0;
    assign qc_o_reg_write_2 = valid_fetch_2 ? temp_reg_write[next_read_ptr_for_1] : 1'b0;
    assign qc_o_imm_2 = valid_fetch_2 ? temp_imm[next_read_ptr_for_1] : {`IMM_WIDTH{1'b0}};
    assign qc_o_data_rs_2 = valid_fetch_2 ? temp_data_rs[next_read_ptr_for_1] : {`DWIDTH{1'b0}};
    assign qc_o_data_rt_2 = valid_fetch_2 ? temp_data_rt[next_read_ptr_for_1] : {`DWIDTH{1'b0}};
    assign qc_o_addr_rd_2 = valid_fetch_2 ? temp_addr_rd[next_read_ptr_for_1] : {`AWIDTH{1'b0}};
    assign qc_o_addr_rs_2 = valid_fetch_2 ? temp_addr_rs[next_read_ptr_for_1] : {`AWIDTH{1'b0}};
    assign qc_o_addr_rt_2 = valid_fetch_2 ? temp_addr_rt[next_read_ptr_for_1] : {`AWIDTH{1'b0}};
    assign qc_o_funct3_2 = valid_fetch_2 ? temp_funct3[next_read_ptr_for_1] : {`FUNCT3_WIDTH{1'b0}};
    assign qc_o_funct7_2 = valid_fetch_2 ? temp_funct7[next_read_ptr_for_1] : {`FUNCT7_WIDTH{1'b0}};
    assign qc_o_opcode_2 = valid_fetch_2 ? temp_opcode[next_read_ptr_for_1] : {`OPCODE_WIDTH{1'b0}};
    assign qc_o_jal_addr_2 = valid_fetch_2 ? temp_jal_addr[next_read_ptr_for_1] : {`JUMP_WIDTH{1'b0}};

    always @(posedge qc_i_clk, negedge qc_i_rst) begin
        if (!qc_i_rst) begin
            for (i = 0; i < `QUEUE_SIZE; i = i + 1) begin
                temp_ce[i] <= 1'b0;
                temp_jr[i] <= 1'b0;
                temp_jal[i] <= 1'b0;
                temp_reg_dst[i] <= 1'b0;
                temp_alu_src[i] <= 1'b0;
                temp_memtoreg[i] <= 1'b0;
                temp_memwrite[i] <= 1'b0;
                temp_reg_write[i] <= 1'b0;
                temp_data_rs[i] <= {`DWIDTH{1'b0}}; 
                temp_imm[i] <= {`IMM_WIDTH{1'b0}};
                temp_data_rt[i] <= {`DWIDTH{1'b0}}; 
                temp_addr_rd[i] <= {`AWIDTH{1'b0}};
                temp_addr_rs[i] <= {`AWIDTH{1'b0}}; 
                temp_addr_rt[i] <= {`AWIDTH{1'b0}};
                temp_funct3[i] <= {`FUNCT3_WIDTH{1'b0}};
                temp_funct7[i] <= {`FUNCT7_WIDTH{1'b0}};
                temp_jal_addr[i] <= {`JUMP_WIDTH{1'b0}};
                temp_opcode[i] <= {`OPCODE_WIDTH{1'b0}};
            end
            from_end <= {`QUEUE_PTR_WIDTH{1'b0}};
            counter <= {(`QUEUE_PTR_WIDTH + 1){1'b0}};
            from_begin <= {`QUEUE_PTR_WIDTH{1'b0}};
        end 
        else begin
            write_count = 2'd0;
            read_count = 2'd0;

            if (qc_i_re_1 && qc_i_re_2) begin
                if ((counter >= 2) && !conflict_1) read_count = 2'd2;
                else if (counter >= 1) read_count = 2'd1;
            end
            else if (qc_i_re_1 || qc_i_re_2) begin
                if (counter >= 1) read_count = 2'd1;
            end

            if (qc_i_we_1 && qc_i_we_2) begin
                if (counter <= `QUEUE_SIZE - 2) begin
                    temp_ce[from_begin] <= qc_i_ce_1;
                    temp_jr[from_begin] <= qc_i_jr_1;
                    temp_jal[from_begin] <= qc_i_jal_1;
                    temp_imm[from_begin] <= qc_i_imm_1;
                    temp_funct3[from_begin] <= qc_i_funct3_1;
                    temp_funct7[from_begin] <= qc_i_funct7_1;
                    temp_opcode[from_begin] <= qc_i_opcode_1;
                    temp_reg_dst[from_begin] <= qc_i_reg_dst_1;
                    temp_alu_src[from_begin] <= qc_i_alu_src_1;
                    temp_data_rs[from_begin] <= qc_i_data_rs_1; 
                    temp_data_rt[from_begin] <= qc_i_data_rt_1; 
                    temp_addr_rd[from_begin] <= qc_i_addr_rd_1;
                    temp_addr_rs[from_begin] <= qc_i_addr_rs_1; 
                    temp_addr_rt[from_begin] <= qc_i_addr_rt_1;
                    temp_memtoreg[from_begin] <= qc_i_memtoreg_1;
                    temp_memwrite[from_begin] <= qc_i_memwrite_1;
                    temp_jal_addr[from_begin] <= qc_i_jal_addr_1;
                    temp_reg_write[from_begin] <= qc_i_reg_write_1;

                    temp_ce[next_write_ptr_for_1] <= qc_i_ce_2;
                    temp_jr[next_write_ptr_for_1] <= qc_i_jr_2;
                    temp_jal[next_write_ptr_for_1] <= qc_i_jal_2;
                    temp_imm[next_write_ptr_for_1] <= qc_i_imm_2;
                    temp_funct3[next_write_ptr_for_1] <= qc_i_funct3_2;
                    temp_funct7[next_write_ptr_for_1] <= qc_i_funct7_2;
                    temp_opcode[next_write_ptr_for_1] <= qc_i_opcode_2;
                    temp_reg_dst[next_write_ptr_for_1] <= qc_i_reg_dst_2;
                    temp_alu_src[next_write_ptr_for_1] <= qc_i_alu_src_2;
                    temp_data_rs[next_write_ptr_for_1] <= qc_i_data_rs_2; 
                    temp_data_rt[next_write_ptr_for_1] <= qc_i_data_rt_2; 
                    temp_addr_rd[next_write_ptr_for_1] <= qc_i_addr_rd_2;
                    temp_addr_rs[next_write_ptr_for_1] <= qc_i_addr_rs_2; 
                    temp_addr_rt[next_write_ptr_for_1] <= qc_i_addr_rt_2;
                    temp_memtoreg[next_write_ptr_for_1] <= qc_i_memtoreg_2;
                    temp_memwrite[next_write_ptr_for_1] <= qc_i_memwrite_2;
                    temp_jal_addr[next_write_ptr_for_1] <= qc_i_jal_addr_2;
                    temp_reg_write[next_write_ptr_for_1] <= qc_i_reg_write_2;

                    from_begin <= next_write_ptr_for_2;
                    write_count = 2'd2;
                end
            end
            else if (qc_i_we_1 && !qc_i_we_2) begin
                if (counter < `QUEUE_SIZE) begin
                    temp_ce[from_begin] <= qc_i_ce_1;
                    temp_jr[from_begin] <= qc_i_jr_1;
                    temp_jal[from_begin] <= qc_i_jal_1;
                    temp_imm[from_begin] <= qc_i_imm_1;
                    temp_funct3[from_begin] <= qc_i_funct3_1;
                    temp_funct7[from_begin] <= qc_i_funct7_1;
                    temp_opcode[from_begin] <= qc_i_opcode_1;
                    temp_reg_dst[from_begin] <= qc_i_reg_dst_1;
                    temp_alu_src[from_begin] <= qc_i_alu_src_1;
                    temp_data_rs[from_begin] <= qc_i_data_rs_1; 
                    temp_data_rt[from_begin] <= qc_i_data_rt_1; 
                    temp_addr_rd[from_begin] <= qc_i_addr_rd_1;
                    temp_addr_rs[from_begin] <= qc_i_addr_rs_1; 
                    temp_addr_rt[from_begin] <= qc_i_addr_rt_1;
                    temp_memtoreg[from_begin] <= qc_i_memtoreg_1;
                    temp_memwrite[from_begin] <= qc_i_memwrite_1;
                    temp_jal_addr[from_begin] <= qc_i_jal_addr_1;
                    temp_reg_write[from_begin] <= qc_i_reg_write_1;

                    from_begin <= next_write_ptr_for_1;
                    write_count = 2'd1;
                end
            end

            if (read_count == 2'd2) begin
                from_end <= next_read_ptr_for_2;
            end
            else if (read_count == 2'd1) begin
                from_end <= next_read_ptr_for_1;
            end

            counter <= counter + write_count - read_count;
        end
    end

    always @(*) begin
        conflict_1 = 1'b0;
        conflict_2 = 1'b0;
        if(counter >= 2) begin
            if(temp_reg_write[from_end] && temp_addr_rd[from_end] != 0) begin
                if((temp_addr_rs[next_read_ptr_for_1] == temp_addr_rd[from_end]) ||
                    (temp_addr_rt[next_read_ptr_for_1] == temp_addr_rd[from_end])) begin
                    conflict_1 = 1'b1;
                end
            end
        end
    end

    // always @(*) begin
    //     conflict_1 = 1'b0;
    //     conflict_2 = 1'b0;
    //     if(counter >= 2) begin
    //         if(temp_reg_write[from_end] && temp_addr_rd[from_end] != 0) begin
    //             for(i = counter; i >= 0; i = i - 1) begin
    //                 if((temp_addr_rs[next_read_ptr_for_1] == temp_addr_rd[i]) ||
    //                     (temp_addr_rt[next_read_ptr_for_1] == temp_addr_rd[i])) begin
    //                         conflict_1 = 1'b1;
    //                 end
    //                 if((temp_addr_rs[next_read_ptr_for_2] == temp_addr_rd[i]) || 
    //                     (temp_addr_rt[next_read_ptr_for_2] == temp_addr_rd[i])) begin
    //                         conflict_2 = 1'b1;
    //                 end
    //             end
    //         end
    //     end
    //     if(counter >= 1) begin
    //         if(temp_reg_write[from_end] && temp_addr_rd[from_end] != 0) begin
    //             for(i = counter; i >= 0; i = i - 1) begin
    //                 if((temp_addr_rs[next_read_ptr_for_1] == temp_addr_rd[i]) || 
    //                 (temp_addr_rt[next_read_ptr_for_1] == temp_addr_rd[i])) begin
    //                     if(qc_i_re_1) begin
    //                         conflict_1 = 1'b1;
    //                     end
    //                     if(qc_i_re_2) begin
    //                         conflict_2 = 1'b1;
    //                     end
    //                 end
    //             end
    //         end
    //     end
    // end
endmodule
`endif
