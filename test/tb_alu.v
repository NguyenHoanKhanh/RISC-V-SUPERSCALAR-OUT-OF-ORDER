`include "alu.v"

module tb_alu;
    reg [`IMM_WIDTH - 1 : 0] a_i_imm;
    reg [`ALU_CONTROL - 1 : 0] a_i_control;
    reg [`DWIDTH - 1 : 0] a_i_data_rs, a_i_data_rt;
    reg [`PC_WIDTH - 1 : 0] a_i_pc;
    reg a_i_alu_src;
    reg [`SHAMT_WIDTH - 1 : 0] a_i_shamt;
    reg a_i_mul;
    reg a_i_div;
    reg [`FUNCT3_WIDTH - 1 : 0] a_i_funct3;
    wire [`DWIDTH - 1 : 0] alu_value;
    wire done;
    integer test_id;
    integer error_count;

    alu u_alu (
        .a_i_imm(a_i_imm), 
        .a_i_control(a_i_control), 
        .a_i_data_rs(a_i_data_rs), 
        .a_i_data_rt(a_i_data_rt), 
        .a_i_pc(a_i_pc),
        .a_i_alu_src(a_i_alu_src), 
        .a_i_shamt(a_i_shamt), 
        .a_i_mul(a_i_mul), 
        .a_i_div(a_i_div),
        .a_i_funct3(a_i_funct3),
        .alu_value(alu_value), 
        .done(done)
    );

    initial begin
        a_i_mul = 1'b0;
        a_i_div = 1'b0;
        a_i_alu_src = 1'b0;
        a_i_pc = {`PC_WIDTH{1'b0}};
        a_i_imm = {`IMM_WIDTH{1'b0}};
        a_i_data_rs = {`DWIDTH{1'b0}};
        a_i_data_rt = {`DWIDTH{1'b0}};
        a_i_shamt = {`SHAMT_WIDTH{1'b0}};
        a_i_funct3 = {`FUNCT3_WIDTH{1'b0}};
        a_i_control = {`ALU_CONTROL{1'b0}};
    end

    initial begin
        $dumpfile("./sim/alu.vcd");
        $dumpvars(0, tb_alu);
    end

    task run_mul_case;
        input [`FUNCT3_WIDTH - 1 : 0] funct3;
        input [`DWIDTH - 1 : 0] rs_value;
        input [`DWIDTH - 1 : 0] rt_value;
        input [`DWIDTH - 1 : 0] expected;
        begin
            test_id = test_id + 1;
            a_i_mul = 1'b1;
            a_i_div = 1'b0;
            a_i_funct3 = funct3;
            a_i_data_rs = rs_value;
            a_i_data_rt = rt_value;
            #10;

            if (alu_value !== expected) begin
                error_count = error_count + 1;
                $display("FAIL test_%0d funct3=%b rs=0x%08h rt=0x%08h got=0x%08h expected=0x%08h",
                         test_id, funct3, rs_value, rt_value, alu_value, expected);
            end
            else begin
                $display("PASS test_%0d funct3=%b rs=0x%08h rt=0x%08h result=0x%08h",
                         test_id, funct3, rs_value, rt_value, alu_value);
            end
        end
    endtask

    initial begin
        test_id = 0;
        error_count = 0;
        #1;

        // MUL: low 32 bits
        run_mul_case(`MUL,    32'd10,       32'd11,       32'd110);
        run_mul_case(`MUL,    32'hffffffff, 32'd2,        32'hfffffffe);
        run_mul_case(`MUL,    32'h80000000, 32'd2,        32'h00000000);
        run_mul_case(`MUL,    32'h00000000, 32'hffffffff, 32'h00000000);

        // MULH: high 32 bits, signed x signed
        run_mul_case(`MULH,   32'hffffffff, 32'd2,        32'hffffffff);
        run_mul_case(`MULH,   32'h80000000, 32'd2,        32'hffffffff);
        run_mul_case(`MULH,   32'h7fffffff, 32'd2,        32'h00000000);

        // MULHSU: high 32 bits, signed x unsigned
        run_mul_case(`MULHSU, 32'hffffffff, 32'd2,        32'hffffffff);
        run_mul_case(`MULHSU, 32'h80000000, 32'd2,        32'hffffffff);
        run_mul_case(`MULHSU, 32'h7fffffff, 32'd2,        32'h00000000);

        // MULHU: high 32 bits, unsigned x unsigned
        run_mul_case(`MULHU,  32'hffffffff, 32'hffffffff, 32'hfffffffe);
        run_mul_case(`MULHU,  32'h80000000, 32'd2,        32'h00000001);
        run_mul_case(`MULHU,  32'h00010000, 32'h00010000, 32'h00000001);

        if (error_count == 0) begin
            $display("==========================================");
            $display("ALU MUL TEST PASS: %0d cases", test_id);
            $display("==========================================");
        end
        else begin
            $display("==========================================");
            $display("ALU MUL TEST FAIL: %0d/%0d cases failed", error_count, test_id);
            $display("==========================================");
        end

        #10;
        $finish;
    end

    initial begin
        $monitor($time, " ", " a_i_data_rs = %d, a_i_data_rt = %d, alu_value = %d", a_i_data_rs, a_i_data_rt, alu_value);
    end
endmodule
