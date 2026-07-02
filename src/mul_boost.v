`timescale 1ns/1ps

module multiplication (
    mult_clk,
    mult_rst,

    mult_i_mult_ce,
    mult_i_opcode,
    mult_i_funct3,
    mult_i_data_rs,
    mult_i_data_rt,
    mult_i_reg_write,
    mult_i_rob_idx,
    mult_i_tag,

    mult_o_alu_value,
    mult_o_busy,
    mult_o_ce,
    mult_o_opcode,
    mult_o_reg_write,
    mult_o_rob_idx,
    mult_o_tag,
    mult_o_funct3
);
    input mult_clk;
    input mult_rst;

    input mult_i_mult_ce;
    input [`OPCODE_WIDTH - 1 : 0] mult_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] mult_i_funct3;
    input [`DWIDTH - 1 : 0] mult_i_data_rs;
    input [`DWIDTH - 1 : 0] mult_i_data_rt;
    input mult_i_reg_write;
    input [`ROB_IDX_W - 1 : 0] mult_i_rob_idx;
    input [`RAT_SIZE - 1 : 0] mult_i_tag;

    output [`DWIDTH - 1 : 0] mult_o_alu_value;
    output mult_o_busy;
    output mult_o_ce;
    output [`OPCODE_WIDTH - 1 : 0] mult_o_opcode;
    output mult_o_reg_write;
    output [`ROB_IDX_W - 1 : 0] mult_o_rob_idx;
    output [`RAT_SIZE - 1 : 0] mult_o_tag;
    output [`FUNCT3_WIDTH - 1 : 0] mult_o_funct3;

    reg busy;
    reg out_valid;
    reg [5:0] count;

    reg [`DWIDTH - 1 : 0] op_data_rs;
    reg [`DWIDTH - 1 : 0] op_data_rt;
    reg [`FUNCT3_WIDTH - 1 : 0] op_funct3;
    reg [`OPCODE_WIDTH - 1 : 0] op_opcode;
    reg op_reg_write;
    reg [`ROB_IDX_W - 1 : 0] op_rob_idx;
    reg [`RAT_SIZE - 1 : 0] op_tag;

    reg signed [(2 * `DWIDTH) - 1 : 0] accum;
    reg [`DWIDTH - 1 : 0] out_alu_value;
    reg [`OPCODE_WIDTH - 1 : 0] out_opcode;
    reg out_reg_write;
    reg [`ROB_IDX_W - 1 : 0] out_rob_idx;
    reg [`RAT_SIZE - 1 : 0] out_tag;
    reg [`FUNCT3_WIDTH - 1 : 0] out_funct3;

    wire accept = mult_i_mult_ce && !busy;

    // Booth recoding scans rt; rs is the value added/subtracted into partial products.
    // Keep rs/rt names here because MULHSU signedness is defined by the ISA as
    // signed(rs1) x unsigned(rs2), not by multiplier/multiplicand terminology.
    wire [`DWIDTH : 0] temp_data_rt;
    wire signed [(2 * `DWIDTH) - 1 : 0] rs_ext;
    reg signed [(2 * `DWIDTH) - 1 : 0] partial_product;
    wire signed [(2 * `DWIDTH) - 1 : 0] shifted_partial;
    wire signed [(2 * `DWIDTH) - 1 : 0] accum_next;
    // rs_signed controls sign extension of rs before forming partial products.
    // rt_unsigned adds the Booth correction needed when rt is treated as unsigned
    // and has bit 31 set.
    wire rs_signed;
    wire rt_unsigned;
    wire signed [(2 * `DWIDTH) - 1 : 0] unsigned_rt_correction;
    wire signed [(2 * `DWIDTH) - 1 : 0] product_next;

    assign rs_signed = (op_funct3 == `MULH) || (op_funct3 == `MULHSU);
    assign rt_unsigned = (op_funct3 == `MUL) || (op_funct3 == `MULHSU) || (op_funct3 == `MULHU);
    assign temp_data_rt = {op_data_rt, 1'b0};
    assign rs_ext = {{`DWIDTH{rs_signed & op_data_rs[`DWIDTH - 1]}}, op_data_rs};
    assign shifted_partial = partial_product <<< (2 * count);
    assign accum_next = accum + shifted_partial;
    assign unsigned_rt_correction =
        (rt_unsigned && op_data_rt[`DWIDTH - 1]) ? (rs_ext <<< `DWIDTH) :
        {(2 * `DWIDTH){1'b0}};
    assign product_next = accum_next + unsigned_rt_correction;

    always @(*) begin
        if (count < (`DWIDTH / 2)) begin
            case ({temp_data_rt[2 * count + 2], temp_data_rt[2 * count + 1], temp_data_rt[2 * count]})
                3'b000, 3'b111 : begin
                    partial_product = {(2 * `DWIDTH){1'b0}};
                end
                3'b001, 3'b010 : begin
                    partial_product = rs_ext;
                end
                3'b011 : begin
                    partial_product = rs_ext <<< 1;
                end
                3'b100 : begin
                    partial_product = -(rs_ext <<< 1);
                end
                3'b101, 3'b110 : begin
                    partial_product = -rs_ext;
                end
                default : begin
                    partial_product = {(2 * `DWIDTH){1'b0}};
                end
            endcase
        end
        else begin
            partial_product = {(2 * `DWIDTH){1'b0}};
        end
    end

    always @(posedge mult_clk, negedge mult_rst) begin
        if (!mult_rst) begin
            busy <= 1'b0;
            out_valid <= 1'b0;
            count <= 6'd0;
            op_data_rs <= {`DWIDTH{1'b0}};
            op_data_rt <= {`DWIDTH{1'b0}};
            op_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            op_opcode <= {`OPCODE_WIDTH{1'b0}};
            op_reg_write <= 1'b0;
            op_rob_idx <= {`ROB_IDX_W{1'b0}};
            op_tag <= {`RAT_SIZE{1'b0}};
            accum <= {(2 * `DWIDTH){1'b0}};
            out_alu_value <= {`DWIDTH{1'b0}};
            out_opcode <= {`OPCODE_WIDTH{1'b0}};
            out_reg_write <= 1'b0;
            out_rob_idx <= {`ROB_IDX_W{1'b0}};
            out_tag <= {`RAT_SIZE{1'b0}};
            out_funct3 <= {`FUNCT3_WIDTH{1'b0}};
        end
        else begin
            out_valid <= 1'b0;

            if (accept) begin
                busy <= 1'b1;
                count <= 6'd0;
                accum <= {(2 * `DWIDTH){1'b0}};
                op_data_rs <= mult_i_data_rs;
                op_data_rt <= mult_i_data_rt;
                op_funct3 <= mult_i_funct3;
                op_opcode <= mult_i_opcode;
                op_reg_write <= mult_i_reg_write;
                op_rob_idx <= mult_i_rob_idx;
                op_tag <= mult_i_tag;
            end
            else if (busy) begin
                if (count == ((`DWIDTH / 2) - 1)) begin
                    out_alu_value <= (op_funct3 == `MUL) ? product_next[31:0] : product_next[63:32];
                    out_opcode <= op_opcode;
                    out_reg_write <= op_reg_write;
                    out_rob_idx <= op_rob_idx;
                    out_tag <= op_tag;
                    out_funct3 <= op_funct3;
                    out_valid <= 1'b1;
                    busy <= 1'b0;
                end
                else begin
                    accum <= accum_next;
                    count <= count + 1'b1;
                end
            end
        end
    end

    assign mult_o_ce = out_valid;
    assign mult_o_busy = busy;
    assign mult_o_reg_write = out_valid ? out_reg_write : 1'b0;
    assign mult_o_opcode = out_valid ? out_opcode : {`OPCODE_WIDTH{1'b0}};
    assign mult_o_alu_value = out_valid ? out_alu_value : {`DWIDTH{1'b0}};
    assign mult_o_rob_idx = out_valid ? out_rob_idx : {`ROB_IDX_W{1'b0}};
    assign mult_o_tag = out_valid ? out_tag : {`RAT_SIZE{1'b0}};
    assign mult_o_funct3 = out_valid ? out_funct3 : {`FUNCT3_WIDTH{1'b0}};

endmodule
