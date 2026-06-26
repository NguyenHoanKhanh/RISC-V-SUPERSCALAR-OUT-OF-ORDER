`timescale 1ns/1ps 

module treat_load(
    tl_i_load_data, tl_i_load_addr, tl_i_opcode, tl_i_funct_3, tl_o_load_data
);
    input [`DWIDTH - 1 : 0] tl_i_load_data;
    input [`DWIDTH - 1 : 0] tl_i_load_addr;
    input [`OPCODE_WIDTH - 1 : 0] tl_i_opcode;
    input [`FUNCT3_WIDTH - 1 : 0] tl_i_funct_3;
    output reg [`DWIDTH - 1 : 0] tl_o_load_data;
    
    reg [7 : 0] load_byte;
    reg [15 : 0] load_half;
    always @(*) begin
        load_byte = 8'b0;
        load_half = 16'b0;
        tl_o_load_data = {`DWIDTH{1'b0}};
        if (tl_i_opcode == `LOAD) begin
            case (tl_i_funct_3)
                `LW : begin
                    tl_o_load_data = tl_i_load_data;
                end
                `LH : begin
                    case (tl_i_load_addr[1])
                        1'b0 : load_half = tl_i_load_data[15 : 0];
                        1'b1 : load_half = tl_i_load_data[31 : 16];
                        default : load_half = 16'b0;
                    endcase
                    tl_o_load_data = {{16{load_half[15]}}, load_half};
                end
                `LHU : begin
                    case (tl_i_load_addr[1])
                        1'b0 : load_half = tl_i_load_data[15 : 0];
                        1'b1 : load_half = tl_i_load_data[31 : 16];
                        default : load_half = 16'b0; 
                    endcase
                    tl_o_load_data = {16'b0, load_half};
                end
                `LB : begin
                    case (tl_i_load_addr[1 : 0])
                        2'b00 : load_byte = tl_i_load_data[7:0];
                        2'b01 : load_byte = tl_i_load_data[15:8];
                        2'b10 : load_byte = tl_i_load_data[23:16];
                        2'b11 : load_byte = tl_i_load_data[31:24];
                        default : load_byte = 8'b0;
                    endcase
                    tl_o_load_data = {{24{load_byte[7]}}, load_byte};
                end  
                `LBU : begin
                    case (tl_i_load_addr[1 : 0])
                        2'b00 : load_byte = tl_i_load_data[7:0];
                        2'b01 : load_byte = tl_i_load_data[15:8];
                        2'b10 : load_byte = tl_i_load_data[23:16];
                        2'b11 : load_byte = tl_i_load_data[31:24];
                        default : load_byte = 8'b0;
                    endcase
                    tl_o_load_data = {24'b0, load_byte};
                end
                default : tl_o_load_data = {`DWIDTH{1'b0}};
            endcase
        end
        else begin
            tl_o_load_data = {`DWIDTH{1'b0}};
        end
    end
endmodule