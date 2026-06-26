`timescale 1ns/1ps

module treat_jal (
    tj_i_jal, tj_i_pc, tj_i_imm, tj_o_pc, tj_o_ra, tj_o_change_pc
);
    input tj_i_jal;
    input [`PC_WIDTH - 1 : 0] tj_i_pc;
    input [`IMM_WIDTH - 1 : 0] tj_i_imm;
    output reg tj_o_change_pc;
    output reg [`PC_WIDTH - 1 : 0] tj_o_pc;
    output reg [`PC_WIDTH - 1 : 0] tj_o_ra;

    always @(*) begin
        tj_o_change_pc = 1'b0;
        tj_o_ra = {`PC_WIDTH{1'b0}};
        tj_o_pc = {`PC_WIDTH{1'b0}};
        if (tj_i_jal) begin
            tj_o_ra = tj_i_pc + 4;
            tj_o_change_pc = 1'b1;
            tj_o_pc = tj_i_pc + tj_i_imm;
        end
        else begin
            tj_o_change_pc = 1'b0;
            tj_o_pc = {`PC_WIDTH{1'b0}};
            tj_o_ra = {`PC_WIDTH{1'b0}};
        end
    end
endmodule