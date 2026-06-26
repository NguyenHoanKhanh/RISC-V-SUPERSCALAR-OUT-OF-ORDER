`ifndef FORWARDING_V
`define FORWARDING_V
`include "./source/header.vh"
module forwarding (
    ds_es_i_opcode, ds_es_i_addr_rs1, ds_es_i_addr_rs2, es_ms_i_addr_rd, es_ms_i_regwrite, 
    ms_wb_i_regwrite, ms_wb_i_addr_rd, f_o_control_rs1, f_o_control_rs2, f_o_stall
);
    input es_ms_i_regwrite;
    input ms_wb_i_regwrite;
    input [`AWIDTH - 1 : 0] es_ms_i_addr_rd;
    input [`AWIDTH - 1 : 0] ms_wb_i_addr_rd;
    input [`OPCODE_WIDTH - 1 : 0] ds_es_i_opcode;
    input [`AWIDTH - 1 : 0] ds_es_i_addr_rs1, ds_es_i_addr_rs2;
    output reg f_o_stall;
    output reg [1 : 0] f_o_control_rs1, f_o_control_rs2;

    wire ds_es_op_load = ds_es_i_opcode == `LOAD;
    always @(*) begin
        f_o_stall = 1'b0;
        if ((es_ms_i_addr_rd != {`AWIDTH{1'b0}}) &&
            ((ds_es_i_addr_rs1 == es_ms_i_addr_rd) || (ds_es_i_addr_rs2 == es_ms_i_addr_rd)) &&
            ds_es_op_load) begin
            f_o_stall = 1'b1;
        end
        else begin
            f_o_stall = 1'b0;
        end
    end

    always @(*) begin
        f_o_control_rs1 = 2'd0;
        f_o_control_rs2 = 2'd0;

        if ((ds_es_i_addr_rs1 != {`AWIDTH{1'b0}}) &&
            (ds_es_i_addr_rs1 == es_ms_i_addr_rd) && es_ms_i_regwrite) begin
            f_o_control_rs1 = 2'd1;
        end 
        else if ((ds_es_i_addr_rs1 != {`AWIDTH{1'b0}}) &&
            (ds_es_i_addr_rs1 == ms_wb_i_addr_rd) && ms_wb_i_regwrite) begin
            f_o_control_rs1 = 2'd2;
        end
        else begin
            f_o_control_rs1 = 2'd0;
        end

        if ((ds_es_i_addr_rs2 != {`AWIDTH{1'b0}}) &&
            (ds_es_i_addr_rs2 == es_ms_i_addr_rd) && es_ms_i_regwrite) begin
            f_o_control_rs2 = 2'd1;
        end 
        else if ((ds_es_i_addr_rs2 != {`AWIDTH{1'b0}}) &&
            (ds_es_i_addr_rs2 == ms_wb_i_addr_rd) && ms_wb_i_regwrite) begin
            f_o_control_rs2 = 2'd2;
        end
        else begin
            f_o_control_rs2 = 2'd0;
        end
    end
endmodule
`endif 
