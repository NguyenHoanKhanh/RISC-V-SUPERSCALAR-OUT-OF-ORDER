`timescale 1ns/1ps
module treat_store(
    ts_i_store_data, ts_i_store_addr, ts_i_opcode, ts_i_funct_3, ts_o_store_data, ts_o_store_mask
);
    input [`DWIDTH - 1 : 0] ts_i_store_data;
    input [`DWIDTH - 1 : 0] ts_i_store_addr;
    input [`OPCODE_WIDTH - 1 : 0] ts_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] ts_i_funct_3;
    output reg [3 : 0] ts_o_store_mask;
    output reg [`DWIDTH - 1 : 0] ts_o_store_data;

    always @(*) begin
       ts_o_store_mask = 4'b0;
       ts_o_store_data = {`DWIDTH{1'b0}};
       if (ts_i_opcode == `STORE) begin
            case (ts_i_funct_3)
                `SW : begin
                    ts_o_store_mask = 4'b1111;
                    ts_o_store_data = ts_i_store_data;
                end
                `SH : begin
                    case (ts_i_store_addr[1])
                        1'b0 : begin
                            ts_o_store_mask = 4'b0011;
                            ts_o_store_data = {16'b0, ts_i_store_data[15 : 0]};
                        end
                        1'b1 : begin    
                            ts_o_store_mask = 4'b1100; 
                            ts_o_store_data = {ts_i_store_data[15 : 0], 16'b0};
                        end
                        default : begin 
                            ts_o_store_mask = 4'b0000;
                            ts_o_store_data = {`DWIDTH{1'b0}};
                        end
                    endcase
                end
                `SB : begin
                    case (ts_i_store_addr[1 : 0])
                        2'b00 : begin   
                            ts_o_store_mask = 4'b0001;
                            ts_o_store_data = {24'b0, ts_i_store_data[7 : 0]};
                        end
                        2'b01 : begin   
                            ts_o_store_mask = 4'b0010;
                            ts_o_store_data = {16'b0, ts_i_store_data[7 : 0], 8'b0};
                        end
                        2'b10 : begin
                            ts_o_store_mask = 4'b0100;
                            ts_o_store_data = {8'b0, ts_i_store_data[7 : 0], 16'b0};
                        end
                        2'b11 : begin   
                            ts_o_store_mask = 4'b1000; 
                            ts_o_store_data = {ts_i_store_data[7 : 0], 24'b0};
                        end
                        default : begin 
                            ts_o_store_mask = 4'b0000;
                            ts_o_store_data = {`DWIDTH{1'b0}};
                        end
                    endcase
                end
                default : begin
                    ts_o_store_mask = 4'b0000;
                    ts_o_store_data = {`DWIDTH{1'b0}};
                end 
            endcase
       end 
       else begin
            ts_o_store_mask = 4'b0000;
            ts_o_store_data = {`DWIDTH{1'b0}};
       end
    end
endmodule