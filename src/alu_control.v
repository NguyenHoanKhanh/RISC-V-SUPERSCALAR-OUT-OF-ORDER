`timescale 1ns/1ps

// ALU control without MUL decode.
// Keeps the same interface as alu_control.v so execute_stage can be swapped easily.
module alu_control (
    ac_i_opcode, ac_i_funct3, ac_i_funct7, ac_o_control, ac_o_is_mul, ac_o_is_div
);
    input [`OPCODE_WIDTH - 1 : 0] ac_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] ac_i_funct3;
    input [`FUNCT7_WIDTH - 1 : 0] ac_i_funct7;
    output reg [`ALU_CONTROL - 1 : 0] ac_o_control;
    output reg ac_o_is_mul;
    output reg ac_o_is_div;

    always @(*) begin
        ac_o_control = {`ALU_CONTROL{1'b0}};
        ac_o_is_mul = 1'b0; // hard-disabled
        ac_o_is_div = 1'b0;
        if (ac_i_opcode == `RTYPE) begin
            if (ac_i_funct7 == `MUL_7) begin
                if (ac_i_funct3 == `MUL || ac_i_funct3 == `MULH ||
                    ac_i_funct3 == `MULHSU || ac_i_funct3 == `MULHU) begin
                    ac_o_is_mul = 1'b1;
                end
                else if (ac_i_funct3 == `DIV || ac_i_funct3 == `DIVU ||
                         ac_i_funct3 == `REM || ac_i_funct3 == `REMU) begin
                    ac_o_is_div = 1'b1;
                end
            end
            else begin
                case (ac_i_funct3)
                    `ADD : begin
                        if (ac_i_funct7 == `SUB) begin
                            ac_o_control = 4'd1;
                        end
                        else begin
                            ac_o_control = 4'd0;
                        end
                    end
                    `SLL : begin
                        ac_o_control = 4'd2;
                    end
                    `SLT : begin
                        ac_o_control = 4'd3;
                    end
                    `SLTU : begin
                        ac_o_control = 4'd4;
                    end
                    `XOR : begin
                        ac_o_control = 4'd5;
                    end
                    `OR : begin
                        ac_o_control = 4'd6;
                    end
                    `AND : begin
                        ac_o_control = 4'd7;
                    end
                    `SRL : begin
                        if (ac_i_funct7 == `SRA) begin
                            ac_o_control = 4'd9;
                        end
                        else begin
                            ac_o_control = 4'd8;
                        end
                    end
                    default : begin
                        ac_o_control = {`ALU_CONTROL{1'b0}};
                    end
                endcase
            end
        end
        else if (ac_i_opcode == `ITYPE) begin
            case (ac_i_funct3)
                `ADD : begin
                    ac_o_control = 4'd0;
                end
                `SLL : begin
                    ac_o_control = 4'd2;
                end
                `SLT : begin
                    ac_o_control = 4'd3;
                end
                `SLTU : begin
                    ac_o_control = 4'd4;
                end
                `XOR : begin
                    ac_o_control = 4'd5;
                end
                `OR : begin
                    ac_o_control = 4'd6;
                end
                `AND : begin
                    ac_o_control = 4'd7;
                end
                `SRL : begin
                    if (ac_i_funct7 == `ZERO) begin
                        ac_o_control = 4'd8;
                    end
                    else if (ac_i_funct7 == `SRA) begin
                        ac_o_control = 4'd9;
                    end
                end
                default : begin
                    ac_o_control = {`ALU_CONTROL{1'b0}};
                end
            endcase
        end
        else if (ac_i_opcode == `STORE || ac_i_opcode == `LOAD) begin
            ac_o_control = 4'd0;
        end
        else if (ac_i_opcode == `BTYPE) begin
            if (ac_i_funct3 == `BEQ) begin
                ac_o_control = 4'd10;
            end
            else if (ac_i_funct3 == `BNE) begin
                ac_o_control = 4'd11;
            end
            else if (ac_i_funct3 == `BLT) begin
                ac_o_control = 4'd12;
            end
            else if (ac_i_funct3 == `BGE) begin
                ac_o_control = 4'd13;
            end
            else if (ac_i_funct3 == `BLTU) begin
                ac_o_control = 4'd14;
            end
            else if (ac_i_funct3 == `BGEU) begin
                ac_o_control = 4'd15;
            end
        end
    end
endmodule
