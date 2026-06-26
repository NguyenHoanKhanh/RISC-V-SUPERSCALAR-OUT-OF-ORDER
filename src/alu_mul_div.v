`timescale 1ns/1ps
`include "header_nomul.vh"
module alu (
    a_i_imm, a_i_control, a_i_data_rs, a_i_data_rt, a_i_pc,
    a_i_alu_src, a_i_shamt, alu_value, done,
    a_i_mul, a_i_div, a_i_funct3
);
    input a_i_alu_src;
    input a_i_mul, a_i_div;
    input [`PC_WIDTH - 1 : 0] a_i_pc;
    input [`FUNCT3_WIDTH - 1 : 0] a_i_funct3;
    input [`DWIDTH - 1 : 0] a_i_data_rs, a_i_data_rt;
    input [`SHAMT_WIDTH - 1 : 0] a_i_shamt;
    input [`ALU_CONTROL - 1 : 0] a_i_control;
    input [`IMM_WIDTH - 1 : 0] a_i_imm;
    output reg done;
    output reg [`DWIDTH - 1 : 0] alu_value;

    wire [`DWIDTH - 1 : 0] a_i_data_2;
    assign a_i_data_2 = (a_i_alu_src) ? a_i_imm : a_i_data_rt;
    wire [`SHAMT_WIDTH - 1 : 0] shift_amt;
    assign shift_amt = (a_i_alu_src) ? a_i_shamt : a_i_data_rt[`SHAMT_WIDTH - 1 : 0];

    wire funct_add  = a_i_control == 4'd0;
    wire funct_sub  = a_i_control == 4'd1;
    wire funct_sll  = a_i_control == 4'd2;
    wire funct_slt  = a_i_control == 4'd3;
    wire funct_sltu = a_i_control == 4'd4;
    wire funct_xor  = a_i_control == 4'd5;
    wire funct_or   = a_i_control == 4'd6;
    wire funct_and  = a_i_control == 4'd7;
    wire funct_srl  = a_i_control == 4'd8;
    wire funct_sra  = a_i_control == 4'd9;
    wire funct_beq  = a_i_control == 4'd10;
    wire funct_bne  = a_i_control == 4'd11;
    wire funct_blt  = a_i_control == 4'd12;
    wire funct_bge  = a_i_control == 4'd13;
    wire funct_bltu = a_i_control == 4'd14;
    wire funct_bgeu = a_i_control == 4'd15;

    reg [(2 * `DWIDTH) - 1 : 0] temp_result;
    reg signed [(2 * `DWIDTH) - 1 : 0] temp_signed_result;
    reg [(2 * `DWIDTH) - 1 : 0] temp_unsigned_result;
    reg signed [(2 * `DWIDTH) - 1 : 0] temp_mixed_result;
    wire signed [63:0] rs_signed_ext;
    wire signed [63:0] rt_unsigned_ext_signed;   

    assign rs_signed_ext = {{32{a_i_data_rs[31]}}, a_i_data_rs};
    assign rt_unsigned_ext_signed = $signed({32'b0, a_i_data_2});

    always @(*) begin
        done = 1'b0;
        alu_value = {`DWIDTH{1'b0}};
        temp_result = {(2 * `DWIDTH){1'b0}};
        temp_signed_result = {(2 * `DWIDTH){1'b0}};
        temp_unsigned_result = {(2 * `DWIDTH){1'b0}};
        temp_mixed_result = {(2 * `DWIDTH){1'b0}};

        if (funct_add && !a_i_mul && !a_i_div) begin
            done = 1'b1;
            alu_value = a_i_data_rs + a_i_data_2;
        end
        else if (funct_sub) begin
            done = 1'b1;
            alu_value = a_i_data_rs - a_i_data_2;
        end
        else if (funct_slt) begin
			done = 1'b1;
            if ($signed(a_i_data_rs) < $signed(a_i_data_2)) begin
                alu_value = {{(`DWIDTH - 1){1'b0}},1'b1};
            end
            else begin
                alu_value = {`DWIDTH{1'b0}};
            end
        end
        else if (funct_sltu) begin
			done = 1'b1;
            if ($unsigned(a_i_data_rs) < $unsigned(a_i_data_2)) begin
                alu_value = {{(`DWIDTH - 1){1'b0}},1'b1};
            end
            else begin
                alu_value = {`DWIDTH{1'b0}};
            end
        end
        else if (funct_or) begin
            done = 1'b1;
            alu_value = a_i_data_rs | a_i_data_2;
        end
        else if (funct_xor) begin
            done = 1'b1;
            alu_value = a_i_data_rs ^ a_i_data_2;
        end
        else if (funct_and) begin
            done = 1'b1;
            alu_value = a_i_data_rs & a_i_data_2;
        end
        else if (funct_sll) begin
            done = 1'b1;
            alu_value = a_i_data_rs << shift_amt;
        end
        else if (funct_srl) begin
            done = 1'b1;
            alu_value = a_i_data_rs >> shift_amt;
        end
        else if (funct_sra) begin
            done = 1'b1;
            alu_value = $signed(a_i_data_rs) >>> shift_amt;
        end
        else if (funct_beq) begin
            done = 1'b1;
            alu_value = (a_i_data_rs == a_i_data_2) ? 32'd1 : 32'd0;
        end
        else if (funct_bne) begin
            done = 1'b1;
            alu_value = (a_i_data_rs != a_i_data_2) ? 32'd1 : 32'd0;
        end
        else if (funct_blt) begin
            done = 1'b1;
            alu_value = ($signed(a_i_data_rs) < $signed(a_i_data_2)) ? 32'd1 : 32'd0;
        end
        else if (funct_bge) begin
            done = 1'b1;
            alu_value = ($signed(a_i_data_rs) >= $signed(a_i_data_2)) ? 32'd1 : 32'd0;
        end
        else if (funct_bltu) begin
            done = 1'b1;
            alu_value = ($unsigned(a_i_data_rs) < $unsigned(a_i_data_2)) ? 32'd1 : 32'd0;
        end
        else if (funct_bgeu) begin
            done = 1'b1;
            alu_value = ($unsigned(a_i_data_rs) >= $unsigned(a_i_data_2)) ? 32'd1 : 32'd0;
        end
        else if (a_i_mul) begin
            done = 1'b1;
            if (a_i_funct3 == `MUL) begin
                temp_result = (a_i_data_rs * a_i_data_2);
                alu_value = temp_result[31 : 0];
            end
            else if (a_i_funct3 == `MULH) begin
                temp_signed_result = ($signed(a_i_data_rs) * $signed(a_i_data_2));
                alu_value = temp_signed_result[63 : 32];
            end
            else if (a_i_funct3 == `MULHSU) begin
                temp_mixed_result = rs_signed_ext * rt_unsigned_ext_signed;
                alu_value = temp_mixed_result[63 : 32];
            end
            else if (a_i_funct3 == `MULHU) begin
                temp_unsigned_result = ($unsigned(a_i_data_rs) * $unsigned(a_i_data_2));
                alu_value = temp_unsigned_result[63 : 32];
            end
        end
        else if (a_i_div) begin
            done = 1'b1;
            if (a_i_funct3 == `DIV) begin
                if (a_i_data_2 != {`DWIDTH{1'b0}}) begin
                    if ((a_i_data_rs == 32'h80000000) && (a_i_data_2 == 32'hffffffff)) begin
                        alu_value = 32'h80000000; // DIV overflow
                    end
                    else begin
                        alu_value = ($signed(a_i_data_rs) / $signed(a_i_data_2));
                    end
                end
                else begin
                    alu_value = 32'hffffffff;
                end
            end
            else if (a_i_funct3 == `DIVU) begin
                if (a_i_data_2 != {`DWIDTH{1'b0}}) begin
                    alu_value = ($unsigned(a_i_data_rs) / $unsigned(a_i_data_2));
                end
                else begin
                    alu_value = 32'hffffffff;
                end
            end
            else if (a_i_funct3 == `REM) begin
                if (a_i_data_2 != {`DWIDTH{1'b0}}) begin
                    if ((a_i_data_rs == 32'h80000000) && (a_i_data_2 == 32'hffffffff)) begin
                        alu_value = 32'h00000000; // REM overflow
                    end
                    else begin
                        alu_value = ($signed(a_i_data_rs) % $signed(a_i_data_2));
                    end
                end
                else begin
                    alu_value = a_i_data_rs;
                end
            end
            else if (a_i_funct3 == `REMU) begin
                if (a_i_data_2 != {`DWIDTH{1'b0}}) begin
                    alu_value = ($unsigned(a_i_data_rs) % $unsigned(a_i_data_2));
                end
                else begin
                    alu_value = a_i_data_rs;
                end
            end
        end
    end
endmodule
