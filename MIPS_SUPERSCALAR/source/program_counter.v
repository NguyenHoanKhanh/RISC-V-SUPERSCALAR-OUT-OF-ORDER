`ifndef PROGRAM_COUNTER_V
`define PROGRAM_COUNTER_V
`include "./source/header.vh"

module program_counter (
    pc_i_clk, pc_i_rst, pc_i_ce, pc_i_pc_1, pc_i_pc_2, pc_i_change_pc_1, pc_i_change_pc_2, pc_o_pc_1, 
    pc_o_pc_2, pc_o_ce
);
    input pc_i_clk, pc_i_rst;
    input pc_i_ce;
    input pc_i_change_pc_1, pc_i_change_pc_2;
    input [`PC_WIDTH - 1 : 0] pc_i_pc_1, pc_i_pc_2;
    output reg pc_o_ce;
    output reg [`PC_WIDTH - 1 : 0] pc_o_pc_1, pc_o_pc_2;
    reg [`PC_WIDTH - 1 : 0] temp_pc;
    reg [`PC_WIDTH - 1 : 0] temp_pc_1, temp_pc_2;

    always @(posedge pc_i_clk, negedge pc_i_rst) begin
        if (!pc_i_rst) begin
            pc_o_ce <= 1'b0;
            temp_pc <= {`PC_WIDTH{1'b0}};
            pc_o_pc_1 <= {`PC_WIDTH{1'b0}};
            pc_o_pc_2 <= {`PC_WIDTH{1'b0}};
            temp_pc_1 <= {`PC_WIDTH{1'b0}};
            temp_pc_2 <= {`PC_WIDTH{1'b0}};
        end
        else begin
            if (pc_i_ce) begin
                pc_o_ce <= 1'b1;
                temp_pc_1 <= pc_o_pc_1;
                temp_pc_2 <= pc_o_pc_2;
                if (pc_i_change_pc_1) begin
                    pc_o_pc_1 <= pc_i_pc_1;
                    pc_o_pc_2 <= pc_i_pc_1 + 4;
                    temp_pc <= pc_i_pc_1 + 8;
                end
                else if (pc_i_change_pc_2) begin
                    pc_o_pc_1 <= pc_i_pc_2;
                    pc_o_pc_2 <= pc_i_pc_2 + 4;
                    temp_pc <= pc_i_pc_2 + 8;
                end
                else begin
                    pc_o_pc_1 <= temp_pc;
                    pc_o_pc_2 <= temp_pc + 4;
                    temp_pc <= temp_pc + 8;
                end
            end
            else begin
                pc_o_pc_1 <= pc_o_pc_1;
                pc_o_pc_2 <= pc_o_pc_2;
                temp_pc <= temp_pc;
                pc_o_ce <= 1'b0;
            end
        end
    end
endmodule
`endif 