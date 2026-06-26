`timescale 1ns/1ps

// Sequential iterative restoring divider, 32 cycles latency.
// Supports DIV/DIVU/REM/REMU per RV32M spec.
// Edge cases: div-by-zero and signed overflow are handled correctly.
module division (
    div_clk, div_rst,
    div_i_div_ce, div_i_result_ready,
    div_i_opcode, div_i_funct3,
    div_i_data_rs, div_i_data_rt, div_i_reg_write,
    div_i_rob_idx, div_i_tag,
    div_o_alu_value, div_o_busy, div_o_ce,
    div_o_opcode, div_o_reg_write,
    div_o_rob_idx, div_o_tag,
    div_o_funct3
);
    input div_clk;
    input div_rst;
    input div_i_div_ce;
    input div_i_result_ready;
    input [`OPCODE_WIDTH - 1 : 0]  div_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0]  div_i_funct3;
    input [`DWIDTH - 1 : 0]        div_i_data_rs;
    input [`DWIDTH - 1 : 0]        div_i_data_rt;
    input                          div_i_reg_write;
    input [`ROB_IDX_W - 1 : 0]     div_i_rob_idx;
    input [`RAT_SIZE - 1 : 0]      div_i_tag;

    output [`DWIDTH - 1 : 0]       div_o_alu_value;
    output                         div_o_busy;
    output                         div_o_ce;
    output [`OPCODE_WIDTH - 1 : 0] div_o_opcode;
    output                         div_o_reg_write;
    output [`ROB_IDX_W - 1 : 0]    div_o_rob_idx;
    output [`RAT_SIZE - 1 : 0]     div_o_tag;
    output [`FUNCT3_WIDTH - 1 : 0] div_o_funct3;

    reg busy;
    reg out_valid;
    reg [5:0] iter_cnt;

    // Division datapath
    reg [32:0] rem_reg;   // 33-bit partial remainder
    reg [31:0] a_reg;     // dividend magnitude (shifts out MSBit each cycle)
    reg [31:0] b_reg;     // divisor magnitude
    reg [31:0] quot_reg;  // quotient being built

    // Flags latched at accept
    reg saved_sign_q;     // quotient sign = a_neg ^ b_neg
    reg saved_sign_r;     // remainder sign = a_neg
    reg is_div_by_zero;   // rs2 == 0
    reg [`DWIDTH - 1 : 0] saved_rs1;  // original rs1 for REM div-by-zero

    // Metadata
    reg [`FUNCT3_WIDTH - 1 : 0] op_funct3;
    reg [`OPCODE_WIDTH - 1 : 0] op_opcode;
    reg                         op_reg_write;
    reg [`ROB_IDX_W - 1 : 0]    op_rob_idx;
    reg [`RAT_SIZE - 1 : 0]     op_tag;

    // Output registers
    reg [`DWIDTH - 1 : 0]       out_alu_value;
    reg [`OPCODE_WIDTH - 1 : 0] out_opcode;
    reg                         out_reg_write;
    reg [`ROB_IDX_W - 1 : 0]    out_rob_idx;
    reg [`RAT_SIZE - 1 : 0]     out_tag;
    reg [`FUNCT3_WIDTH - 1 : 0] out_funct3;

    // Accept a new DIV only when the divider is not computing and no previous
    // result is waiting to be drained by execute_stage.
    wire accept = div_i_div_ce && !busy && !out_valid;

    // Sign detection (combinational, used at accept)
    wire is_signed_op_w = (div_i_funct3 == `DIV || div_i_funct3 == `REM);
    wire a_neg_w        = is_signed_op_w && div_i_data_rs[`DWIDTH - 1];
    wire b_neg_w        = is_signed_op_w && div_i_data_rt[`DWIDTH - 1];
    wire [31:0] a_mag_w = a_neg_w ? (~div_i_data_rs + 32'd1) : div_i_data_rs;
    wire [31:0] b_mag_w = b_neg_w ? (~div_i_data_rt + 32'd1) : div_i_data_rt;
    wire b_is_zero_w    = (div_i_data_rt == 32'd0);
    wire sign_q_w       = a_neg_w ^ b_neg_w;
    wire sign_r_w       = a_neg_w;

    // Iteration step (combinational)
    wire [32:0] new_rem   = {rem_reg[31:0], a_reg[31]};
    wire [32:0] b_ext     = {1'b0, b_reg};
    wire        do_sub    = (new_rem >= b_ext) && !is_div_by_zero;
    wire [32:0] next_rem  = do_sub ? (new_rem - b_ext) : new_rem;
    wire [31:0] next_quot = {quot_reg[30:0], do_sub ? 1'b1 : 1'b0};

    // Final results at iter_cnt == 31
    wire [31:0] final_quot_unsigned = next_quot;
    wire [31:0] final_rem_unsigned  = next_rem[31:0];
    wire [31:0] final_quot_signed =
        saved_sign_q ? (~final_quot_unsigned + 32'd1) : final_quot_unsigned;
    wire [31:0] final_rem_signed =
        saved_sign_r ? (~final_rem_unsigned + 32'd1) : final_rem_unsigned;

    wire [31:0] normal_result =
        (op_funct3 == `DIV)  ? final_quot_signed   :
        (op_funct3 == `DIVU) ? final_quot_unsigned  :
        (op_funct3 == `REM)  ? final_rem_signed     :
                                final_rem_unsigned;   // REMU

    // div-by-zero: DIV/DIVU -> 0xFFFFFFFF, REM/REMU -> rs1
    wire [31:0] divzero_result =
        (op_funct3 == `REM || op_funct3 == `REMU) ? saved_rs1 : 32'hFFFFFFFF;

    wire [31:0] completion_result = is_div_by_zero ? divzero_result : normal_result;

    always @(posedge div_clk or negedge div_rst) begin
        if (!div_rst) begin
            busy           <= 1'b0;
            out_valid      <= 1'b0;
            iter_cnt       <= 6'd0;
            rem_reg        <= 33'd0;
            a_reg          <= 32'd0;
            b_reg          <= 32'd0;
            quot_reg       <= 32'd0;
            saved_sign_q   <= 1'b0;
            saved_sign_r   <= 1'b0;
            is_div_by_zero <= 1'b0;
            saved_rs1      <= {`DWIDTH{1'b0}};
            op_funct3      <= {`FUNCT3_WIDTH{1'b0}};
            op_opcode      <= {`OPCODE_WIDTH{1'b0}};
            op_reg_write   <= 1'b0;
            op_rob_idx     <= {`ROB_IDX_W{1'b0}};
            op_tag         <= {`RAT_SIZE{1'b0}};
            out_alu_value  <= {`DWIDTH{1'b0}};
            out_opcode     <= {`OPCODE_WIDTH{1'b0}};
            out_reg_write  <= 1'b0;
            out_rob_idx    <= {`ROB_IDX_W{1'b0}};
            out_tag        <= {`RAT_SIZE{1'b0}};
            out_funct3     <= {`FUNCT3_WIDTH{1'b0}};
        end
        else begin
            if (out_valid && div_i_result_ready) begin
                out_valid <= 1'b0;
            end

            if (accept) begin
                busy           <= 1'b1;
                iter_cnt       <= 6'd0;
                rem_reg        <= 33'd0;
                a_reg          <= a_mag_w;
                b_reg          <= b_mag_w;
                quot_reg       <= 32'd0;
                saved_sign_q   <= sign_q_w;
                saved_sign_r   <= sign_r_w;
                is_div_by_zero <= b_is_zero_w;
		saved_rs1      <= div_i_data_rs;
                op_funct3      <= div_i_funct3;
                op_opcode      <= div_i_opcode;
                op_reg_write   <= div_i_reg_write;
                op_rob_idx     <= div_i_rob_idx;
                op_tag         <= div_i_tag;
            end
            else if (busy) begin
                if (iter_cnt == 6'd31) begin
                    out_alu_value <= completion_result;
                    out_opcode    <= op_opcode;
                    out_reg_write <= op_reg_write;
                    out_rob_idx   <= op_rob_idx;
                    out_tag       <= op_tag;
                    out_funct3    <= op_funct3;
                    out_valid     <= 1'b1;
                    busy          <= 1'b0;
                end
                else begin
                    rem_reg  <= next_rem;
                    a_reg    <= {a_reg[30:0], 1'b0};
                    quot_reg <= next_quot;
                    iter_cnt <= iter_cnt + 1'b1;
                end
            end
        end
    end

    assign div_o_ce        = out_valid;
    assign div_o_busy      = busy || out_valid;
    assign div_o_reg_write = out_valid ? out_reg_write : 1'b0;
    assign div_o_opcode    = out_valid ? out_opcode    : {`OPCODE_WIDTH{1'b0}};
    assign div_o_alu_value = out_valid ? out_alu_value : {`DWIDTH{1'b0}};
    assign div_o_rob_idx   = out_valid ? out_rob_idx   : {`ROB_IDX_W{1'b0}};
    assign div_o_tag       = out_valid ? out_tag       : {`RAT_SIZE{1'b0}};
    assign div_o_funct3    = out_valid ? out_funct3    : {`FUNCT3_WIDTH{1'b0}};

endmodule
