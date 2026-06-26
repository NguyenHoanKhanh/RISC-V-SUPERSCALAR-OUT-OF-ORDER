`timescale 1ns/1ps
`include "alu_control.v"
`include "alu.v"
`include "division.v"
`include "multiplication.v"
`include "treat_jal.v"
module execute_stage (
    es_i_clk, es_i_rst, es_i_ce, es_i_jal, es_i_alu_src, es_i_opcode,
    es_i_funct3, es_i_funct7, es_i_shamt, es_i_data_rs, es_i_data_rt, es_i_imm, es_i_pc,
    es_i_rob_idx, es_i_sq_idx, es_i_tag, es_i_memwrite, es_i_memtoreg, es_i_regwrite,
    es_o_change_pc, es_o_alu_pc, es_o_alu_value, es_o_ce, es_o_done,
    es_o_opcode, es_o_rob_idx, es_o_sq_idx, es_o_tag, es_o_memwrite, es_o_memtoreg, es_o_regwrite, es_o_funct3,
    es_o_ready
);

    input es_i_clk;
    input es_i_rst;
    input es_i_ce;
    input es_i_jal;
    input es_i_alu_src;
    input [`OPCODE_WIDTH - 1 : 0] es_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] es_i_funct3;
    input [`FUNCT7_WIDTH - 1 : 0] es_i_funct7;
    input [`SHAMT_WIDTH - 1 : 0] es_i_shamt;
    input [`IMM_WIDTH - 1 : 0] es_i_imm;
    input [`DWIDTH - 1 : 0] es_i_data_rs, es_i_data_rt;
    input [`PC_WIDTH - 1 : 0] es_i_pc;
    input [`ROB_IDX_W - 1 : 0] es_i_rob_idx;
    input [`ROB_IDX_W - 1 : 0] es_i_sq_idx;
    input [`RAT_SIZE - 1 : 0] es_i_tag;
    input es_i_memwrite;
    input es_i_memtoreg;
    input es_i_regwrite;

    output es_o_done;
    output es_o_change_pc;
    output [`PC_WIDTH - 1 : 0] es_o_alu_pc;
    output reg [`DWIDTH - 1 : 0] es_o_alu_value;
    output reg [`OPCODE_WIDTH - 1 : 0] es_o_opcode;
    output reg [`ROB_IDX_W - 1 : 0] es_o_rob_idx;
    output reg [`ROB_IDX_W - 1 : 0] es_o_sq_idx;
    output reg [`RAT_SIZE - 1 : 0] es_o_tag;
    output reg es_o_memwrite;
    output reg es_o_memtoreg;
    output reg es_o_regwrite;
    output reg [`FUNCT3_WIDTH - 1 : 0] es_o_funct3;
    output reg es_o_ce;
    output es_o_ready;

    // ============================================================
    // Decode ALU / MUL
    // ============================================================
    wire is_mul_op;
    wire is_div_op;
    wire [`ALU_CONTROL - 1 : 0] es_o_control;

    alu_control ac (
        .ac_i_opcode(es_i_opcode),
        .ac_i_funct3(es_i_funct3),
        .ac_i_funct7(es_i_funct7),
        .ac_o_control(es_o_control),
        .ac_o_is_mul(is_mul_op),
        .ac_o_is_div(is_div_op)
    );

    // ============================================================
    // Normal ALU
    // ============================================================
    wire done;
    wire [`DWIDTH - 1 : 0] alu_value;

    alu a (
        .a_i_pc(es_i_pc),
        .a_i_imm(es_i_imm),
        .a_i_control(es_o_control),
        .a_i_data_rs(es_i_data_rs),
        .a_i_data_rt(es_i_data_rt),
        .a_i_alu_src(es_i_alu_src),
        .a_i_shamt(es_i_shamt),
        .done(done),
        .alu_value(alu_value)
    );

    // ============================================================
    // JAL
    // ============================================================
    wire temp_jal_change_pc;
    wire [`PC_WIDTH - 1 : 0] tj_o_pc;
    wire [`PC_WIDTH - 1 : 0] tj_o_ra;

    treat_jal tj (
        .tj_i_pc(es_i_pc),
        .tj_i_jal(es_i_jal),
        .tj_i_imm(es_i_imm),
        .tj_o_pc(tj_o_pc),
        .tj_o_ra(tj_o_ra),
        .tj_o_change_pc(temp_jal_change_pc)
    );

    wire take_jal = es_i_jal;
    wire take_branch = (es_i_opcode == `BTYPE) && (alu_value == 32'd1);
    wire [`PC_WIDTH - 1 : 0] branch_target_pc = es_i_pc + es_i_imm;

    assign es_o_change_pc = (take_jal & temp_jal_change_pc) | take_branch;
    assign es_o_alu_pc =
        (take_jal && temp_jal_change_pc) ? tj_o_pc :
        take_branch ? branch_target_pc :
        {`PC_WIDTH{1'b0}};

    // ============================================================
    // MUL input FIFO
    //
    // Queue này giữ các lệnh MUL đang chờ multiplier rảnh.
    // Completion queue q0/q1 ở dưới chỉ giữ kết quả trả về.
    // Hai queue này khác nhau.
    // ============================================================
    localparam MULQ_IDX_W = $clog2(`MULQ_SIZE);
    localparam MULQ_CNT_W = $clog2(`MULQ_SIZE + 1);

    reg [MULQ_IDX_W - 1 : 0] mulq_head;
    reg [MULQ_IDX_W - 1 : 0] mulq_tail;
    reg [MULQ_CNT_W - 1 : 0] mulq_count;

    wire mulq_empty = (mulq_count == 0);
    wire mulq_full  = (mulq_count == `MULQ_SIZE);

    reg [`OPCODE_WIDTH - 1 : 0] mulq_opcode   [0 : `MULQ_SIZE - 1];
    reg [`FUNCT3_WIDTH - 1 : 0] mulq_funct3   [0 : `MULQ_SIZE - 1];
    reg [`DWIDTH - 1 : 0]       mulq_data_rs  [0 : `MULQ_SIZE - 1];
    reg [`DWIDTH - 1 : 0]       mulq_data_rt  [0 : `MULQ_SIZE - 1];
    reg                         mulq_regwrite [0 : `MULQ_SIZE - 1];
    reg [`ROB_IDX_W - 1 : 0]    mulq_rob_idx  [0 : `MULQ_SIZE - 1];
    reg [`RAT_SIZE - 1 : 0]     mulq_tag      [0 : `MULQ_SIZE - 1];

    // ============================================================
    // Multiplier wires
    // ============================================================
    wire mul_o_ce;
    wire mul_o_busy;
    wire mul_o_reg_write;
    wire [`DWIDTH - 1 : 0] mul_o_alu_value;
    wire [`OPCODE_WIDTH - 1 : 0] mul_o_opcode;
    wire [`ROB_IDX_W - 1 : 0] mul_o_rob_idx;
    wire [`RAT_SIZE - 1 : 0] mul_o_tag;
    wire [`FUNCT3_WIDTH - 1 : 0] mul_o_funct3;

    // Start multiplier từ đầu MUL queue.
    // Không lấy trực tiếp từ es_i_* nữa.
    wire start_mul_from_queue = (~mul_o_busy) & (~mulq_empty);

    multiplication u_mul (
        .mult_clk(es_i_clk),
        .mult_rst(es_i_rst),

        .mult_i_mult_ce(start_mul_from_queue),

        .mult_i_opcode(mulq_opcode[mulq_head]),
        .mult_i_funct3(mulq_funct3[mulq_head]),
        .mult_i_data_rs(mulq_data_rs[mulq_head]),
        .mult_i_data_rt(mulq_data_rt[mulq_head]),
        .mult_i_reg_write(mulq_regwrite[mulq_head]),
        .mult_i_rob_idx(mulq_rob_idx[mulq_head]),
        .mult_i_tag(mulq_tag[mulq_head]),

        .mult_o_alu_value(mul_o_alu_value),
        .mult_o_busy(mul_o_busy),
        .mult_o_ce(mul_o_ce),
        .mult_o_opcode(mul_o_opcode),
        .mult_o_reg_write(mul_o_reg_write),
        .mult_o_rob_idx(mul_o_rob_idx),
        .mult_o_tag(mul_o_tag),
        .mult_o_funct3(mul_o_funct3)
    );


    // ============================================================
    // DIV input FIFO
    //
    // Queue này giữ các lệnh DIV đang chờ.
