`timescale 1ns/1ps

module decoder_stage (
    ds_i_ce, ds_i_instr, ds_o_opcode, ds_o_funct3, ds_o_funct7, ds_o_shamt, ds_o_imm, 
    ds_o_alu_src, ds_o_branch, ds_o_regdst, ds_o_memwrite, ds_o_memtoreg, ds_o_regwrite, 
    ds_o_addr_rs, ds_o_addr_rt, ds_o_addr_rd, ds_o_ce, ds_o_jal
);
    input ds_i_ce;
    input [`IWIDTH - 1 : 0] ds_i_instr;
    output reg ds_o_ce;
    output reg ds_o_jal;
    output reg ds_o_branch; 
    output reg ds_o_regdst; 
    output reg ds_o_alu_src;
    output reg ds_o_memwrite; 
    output reg ds_o_memtoreg;
    output reg ds_o_regwrite;
    output reg [`IMM_WIDTH - 1 : 0] ds_o_imm;
    output reg [`SHAMT_WIDTH - 1 : 0] ds_o_shamt;
    output reg [`OPCODE_WIDTH - 1 : 0] ds_o_opcode;
    output reg [`FUNCT3_WIDTH - 1 : 0] ds_o_funct3;
    output reg [`FUNCT7_WIDTH - 1 : 0] ds_o_funct7;
    output reg [`AWIDTH - 1 : 0] ds_o_addr_rd, ds_o_addr_rs, ds_o_addr_rt;

    wire [`FUNCT3_WIDTH - 1 : 0] funct_sll = `SLL;
    wire [`FUNCT3_WIDTH - 1 : 0] funct_srl = `SRL;
    wire [`FUNCT7_WIDTH - 1 : 0] funct_sra = `SRA;

    wire [`AWIDTH - 1 : 0] rs, rt, rd;
    assign rs = ds_i_instr[19 : 15];
    assign rt= ds_i_instr[24 : 20];
    assign rd = ds_i_instr[11 : 7];

    wire [4 : 0] temp_shamt;
    assign temp_shamt = ds_i_instr[24 : 20];

    wire [`OPCODE_WIDTH - 1 : 0] temp_opcode;
    assign temp_opcode = ds_i_instr[6 : 0]; 

    wire [`FUNCT3_WIDTH - 1 : 0] temp_funct3;
    assign temp_funct3 = ds_i_instr[14 : 12];

    wire [`FUNCT7_WIDTH - 1 : 0] temp_funct7;
    assign temp_funct7 = ds_i_instr[31 : 25];

    wire op_jal = temp_opcode == `JAL;
    wire op_jalr = temp_opcode == `JALR;
    wire op_load = temp_opcode == `LOAD;
    wire op_rtype = temp_opcode == `RTYPE;
    wire op_itype = temp_opcode == `ITYPE;
    wire op_store = temp_opcode == `STORE;
    wire op_btype = temp_opcode == `BTYPE;
    wire op_lui = temp_opcode == `LUI;
    wire op_auipc = temp_opcode == `AUIPC;

    always @(*) begin
        ds_o_ce = 1'b0;
        ds_o_jal = 1'b0;
        ds_o_branch = 1'b0;
        ds_o_regdst = 1'b0;
        ds_o_alu_src = 1'b0;
        ds_o_memwrite = 1'b0;
        ds_o_memtoreg = 1'b0;
        ds_o_regwrite = 1'b0;
        ds_o_imm = {`IMM_WIDTH{1'b0}};
        ds_o_addr_rd = {`AWIDTH{1'b0}};
        ds_o_addr_rs = {`AWIDTH{1'b0}};
        ds_o_addr_rt = {`AWIDTH{1'b0}};
        ds_o_shamt = {`SHAMT_WIDTH{1'b0}};
        ds_o_opcode = {`OPCODE_WIDTH{1'b0}};
        ds_o_funct3 = {`FUNCT3_WIDTH{1'b0}};
        ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};

        if (ds_i_ce) begin
            if (op_rtype) begin
                ds_o_ce = 1'b1;
                ds_o_addr_rd = rd;
                ds_o_addr_rs = rs;
                ds_o_addr_rt = rt;
                ds_o_regdst = 1'b1;
                ds_o_branch = 1'b0;
                ds_o_alu_src = 1'b0;
                ds_o_memtoreg = 1'b0;
                ds_o_memwrite = 1'b0;
                ds_o_regwrite = 1'b1;
                ds_o_opcode = temp_opcode;
                ds_o_funct3 = temp_funct3;
                ds_o_funct7 = temp_funct7;
                ds_o_imm = {`IMM_WIDTH{1'b0}};
            end
            else if (op_itype) begin
                ds_o_ce = 1'b1;
                ds_o_addr_rs = rs;
                ds_o_addr_rt = {`AWIDTH{1'b0}};
                ds_o_regdst = 1'b1;
                ds_o_branch = 1'b0;
                ds_o_alu_src = 1'b1;
                ds_o_memtoreg = 1'b0;
                ds_o_memwrite = 1'b0;
                ds_o_regwrite = 1'b1;
                ds_o_opcode = temp_opcode;
                ds_o_funct3 = temp_funct3;
                ds_o_addr_rd = rd;
                if (temp_funct3 == funct_sll) begin
                    ds_o_shamt = temp_shamt;  
                end
                else if (temp_funct3 == funct_srl) begin
                    ds_o_shamt = temp_shamt;
                    if (temp_funct7 == funct_sra) begin
                        ds_o_funct7 = temp_funct7;
                    end
                end
                else begin
                    ds_o_imm = {{20{ds_i_instr[31]}}, ds_i_instr[31 : 20]};
                end
            end
            else if (op_load) begin
                ds_o_ce = 1'b1;
                ds_o_addr_rs = rs;
                ds_o_addr_rt = {`AWIDTH{1'b0}};
                ds_o_regdst = 1'b0;
                ds_o_branch = 1'b0;
                ds_o_alu_src = 1'b1;
                ds_o_regwrite = 1'b1;
                ds_o_memtoreg = 1'b1;
                ds_o_memwrite = 1'b0;
                ds_o_addr_rd = rd;
                ds_o_opcode = temp_opcode;
                ds_o_funct3 = temp_funct3;
                ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
                ds_o_imm = {{20{ds_i_instr[31]}}, ds_i_instr[31 : 20]};
            end
            else if (op_store) begin
                ds_o_ce = 1'b1;
                ds_o_addr_rs = rs;
                ds_o_addr_rt = rt;
                ds_o_regdst = 1'b0;
                ds_o_branch = 1'b0;
                ds_o_alu_src = 1'b1;
                ds_o_regwrite = 1'b0;
                ds_o_memtoreg = 1'b0;
                ds_o_memwrite = 1'b1;
                ds_o_opcode = temp_opcode;
                ds_o_funct3 = temp_funct3;
                ds_o_addr_rd = {`AWIDTH{1'b0}};
                ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
                ds_o_imm = {{20{ds_i_instr[31]}}, ds_i_instr[31 : 25], ds_i_instr[11 : 7]};
            end
            else if (op_btype) begin
                ds_o_ce = 1'b1;
                ds_o_addr_rs = rs;
                ds_o_addr_rt = rt;
                ds_o_regdst = 1'b0;
                ds_o_branch = 1'b1;
                ds_o_alu_src = 1'b0;
                ds_o_memtoreg = 1'b0;
                ds_o_memwrite = 1'b0;
                ds_o_regwrite = 1'b0;
                ds_o_opcode = temp_opcode;
                ds_o_funct3 = temp_funct3;
                ds_o_addr_rd = {`AWIDTH{1'b0}};
                ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
                ds_o_imm = {{20{ds_i_instr[31]}}, ds_i_instr[7], ds_i_instr[30 : 25], ds_i_instr[11 : 8], 1'b0};
            end
            else if (op_lui || op_auipc) begin
                ds_o_ce = 1'b1;
                ds_o_jal = 1'b0;
                ds_o_branch = 1'b0;
                ds_o_regdst = 1'b1;
                ds_o_alu_src = 1'b1;
                ds_o_regwrite = (rd != {`AWIDTH{1'b0}});
                ds_o_addr_rd = rd;
                ds_o_addr_rs = {`AWIDTH{1'b0}};
                ds_o_addr_rt = {`AWIDTH{1'b0}};
                ds_o_memwrite = 1'b0;
                ds_o_memtoreg = 1'b0;
                ds_o_opcode = temp_opcode;
                ds_o_funct3 = {`FUNCT3_WIDTH{1'b0}};
                ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
                ds_o_imm = {ds_i_instr[31 : 12], 12'b0};
            end
            else if (op_jal || op_jalr) begin
                ds_o_ce = 1'b1;
                ds_o_jal = 1'b1;
                ds_o_branch = 1'b0;
                ds_o_regdst = 1'b1;
                ds_o_alu_src = op_jalr;
                ds_o_regwrite = (rd != {`AWIDTH{1'b0}});
                ds_o_addr_rd = rd;
                ds_o_memwrite = 1'b0;
                ds_o_memtoreg = 1'b0;
                ds_o_opcode = temp_opcode;
                ds_o_addr_rs = op_jalr ? rs : {`AWIDTH{1'b0}};
                ds_o_addr_rt = {`AWIDTH{1'b0}};
                ds_o_funct3 = op_jalr ? temp_funct3 : {`FUNCT3_WIDTH{1'b0}};
                ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
                ds_o_imm = op_jalr ?
                           {{20{ds_i_instr[31]}}, ds_i_instr[31 : 20]} :
                           {{12{ds_i_instr[31]}}, ds_i_instr[19 : 12], ds_i_instr[20], ds_i_instr[30 : 21], 1'b0};
            end
            else begin
                ds_o_ce = 1'b0;
                ds_o_branch = 1'b0;
                ds_o_regdst = 1'b0;
                ds_o_alu_src = 1'b0;
                ds_o_memwrite = 1'b0;
                ds_o_memtoreg = 1'b0;
                ds_o_regwrite = 1'b0;
                ds_o_addr_rd = {`AWIDTH{1'b0}};
                ds_o_addr_rs = {`AWIDTH{1'b0}};
                ds_o_addr_rt = {`AWIDTH{1'b0}};
                ds_o_shamt = {`SHAMT_WIDTH{1'b0}};
                ds_o_opcode = {`OPCODE_WIDTH{1'b0}};
                ds_o_funct3 = {`FUNCT3_WIDTH{1'b0}};
                ds_o_funct7 = {`FUNCT7_WIDTH{1'b0}};
            end
        end
    end
endmodule
