`ifndef ALU_CONTROL_V
`define ALU_CONTROL_V
`include "./source/header.vh"

module alucontrol (
    ac_i_opcode, ac_i_funct3, ac_i_funct7, ac_o_control
);
    input [`OPCODE_WIDTH - 1 : 0] ac_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] ac_i_funct3;
    input [`FUNCT7_WIDTH - 1 : 0] ac_i_funct7;
    output reg [`ALU_CONTROL - 1 : 0] ac_o_control;

    always @(*) begin
        ac_o_control = {`ALU_CONTROL{1'b0}};
        if (ac_i_opcode == `RTYPE) begin
            case (ac_i_funct3)
                `ADD: ac_o_control = (ac_i_funct7 == `SUB) ? 5'd1 : 5'd0;
                `SLL: ac_o_control = 5'd7;
                `SLT: ac_o_control = 5'd5;
                `SLTU: ac_o_control = 5'd6;
                `XOR: ac_o_control = 5'd15;
                `SRL: ac_o_control = (ac_i_funct7 == `SRA) ? 5'd9 : 5'd8;
                `OR: ac_o_control = 5'd3;
                `AND: ac_o_control = 5'd2;
                default: ac_o_control = 5'd0;
            endcase
        end
        else if (ac_i_opcode == `ITYPE) begin
            case (ac_i_funct3)
                `ADD: ac_o_control = 5'd0;
                `SLL: ac_o_control = 5'd7;
                `SLT: ac_o_control = 5'd5;
                `SLTU: ac_o_control = 5'd6;
                `XOR: ac_o_control = 5'd15;
                `SRL: ac_o_control = (ac_i_funct7 == `SRA) ? 5'd9 : 5'd8;
                `OR: ac_o_control = 5'd3;
                `AND: ac_o_control = 5'd2;
                default: ac_o_control = 5'd0;
            endcase
        end
        else if (ac_i_opcode == `LOAD || ac_i_opcode == `STORE) begin
            ac_o_control = 5'd0;
        end
    end
endmodule
`endif
