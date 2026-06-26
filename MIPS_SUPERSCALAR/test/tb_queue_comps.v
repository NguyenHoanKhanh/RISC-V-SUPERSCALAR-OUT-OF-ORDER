`include "./source/queue_components.v"
`timescale 1ns / 1ps

// 1. Define Macros to mock "header.vh" logic
`define DEPTH 3          // 2^3 = 8 slots
`define PC_WIDTH 32
`define IMM_WIDTH 16
`define FUNCT_WIDTH 6
`define JUMP_WIDTH 26
`define OPCODE_WIDTH 6
`define DWIDTH 32
`define AWIDTH 5

module tb_queue_comps;

    // Inputs
    reg qc_clk;
    reg qc_rst;
    reg qc_i_ce;
    reg qc_i_reg_dst;
    reg qc_i_alu_src;
    reg qc_i_reg_write;
    reg qc_i_we;
    reg qc_i_re;
    reg qc_i_jr;
    reg qc_i_jal;
    reg qc_i_memtoreg;
    reg qc_i_memwrite;
    
    reg [`PC_WIDTH - 1 : 0] qc_i_pc;
    reg [`IMM_WIDTH - 1 : 0] qc_i_imm;
    reg [`FUNCT_WIDTH - 1 : 0] qc_i_funct;
    reg [`JUMP_WIDTH - 1 : 0] qc_i_jal_addr;
    reg [`OPCODE_WIDTH - 1 : 0] qc_i_opcode;
    reg [`DWIDTH - 1 : 0] qc_i_data_rs;
    reg [`DWIDTH - 1 : 0] qc_i_data_rt;
    reg [`AWIDTH - 1 : 0] qc_i_addr_rd;
    reg [`AWIDTH - 1 : 0] qc_i_addr_rs;
    reg [`AWIDTH - 1 : 0] qc_i_addr_rt;

    // Outputs
    wire qc_o_ce;
    wire qc_o_reg_dst;
    wire qc_o_alu_src;
    wire qc_o_regwrite;
    wire qc_o_jr;
    wire qc_o_jal;
    wire qc_o_memtoreg;
    wire qc_o_memwrite;
    
    wire [`PC_WIDTH - 1 : 0] qc_o_pc;
    wire [`IMM_WIDTH - 1 : 0] qc_o_imm;
    wire [`FUNCT_WIDTH - 1 : 0] qc_o_funct;
    wire [`JUMP_WIDTH - 1 : 0] qc_o_jal_addr;
    wire [`OPCODE_WIDTH - 1 : 0] qc_o_opcode;
    wire [`DWIDTH - 1 : 0] qc_o_data_rs;
    wire [`DWIDTH - 1 : 0] qc_o_data_rt;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rd;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rs;
    wire [`AWIDTH - 1 : 0] qc_o_addr_rt;

    // Instantiate the Unit Under Test (UUT)
    queue_comps uut (
        .qc_clk(qc_clk), .qc_rst(qc_rst), 
        .qc_i_ce(qc_i_ce), .qc_i_pc(qc_i_pc), 
        .qc_i_jr(qc_i_jr), .qc_i_jal(qc_i_jal), 
        .qc_i_imm(qc_i_imm), .qc_i_funct(qc_i_funct), 
        .qc_i_opcode(qc_i_opcode), .qc_i_reg_dst(qc_i_reg_dst), 
        .qc_i_alu_src(qc_i_alu_src), .qc_i_data_rs(qc_i_data_rs), 
        .qc_i_data_rt(qc_i_data_rt), .qc_i_memtoreg(qc_i_memtoreg), 
        .qc_i_memwrite(qc_i_memwrite), .qc_i_jal_addr(qc_i_jal_addr), 
        .qc_i_reg_write(qc_i_reg_write), .qc_i_addr_rd(qc_i_addr_rd), 
        .qc_i_addr_rs(qc_i_addr_rs), .qc_i_addr_rt(qc_i_addr_rt), 
        .qc_i_we(qc_i_we), .qc_i_re(qc_i_re), 
        // Outputs
        .qc_o_addr_rd(qc_o_addr_rd), .qc_o_addr_rs(qc_o_addr_rs), 
        .qc_o_addr_rt(qc_o_addr_rt), .qc_o_ce(qc_o_ce), 
        .qc_o_jr(qc_o_jr), .qc_o_jal(qc_o_jal), 
        .qc_o_imm(qc_o_imm), .qc_o_funct(qc_o_funct), 
        .qc_o_opcode(qc_o_opcode), .qc_o_reg_dst(qc_o_reg_dst), 
        .qc_o_alu_src(qc_o_alu_src), .qc_o_data_rs(qc_o_data_rs), 
        .qc_o_data_rt(qc_o_data_rt), .qc_o_memtoreg(qc_o_memtoreg), 
        .qc_o_memwrite(qc_o_memwrite), .qc_o_jal_addr(qc_o_jal_addr), 
        .qc_o_regwrite(qc_o_regwrite), .qc_o_pc(qc_o_pc)
    );

    // Clock Generation
    always #5 qc_clk = ~qc_clk; // 10ns period

    initial begin
        $dumpfile("./waveform/queue_comps.vcd");
        $dumpvars(0, tb_queue_comps);
    end

    // Task to drive inputs quickly
    task write_queue(input [31:0] pc_val, input [5:0] opcode_val);
        begin
            qc_i_we = 1;
            qc_i_pc = pc_val;
            qc_i_opcode = opcode_val;
            // Set other signals to dummy values to reduce clutter
            qc_i_ce = 1; qc_i_jr = 0; qc_i_jal = 0;
            qc_i_reg_dst = 1; qc_i_alu_src = 0; qc_i_memtoreg = 0;
            qc_i_memwrite = 0; qc_i_reg_write = 1;
            qc_i_data_rs = 32'hAAAA_BBBB; qc_i_data_rt = 32'hCCCC_DDDD;
            qc_i_addr_rd = 5'd1; qc_i_addr_rs = 5'd2; qc_i_addr_rt = 5'd3;
            @(negedge qc_clk); // Wait for edge
            qc_i_we = 0;
        end
    endtask

    initial begin
        // Initialize Inputs
        qc_clk = 0;
        qc_rst = 1;
        qc_i_we = 0;
        qc_i_re = 0;
        qc_i_pc = 0;
        
        // --- 1. Reset ---
        $display("Test 1: Reset");
        #10 qc_rst = 0; // Assert Reset
        #10 qc_rst = 1; // Release Reset
        #10;

        // --- 2. Write Data (Fill Queue partially) ---
        $display("Test 2: Writing 3 items (Size is 8)");
        write_queue(32'h0000_0010, 6'h01); // Item 1
        write_queue(32'h0000_0014, 6'h02); // Item 2
        write_queue(32'h0000_0018, 6'h03); // Item 3

        // --- 3. Read Data ---
        $display("Test 3: Reading 2 items");
        qc_i_re = 1;
        @(negedge qc_clk); // Read Item 1
        $display("Read PC: %h (Exp: 00000010)", qc_o_pc);
        
        @(negedge qc_clk); // Read Item 2
        $display("Read PC: %h (Exp: 00000014)", qc_o_pc);
        
        qc_i_re = 0;
        #10;
        $display("Current Output PC (Peek Item 3): %h (Exp: 00000018)", qc_o_pc);

        // --- 4. Simultaneous Read/Write (THE BUG CHECK) ---
        $display("Test 4: Simultaneous Read and Write");
        // We have Item 3 inside.
        // We will Write Item 4 and Read Item 3 at the same time.
        qc_i_we = 1;
        qc_i_re = 1;
        qc_i_pc = 32'h0000_0020; // New Item 4
        
        @(negedge qc_clk);
        qc_i_we = 0;
        qc_i_re = 0;
        
        // If the bug exists, counter decreased.
        // If logic is correct, counter stayed same.
        // We consumed Item 3, so Item 4 should be at output now.
        #10;
        $display("After Simult. R/W - Output PC: %h (Exp: 00000020)", qc_o_pc);

        $finish;
    end
endmodule