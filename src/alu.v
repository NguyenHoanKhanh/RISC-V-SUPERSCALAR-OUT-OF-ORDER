`timescale 1ns/1ps
`include "header_nomul.vh"
module alu (
    a_i_imm, a_i_control, a_i_data_rs, a_i_data_rt, a_i_pc,
    a_i_alu_src, a_i_shamt, alu_value, done
);
    input a_i_alu_src;
    input [`PC_WIDTH - 1 : 0] a_i_pc;
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

    always @(*) begin
        done = 1'b0;
        alu_value = {`DWIDTH{1'b0}};

        if (funct_add) begin
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
    end
endmodule
