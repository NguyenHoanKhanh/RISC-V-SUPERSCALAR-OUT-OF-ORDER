`include "./source/queue_components.v"

module tb_qc;
    reg qc_i_ce;
    reg qc_i_reg_dst;
    reg qc_i_alu_src;
    reg qc_clk, qc_rst;
    reg qc_i_reg_write;
    reg qc_i_we, qc_i_re;
    reg qc_i_jr, qc_i_jal;
    reg qc_i_memtoreg, qc_i_memwrite;
    reg [`IMM_WIDTH - 1 : 0] qc_i_imm;
    reg [`FUNCT_WIDTH - 1 : 0] qc_i_funct;
    reg [`JUMP_WIDTH - 1 : 0] qc_i_jal_addr;
    reg [`OPCODE_WIDTH - 1 : 0] qc_i_opcode;
    reg [`DWIDTH - 1 : 0] qc_i_data_rs, qc_i_data_rt;
    reg [`AWIDTH - 1 : 0] qc_i_addr_rd, qc_i_addr_rs, qc_i_addr_rt;
    wire qc_o_ce;
    wire qc_o_reg_dst;
    wire qc_o_alu_src;
    wire qc_o_regwrite;
    wire qc_o_jr, qc_o_jal;
    wire qc_o_memtoreg, qc_o_memwrite;
    wire [`IMM_WIDTH - 1 : 0] qc_o_imm;
    wire [`FUNCT_WIDTH - 1 : 0] qc_o_funct;
    wire [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr;
    wire [`OPCODE_WIDTH - 1 : 0] qc_o_opcode;
    wire [`DWIDTH - 1 : 0] qc_o_data_rs, qc_o_data_rt;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rd, qc_o_addr_rs, qc_o_addr_rt;

    queue_comps qc (
        .qc_clk(qc_clk), 
        .qc_rst(qc_rst), 
        .qc_i_ce(qc_i_ce), 
        .qc_i_jr(qc_i_jr), 
        .qc_i_jal(qc_i_jal), 
        .qc_i_imm(qc_i_imm), 
        .qc_i_funct(qc_i_funct), 
        .qc_i_opcode(qc_i_opcode), 
        .qc_i_reg_dst(qc_i_reg_dst), 
        .qc_i_alu_src(qc_i_alu_src), 
        .qc_i_data_rs(qc_i_data_rs), 
        .qc_i_data_rt(qc_i_data_rt), 
        .qc_i_memtoreg(qc_i_memtoreg), 
        .qc_i_memwrite(qc_i_memwrite),
        .qc_i_jal_addr(qc_i_jal_addr), 
        .qc_i_reg_write(qc_i_reg_write), 
        .qc_i_addr_rd(qc_i_addr_rd), 
        .qc_i_addr_rs(qc_i_addr_rs), 
        .qc_i_addr_rt(qc_i_addr_rt), 
        .qc_i_we(qc_i_we), 
        .qc_i_re(qc_i_re), 
        .qc_o_addr_rd(qc_o_addr_rd), 
        .qc_o_addr_rs(qc_o_addr_rs),
        .qc_o_addr_rt(qc_o_addr_rt), 
        .qc_o_ce(qc_o_ce), 
        .qc_o_jr(qc_o_jr), 
        .qc_o_jal(qc_o_jal), 
        .qc_o_imm(qc_o_imm), 
        .qc_o_funct(qc_o_funct), 
        .qc_o_opcode(qc_o_opcode), 
        .qc_o_reg_dst(qc_o_reg_dst), 
        .qc_o_alu_src(qc_o_alu_src), 
        .qc_o_data_rs(qc_o_data_rs), 
        .qc_o_data_rt(qc_o_data_rt), 
        .qc_o_memtoreg(qc_o_memtoreg), 
        .qc_o_memwrite(qc_o_memwrite), 
        .qc_o_jal_addr(qc_o_jal_addr), 
        .qc_o_regwrite(qc_o_regwrite)
    );

    initial begin
        qc_clk = 1'b0;
        qc_i_ce = 1'b0;
        qc_i_reg_dst = 1'b0;
        qc_i_alu_src = 1'b0;
        qc_i_reg_write = 1'b0;
        qc_i_we = 1'b0;
        qc_i_re = 1'b0;
        qc_i_jr = 1'b0;
        qc_i_jal = 1'b0;
        qc_i_memtoreg = 1'b0;
        qc_i_memwrite = 1'b0;
        qc_i_imm = {`IMM_WIDTH{1'b0}};
        qc_i_funct = {`FUNCT_WIDTH{1'b0}};
        qc_i_jal_addr = {`JUMP_WIDTH{1'b0}};
        qc_i_opcode = {`OPCODE_WIDTH{1'b0}};
        qc_i_data_rs = {`DWIDTH{1'b0}};
        qc_i_data_rt = {`DWIDTH{1'b0}};
        qc_i_addr_rd = {`AWIDTH{1'b0}};
        qc_i_addr_rs = {`AWIDTH{1'b0}};
        qc_i_addr_rt = {`AWIDTH{1'b0}};
    end
    always #5 qc_clk = ~qc_clk;

    task reset (input integer counter);
        begin
            qc_rst = 1'b0;
            repeat(counter) @(posedge qc_clk);
            qc_rst = 1'b1;
        end
    endtask

    // --- PHẦN BỔ SUNG: Kịch bản kiểm tra (Stimulus) ---
    initial begin
        // 1. Chờ ổn định và Reset hệ thống
        #10;
        reset(5); // Reset trong 5 chu kỳ xung nhịp

        // 2. TEST CASE 1: Ghi dữ liệu vào hàng đợi (Write)
        // Ghi gói tin thứ 1
        @(negedge qc_clk); // Đồng bộ với cạnh xuống (vì DUT dùng negedge)
        qc_i_we = 1'b1;
        qc_i_re = 1'b0;
        
        // Dữ liệu mẫu 1
        qc_i_opcode   = 6'h0A;       // Opcode mẫu
        qc_i_data_rs  = 32'h11112222; // Data RS mẫu
        qc_i_addr_rd  = 5'd5;        // Địa chỉ RD mẫu
        qc_i_alu_src  = 1'b1;
        
        @(negedge qc_clk); // Đợi 1 chu kỳ để DUT ghi nhận
        qc_i_we = 1'b0;    // Tắt tín hiệu ghi

        // Ghi gói tin thứ 2
        #10;
        @(negedge qc_clk);
        qc_i_we = 1'b1;
        
        // Dữ liệu mẫu 2
        qc_i_opcode   = 6'h0B;
        qc_i_data_rs  = 32'h33334444;
        qc_i_addr_rd  = 5'd6;
        qc_i_alu_src  = 1'b0;

        @(negedge qc_clk);
        qc_i_we = 1'b0;

        // 3. TEST CASE 2: Đọc dữ liệu từ hàng đợi (Read)
        // Hàng đợi là FIFO nên phải đọc ra dữ liệu mẫu 1 trước (Opcode 0A)
        
        #20; // Chờ một chút
        @(negedge qc_clk);
        qc_i_re = 1'b1; // Bật tín hiệu đọc
        qc_i_we = 1'b0;

        @(negedge qc_clk); // Đợi DUT cập nhật output ở cạnh xuống
        // Tại đây qc_o_opcode phải là 0x0A, qc_o_data_rs là 11112222
        
        qc_i_re = 1'b0; // Tắt đọc (hoặc giữ nguyên nếu muốn đọc liên tiếp)

        // Đọc tiếp gói tin thứ 2 (Opcode 0B)
        #20;
        @(negedge qc_clk);
        qc_i_re = 1'b1;
        
        @(negedge qc_clk);
        // Tại đây qc_o_opcode phải là 0x0B, qc_o_data_rs là 33334444
        qc_i_re = 1'b0;

        // 4. Kết thúc mô phỏng
        #50;
        $display("Simulation finished.");
        $finish;
    end

    // Tùy chọn: Monitor để in giá trị ra console khi có thay đổi
    initial begin
        $monitor("Time=%0t | RST=%b | WE=%b | RE=%b | InOp=%h | OutOp=%h | OutData=%h", 
                 $time, qc_rst, qc_i_we, qc_i_re, qc_i_opcode, qc_o_opcode, qc_o_data_rs);
    end
endmodule