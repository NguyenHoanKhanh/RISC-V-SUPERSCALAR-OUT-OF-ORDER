`timescale 1ns/1ps
`include "../src/header_nomul.vh"
`include "../src/division.v"

module tb_division_signed;
    reg clk;
    reg rstn;
    reg div_ce;
    reg result_ready;
    reg [`FUNCT3_WIDTH-1:0] funct3;
    reg [`DWIDTH-1:0] rs;
    reg [`DWIDTH-1:0] rt;

    wire [`DWIDTH-1:0] value;
    wire busy;
    wire ce;
    wire [`FUNCT3_WIDTH-1:0] out_funct3;

    division dut (
        .div_clk(clk),
        .div_rst(rstn),
        .div_i_div_ce(div_ce),
        .div_i_result_ready(result_ready),
        .div_i_opcode(`RTYPE),
        .div_i_funct3(funct3),
        .div_i_data_rs(rs),
        .div_i_data_rt(rt),
        .div_i_reg_write(1'b1),
        .div_i_rob_idx({`ROB_IDX_W{1'b0}}),
        .div_i_tag({`RAT_SIZE{1'b0}}),
        .div_o_alu_value(value),
        .div_o_busy(busy),
        .div_o_ce(ce),
        .div_o_opcode(),
        .div_o_reg_write(),
        .div_o_rob_idx(),
        .div_o_tag(),
        .div_o_funct3(out_funct3)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    task run_case;
        input [`FUNCT3_WIDTH-1:0] op;
        input [`DWIDTH-1:0] a;
        input [`DWIDTH-1:0] b;
        input [`DWIDTH-1:0] expected;
        begin
            @(negedge clk);
            funct3 = op;
            rs = a;
            rt = b;
            div_ce = 1'b1;
            @(negedge clk);
            div_ce = 1'b0;
            wait (ce);
            #1;
            $display("op=%0d out_op=%0d rs=%h rt=%h value=%h expected=%h %s",
                     op, out_funct3, a, b, value, expected, (value == expected) ? "PASS" : "FAIL");
            if (value !== expected) begin
                $display("division mismatch");
                $finish;
            end
            @(negedge clk);
            result_ready = 1'b1;
            @(negedge clk);
            result_ready = 1'b0;
            repeat (3) @(negedge clk);
        end
    endtask

    initial begin
        rstn = 1'b0;
        div_ce = 1'b0;
        result_ready = 1'b0;
        funct3 = `DIV;
        rs = 32'd0;
        rt = 32'd0;
        repeat (3) @(negedge clk);
        rstn = 1'b1;

        run_case(`DIV, 32'h00000014, 32'hfffffffa, 32'hfffffffd);
        run_case(`REM, 32'h00000014, 32'hfffffffa, 32'h00000002);
        $finish;
    end
endmodule