// Completion queue q0/q1 ở dưới chỉ giữ kết quả trả về.
    // Hai queue này khác nhau.
    // ============================================================
    localparam DIVQ_IDX_W = $clog2(`DIVQ_SIZE);
    localparam DIVQ_CNT_W = $clog2(`DIVQ_SIZE + 1);

    reg [DIVQ_IDX_W - 1 : 0] divq_head;
    reg [DIVQ_IDX_W - 1 : 0] divq_tail;
    reg [DIVQ_CNT_W - 1 : 0] divq_count;

    wire divq_empty = (divq_count == 0);
    wire divq_full  = (divq_count == `DIVQ_SIZE);

    reg [`OPCODE_WIDTH - 1 : 0] divq_opcode   [0 : `DIVQ_SIZE - 1];
    reg [`FUNCT3_WIDTH - 1 : 0] divq_funct3   [0 : `DIVQ_SIZE - 1];
    reg [`DWIDTH - 1 : 0]       divq_data_rs  [0 : `DIVQ_SIZE - 1];
    reg [`DWIDTH - 1 : 0]       divq_data_rt  [0 : `DIVQ_SIZE - 1];
    reg                         divq_regwrite [0 : `DIVQ_SIZE - 1];
    reg [`ROB_IDX_W - 1 : 0]    divq_rob_idx  [0 : `DIVQ_SIZE - 1];
    reg [`RAT_SIZE - 1 : 0]     divq_tag      [0 : `DIVQ_SIZE - 1];

    reg div_i_result_ready;
    wire [`DWIDTH-1:0] div_o_alu_value;
    wire div_o_busy;
    wire div_o_ce;
    wire [`OPCODE_WIDTH-1:0] div_o_opcode;
    wire div_o_reg_write;
    wire [`ROB_IDX_W-1:0] div_o_rob_idx;
    wire [`RAT_SIZE-1:0] div_o_tag;
    wire [`FUNCT3_WIDTH-1:0] div_o_funct3;

		wire start_div_from_queue = (~divq_empty) & (~div_o_busy);

    division u_division (
        .div_clk(es_i_clk), 
        .div_rst(es_i_rst),
        .div_i_div_ce(start_div_from_queue), 
        .div_i_result_ready(div_i_result_ready),
        .div_i_opcode(divq_opcode[divq_head]), 
        .div_i_funct3(divq_funct3[divq_head]), 
        .div_i_data_rs(divq_data_rs[divq_head]), 
        .div_i_data_rt(divq_data_rt[divq_head]), 
        .div_i_reg_write(divq_regwrite[divq_head]),
        .div_i_rob_idx(divq_rob_idx[divq_head]), 
        .div_i_tag(divq_tag[divq_head]), 
        .div_o_alu_value(div_o_alu_value), 
        .div_o_busy(div_o_busy), 
        .div_o_ce(div_o_ce),
        .div_o_opcode(div_o_opcode), 
        .div_o_reg_write(div_o_reg_write),
        .div_o_rob_idx(div_o_rob_idx), 
        .div_o_tag(div_o_tag), 
        .div_o_funct3(div_o_funct3)
    );
    // ============================================================
    // Completion queue q0/q1
    //
    // Queue này giữ kết quả trả về khi MUL result và ALU result
    // tranh chấp cùng 1 output port.
    // ============================================================
    reg q0_valid, q1_valid;

    reg [`DWIDTH - 1 : 0] q0_alu_value, q1_alu_value;
    reg [`OPCODE_WIDTH - 1 : 0] q0_opcode, q1_opcode;
    reg [`ROB_IDX_W - 1 : 0] q0_rob_idx, q1_rob_idx;
    reg [`ROB_IDX_W - 1 : 0] q0_sq_idx, q1_sq_idx;
    reg [`RAT_SIZE - 1 : 0] q0_tag, q1_tag;
    reg q0_memwrite, q1_memwrite;
    reg q0_memtoreg, q1_memtoreg;
    reg q0_regwrite, q1_regwrite;
    reg [`FUNCT3_WIDTH - 1 : 0] q0_funct3, q1_funct3;

    wire queue_full = q0_valid & q1_valid;

    // Nếu completion queue đầy và MUL completion về đúng chu kỳ này,
// không nên nhận ALU mới vì có thể không còn slot để giữ kết quả.
    wire nonmul_ready = ~(queue_full & mul_o_ce);

    // ============================================================
    // Input ready / accept
    //
    // MUL chỉ cần MUL queue chưa đầy là được accept.
    // Không cần chờ multiplier rảnh.
    //
    // Non-MUL đi qua ALU, phụ thuộc completion queue.
    // ============================================================
    assign es_o_ready = is_mul_op ? (~mulq_full) :
                        (is_div_op ? (~divq_full) : nonmul_ready);

    wire accept_in   = es_i_ce & es_o_ready;
    wire enqueue_mul = accept_in & is_mul_op;
    wire enqueue_div = accept_in & is_div_op;
    wire alu_fire    = accept_in & (~is_mul_op) & (~is_div_op) & done;
    wire mul_fire    = mul_o_ce;

    // ============================================================
    // Output selection
    //
    // MUL result không output trực tiếp.
    // MUL result luôn được đưa vào completion queue trước.
    // ============================================================
    wire out_from_q   = q0_valid;
    wire out_from_alu = (~q0_valid) & alu_fire;

    assign es_o_done = out_from_q | out_from_alu;

    // ============================================================
    // Output mux
    // ============================================================
    always @(*) begin
        es_o_ce = 1'b0;
        es_o_alu_value = {`DWIDTH{1'b0}};
        es_o_opcode = {`OPCODE_WIDTH{1'b0}};
        es_o_rob_idx = {`ROB_IDX_W{1'b0}};
        es_o_sq_idx = {`ROB_IDX_W{1'b0}};
        es_o_tag = {`RAT_SIZE{1'b0}};
        es_o_memwrite = 1'b0;
        es_o_memtoreg = 1'b0;
        es_o_regwrite = 1'b0;
        es_o_funct3 = {`FUNCT3_WIDTH{1'b0}};

        if (out_from_q) begin
            es_o_ce = 1'b1;
            es_o_opcode = q0_opcode;
            es_o_alu_value = q0_alu_value;
            es_o_rob_idx = q0_rob_idx;
            es_o_sq_idx = q0_sq_idx;
            es_o_tag = q0_tag;
            es_o_memwrite = q0_memwrite;
            es_o_memtoreg = q0_memtoreg;
            es_o_regwrite = q0_regwrite;
            es_o_funct3 = q0_funct3;
        end
        else if (out_from_alu) begin
            es_o_ce = 1'b1;
            es_o_opcode = es_i_opcode;
            es_o_alu_value = alu_value;
            es_o_rob_idx = es_i_rob_idx;
            es_o_sq_idx = es_i_sq_idx;
            es_o_tag = es_i_tag;
            es_o_memwrite = es_i_memwrite;
            es_o_memtoreg = es_i_memtoreg;
            es_o_regwrite = es_i_regwrite;
            es_o_funct3 = es_i_funct3;
        end
    end

    // ============================================================
    // Completion queue next-state regs
    // ============================================================
    reg n_q0_valid, n_q1_valid;

    reg [`DWIDTH - 1 : 0] n_q0_alu_value, n_q1_alu_value;
    reg [`OPCODE_WIDTH - 1 : 0] n_q0_opcode, n_q1_opcode;
reg [`ROB_IDX_W - 1 : 0] n_q0_rob_idx, n_q1_rob_idx;
    reg [`ROB_IDX_W - 1 : 0] n_q0_sq_idx, n_q1_sq_idx;
    reg [`RAT_SIZE - 1 : 0] n_q0_tag, n_q1_tag;
    reg n_q0_memwrite, n_q1_memwrite;
    reg n_q0_memtoreg, n_q1_memtoreg;
    reg n_q0_regwrite, n_q1_regwrite;
    reg [`FUNCT3_WIDTH - 1 : 0] n_q0_funct3, n_q1_funct3;

    always @(*) begin
        // Default hold
        n_q0_valid = q0_valid;
        n_q1_valid = q1_valid;

        n_q0_alu_value = q0_alu_value;
        n_q1_alu_value = q1_alu_value;

        n_q0_opcode = q0_opcode;
        n_q1_opcode = q1_opcode;

        n_q0_rob_idx = q0_rob_idx;
        n_q1_rob_idx = q1_rob_idx;
        n_q0_sq_idx = q0_sq_idx;
        n_q1_sq_idx = q1_sq_idx;

        n_q0_tag = q0_tag;
        n_q1_tag = q1_tag;

        n_q0_memwrite = q0_memwrite;
        n_q1_memwrite = q1_memwrite;

        n_q0_memtoreg = q0_memtoreg;
        n_q1_memtoreg = q1_memtoreg;

        n_q0_regwrite = q0_regwrite;
        n_q1_regwrite = q1_regwrite;

        n_q0_funct3 = q0_funct3;
        n_q1_funct3 = q1_funct3;
        div_i_result_ready = 1'b0;

        // Dequeue completion queue
        if (out_from_q) begin
            n_q0_valid = q1_valid;
            n_q0_alu_value = q1_alu_value;
            n_q0_opcode = q1_opcode;
            n_q0_rob_idx = q1_rob_idx;
            n_q0_sq_idx = q1_sq_idx;
            n_q0_tag = q1_tag;
            n_q0_memwrite = q1_memwrite;
            n_q0_memtoreg = q1_memtoreg;
            n_q0_regwrite = q1_regwrite;
            n_q0_funct3 = q1_funct3;

            n_q1_valid = 1'b0;
            n_q1_alu_value = {`DWIDTH{1'b0}};
            n_q1_opcode = {`OPCODE_WIDTH{1'b0}};
            n_q1_rob_idx = {`ROB_IDX_W{1'b0}};
            n_q1_sq_idx = {`ROB_IDX_W{1'b0}};
            n_q1_tag = {`RAT_SIZE{1'b0}};
            n_q1_memwrite = 1'b0;
            n_q1_memtoreg = 1'b0;
            n_q1_regwrite = 1'b0;
            n_q1_funct3 = {`FUNCT3_WIDTH{1'b0}};
        end

        // Enqueue MUL completion
        if (mul_fire) begin
            if (!n_q0_valid) begin
                n_q0_valid = 1'b1;
                n_q0_alu_value = mul_o_alu_value;
                n_q0_opcode = mul_o_opcode;
                n_q0_rob_idx = mul_o_rob_idx;
                n_q0_sq_idx = {`ROB_IDX_W{1'b0}};
                n_q0_tag = mul_o_tag;
                n_q0_memwrite = 1'b0;
                n_q0_memtoreg = 1'b0;
                n_q0_regwrite = mul_o_reg_write;
                n_q0_funct3 = mul_o_funct3;
            end
            else if (!n_q1_valid) begin
                n_q1_valid = 1'b1;
                n_q1_alu_value = mul_o_alu_value;
                n_q1_opcode = mul_o_opcode;
                n_q1_rob_idx = mul_o_rob_idx;
                n_q1_sq_idx = {`ROB_IDX_W{1'b0}};
                n_q1_tag = mul_o_tag;
                n_q1_memwrite = 1'b0;
                n_q1_memtoreg = 1'b0;
                n_q1_regwrite = mul_o_reg_write;
                n_q1_funct3 = mul_o_funct3;
end
        end

        // Enqueue ALU completion if not directly output
        if (alu_fire && !out_from_alu) begin
            if (!n_q0_valid) begin
                n_q0_valid = 1'b1;
                n_q0_alu_value = alu_value;
                n_q0_opcode = es_i_opcode;
                n_q0_rob_idx = es_i_rob_idx;
                n_q0_sq_idx = es_i_sq_idx;
                n_q0_tag = es_i_tag;
                n_q0_memwrite = es_i_memwrite;
                n_q0_memtoreg = es_i_memtoreg;
                n_q0_regwrite = es_i_regwrite;
                n_q0_funct3 = es_i_funct3;
            end
            else if (!n_q1_valid) begin
                n_q1_valid = 1'b1;
                n_q1_alu_value = alu_value;
                n_q1_opcode = es_i_opcode;
                n_q1_rob_idx = es_i_rob_idx;
                n_q1_sq_idx = es_i_sq_idx;
                n_q1_tag = es_i_tag;
                n_q1_memwrite = es_i_memwrite;
                n_q1_memtoreg = es_i_memtoreg;
                n_q1_regwrite = es_i_regwrite;
                n_q1_funct3 = es_i_funct3;
            end
        end

        // Drain held DIV completion after MUL and ALU arbitration.
        if (div_o_ce) begin
            if (!n_q0_valid) begin
                n_q0_valid = 1'b1;
                n_q0_alu_value = div_o_alu_value;
                n_q0_opcode = div_o_opcode;
                n_q0_rob_idx = div_o_rob_idx;
                n_q0_sq_idx = {`ROB_IDX_W{1'b0}};
                n_q0_tag = div_o_tag;
                n_q0_memwrite = 1'b0;
                n_q0_memtoreg = 1'b0;
                n_q0_regwrite = div_o_reg_write;
                n_q0_funct3 = div_o_funct3;
                div_i_result_ready = 1'b1;
            end
            else if (!n_q1_valid) begin
                n_q1_valid = 1'b1;
                n_q1_alu_value = div_o_alu_value;
                n_q1_opcode = div_o_opcode;
                n_q1_rob_idx = div_o_rob_idx;
                n_q1_sq_idx = {`ROB_IDX_W{1'b0}};
                n_q1_tag = div_o_tag;
                n_q1_memwrite = 1'b0;
                n_q1_memtoreg = 1'b0;
                n_q1_regwrite = div_o_reg_write;
                n_q1_funct3 = div_o_funct3;
                div_i_result_ready = 1'b1;
            end
        end
    end

    // ============================================================
    // Sequential state update:
    // - MUL input FIFO
    // - Completion queue
    // ============================================================
    always @(posedge es_i_clk or negedge es_i_rst) begin
        if (!es_i_rst) begin
            // MUL input FIFO
            mulq_head <= {MULQ_IDX_W{1'b0}};
            mulq_tail <= {MULQ_IDX_W{1'b0}};
            mulq_count <= {MULQ_CNT_W{1'b0}};

            //DIV input FIFO
            divq_head <= {DIVQ_IDX_W{1'b0}};
            divq_tail <= {DIVQ_IDX_W{1'b0}};
            divq_count <= {DIVQ_CNT_W{1'b0}};

            // Completion queue
            q0_valid <= 1'b0;
q1_valid <= 1'b0;

            q0_alu_value <= {`DWIDTH{1'b0}};
            q1_alu_value <= {`DWIDTH{1'b0}};

            q0_opcode <= {`OPCODE_WIDTH{1'b0}};
            q1_opcode <= {`OPCODE_WIDTH{1'b0}};

            q0_rob_idx <= {`ROB_IDX_W{1'b0}};
            q1_rob_idx <= {`ROB_IDX_W{1'b0}};
            q0_sq_idx <= {`ROB_IDX_W{1'b0}};
            q1_sq_idx <= {`ROB_IDX_W{1'b0}};

            q0_tag <= {`RAT_SIZE{1'b0}};
            q1_tag <= {`RAT_SIZE{1'b0}};

            q0_memwrite <= 1'b0;
            q1_memwrite <= 1'b0;

            q0_memtoreg <= 1'b0;
            q1_memtoreg <= 1'b0;

            q0_regwrite <= 1'b0;
            q1_regwrite <= 1'b0;

            q0_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            q1_funct3 <= {`FUNCT3_WIDTH{1'b0}};
        end
        else begin
            // ----------------------------------------------------
            // Completion queue update
            // ----------------------------------------------------
            q0_valid <= n_q0_valid;
            q1_valid <= n_q1_valid;

            q0_alu_value <= n_q0_alu_value;
            q1_alu_value <= n_q1_alu_value;

            q0_opcode <= n_q0_opcode;
            q1_opcode <= n_q1_opcode;

            q0_rob_idx <= n_q0_rob_idx;
            q1_rob_idx <= n_q1_rob_idx;
            q0_sq_idx <= n_q0_sq_idx;
            q1_sq_idx <= n_q1_sq_idx;

            q0_tag <= n_q0_tag;
            q1_tag <= n_q1_tag;

            q0_memwrite <= n_q0_memwrite;
            q1_memwrite <= n_q1_memwrite;

            q0_memtoreg <= n_q0_memtoreg;
            q1_memtoreg <= n_q1_memtoreg;

            q0_regwrite <= n_q0_regwrite;
            q1_regwrite <= n_q1_regwrite;

            q0_funct3 <= n_q0_funct3;
            q1_funct3 <= n_q1_funct3;

            // ----------------------------------------------------
            // MUL input FIFO enqueue
            // ----------------------------------------------------
            if (enqueue_mul) begin
                mulq_opcode[mulq_tail]   <= es_i_opcode;
                mulq_funct3[mulq_tail]   <= es_i_funct3;
                mulq_data_rs[mulq_tail]  <= es_i_data_rs;
                mulq_data_rt[mulq_tail]  <= es_i_data_rt;
                mulq_regwrite[mulq_tail] <= es_i_regwrite;
                mulq_rob_idx[mulq_tail]  <= es_i_rob_idx;
                mulq_tag[mulq_tail]      <= es_i_tag;

                mulq_tail <= mulq_tail + 1'b1;
            end

            // ----------------------------------------------------
            // DIV input FIFO enqueue
            // ----------------------------------------------------
            if (enqueue_div) begin
                divq_opcode[divq_tail]   <= es_i_opcode;
                divq_funct3[divq_tail]   <= es_i_funct3;
                divq_data_rs[divq_tail]  <= es_i_data_rs;
                divq_data_rt[divq_tail]  <= es_i_data_rt;
                divq_regwrite[divq_tail] <= es_i_regwrite;
                divq_rob_idx[divq_tail]  <= es_i_rob_idx;
divq_tag[divq_tail]      <= es_i_tag;

                divq_tail <= divq_tail + 1'b1;
            end

            // ----------------------------------------------------
            // MUL input FIFO dequeue
            // ----------------------------------------------------
            if (start_mul_from_queue) begin
                mulq_head <= mulq_head + 1'b1;
            end

            // ----------------------------------------------------
            // MUL input FIFO dequeue
            // ----------------------------------------------------
            if (start_div_from_queue) begin
                divq_head <= divq_head + 1'b1;
            end

            // ----------------------------------------------------
            // MUL input FIFO count update
            // ----------------------------------------------------
            case ({enqueue_mul, start_mul_from_queue})
                2'b10: begin
                    mulq_count <= mulq_count + 1'b1;
                end
                2'b01: begin
                    mulq_count <= mulq_count - 1'b1;
                end
                default: begin
                    mulq_count <= mulq_count;
                end
            endcase

            // ----------------------------------------------------
            // MUL input FIFO count update
            // ----------------------------------------------------
            case ({enqueue_div, start_div_from_queue})
                2'b10: begin
                    divq_count <= divq_count + 1'b1;
                end
                2'b01: begin
                    divq_count <= divq_count - 1'b1;
                end
                default: begin
                    divq_count <= divq_count;
                end
            endcase
        end
    end

endmodule
