`include "./source/forwarding.v"
module tb;
    reg [`OPCODE_WIDTH - 1 : 0] ds_es_i_opcode;
    reg [`AWIDTH - 1 : 0] ds_es_i_addr_rs1, ds_es_i_addr_rs2;
    reg [`AWIDTH - 1 : 0] es_ms_i_addr_rd, ms_wb_i_addr_rd;
    reg es_ms_i_regwrite, ms_wb_i_regwrite;
    wire [1 : 0] f_o_control_rs1, f_o_control_rs2;
    wire f_o_stall;

    forwarding f (
        .ds_es_i_addr_rs1(ds_es_i_addr_rs1), 
        .ds_es_i_addr_rs2(ds_es_i_addr_rs2), 
        .es_ms_i_addr_rd(es_ms_i_addr_rd), 
        .es_ms_i_regwrite(es_ms_i_regwrite), 
        .ms_wb_i_regwrite(ms_wb_i_regwrite),
        .ms_wb_i_addr_rd(ms_wb_i_addr_rd), 
        .f_o_control_rs1(f_o_control_rs1), 
        .f_o_control_rs2(f_o_control_rs2),
        .f_o_stall(f_o_stall)
    );

    initial begin
        ds_es_i_addr_rs1 = {`AWIDTH{1'b0}};
        ds_es_i_addr_rs2 = {`AWIDTH{1'b0}};
        es_ms_i_addr_rd = {`AWIDTH{1'b0}};
        ms_wb_i_addr_rd = {`AWIDTH{1'b0}};
        es_ms_i_regwrite = 1'b0;
        ms_wb_i_regwrite = 1'b0;
    end

    initial begin
        $dumpfile("./waveform/forwarding.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #1;
        ds_es_i_addr_rs1 = 5;
        ds_es_i_addr_rs2 = 10;
        #10;
        es_ms_i_addr_rd = 5;
        es_ms_i_regwrite = 1'b1;
        ms_wb_i_addr_rd = 7;
        ms_wb_i_regwrite = 1'b1;
        #10; 
        es_ms_i_addr_rd = 7;
        es_ms_i_regwrite = 1'b1;
        ms_wb_i_addr_rd = 10;
        ms_wb_i_regwrite = 1'b1;
        #20; $finish;
    end

    initial begin
        $monitor($time, " ", "f_o_control_rs1 = %d, f_o_control_rs2 = %d, f_o_stall = %b", f_o_control_rs1, f_o_control_rs2, f_o_stall);
    end
endmodule