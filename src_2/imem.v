`timescale 1ns/1ps
`include "header_nomul.vh"
`include "program_info.vh"
module imem (
    im_i_ce, im_i_addr_1, im_i_addr_2, im_i_stall_1, im_i_stall_2,
    im_o_ce, im_o_instr_1, im_o_instr_2
);
    input im_i_ce;
    input im_i_stall_1, im_i_stall_2;
    input [`PC_WIDTH - 1 : 0] im_i_addr_1, im_i_addr_2;
    output im_o_ce;
    output [`IWIDTH - 1 : 0] im_o_instr_1, im_o_instr_2;

    reg [`IWIDTH - 1 : 0] mem_instr [`DEPTH - 1 : 0];
    localparam IMEM_IDX_W = $clog2(`DEPTH);

	wire [IMEM_IDX_W-1:0] im_idx_1;
	wire [IMEM_IDX_W-1:0] im_idx_2;

	assign im_idx_1 = im_i_addr_1[IMEM_IDX_W+1:2];
	assign im_idx_2 = im_i_addr_2[IMEM_IDX_W+1:2];

	initial begin
`ifdef USE_SRC2
		$readmemh("./src_2/instr.hex", mem_instr, 0, `PROGRAM_INSTRS - 1);
`else
		$readmemh("./src/instr.hex", mem_instr, 0, `PROGRAM_INSTRS - 1);
`endif
	end

	assign im_o_ce = im_i_ce && (!im_i_stall_1 || !im_i_stall_2);

	assign im_o_instr_1 =
		(im_i_ce && !im_i_stall_1 && (im_idx_1 < `DEPTH)) ?
		mem_instr[im_idx_1] :
		32'h00000013;

	assign im_o_instr_2 =
		(im_i_ce && !im_i_stall_2 && (im_idx_2 < `DEPTH)) ?
		mem_instr[im_idx_2] :
		32'h00000013;
endmodule


// module imem (
//     im_clk, im_rst, im_i_ce, im_i_addr_1, im_i_addr_2, im_i_stall_1, im_i_stall_2,
//     im_o_ce, im_o_instr_1, im_o_instr_2
// );
//     input im_clk, im_rst;
//     input im_i_ce;
//     input im_i_stall_1, im_i_stall_2;
//     input [`PC_WIDTH - 1 : 0] im_i_addr_1, im_i_addr_2;
//     output im_o_ce;
//     output [`IWIDTH - 1 : 0] im_o_instr_1, im_o_instr_2;

//     localparam IMEM64_DEPTH = (`DEPTH + 1) / 2;
//     localparam IMEM64_IDX_W = $clog2(IMEM64_DEPTH);

//     (* ramstyle = "M10K" *) reg [63:0] mem_instr64 [0 : IMEM64_DEPTH - 1];

//     wire [IMEM64_IDX_W - 1 : 0] im_idx_1;
//     wire [IMEM64_IDX_W - 1 : 0] im_idx_2;

//     wire [`IWIDTH - 1 : 0] im_instr_1;
//     wire [`IWIDTH - 1 : 0] im_instr_2;

//     assign im_idx_1 = im_i_addr_1[IMEM64_IDX_W + 2 : 3];
//     assign im_idx_2 = im_i_addr_2[IMEM64_IDX_W + 2 : 3];

//     assign im_instr_1 = im_i_addr_1[2] ? mem_instr64[im_idx_1][63:32] :
//                                          mem_instr64[im_idx_1][31:0];
//     assign im_instr_2 = im_i_addr_2[2] ? mem_instr64[im_idx_2][63:32] :
//                                          mem_instr64[im_idx_2][31:0];

//     initial begin
//         $readmemh("${KLTN_HOME}/RTL/src/instr64.hex", mem_instr64);
//     end

//     assign im_o_ce = im_i_ce && (!im_i_stall_1 || !im_i_stall_2);

//     assign im_o_instr_1 =
//         (im_i_ce && !im_i_stall_1 && (im_idx_1 < IMEM64_DEPTH)) ?
//         im_instr_1 :
//         32'h00000013;

//     assign im_o_instr_2 =
//         (im_i_ce && !im_i_stall_2 && (im_idx_2 < IMEM64_DEPTH)) ?
//         im_instr_2 :
//         32'h00000013;
// endmodule
