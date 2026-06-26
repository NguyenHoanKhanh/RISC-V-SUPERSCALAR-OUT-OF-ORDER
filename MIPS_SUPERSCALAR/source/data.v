`ifndef DATA_V
`define DATA_V
`include "./source/imem.v"
`include "./source/regis.v"
`include "./source/queue.v"
`include "./source/mux2_1.v"
`include "./source/mux3_1.v"
`include "./source/memory.v"
`include "./source/decoder_s.v"
`include "./source/forwarding.v"
`include "./source/treat_load.v"
`include "./source/treat_store.v"
`include "./source/control_hazard.v"
`include "./source/execute_stage_1.v"
`include "./source/program_counter.v"
//Compared to the previous architecture, the queue of the current one will be moved after the ds_es register to reduce latency
module datapath (
    d_clk, d_rst, d_i_ce, wb_ds1_o_data_rd, wb_ds2_o_data_rd, pc_o_pc_1, pc_o_pc_2
);
    input d_i_ce;
    input d_clk, d_rst;
    output [`PC_WIDTH - 1 : 0] pc_o_pc_1, pc_o_pc_2;
    output [`DWIDTH - 1 : 0] wb_ds1_o_data_rd, wb_ds2_o_data_rd;

    wire pc_o_ce;
    reg pc_im_o_ce;
    reg [`PC_WIDTH - 1 : 0] pc_im_o_pc_1, pc_im_o_pc_2;
    
    // Declare control_hazard outputs
    wire ctrl1_o_change_pc;
    wire [`PC_WIDTH - 1 : 0] ctrl1_o_pc;
    wire ctrl2_o_change_pc;
    wire [`PC_WIDTH - 1 : 0] ctrl2_o_pc;
    
    // Declare execute stage outputs to control_hazard
    reg es1_ctrl1_o_change_pc;
    reg [`PC_WIDTH - 1 : 0] es1_ctrl1_o_alu_pc;
    reg es2_ctrl2_o_change_pc;
    reg [`PC_WIDTH - 1 : 0] es2_ctrl2_o_alu_pc;
    
    // Declare forwarding outputs and queue fetch signals
    wire fw1_o_stall;
    wire [1 : 0] fw1_o_data_rs, fw1_o_data_rt;
    wire fw2_o_stall;
    wire [1 : 0] fw2_o_data_rs, fw2_o_data_rt;
    wire qc_o_full;
    wire frontend_stall = qc_o_full;
    reg es1_queue2_o_fetch;
    reg es2_queue1_o_fetch;
    
    // Declare execute stage memory/writeback outputs
    reg es1_ms_o_ce;
    reg es1_qc_o_busy;
    reg es1_ms_o_memwrite;
    reg es1_ms_o_memtoreg;
    reg es1_ms_o_regwrite;
    reg [`AWIDTH - 1 : 0] es1_ms_o_addr_rd;
    reg [`DWIDTH - 1 : 0] es1_ms_o_alu_value;
    reg [`OPCODE_WIDTH - 1 : 0] es1_ms_o_opcode;
    reg [`FUNCT3_WIDTH - 1 : 0] es1_ms_o_funct3;
    reg es2_ms_o_ce;
    reg es2_qc_o_busy;
    reg es2_ms_o_memwrite;
    reg es2_ms_o_memtoreg;
    reg es2_ms_o_regwrite;
    reg [`AWIDTH - 1 : 0] es2_ms_o_addr_rd;
    reg [`DWIDTH - 1 : 0] es2_ms_o_alu_value;
    reg [`OPCODE_WIDTH - 1 : 0] es2_ms_o_opcode;
    reg [`FUNCT3_WIDTH - 1 : 0] es2_ms_o_funct3;
    
    // Declare memory/writeback outputs
    reg ms_wb1_o_memtoreg, ms_wb2_o_memtoreg;
    reg ms_wb1_o_regwrite, ms_wb2_o_regwrite;
    reg [`AWIDTH - 1 : 0] ms_wb1_o_addr_rd, ms_wb2_o_addr_rd;
    reg [`DWIDTH - 1 : 0] ms_wb1_o_alu_value, ms_wb2_o_alu_value;
    reg [`DWIDTH - 1 : 0] ms_wb1_o_load_data_1, ms_wb2_o_load_data_2;
    program_counter pc (
        .pc_i_clk(d_clk), 
        .pc_i_rst(d_rst), 
        .pc_i_ce(d_i_ce && !frontend_stall), 
        .pc_i_pc_1(ctrl1_o_pc), 
        .pc_i_pc_2(ctrl2_o_pc), 
        .pc_i_change_pc_1(ctrl1_o_change_pc), 
        .pc_i_change_pc_2(ctrl2_o_change_pc), 
        .pc_o_pc_1(pc_o_pc_1), 
        .pc_o_pc_2(pc_o_pc_2), 
        .pc_o_ce(pc_o_ce)
    );

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            pc_im_o_ce <= 1'b0;
            pc_im_o_pc_1 <= {`PC_WIDTH{1'b0}};
            pc_im_o_pc_2 <= {`PC_WIDTH{1'b0}};
        end
        else begin
            pc_im_o_ce <= pc_o_ce;
            pc_im_o_pc_1 <= pc_o_pc_1;
            pc_im_o_pc_2 <= pc_o_pc_2;
        end
    end

    wire im_o_ce;
    wire [`IWIDTH - 1 : 0] im_o_instr_1, im_o_instr_2; 
    reg im_ds1_o_ce, im_ds2_o_ce;
    reg [`PC_WIDTH - 1 : 0] im_ds1_o_pc, im_ds2_o_pc;
    reg [`IWIDTH - 1 : 0] im_ds1_o_instr, im_ds2_o_instr;
    imem im (
        .im_clk(d_clk), 
        .im_rst(d_rst), 
        .im_i_ce(pc_im_o_ce), 
        .im_i_addr_1(pc_im_o_pc_1), 
        .im_i_addr_2(pc_im_o_pc_2), 
        .im_o_instr_1(im_o_instr_1), 
        .im_o_instr_2(im_o_instr_2), 
        .im_o_ce(im_o_ce)
    );

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            im_ds1_o_ce <= 1'b0;
            im_ds1_o_pc <= {`PC_WIDTH{1'b0}};
            im_ds1_o_instr <= {`IWIDTH{1'b0}};
        end
        else begin  
            if (!fw1_o_stall && !frontend_stall) begin
                im_ds1_o_ce <= im_o_ce;
                im_ds1_o_pc <= pc_im_o_pc_1;           
                im_ds1_o_instr <= im_o_instr_1;
            end
            else begin
                im_ds1_o_ce <= im_ds1_o_ce;
                im_ds1_o_pc <= im_ds1_o_pc;     
                im_ds1_o_instr <= im_ds1_o_instr;
            end
        end
    end

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            im_ds2_o_ce <= 1'b0;
            im_ds2_o_pc <= {`PC_WIDTH{1'b0}};
            im_ds2_o_instr <= {`IWIDTH{1'b0}};
        end
        else begin
            if (!fw2_o_stall && !frontend_stall) begin
                im_ds2_o_ce <= im_o_ce;
                im_ds2_o_pc <= pc_im_o_pc_2;
                im_ds2_o_instr <= im_o_instr_2;
            end
            else begin
                im_ds2_o_ce <= im_ds2_o_ce;
                im_ds2_o_pc <= im_ds2_o_pc;
                im_ds2_o_instr <= im_ds2_o_instr;
            end
        end
    end

    wire ds1_o_ce;
    wire ds1_o_jr;
    wire ds1_o_jal;
    wire ds1_o_branch;
    wire ds1_o_reg_dst;
    wire ds1_o_alu_src;
    wire ds1_o_memtoreg;
    wire ds1_o_memwrite;
    wire ds1_o_reg_write;
    wire [`IMM_WIDTH - 1 : 0] ds1_o_imm;
    wire [`FUNCT3_WIDTH - 1 : 0] ds1_o_funct3;
    wire [`FUNCT7_WIDTH - 1 : 0] ds1_o_funct7;
    wire [`OPCODE_WIDTH - 1 : 0] ds1_o_opcode;
    wire [`JUMP_WIDTH - 1 : 0] ds1_o_jal_addr;
    wire [`AWIDTH - 1 : 0] ds1_o_addr_rd, ds1_o_addr_rs, ds1_o_addr_rt;

    decoder_stage ds1 (
        .ds_i_clk(d_clk), 
        .ds_i_rst(d_rst), 
        .ds_i_ce(im_ds1_o_ce), 
        .ds_i_instr(im_ds1_o_instr), 
        .ds_o_ce(ds1_o_ce), 
        .ds_o_jr(ds1_o_jr), 
        .ds_o_jal(ds1_o_jal), 
        .ds_o_imm(ds1_o_imm), 
        .ds_o_funct3(ds1_o_funct3),
        .ds_o_funct7(ds1_o_funct7),
        .ds_o_opcode(ds1_o_opcode), 
        .ds_o_branch(ds1_o_branch), 
        .ds_o_addr_rd(ds1_o_addr_rd), 
        .ds_o_addr_rt(ds1_o_addr_rt), 
        .ds_o_addr_rs(ds1_o_addr_rs), 
        .ds_o_reg_dst(ds1_o_reg_dst), 
        .ds_o_alu_src(ds1_o_alu_src), 
        .ds_o_jal_addr(ds1_o_jal_addr), 
        .ds_o_memwrite(ds1_o_memwrite), 
        .ds_o_memtoreg(ds1_o_memtoreg), 
        .ds_o_reg_write(ds1_o_reg_write)
    );

    wire ds2_o_ce;
    wire ds2_o_jr;
    wire ds2_o_jal;
    wire ds2_o_branch;
    wire ds2_o_reg_dst;
    wire ds2_o_alu_src;
    wire ds2_o_memtoreg;
    wire ds2_o_memwrite;
    wire ds2_o_reg_write;
    wire [`IMM_WIDTH - 1 : 0] ds2_o_imm;
    wire [`FUNCT3_WIDTH - 1 : 0] ds2_o_funct3;
    wire [`FUNCT7_WIDTH - 1 : 0] ds2_o_funct7;
    wire [`OPCODE_WIDTH - 1 : 0] ds2_o_opcode;
    wire [`JUMP_WIDTH - 1 : 0] ds2_o_jal_addr;
    wire [`AWIDTH - 1 : 0] ds2_o_addr_rd, ds2_o_addr_rs, ds2_o_addr_rt;

    decoder_stage ds2 (
        .ds_i_clk(d_clk), 
        .ds_i_rst(d_rst), 
        .ds_i_ce(im_ds2_o_ce), 
        .ds_i_instr(im_ds2_o_instr), 
        .ds_o_ce(ds2_o_ce), 
        .ds_o_jr(ds2_o_jr), 
        .ds_o_jal(ds2_o_jal), 
        .ds_o_imm(ds2_o_imm), 
        .ds_o_funct3(ds2_o_funct3),
        .ds_o_funct7(ds2_o_funct7),
        .ds_o_opcode(ds2_o_opcode), 
        .ds_o_branch(ds2_o_branch), 
        .ds_o_addr_rd(ds2_o_addr_rd), 
        .ds_o_addr_rt(ds2_o_addr_rt), 
        .ds_o_addr_rs(ds2_o_addr_rs), 
        .ds_o_reg_dst(ds2_o_reg_dst), 
        .ds_o_alu_src(ds2_o_alu_src), 
        .ds_o_jal_addr(ds2_o_jal_addr), 
        .ds_o_memwrite(ds2_o_memwrite), 
        .ds_o_memtoreg(ds2_o_memtoreg), 
        .ds_o_reg_write(ds2_o_reg_write)
    );
    //Note: Check read new data
    wire [`DWIDTH - 1 : 0] r_o_data_rs_1, r_o_data_rt_1;
    wire [`DWIDTH - 1 : 0] r_o_data_rs_2, r_o_data_rt_2;
    wire [`DWIDTH - 1 : 0] r_o_issue_data_rs_1, r_o_issue_data_rt_1;
    wire [`DWIDTH - 1 : 0] r_o_issue_data_rs_2, r_o_issue_data_rt_2;
    regis r_eg (
        .r_clk(d_clk), 
        .r_rst(d_rst), 
        .r_wr_en_1(ms_wb1_o_regwrite), 
        .r_wr_en_2(ms_wb2_o_regwrite), 
        .r_i_addr_rs_1(ds1_o_addr_rs), 
        .r_i_addr_rt_1(ds1_o_addr_rt), 
        .r_i_addr_rs_2(ds2_o_addr_rs), 
        .r_i_addr_rt_2(ds2_o_addr_rt), 
        .r_i_addr_rd_1(ms_wb1_o_addr_rd), 
        .r_i_data_rd_1(wb_ds1_o_data_rd), 
        .r_i_addr_rd_2(ms_wb2_o_addr_rd), 
        .r_i_data_rd_2(wb_ds2_o_data_rd), 
        .r_o_data_rs_1(r_o_data_rs_1), 
        .r_o_data_rt_1(r_o_data_rt_1), 
        .r_o_data_rs_2(r_o_data_rs_2), 
        .r_o_data_rt_2(r_o_data_rt_2),
        .r_i_issue_addr_rs_1(qc_o_addr_rs_1),
        .r_i_issue_addr_rt_1(qc_o_addr_rt_1),
        .r_i_issue_addr_rs_2(qc_o_addr_rs_2),
        .r_i_issue_addr_rt_2(qc_o_addr_rt_2),
        .r_o_issue_data_rs_1(r_o_issue_data_rs_1),
        .r_o_issue_data_rt_1(r_o_issue_data_rt_1),
        .r_o_issue_data_rs_2(r_o_issue_data_rs_2),
        .r_o_issue_data_rt_2(r_o_issue_data_rt_2)
    );

    control_hazard ctrl_1 (
        .i_pc(im_ds1_o_pc), 
        .i_imm(ds1_o_imm), 
        .i_branch(ds1_o_branch), 
        .i_opcode(ds1_o_opcode), 
        .i_data_r1(r_o_data_rs_1), 
        .i_data_r2(r_o_data_rt_1), 
        .i_es_o_pc(es1_ctrl1_o_alu_pc), 
        .i_es_o_change_pc(es1_ctrl1_o_change_pc), 
        .o_pc(ctrl1_o_pc), 
        .o_compare(ctrl1_o_change_pc)
    );

    control_hazard ctrl_2 (
        .i_pc(im_ds2_o_pc), 
        .i_imm(ds2_o_imm), 
        .i_branch(ds2_o_branch), 
        .i_opcode(ds2_o_opcode), 
        .i_data_r1(r_o_data_rs_2), 
        .i_data_r2(r_o_data_rt_2), 
        .i_es_o_pc(es2_ctrl2_o_alu_pc), 
        .i_es_o_change_pc(es2_ctrl2_o_change_pc), 
        .o_pc(ctrl2_o_pc), 
        .o_compare(ctrl2_o_change_pc)
    );

    //Check for conflicts before passing the value to the ds_es register and convert 
    //the queue_instr to queue_comps


    reg ds1_es1_o_ce;
    reg ds1_es1_o_jr;
    reg ds1_es1_o_jal;
    reg ds1_es1_o_reg_dst;
    reg ds1_es1_o_alu_src;
    reg ds1_es1_o_memtoreg;
    reg ds1_es1_o_memwrite;
    reg ds1_es1_o_reg_write;
    reg [`PC_WIDTH - 1 : 0] ds1_es1_o_pc;
    reg [`IMM_WIDTH - 1 : 0] ds1_es1_o_imm;
    reg [`FUNCT3_WIDTH - 1 : 0] ds1_es1_o_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] ds1_es1_o_funct7;
    reg [`OPCODE_WIDTH - 1 : 0] ds1_es1_o_opcode;
    reg [`JUMP_WIDTH - 1 : 0] ds1_es1_o_jal_addr;
    reg [`DWIDTH - 1 : 0] ds1_es1_o_data_rs, ds1_es1_o_data_rt;
    reg [`AWIDTH - 1 : 0] ds1_es1_o_addr_rd, ds1_es1_o_addr_rs, ds1_es1_o_addr_rt;

    reg ds2_es2_o_ce;
    reg ds2_es2_o_jr;
    reg ds2_es2_o_jal;
    reg ds2_es2_o_reg_dst;
    reg ds2_es2_o_alu_src;
    reg ds2_es2_o_memtoreg;
    reg ds2_es2_o_memwrite;
    reg ds2_es2_o_reg_write;
    reg [`PC_WIDTH - 1 : 0] ds2_es2_o_pc;
    reg [`IMM_WIDTH - 1 : 0] ds2_es2_o_imm;
    reg [`FUNCT3_WIDTH - 1 : 0] ds2_es2_o_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] ds2_es2_o_funct7;
    reg [`OPCODE_WIDTH - 1 : 0] ds2_es2_o_opcode;
    reg [`JUMP_WIDTH - 1 : 0] ds2_es2_o_jal_addr;
    reg [`DWIDTH - 1 : 0] ds2_es2_o_data_rs, ds2_es2_o_data_rt;
    reg [`AWIDTH - 1 : 0] ds2_es2_o_addr_rd, ds2_es2_o_addr_rs, ds2_es2_o_addr_rt;

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            ds1_es1_o_ce <= 1'b0;
            ds1_es1_o_jr <= 1'b0;
            ds1_es1_o_jal <= 1'b0;
            ds1_es1_o_reg_dst <= 1'b0;
            ds1_es1_o_alu_src <= 1'b0;
            ds1_es1_o_memtoreg <= 1'b0;
            ds1_es1_o_memwrite <= 1'b0;
            ds1_es1_o_reg_write <= 1'b0;
            ds1_es1_o_pc <= {`PC_WIDTH{1'b0}};
            ds1_es1_o_imm <= {`IMM_WIDTH{1'b0}};
            ds1_es1_o_data_rs <= {`DWIDTH{1'b0}};
            ds1_es1_o_data_rt <= {`DWIDTH{1'b0}};
            ds1_es1_o_addr_rd <= {`AWIDTH{1'b0}};
            ds1_es1_o_addr_rs <= {`AWIDTH{1'b0}};
            ds1_es1_o_addr_rt <= {`AWIDTH{1'b0}};
            ds1_es1_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            ds1_es1_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
            ds1_es1_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            ds1_es1_o_jal_addr <= {`JUMP_WIDTH{1'b0}};
        end
        else begin
            if (!fw1_o_stall && !frontend_stall) begin 
                ds1_es1_o_ce <= ds1_o_ce;
                ds1_es1_o_jr <= ds1_o_jr;
                ds1_es1_o_jal <= ds1_o_jal;
                ds1_es1_o_imm <= ds1_o_imm;
                ds1_es1_o_pc <= im_ds1_o_pc;
                ds1_es1_o_funct3 <= ds1_o_funct3;
                ds1_es1_o_funct7 <= ds1_o_funct7;
                ds1_es1_o_opcode <= ds1_o_opcode;
                ds1_es1_o_reg_dst <= ds1_o_reg_dst;
                ds1_es1_o_alu_src <= ds1_o_alu_src;
                ds1_es1_o_data_rs <= r_o_data_rs_1;
                ds1_es1_o_data_rt <= r_o_data_rt_1;
                ds1_es1_o_addr_rd <= ds1_o_addr_rd;
                ds1_es1_o_addr_rs <= ds1_o_addr_rs;
                ds1_es1_o_addr_rt <= ds1_o_addr_rt;
                ds1_es1_o_memtoreg <= ds1_o_memtoreg;
                ds1_es1_o_memwrite <= ds1_o_memwrite;
                ds1_es1_o_jal_addr <= ds1_o_jal_addr;
                ds1_es1_o_reg_write <= ds1_o_reg_write;
            end
            else begin
                ds1_es1_o_ce <= ds1_es1_o_ce;
                ds1_es1_o_jr <= ds1_es1_o_jr;
                ds1_es1_o_pc <= ds1_es1_o_pc;
                ds1_es1_o_jal <= ds1_es1_o_jal;
                ds1_es1_o_imm <= ds1_es1_o_imm;
                ds1_es1_o_funct3 <= ds1_es1_o_funct3;
                ds1_es1_o_funct7 <= ds1_es1_o_funct7;
                ds1_es1_o_opcode <= ds1_es1_o_opcode;
                ds1_es1_o_reg_dst <= ds1_es1_o_reg_dst;
                ds1_es1_o_alu_src <= ds1_es1_o_alu_src;
                ds1_es1_o_data_rs <= ds1_es1_o_data_rs;
                ds1_es1_o_data_rt <= ds1_es1_o_data_rt;
                ds1_es1_o_addr_rd <= ds1_es1_o_addr_rd;
                ds1_es1_o_addr_rs <= ds1_es1_o_addr_rs;
                ds1_es1_o_addr_rt <= ds1_es1_o_addr_rt;
                ds1_es1_o_jal_addr <= ds1_es1_o_jal_addr;
                ds1_es1_o_memtoreg <= ds1_es1_o_memtoreg;
                ds1_es1_o_memwrite <= ds1_es1_o_memwrite;
                ds1_es1_o_reg_write <= ds1_es1_o_reg_write;
            end
        end
    end

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            ds2_es2_o_ce <= 1'b0;
            ds2_es2_o_jr <= 1'b0;
            ds2_es2_o_jal <= 1'b0;
            ds2_es2_o_reg_dst <= 1'b0;
            ds2_es2_o_alu_src <= 1'b0;
            ds2_es2_o_memtoreg <= 1'b0;
            ds2_es2_o_memwrite <= 1'b0;
            ds2_es2_o_reg_write <= 1'b0;
            ds2_es2_o_pc <= {`PC_WIDTH{1'b0}};
            ds2_es2_o_imm <= {`IMM_WIDTH{1'b0}};
            ds2_es2_o_data_rs <= {`DWIDTH{1'b0}};
            ds2_es2_o_data_rt <= {`DWIDTH{1'b0}};
            ds2_es2_o_addr_rd <= {`AWIDTH{1'b0}};
            ds2_es2_o_addr_rs <= {`AWIDTH{1'b0}};
            ds2_es2_o_addr_rt <= {`AWIDTH{1'b0}};
            ds2_es2_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            ds2_es2_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
            ds2_es2_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            ds2_es2_o_jal_addr <= {`JUMP_WIDTH{1'b0}};
        end
        else begin
            if (!fw2_o_stall && !frontend_stall) begin 
                ds2_es2_o_ce <= ds2_o_ce;
                ds2_es2_o_jr <= ds2_o_jr;
                ds2_es2_o_jal <= ds2_o_jal;
                ds2_es2_o_imm <= ds2_o_imm;
                ds2_es2_o_pc <= im_ds2_o_pc;
                ds2_es2_o_funct3 <= ds2_o_funct3;
                ds2_es2_o_funct7 <= ds2_o_funct7;
                ds2_es2_o_opcode <= ds2_o_opcode;
                ds2_es2_o_reg_dst <= ds2_o_reg_dst;
                ds2_es2_o_alu_src <= ds2_o_alu_src;
                ds2_es2_o_data_rs <= r_o_data_rs_2;
                ds2_es2_o_data_rt <= r_o_data_rt_2;
                ds2_es2_o_addr_rd <= ds2_o_addr_rd;
                ds2_es2_o_addr_rs <= ds2_o_addr_rs;
                ds2_es2_o_addr_rt <= ds2_o_addr_rt;
                ds2_es2_o_memtoreg <= ds2_o_memtoreg;
                ds2_es2_o_memwrite <= ds2_o_memwrite;
                ds2_es2_o_jal_addr <= ds2_o_jal_addr;
                ds2_es2_o_reg_write <= ds2_o_reg_write;
            end
            else begin
                ds2_es2_o_ce <= ds2_es2_o_ce;
                ds2_es2_o_jr <= ds2_es2_o_jr;
                ds2_es2_o_pc <= ds2_es2_o_pc;
                ds2_es2_o_jal <= ds2_es2_o_jal;
                ds2_es2_o_imm <= ds2_es2_o_imm;
                ds2_es2_o_funct3 <= ds2_es2_o_funct3;
                ds2_es2_o_funct7 <= ds2_es2_o_funct7;
                ds2_es2_o_opcode <= ds2_es2_o_opcode;
                ds2_es2_o_reg_dst <= ds2_es2_o_reg_dst;
                ds2_es2_o_alu_src <= ds2_es2_o_alu_src;
                ds2_es2_o_data_rs <= ds2_es2_o_data_rs;
                ds2_es2_o_data_rt <= ds2_es2_o_data_rt;
                ds2_es2_o_addr_rd <= ds2_es2_o_addr_rd;
                ds2_es2_o_addr_rs <= ds2_es2_o_addr_rs;
                ds2_es2_o_addr_rt <= ds2_es2_o_addr_rt;
                ds2_es2_o_memtoreg <= ds2_es2_o_memtoreg;
                ds2_es2_o_memwrite <= ds2_es2_o_memwrite;
                ds2_es2_o_jal_addr <= ds2_es2_o_jal_addr;
                ds2_es2_o_reg_write <= ds2_es2_o_reg_write;
            end
        end
    end

    reg es1_o_qc1, es2_o_qc2;
    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            es1_o_qc1 <= 1'b0;
            es2_o_qc2 <= 1'b0;
        end 
        else begin
            es1_o_qc1 <= es1_queue2_o_fetch;
            es2_o_qc2 <= es2_queue1_o_fetch;
        end
    end

    wire qc_o_ce_1;
    wire qc_o_reg_dst_1;
    wire qc_o_alu_src_1;
    wire qc_o_memtoreg_1;
    wire qc_o_memwrite_1;
    wire qc_o_reg_write_1;
    wire qc_o_active_fetch_1;
    wire qc_o_jr_1, qc_o_jal_1;
    wire [`IMM_WIDTH - 1 : 0] qc_o_imm_1;
    wire [`FUNCT3_WIDTH - 1 : 0] qc_o_funct3_1;
    wire [`FUNCT7_WIDTH - 1 : 0] qc_o_funct7_1;
    wire [`OPCODE_WIDTH - 1 : 0] qc_o_opcode_1;
    wire [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr_1;
    wire [`DWIDTH - 1 : 0] qc_o_data_rs_1, qc_o_data_rt_1;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rd_1, qc_o_addr_rs_1, qc_o_addr_rt_1;

    wire qc_o_ce_2;
    wire qc_o_reg_dst_2;
    wire qc_o_alu_src_2;
    wire qc_o_memtoreg_2;
    wire qc_o_memwrite_2;
    wire qc_o_reg_write_2;
    wire qc_o_active_fetch_2;
    wire qc_o_jr_2, qc_o_jal_2;
    wire [`IMM_WIDTH - 1 : 0] qc_o_imm_2;
    wire [`FUNCT3_WIDTH - 1 : 0] qc_o_funct3_2;
    wire [`FUNCT7_WIDTH - 1 : 0] qc_o_funct7_2;
    wire [`OPCODE_WIDTH - 1 : 0] qc_o_opcode_2;
    wire [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr_2;
    wire [`DWIDTH - 1 : 0] qc_o_data_rs_2, qc_o_data_rt_2;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rd_2, qc_o_addr_rs_2, qc_o_addr_rt_2;

    queue q (
        .qc_i_clk(d_clk), 
        .qc_i_rst(d_rst), 
        .qc_i_we_1(ds1_es1_o_ce), 
        .qc_i_we_2(ds2_es2_o_ce), 
        .qc_i_re_1(es1_o_qc1), 
        .qc_i_re_2(es2_o_qc2),
        .qc_i_ce_1(ds1_es1_o_ce), 
        .qc_i_jr_1(ds1_es1_o_jr), 
        .qc_i_jal_1(ds1_es1_o_jal), 
        .qc_i_imm_1(ds1_es1_o_imm), 
        .qc_i_busy_1(es1_qc_o_busy),
        .qc_i_busy_2(es2_qc_o_busy),
        .qc_i_funct3_1(ds1_es1_o_funct3),
        .qc_i_funct7_1(ds1_es1_o_funct7),
        .qc_i_opcode_1(ds1_es1_o_opcode), 
        .qc_i_addr_rd_1(ds1_es1_o_addr_rd), 
        .qc_i_addr_rs_1(ds1_es1_o_addr_rs), 
        .qc_i_addr_rt_1(ds1_es1_o_addr_rt), 
        .qc_i_reg_dst_1(ds1_es1_o_reg_dst), 
        .qc_i_alu_src_1(ds1_es1_o_alu_src), 
        .qc_i_data_rs_1(ds1_es1_o_data_rs), 
        .qc_i_data_rt_1(ds1_es1_o_data_rt),
        .qc_i_jal_addr_1(ds1_es1_o_jal_addr), 
        .qc_i_memtoreg_1(ds1_es1_o_memtoreg),
        .qc_i_memwrite_1(ds1_es1_o_memwrite), 
        .qc_i_reg_write_1(ds1_es1_o_reg_write), 
        .qc_i_ce_2(ds2_es2_o_ce), 
        .qc_i_jr_2(ds2_es2_o_jr), 
        .qc_i_jal_2(ds2_es2_o_jal), 
        .qc_i_imm_2(ds2_es2_o_imm), 
        .qc_i_funct3_2(ds2_es2_o_funct3),
        .qc_i_funct7_2(ds2_es2_o_funct7),
        .qc_i_opcode_2(ds2_es2_o_opcode), 
        .qc_i_addr_rd_2(ds2_es2_o_addr_rd), 
        .qc_i_addr_rs_2(ds2_es2_o_addr_rs), 
        .qc_i_addr_rt_2(ds2_es2_o_addr_rt), 
        .qc_i_reg_dst_2(ds2_es2_o_reg_dst), 
        .qc_i_alu_src_2(ds2_es2_o_alu_src), 
        .qc_i_data_rs_2(ds2_es2_o_data_rs), 
        .qc_i_data_rt_2(ds2_es2_o_data_rt),
        .qc_i_jal_addr_2(ds2_es2_o_jal_addr), 
        .qc_i_memtoreg_2(ds2_es2_o_memtoreg),
        .qc_i_memwrite_2(ds2_es2_o_memwrite), 
        .qc_i_reg_write_2(ds2_es2_o_reg_write), 
        .qc_o_ce_1(qc_o_ce_1), 
        .qc_o_jr_1(qc_o_jr_1), 
        .qc_o_jal_1(qc_o_jal_1), 
        .qc_o_imm_1(qc_o_imm_1), 
        .qc_o_funct3_1(qc_o_funct3_1),
        .qc_o_funct7_1(qc_o_funct7_1),
        .qc_o_opcode_1(qc_o_opcode_1), 
        .qc_o_addr_rd_1(qc_o_addr_rd_1), 
        .qc_o_addr_rs_1(qc_o_addr_rs_1), 
        .qc_o_addr_rt_1(qc_o_addr_rt_1), 
        .qc_o_reg_dst_1(qc_o_reg_dst_1), 
        .qc_o_alu_src_1(qc_o_alu_src_1), 
        .qc_o_data_rs_1(qc_o_data_rs_1), 
        .qc_o_data_rt_1(qc_o_data_rt_1),
        .qc_o_jal_addr_1(qc_o_jal_addr_1), 
        .qc_o_memtoreg_1(qc_o_memtoreg_1),
        .qc_o_memwrite_1(qc_o_memwrite_1), 
        .qc_o_reg_write_1(qc_o_reg_write_1), 
        .qc_o_active_fetch_1(qc_o_active_fetch_1),
        .qc_o_ce_2(qc_o_ce_2), 
        .qc_o_jr_2(qc_o_jr_2), 
        .qc_o_jal_2(qc_o_jal_2), 
        .qc_o_imm_2(qc_o_imm_2), 
        .qc_o_funct3_2(qc_o_funct3_2),
        .qc_o_funct7_2(qc_o_funct7_2),
        .qc_o_opcode_2(qc_o_opcode_2), 
        .qc_o_addr_rd_2(qc_o_addr_rd_2), 
        .qc_o_addr_rs_2(qc_o_addr_rs_2), 
        .qc_o_addr_rt_2(qc_o_addr_rt_2), 
        .qc_o_reg_dst_2(qc_o_reg_dst_2), 
        .qc_o_alu_src_2(qc_o_alu_src_2), 
        .qc_o_data_rs_2(qc_o_data_rs_2), 
        .qc_o_data_rt_2(qc_o_data_rt_2),
        .qc_o_jal_addr_2(qc_o_jal_addr_2), 
        .qc_o_memtoreg_2(qc_o_memtoreg_2),
        .qc_o_memwrite_2(qc_o_memwrite_2), 
        .qc_o_reg_write_2(qc_o_reg_write_2),
        .qc_o_active_fetch_2(qc_o_active_fetch_2),
        .qc_o_full(qc_o_full)
    );

    reg qc_es1_o_ce;
    reg qc_es1_o_reg_dst;
    reg qc_es1_o_alu_src;
    reg qc_es1_o_memtoreg;
    reg qc_es1_o_memwrite;
    reg qc_es1_o_reg_write;
    reg qc_es1_o_jr, qc_es1_o_jal;
    reg [`PC_WIDTH - 1 : 0] qc_es1_o_pc;
    reg [`IMM_WIDTH - 1 : 0] qc_es1_o_imm;
    reg [`FUNCT3_WIDTH - 1 : 0] qc_es1_o_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] qc_es1_o_funct7;
    reg [`OPCODE_WIDTH - 1 : 0] qc_es1_o_opcode;
    reg [`JUMP_WIDTH - 1 : 0] qc_es1_o_jal_addr;
    reg [`DWIDTH - 1 : 0] qc_es1_o_data_rs, qc_es1_o_data_rt;
    reg [`AWIDTH - 1 : 0] qc_es1_o_addr_rd, qc_es1_o_addr_rs, qc_es1_o_addr_rt;

    reg qc_es2_o_ce;
    reg qc_es2_o_reg_dst;
    reg qc_es2_o_alu_src;
    reg qc_es2_o_memtoreg;
    reg qc_es2_o_memwrite;
    reg qc_es2_o_reg_write;
    reg qc_es2_o_jr, qc_es2_o_jal;
    reg [`PC_WIDTH - 1 : 0] qc_es2_o_pc;
    reg [`IMM_WIDTH - 1 : 0] qc_es2_o_imm;
    reg [`FUNCT3_WIDTH - 1 : 0] qc_es2_o_funct3;
    reg [`FUNCT7_WIDTH - 1 : 0] qc_es2_o_funct7;
    reg [`OPCODE_WIDTH - 1 : 0] qc_es2_o_opcode;
    reg [`JUMP_WIDTH - 1 : 0] qc_es2_o_jal_addr;
    reg [`DWIDTH - 1 : 0] qc_es2_o_data_rs, qc_es2_o_data_rt;
    reg [`AWIDTH - 1 : 0] qc_es2_o_addr_rd, qc_es2_o_addr_rs, qc_es2_o_addr_rt;

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            qc_es1_o_ce <= 1'b0;
            qc_es1_o_jr <= 1'b0;
            qc_es1_o_jal <= 1'b0;
            qc_es1_o_reg_dst <= 1'b0;
            qc_es1_o_alu_src <= 1'b0;
            qc_es1_o_memtoreg <= 1'b0;
            qc_es1_o_memwrite <= 1'b0;
            qc_es1_o_reg_write <= 1'b0;
            qc_es1_o_pc <= {`PC_WIDTH{1'b0}};
            qc_es1_o_imm <= {`IMM_WIDTH{1'b0}};
            qc_es1_o_data_rs <= {`DWIDTH{1'b0}};
            qc_es1_o_data_rt <= {`DWIDTH{1'b0}};
            qc_es1_o_addr_rd <= {`AWIDTH{1'b0}};
            qc_es1_o_addr_rs <= {`AWIDTH{1'b0}};
            qc_es1_o_addr_rt <= {`AWIDTH{1'b0}};
            qc_es1_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            qc_es1_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
            qc_es1_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            qc_es1_o_jal_addr <= {`JUMP_WIDTH{1'b0}};

            qc_es2_o_ce <= 1'b0;
            qc_es2_o_jr <= 1'b0;
            qc_es2_o_jal <= 1'b0;
            qc_es2_o_reg_dst <= 1'b0;
            qc_es2_o_alu_src <= 1'b0;
            qc_es2_o_memtoreg <= 1'b0;
            qc_es2_o_memwrite <= 1'b0;
            qc_es2_o_reg_write <= 1'b0;
            qc_es2_o_pc <= {`PC_WIDTH{1'b0}};
            qc_es2_o_imm <= {`IMM_WIDTH{1'b0}};
            qc_es2_o_data_rs <= {`DWIDTH{1'b0}};
            qc_es2_o_data_rt <= {`DWIDTH{1'b0}};
            qc_es2_o_addr_rd <= {`AWIDTH{1'b0}};
            qc_es2_o_addr_rs <= {`AWIDTH{1'b0}};
            qc_es2_o_addr_rt <= {`AWIDTH{1'b0}};
            qc_es2_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
            qc_es2_o_funct7 <= {`FUNCT7_WIDTH{1'b0}};
            qc_es2_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            qc_es2_o_jal_addr <= {`JUMP_WIDTH{1'b0}};
        end
        else begin
            qc_es1_o_ce <= qc_o_ce_1;
            qc_es1_o_jr <= qc_o_jr_1;
            qc_es1_o_jal <= qc_o_jal_1;
            qc_es1_o_imm <= qc_o_imm_1;
            qc_es1_o_pc <= ds1_es1_o_pc;
            qc_es1_o_funct3 <= qc_o_funct3_1;
            qc_es1_o_funct7 <= qc_o_funct7_1;
            qc_es1_o_opcode <= qc_o_opcode_1;
            qc_es1_o_reg_dst <= qc_o_reg_dst_1;
            qc_es1_o_alu_src <= qc_o_alu_src_1;
            qc_es1_o_data_rs <= r_o_issue_data_rs_1;
            qc_es1_o_data_rt <= r_o_issue_data_rt_1;
            qc_es1_o_addr_rd <= qc_o_addr_rd_1;
            qc_es1_o_addr_rs <= qc_o_addr_rs_1;
            qc_es1_o_addr_rt <= qc_o_addr_rt_1;
            qc_es1_o_memtoreg <= qc_o_memtoreg_1;
            qc_es1_o_memwrite <= qc_o_memwrite_1;
            qc_es1_o_jal_addr <= qc_o_jal_addr_1;
            qc_es1_o_reg_write <= qc_o_reg_write_1;

            qc_es2_o_ce <= qc_o_ce_2;
            qc_es2_o_jr <= qc_o_jr_2;
            qc_es2_o_jal <= qc_o_jal_2;
            qc_es2_o_imm <= qc_o_imm_2;
            qc_es2_o_pc <= ds2_es2_o_pc;
            qc_es2_o_funct3 <= qc_o_funct3_2;
            qc_es2_o_funct7 <= qc_o_funct7_2;
            qc_es2_o_opcode <= qc_o_opcode_2;
            qc_es2_o_reg_dst <= qc_o_reg_dst_2;
            qc_es2_o_alu_src <= qc_o_alu_src_2;
            qc_es2_o_data_rs <= r_o_issue_data_rs_2;
            qc_es2_o_data_rt <= r_o_issue_data_rt_2;
            qc_es2_o_addr_rd <= qc_o_addr_rd_2;
            qc_es2_o_addr_rs <= qc_o_addr_rs_2;
            qc_es2_o_addr_rt <= qc_o_addr_rt_2;
            qc_es2_o_memtoreg <= qc_o_memtoreg_2;
            qc_es2_o_memwrite <= qc_o_memwrite_2;
            qc_es2_o_jal_addr <= qc_o_jal_addr_2;
            qc_es2_o_reg_write <= qc_o_reg_write_2;
        end
    end

    wire [`AWIDTH - 1 : 0] es1_i_addr_rd;
    mux2_1 m1 (
        .mx_i_addr_rd(qc_es1_o_addr_rd), 
        .mx_i_addr_rt(qc_es1_o_addr_rt), 
        .mx_i_reg_dst(qc_es1_o_reg_dst), 
        .mx_o_addr_rd(es1_i_addr_rd)
    );

    wire [`AWIDTH - 1 : 0] es2_i_addr_rd;
    mux2_1 m2 (
        .mx_i_addr_rd(qc_es2_o_addr_rd), 
        .mx_i_addr_rt(qc_es2_o_addr_rt), 
        .mx_i_reg_dst(qc_es2_o_reg_dst), 
        .mx_o_addr_rd(es2_i_addr_rd)
    );
    // TODO: How to know when The system uses alu_value 1 or alu_value 2
    // Add some conditions to check when system uses es1 or es2, Maybe when es1 is trigged
    // TODO: Check lệnh ở luồng 1 đưa ra xem có trùng với lệnh ở luồng 2 tính toán không nếu có thì lệnh 1 sẽ 
    // được đưa về queue 2, thêm một tín hiệu ghi bảo ghi vào 2, tín hiệu này 
    // sẽ điều khiển việc tắt es1

    wire [`DWIDTH - 1 : 0] mx31_1_o_data_rs;
    mux3_1 mux31_1(
        .data(qc_es1_o_data_rs), 
        .alu_value(es1_ms_o_alu_value), 
        .write_back_data(wb_ds1_o_data_rd), 
        .forwarding(fw1_o_data_rs), 
        .data_out(mx31_1_o_data_rs)
    );

    wire [`DWIDTH - 1 : 0] mx31_1_o_data_rt;
    mux3_1 mux31_2(
        .data(qc_es1_o_data_rt), 
        .alu_value(es1_ms_o_alu_value), 
        .write_back_data(wb_ds1_o_data_rd), 
        .forwarding(fw1_o_data_rt), 
        .data_out(mx31_1_o_data_rt)
    );

    wire [`DWIDTH - 1 : 0] mx31_2_o_data_rs;
    mux3_1 mux31_3(
        .data(qc_es2_o_data_rs), 
        .alu_value(es2_ms_o_alu_value), 
        .write_back_data(wb_ds2_o_data_rd), 
        .forwarding(fw2_o_data_rs), 
        .data_out(mx31_2_o_data_rs)
    );

    wire [`DWIDTH - 1 : 0] mx31_2_o_data_rt;
    mux3_1 mux31_4(
        .data(qc_es2_o_data_rt), 
        .alu_value(es2_ms_o_alu_value), 
        .write_back_data(wb_ds2_o_data_rd), 
        .forwarding(fw2_o_data_rt), 
        .data_out(mx31_2_o_data_rt)
    );

    wire es1_o_ce;
    wire es1_o_busy;
    wire es1_o_change_pc;
    wire [`PC_WIDTH - 1 : 0] es1_o_alu_pc;
    wire [`DWIDTH - 1 : 0] es1_o_alu_value;
    wire [`OPCODE_WIDTH - 1 : 0] es1_o_opcode;
    wire es1_o_fetch_queue;
    execute_stage es1 (
        .es_i_ce(qc_es1_o_ce), 
        .es_i_jr(qc_es1_o_jr), 
        .es_i_pc(qc_es1_o_pc), 
        .es_i_imm(qc_es1_o_imm), 
        .es_i_jal(qc_es1_o_jal), 
        .es_i_alu_op(qc_es1_o_opcode), 
        .es_i_alu_src(qc_es1_o_alu_src), 
        .es_i_funct3(qc_es1_o_funct3),
        .es_i_funct7(qc_es1_o_funct7),
        .es_i_data_rs(mx31_1_o_data_rs), 
        .es_i_data_rt(mx31_1_o_data_rt), 
        .es_i_jal_addr(qc_es1_o_jal_addr), 
        .es_i_fetch_queue(qc_o_active_fetch_1), 
        .es_o_ce(es1_o_ce), 
        .es_o_busy(es1_o_busy),
        .es_o_alu_pc(es1_o_alu_pc), 
        .es_o_opcode(es1_o_opcode), 
        .es_o_change_pc(es1_o_change_pc), 
        .es_o_alu_value(es1_o_alu_value), 
        .es_o_fetch_queue(es1_o_fetch_queue)
    );

    wire es2_o_ce;
    wire es2_o_busy;
    wire es2_o_change_pc;
    wire es2_o_fetch_queue;
    wire [`PC_WIDTH - 1 : 0] es2_o_alu_pc;
    wire [`DWIDTH - 1 : 0] es2_o_alu_value;
    wire [`OPCODE_WIDTH - 1 : 0] es2_o_opcode;
    execute_stage es2 (
        .es_i_ce(qc_es2_o_ce), 
        .es_i_jr(qc_es2_o_jr), 
        .es_i_pc(qc_es2_o_pc), 
        .es_i_jal(qc_es2_o_jal), 
        .es_i_imm(qc_es2_o_imm), 
        .es_i_alu_op(qc_es2_o_opcode), 
        .es_i_alu_src(qc_es2_o_alu_src), 
        .es_i_funct3(qc_es2_o_funct3),
        .es_i_funct7(qc_es2_o_funct7),
        .es_i_data_rs(mx31_2_o_data_rs), 
        .es_i_data_rt(mx31_2_o_data_rt), 
        .es_i_jal_addr(qc_es2_o_jal_addr),
        .es_i_fetch_queue(qc_o_active_fetch_2),
        .es_o_ce(es2_o_ce),  
        .es_o_busy(es2_o_busy),
        .es_o_alu_pc(es2_o_alu_pc), 
        .es_o_opcode(es2_o_opcode), 
        .es_o_alu_value(es2_o_alu_value), 
        .es_o_change_pc(es2_o_change_pc), 
        .es_o_fetch_queue(es2_o_fetch_queue)
    );

    wire [3 : 0] ts1_o_store_mask;
    wire [`DWIDTH - 1 : 0] ts1_o_store_data;
    reg [3 : 0] ts1_ms_o_store_mask;
    reg [`DWIDTH - 1 : 0] ts1_ms_o_store_data;
    treatstore ts1 (
        .ts_i_store_addr(es1_o_alu_value),
        .ts_i_opcode(qc_es1_o_opcode), 
        .ts_i_funct_3(qc_es1_o_funct3),
        .ts_i_store_data(mx31_1_o_data_rt), 
        .ts_o_store_data(ts1_o_store_data), 
        .ts_o_store_mask(ts1_o_store_mask)
    );

    wire [3 : 0] ts2_o_store_mask;
    wire [`DWIDTH - 1 : 0] ts2_o_store_data;
    reg [3 : 0] ts2_ms_o_store_mask;
    reg [`DWIDTH - 1 : 0] ts2_ms_o_store_data;
    treatstore ts2 (
        .ts_i_store_addr(es2_o_alu_value),
        .ts_i_opcode(qc_es2_o_opcode), 
        .ts_i_funct_3(qc_es2_o_funct3),
        .ts_i_store_data(mx31_2_o_data_rt), 
        .ts_o_store_data(ts2_o_store_data), 
        .ts_o_store_mask(ts2_o_store_mask)
    );

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            es1_ms_o_ce <= 1'b0;
            es1_qc_o_busy <= 1'b0;
            es1_ms_o_memwrite <= 1'b0;
            es1_ms_o_memtoreg <= 1'b0;
            es1_ms_o_regwrite <= 1'b0;
            es1_queue2_o_fetch <= 1'b0;
            ts1_ms_o_store_mask <= 4'b0;
            es1_ctrl1_o_change_pc <= 1'b0;
            es1_ms_o_addr_rd <= {`AWIDTH{1'b0}};
            es1_ms_o_alu_value <= {`DWIDTH{1'b0}};
            ts1_ms_o_store_data <= {`DWIDTH{1'b0}};
            es1_ctrl1_o_alu_pc <= {`PC_WIDTH{1'b0}};
            es1_ms_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            es1_ms_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
        end
        else begin
            es1_ms_o_ce <= es1_o_ce;
            es1_qc_o_busy <= es1_o_busy;
            es1_ms_o_opcode <= es1_o_opcode;
            es1_ms_o_funct3 <= qc_es1_o_funct3;
            es1_ms_o_addr_rd <= es1_i_addr_rd;
            es1_ctrl1_o_alu_pc <= es1_o_alu_pc;
            es1_ms_o_alu_value <= es1_o_alu_value;
            es1_ms_o_memwrite <= qc_es1_o_memwrite;
            es1_ms_o_memtoreg <= qc_es1_o_memtoreg;
            ts1_ms_o_store_mask <= ts1_o_store_mask;
            ts1_ms_o_store_data <= ts1_o_store_data;
            es1_queue2_o_fetch <= es1_o_fetch_queue;
            es1_ms_o_regwrite <= qc_es1_o_reg_write;
            es1_ctrl1_o_change_pc <= es1_o_change_pc;
        end
    end

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            es2_ms_o_ce <= 1'b0;
            es2_qc_o_busy <= 1'b0;
            es2_ms_o_memwrite <= 1'b0;
            es2_ms_o_memtoreg <= 1'b0;
            es2_ms_o_regwrite <= 1'b0;
            es2_queue1_o_fetch <= 1'b0;
            ts2_ms_o_store_mask <= 4'b0;
            es2_ctrl2_o_change_pc <= 1'b0;
            es2_ms_o_addr_rd <= {`AWIDTH{1'b0}};
            es2_ms_o_alu_value <= {`DWIDTH{1'b0}};
            ts2_ms_o_store_data <= {`DWIDTH{1'b0}};
            es2_ctrl2_o_alu_pc <= {`PC_WIDTH{1'b0}};
            es2_ms_o_opcode <= {`OPCODE_WIDTH{1'b0}};
            es2_ms_o_funct3 <= {`FUNCT3_WIDTH{1'b0}};
        end
        else begin
            es2_ms_o_ce <= es2_o_ce;
            es2_qc_o_busy <= es2_o_busy;
            es2_ms_o_opcode <= es2_o_opcode;
            es2_ms_o_funct3 <= qc_es2_o_funct3;
            es2_ms_o_addr_rd <= es2_i_addr_rd;
            es2_ctrl2_o_alu_pc <= es2_o_alu_pc;
            es2_ms_o_alu_value <= es2_o_alu_value;
            es2_ms_o_memwrite <= qc_es2_o_memwrite;
            es2_ms_o_memtoreg <= qc_es2_o_memtoreg;
            ts2_ms_o_store_mask <= ts2_o_store_mask;
            ts2_ms_o_store_data <= ts2_o_store_data;
            es2_queue1_o_fetch <= es2_o_fetch_queue;
            es2_ms_o_regwrite <= qc_es2_o_reg_write;
            es2_ctrl2_o_change_pc <= es2_o_change_pc;
        end
    end

    wire [`DWIDTH - 1 : 0] ms_o_load_data_1, ms_o_load_data_2;
    memory m (
        .m_clk(d_clk), 
        .m_rst(d_rst), 
        .m_i_ce_1(es1_ms_o_ce), 
        .m_i_ce_2(es2_ms_o_ce), 
        .m_i_wr_en_1(es1_ms_o_memwrite), 
        .m_i_wr_en_2(es2_ms_o_memwrite), 
        .m_i_mask_1(ts1_ms_o_store_mask), 
        .m_i_mask_2(ts2_ms_o_store_mask), 
        .m_i_data_rs_1(ts1_ms_o_store_data), 
        .m_i_data_rs_2(ts2_ms_o_store_data), 
        .m_i_alu_value_1(es1_ms_o_alu_value), 
        .m_i_alu_value_2(es2_ms_o_alu_value), 
        .m_o_load_data_1(ms_o_load_data_1),
        .m_o_load_data_2(ms_o_load_data_2)
    );

    wire [`DWIDTH - 1 : 0] tl1_o_load_data;
    treatload tl1 (
        .tl_i_load_data(ms_o_load_data_1), 
        .tl_i_load_addr(es1_ms_o_alu_value),
        .tl_i_opcode(es1_ms_o_opcode),
        .tl_i_funct_3(es1_ms_o_funct3),
        .tl_o_load_data(tl1_o_load_data)
    );

    wire [`DWIDTH - 1 : 0] tl2_o_load_data;
    treatload tl2 (
        .tl_i_load_data(ms_o_load_data_2), 
        .tl_i_load_addr(es2_ms_o_alu_value),
        .tl_i_opcode(es2_ms_o_opcode),
        .tl_i_funct_3(es2_ms_o_funct3),
        .tl_o_load_data(tl2_o_load_data)
    );

    always @(posedge d_clk, negedge d_rst) begin
        if (!d_rst) begin
            ms_wb1_o_memtoreg <= 1'b0;
            ms_wb2_o_memtoreg <= 1'b0;
            ms_wb1_o_regwrite <= 1'b0;
            ms_wb2_o_regwrite <= 1'b0;
            ms_wb1_o_addr_rd <= {`AWIDTH{1'b0}};
            ms_wb2_o_addr_rd <= {`AWIDTH{1'b0}};
            ms_wb1_o_alu_value <= {`DWIDTH{1'b0}};
            ms_wb2_o_alu_value <= {`DWIDTH{1'b0}};
            ms_wb1_o_load_data_1 <= {`DWIDTH{1'b0}};
            ms_wb2_o_load_data_2 <= {`DWIDTH{1'b0}};
        end
        else begin
            ms_wb1_o_addr_rd <= es1_ms_o_addr_rd;
            ms_wb2_o_addr_rd <= es2_ms_o_addr_rd;
            ms_wb1_o_memtoreg <= es1_ms_o_memtoreg;
            ms_wb2_o_memtoreg <= es2_ms_o_memtoreg;
            ms_wb1_o_regwrite <= es1_ms_o_regwrite;
            ms_wb2_o_regwrite <= es2_ms_o_regwrite;
            ms_wb1_o_load_data_1 <= tl1_o_load_data;
            ms_wb2_o_load_data_2 <= tl2_o_load_data;
            ms_wb1_o_alu_value <= es1_ms_o_alu_value;
            ms_wb2_o_alu_value <= es2_ms_o_alu_value;
        end 
    end

    forwarding fw1 (
        .ds_es_i_opcode(qc_es1_o_opcode), 
        .ds_es_i_addr_rs1(qc_es1_o_addr_rs), 
        .ds_es_i_addr_rs2(qc_es1_o_addr_rt), 
        .es_ms_i_addr_rd(es1_ms_o_addr_rd), 
        .es_ms_i_regwrite(es1_ms_o_regwrite), 
        .ms_wb_i_regwrite(ms_wb1_o_regwrite), 
        .ms_wb_i_addr_rd(ms_wb1_o_addr_rd), 
        .f_o_control_rs1(fw1_o_data_rs), 
        .f_o_control_rs2(fw1_o_data_rt), 
        .f_o_stall(fw1_o_stall)
    );

    forwarding fw2 (
        .ds_es_i_opcode(qc_es2_o_opcode), 
        .ds_es_i_addr_rs1(qc_es2_o_addr_rs), 
        .ds_es_i_addr_rs2(qc_es2_o_addr_rt), 
        .es_ms_i_addr_rd(es2_ms_o_addr_rd), 
        .es_ms_i_regwrite(es2_ms_o_regwrite), 
        .ms_wb_i_regwrite(ms_wb2_o_regwrite), 
        .ms_wb_i_addr_rd(ms_wb2_o_addr_rd), 
        .f_o_control_rs1(fw2_o_data_rs), 
        .f_o_control_rs2(fw2_o_data_rt), 
        .f_o_stall(fw2_o_stall)
    );

    assign wb_ds1_o_data_rd = (ms_wb1_o_memtoreg) ? ms_wb1_o_load_data_1 : ms_wb1_o_alu_value;
    assign wb_ds2_o_data_rd = (ms_wb2_o_memtoreg) ? ms_wb2_o_load_data_2 : ms_wb2_o_alu_value;
endmodule
`endif 
