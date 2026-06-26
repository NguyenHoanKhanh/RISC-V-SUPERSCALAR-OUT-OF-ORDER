`ifndef IMEM_V
`define IMEM_V
`timescale 1ns/1ps
`include "./source/header.vh"
`include "./source/program_info.vh"

module imem (
    im_clk, im_rst, im_i_ce, im_i_addr_1, im_i_addr_2, im_o_instr_1, 
    im_o_instr_2, im_o_ce
);
    input im_clk, im_rst;
    input im_i_ce;
    input [`PC_WIDTH - 1 : 0] im_i_addr_1, im_i_addr_2;
    output [`IWIDTH - 1 : 0] im_o_instr_1, im_o_instr_2;
    output im_o_ce;

    reg [`IWIDTH - 1 : 0] mem_instr [0 : `DEPTH - 1];
    integer imem_i;
    wire [`PC_WIDTH - 3 : 0] instr_index_1 = im_i_addr_1[`PC_WIDTH - 1 : 2];
    wire [`PC_WIDTH - 3 : 0] instr_index_2 = im_i_addr_2[`PC_WIDTH - 1 : 2];
    wire valid_addr_1 = instr_index_1 < `DEPTH;
    wire valid_addr_2 = instr_index_2 < `DEPTH;

    initial begin
        for (imem_i = 0; imem_i < `DEPTH; imem_i = imem_i + 1) begin
            mem_instr[imem_i] = {`IWIDTH{1'b0}};
        end
        $readmemh("./source/imem.txt", mem_instr, 0, `PROGRAM_INSTRS - 1);
        if ($test$plusargs("MIPS_PRINT_IMEM") || $test$plusargs("MIPS_DEBUG_FETCH")) begin
            $display("MIPS_SUPERSCALAR IMEM: ./source/imem.txt PROGRAM_INSTRS=%0d", `PROGRAM_INSTRS);
            $display("MIPS_SUPERSCALAR IMEM[0]=%h IMEM[1]=%h IMEM[2]=%h IMEM[3]=%h",
                     mem_instr[0], mem_instr[1], mem_instr[2], mem_instr[3]);
            $display("MIPS_SUPERSCALAR IMEM[7]=%h IMEM[14]=%h IMEM[21]=%h IMEM[28]=%h",
                     mem_instr[7], mem_instr[14], mem_instr[21], mem_instr[28]);
        end
    end

    assign im_o_ce = im_i_ce && (valid_addr_1 || valid_addr_2);

    assign im_o_instr_1 =
        (im_i_ce && valid_addr_1) ?
        mem_instr[instr_index_1] :
        32'h00000013;

    assign im_o_instr_2 =
        (im_i_ce && valid_addr_2) ?
        mem_instr[instr_index_2] :
        32'h00000013;
endmodule
`endif
