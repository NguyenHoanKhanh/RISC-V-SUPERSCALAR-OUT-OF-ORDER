`timescale 1ns/1ps
module imem (
    im_clk, im_rst, im_i_ce, im_i_addr_1, im_i_addr_2, im_i_stall_1, im_i_stall_2,
    im_o_ce, im_o_instr_1, im_o_instr_2
);
    input im_clk, im_rst;
    input im_i_ce;
    input im_i_stall_1, im_i_stall_2;
    input [`PC_WIDTH - 1 : 0] im_i_addr_1, im_i_addr_2;
    output reg im_o_ce;
    output reg [`IWIDTH - 1 : 0] im_o_instr_1, im_o_instr_2;

    localparam IMEM64_DEPTH = (`DEPTH + 1) / 2;
    localparam IMEM64_IDX_W = $clog2(IMEM64_DEPTH);

    // Each M10K word stores two 32-bit instructions:
    //   [31:0]  -> lane 1 instruction at PC
    //   [63:32] -> lane 2 instruction at PC + 4
    (* ramstyle = "M10K" *) reg [63:0] mem_instr64 [0 : IMEM64_DEPTH - 1];

    wire [IMEM64_IDX_W - 1 : 0] im_idx;
    assign im_idx = im_i_addr_1[IMEM64_IDX_W + 2 : 3];

    initial begin
        $readmemh("${KLTN_HOME}/RTL/src/instr64.hex", mem_instr64, 0, IMEM64_DEPTH - 1);
    end

	always @(posedge im_clk or negedge im_rst) begin
	    if (!im_rst) begin
            im_o_ce <= 1'b0;
            im_o_instr_1 <= 32'h00000013;
            im_o_instr_2 <= 32'h00000013;
	    end
	    else begin
            im_o_ce <= im_i_ce && (!im_i_stall_1 || !im_i_stall_2);

            if (im_i_ce) begin
                if (im_idx < IMEM64_DEPTH) begin
                    if (!im_i_stall_1)
                        im_o_instr_1 <= mem_instr64[im_idx][31:0];

                    if (!im_i_stall_2)
                        im_o_instr_2 <= mem_instr64[im_idx][63:32];
                end
                else begin
                    if (!im_i_stall_1)
                        im_o_instr_1 <= 32'h00000013;

                    if (!im_i_stall_2)
                        im_o_instr_2 <= 32'h00000013;
                end
            end
            else begin
                im_o_instr_1 <= 32'h00000013;
                im_o_instr_2 <= 32'h00000013;
            end
	    end
	end
endmodule
