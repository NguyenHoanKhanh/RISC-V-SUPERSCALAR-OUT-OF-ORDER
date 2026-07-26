# SuperScalar RV32IM-clean benchmark flow

# The position of simulation files.
SIMDIR := sim
# Contains .elf/.bin when building benchmarks.
BUILDDIR := build
# The position of RTL source files.
SRC_DIR := src
SRC2_DIR := src_2
BEEBS_DIR := beebs
BEEBS_PORT_DIR := beebs_port
BEEBS_CRC_ITERS ?= 1024
BEEBS_MAX_CYCLES ?= 500000
BEEBS_BASE_CFLAGS := -fno-pic -fno-pie -mcmodel=medlow -mno-relax
BEEBS_EXTRA_CFLAGS ?=
BEEBS_EXTRA_PLUSARGS ?=
BEEBS_RTL_DEFINES ?= -DCTRL_SAFE_MODE
BEEBS_SUBSET := alu alu_parallel mem mix mix_parallel load_chain
# The position of the testbench.
TB := test/tb_datapath.v
DHRYSTONE_TB := test/tb_datapath_dhrystone.v
TB_ALU := test/tb_alu.v

OUT := $(SIMDIR)/datapath.vvp
ALU_OUT := $(SIMDIR)/alu.vvp
BEEBS_OUT := $(SIMDIR)/beebs_datapath.vvp
SRC2_OUT := $(SIMDIR)/src2_datapath.vvp
ONECYCLE_OUT := $(SIMDIR)/datapath_1cycle.vvp
VCD := $(SIMDIR)/datapath.vcd
ALU_VCD := $(SIMDIR)/alu.vcd

RISCV_TESTS := riscv-tests-master/isa/rv32im_clean
# Some toolchains are used to run project
RISCV_GCC := riscv64-unknown-elf-gcc
RISCV_OBJCOPY := riscv64-unknown-elf-objcopy
RISCV_OBJDUMP := riscv64-unknown-elf-objdump
POWERSHELL := powershell.exe
IVERILOG := iverilog
VVP := vvp
GTKWAVE := gtkwave
QUARTUS_SH ?= D:/intelFPGA_lite/quartus/bin64/quartus_sh.exe
SUPERSCALAR_QUARTUS_DIR ?= F:/superscalar
SUPERSCALAR_QUARTUS_PROJECT ?= datapath

BENCHMARKS := add sub and or xor sll srl sra slt sltu \
              addi andi ori xori slli srli srai slti sltiu srl_ext sra_ext \
              lb lh lw lbu lhu sb sh sw \
              mul mulh mulhsu mulhu div divu rem remu
DEBUG_BENCHMARKS := add_t5
RV32I_R_BENCHMARKS := add sub and or xor sll srl sra slt sltu
RV32I_I_BENCHMARKS := addi andi ori xori slli srli srai slti sltiu srl_ext sra_ext
LOAD_STORE_BENCHMARKS := lb lh lw lbu lhu sb sh sw
RV32M_BENCHMARKS := mul mulh mulhsu mulhu div divu rem remu
BIRISCV_TB := biriscv/tb/tb_core_icarus
BIRISCV_BUILDDIR := $(BUILDDIR)/biriscv
BIRISCV_OBJCOPY := $(RISCV_OBJCOPY)
RSD_REAL_PROCESSOR := $(abspath rsd_master/Processor)
RSD_PROCESSOR_LINK := /tmp/superscalar_rsd_processor
RSD_SRC := $(RSD_PROCESSOR_LINK)/Src
RSD_BUILDDIR := /tmp/superscalar_rsd_bench
RSD_HEX_TOOL := $(RSD_PROCESSOR_LINK)/Tools/TestDriver/BinaryToHex.py
RSD_MAX_TEST_CYCLES ?= 100000
RSD_VERILATOR_BIN ?= /opt/verilator-4.026/bin/verilator
BOOM_DIR := riscv-boom
BOOM_BUILDDIR := $(BUILDDIR)/boom
BOOM_ASMDIR := $(BUILDDIR)/boom_asm
BOOM_ELF_TEXT ?= 0x80000000
BOOM_GCC_MARCH ?= rv64im_zicsr_zicntr
BOOM_GCC_MABI ?= lp64
BOOM_LINKER ?= riscv-tests-master/benchmarks/common/test.ld
BOOM_GCC_FLAGS ?= -U_FORTIFY_SOURCE -DPREALLOCATE=1 -static -mcmodel=medany -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns -Wno-implicit-int -Wno-implicit-function-declaration -fno-pic -fno-pie -Wl,--no-relax
BOOM_LINK_LIBS ?=
BOOM_COMMON_DIR ?= riscv-tests-master/benchmarks/common
BOOM_ENCODING_DIR ?= $(CHIPYARD_DIR)/.conda-env/riscv-tools/include/riscv
BOOM_RUNTIME_SRCS := tools/boom_min_runtime.S
BOOM_USE_RISCV_TESTS_RUNTIME ?= 1
CHIPYARD_DIR ?=
BOOM_CHIPYARD_CONFIG ?= SmallBoomV3Config
BOOM_MAX_CYCLES ?= 1000000
BOOM_EXTRA_RUN_ARGS ?=
BOOM_STAGEDIR ?= /tmp/superscalar_boom_bench
BOOM_BENCH_ITERS ?= 64
MIPS_DIR := MIPS_SUPERSCALAR
MIPS_BUILDDIR := $(BUILDDIR)/mips
BEEBS_BUILDDIR := $(BUILDDIR)/beebs
DHRYSTONE21_SRC_DIR := drystone_2_1
DHRYSTONE21_PORT_DIR := drystone_2_1_port
DHRYSTONE21_BUILDDIR := $(BUILDDIR)/dhrystone_2_1
DHRYSTONE_RTL_DIR := src copy
DHRYSTONE21_OUT := $(SIMDIR)/dhrystone_2_1_datapath.vvp
DHRYSTONE21_PORT_SRC := $(DHRYSTONE21_BUILDDIR)/dhry_1_rtl.c
DHRYSTONE21_PORT_SRC2 := $(DHRYSTONE21_BUILDDIR)/dhry_2_rtl.c
DHRYSTONE_RUNS ?= 4
DHRYSTONE_MAX_CYCLES ?= 200000
DHRYSTONE_FMAX_MHZ ?= 87.17
DHRYSTONE_RTL_DEFINES ?= $(BEEBS_RTL_DEFINES) -DBRANCH_FRONTEND_ONLY
DHRYSTONE_EXTRA_PLUSARGS ?=
BRANCH_FLUSH_EXTRA_PLUSARGS ?=
PICOLIBC_INCLUDE ?= /usr/lib/picolibc/riscv64-unknown-elf/include
MIPS_RISCV_TESTS := riscv-tests-master/isa/rv32i_mips_safe
MIPS_FRIENDLY_RISCV_TESTS := riscv-tests-master/isa/rv32i_mips_friendly
MIPS_OUT := ../$(SIMDIR)/mips_datapath.vvp
MIPS_TB := test/tb_benchmark.v
MIPS_MAX_CYCLES ?= 10000
MIPS_DRAIN_CYCLES ?= 300
MIPS_EXTRA_PLUSARGS ?=
MIPS_LOAD_STORE_BENCHMARKS := lw sw
MIPS_SUPPORTED_BENCHMARKS := $(RV32I_R_BENCHMARKS) $(RV32I_I_BENCHMARKS) $(MIPS_LOAD_STORE_BENCHMARKS)

BIRISCV_BENCHMARKS := $(addprefix biriscv_,$(BENCHMARKS))
RSD_BENCHMARKS := $(addprefix rsd_,$(BENCHMARKS))
BOOM_BENCHMARKS := $(addprefix boom_,$(BENCHMARKS))
MIPS_BENCHMARKS := $(addprefix mips_,$(MIPS_SUPPORTED_BENCHMARKS))
MIPS_FRIENDLY_BENCHMARKS := $(addprefix mipsf_,$(MIPS_SUPPORTED_BENCHMARKS))
SRC2_BENCHMARKS := $(addprefix src2_,$(BENCHMARKS))
ONECYCLE_BENCHMARKS := $(addprefix 1cycle_,$(BENCHMARKS))

.PHONY: all compile compile_superscalar run run_raw run_print run_raw_print raw_result print_result branch_loop_test lsq_stack_test dhrystone_proc7_smoke dhrystone_proc1_smoke_copy branch_flush_min_copy branch_flush_no_overwrite_copy branch_after_load_test branch_after_load_copy pointer_field_branch_copy dhrystone_final_check_like_copy store_data_reuse_copy store_burst_reuse_copy repeated_load_same_rd_copy repeated_load_same_rd_debug_copy loop_exit_blt_copy func2_strcmp_copy strcpy_stack_loop_copy sb_lbu_basic_copy sb_burst_lbu_copy lbu_bne_loop_copy lbu_sb_bne_min_copy spec_lq_restore_load_copy spec_lq_restore_load_forward_spec_copy forward_spec_restore_lane1_copy forward_spec_late_load_restore_copy lbu_bne_body_update_wakeup_copy lbu_bne_body_loop_wakeup_copy btfnt_loop_copy branch_after_load_safe_test jal_skip_test jal_skip_safe_test compile_alu run_alu wave_alu dhrystone_2_1 dhrystone_2_1_debug dhrystone_2_1_proc1_debug dhrystone_2_1_markers dhrystone_2_1_fast_single_branch_spec_profile dhrystone_2_1_fast_forward_branch_spec dhrystone_2_1_fast_forward_branch_spec_quick dhrystone_2_1_fast_forward_branch_spec_profile dhrystone_2_1_fast_forward_branch_spec_log dhrystone_2_1_fast_forward_branch_spec_quick_log dhrystone_2_1_fast_forward_branch_spec_markers_log dhrystone_2_1_fast_forward_branch_spec_debug_log dhrystone_2_1_fast_forward_branch_spec_load_direct dhrystone_2_1_fast_forward_branch_spec_load_direct_quick dhrystone_2_1_fast_forward_branch_spec_load_direct_profile dhrystone_2_1_fast_forward_branch_spec_load_direct_log dhrystone_2_1_fast_forward_branch_spec_load_direct_quick_log dhrystone_2_1_fast_all_branch_spec dhrystone_2_1_fast_all_branch_spec_quick dhrystone_2_1_fast_all_branch_spec_profile dhrystone_2_1_fast_all_branch_spec_log dhrystone_2_1_fast_all_branch_spec_quick_log dhrystone_2_1_fast_all_branch_spec_load_direct dhrystone_2_1_fast_all_branch_spec_load_direct_quick dhrystone_2_1_fast_all_branch_spec_load_direct_profile dhrystone_2_1_fast_all_branch_spec_load_direct_log dhrystone_2_1_fast_all_branch_spec_load_direct_quick_log dhrystone_2_1_fast_single_branch_spec_lq_debug dhrystone_2_1_fast_single_branch_spec_lq_debug_log dhrystone_2_1_fast_single_branch_spec_lq_debug_quick_log dhrystone_2_1_fast_pht_proc1_focus_log dhrystone_2_1_fast_pht_proc1_head_priority_log dhrystone_2_1_fast_pht_proc1_lane2_branch_ckpt_log dhrystone_2_1_fast_pht_proc1_lane2_buffer_log dhrystone_2_1_fast_pht_proc1_early_rob_nonmem_log dhrystone_2_1_fast_pht_proc1_early_rob_ready_alu_log dhrystone_2_1_fast_pht_proc1_branch_load_wakeup_log dhrystone_2_1_fast_pht_proc1_lq_resp_scan_log dhrystone_2_1_fast_pht_proc1_lq_head_cpl_priority_log dhrystone_2_1_fast_pht_proc1_no_ckpt_barrier_log dhrystone_2_1_fast_pht_proc1_allow_rename_on_save_log clean_logs beebs_subset_report beebs_subset_summary beebs_crc32 beebs_crc32_smoke beebs_crc32_check16 src2_compile src2_run src2_run_raw src2_run_print src2_run_raw_print src2_raw_run_print 1cycle_compile 1cycle_run 1cycle_report_im view wave clean rebuild build_bench_elfs check_jumps allim report_im src2_report_im biriscv_allim biriscv_make_allim make_allim_biriscv biriscv_report_im biriscv_clean rsd_build rsd_run_hex rsd_allim rsd_make_allim make_allim_rsd rsd_report_im rsd_clean boom_info boom_build_elfs boom_allim boom_report_im mips_info mips_run_hex mips_run_raw mips_run_print mips_run_raw_print mips_alli mips_allim mips_make_alli mips_make_allim make_alli_mips make_allim_mips mips_report_i mips_report_im mips_friendly_alli mips_friendly_report_i mips_friendly_report_im $(BENCHMARKS) $(DEBUG_BENCHMARKS) $(SRC2_BENCHMARKS) $(ONECYCLE_BENCHMARKS) $(BIRISCV_BENCHMARKS) $(RSD_BENCHMARKS) $(BOOM_BENCHMARKS) $(MIPS_BENCHMARKS) $(MIPS_FRIENDLY_BENCHMARKS)

all: compile

# When run compile The project will automatically create sim and build folder if They do not already exist and update PROGRAM_INSTRS 
# for tb_datapath.v
compile:
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
	$(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -I $(SRC_DIR) -o $(OUT) $(TB)

# Compile the Quartus project located at F:\superscalar.
compile_superscalar:
	@echo "=========================================="
	@echo "Compiling Quartus project: $(SUPERSCALAR_QUARTUS_DIR)/$(SUPERSCALAR_QUARTUS_PROJECT).qpf"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "& { Set-Location '$(SUPERSCALAR_QUARTUS_DIR)'; & '$(QUARTUS_SH)' --flow compile '$(SUPERSCALAR_QUARTUS_PROJECT)' }"

# Run simulation only
run: compile
	$(VVP) $(OUT)

run_raw: compile
	$(VVP) $(OUT) +RAW_RESULT

run_print: compile
	$(VVP) $(OUT) +PRINT_COMMITS

run_raw_print: compile
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS

raw_result: run_raw

print_result: run_print

branch_loop_test:
	@echo "=========================================="
	@echo "Running directed branch dependency loop test"
	@echo "Expected: x28=0 and x29=1"
	@echo "If x28=3, branch used stale x5 and exited after one loop."
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		test/asm/branch_loop.S -o $(BUILDDIR)/branch_loop.elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/branch_loop.elf $(BUILDDIR)/branch_loop.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/branch_loop.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +MAX_CYCLES=500

lsq_stack_test:
	@echo "=========================================="
	@echo "Running directed store/load stack test"
	@echo "Expected: x28=2080 and x29=1"
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		test/asm/lsq_stack_test.S -o $(BUILDDIR)/lsq_stack_test.elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/lsq_stack_test.elf $(BUILDDIR)/lsq_stack_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/lsq_stack_test.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +MAX_CYCLES=500

dhrystone_proc7_smoke:
	@echo "=========================================="
	@echo "Running Dhrystone Proc_7-like directed smoke test"
	@echo "Expected: x28=7, x29=1, x30 reaches 150"
	@echo "If x30 stops at 13, the issue is after Proc_7-like return/store commit."
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/dhrystone_proc7_smoke.S -o $(BUILDDIR)/dhrystone_proc7_smoke.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/dhrystone_proc7_smoke.elf > $(BUILDDIR)/dhrystone_proc7_smoke.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/dhrystone_proc7_smoke.elf $(BUILDDIR)/dhrystone_proc7_smoke.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/dhrystone_proc7_smoke.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

dhrystone_proc1_smoke_copy:
	@echo "=========================================="
	@echo "Running Dhrystone Proc_1-like directed smoke test on src copy"
	@echo "Expected: x30 reaches 15 after return, x28=29, x29=1"
	@echo "If x30 stops at 14, the issue is inside Proc_1-like call/load/store/return path."
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/dhrystone_proc1_smoke.S -o $(BUILDDIR)/dhrystone_proc1_smoke.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/dhrystone_proc1_smoke.elf > $(BUILDDIR)/dhrystone_proc1_smoke.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/dhrystone_proc1_smoke.elf $(BUILDDIR)/dhrystone_proc1_smoke.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/dhrystone_proc1_smoke.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/dhrystone_proc1_smoke_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/dhrystone_proc1_smoke_copy.vvp +RAW_RESULT +PRINT_MARKERS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

branch_flush_min_copy:
	@echo "=========================================="
	@echo "Running minimal taken-branch flush test on src copy"
	@echo "Expected: wrong-path x28=123/x29=-1 must not commit; final x30=99 x28=7 x29=1"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/branch_flush_min.S -o $(BUILDDIR)/branch_flush_min.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/branch_flush_min.elf > $(BUILDDIR)/branch_flush_min.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/branch_flush_min.elf $(BUILDDIR)/branch_flush_min.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/branch_flush_min.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/branch_flush_min_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/branch_flush_min_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300 $(BRANCH_FLUSH_EXTRA_PLUSARGS)

branch_flush_no_overwrite_copy:
	@echo "=========================================="
	@echo "Running taken-branch no-overwrite flush test on src copy"
	@echo "Expected: wrong-path x27=123 must not commit; final x30=99 x28=7 x29=1"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/branch_flush_no_overwrite.S -o $(BUILDDIR)/branch_flush_no_overwrite.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/branch_flush_no_overwrite.elf > $(BUILDDIR)/branch_flush_no_overwrite.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/branch_flush_no_overwrite.elf $(BUILDDIR)/branch_flush_no_overwrite.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/branch_flush_no_overwrite.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/branch_flush_no_overwrite_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/branch_flush_no_overwrite_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300 $(BRANCH_FLUSH_EXTRA_PLUSARGS)

branch_after_load_test:
	@echo "=========================================="
	@echo "Running directed branch-after-load test"
	@echo "Expected: x28=2080 and x29=1"
	@echo "If x29=-1, branch/load compare used wrong data."
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		test/asm/branch_after_load_test.S -o $(BUILDDIR)/branch_after_load_test.elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/branch_after_load_test.elf $(BUILDDIR)/branch_after_load_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/branch_after_load_test.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +MAX_CYCLES=500

branch_after_load_copy:
	@echo "=========================================="
	@echo "Running directed branch-after-load test on src copy"
	@echo "PASS expected: x28=2080 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20 means load-to-branch compare used stale data"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/branch_after_load_test.S -o $(BUILDDIR)/branch_after_load_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/branch_after_load_test.elf > $(BUILDDIR)/branch_after_load_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/branch_after_load_test.elf $(BUILDDIR)/branch_after_load_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/branch_after_load_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/branch_after_load_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/branch_after_load_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

pointer_field_branch_copy:
	@echo "=========================================="
	@echo "Running pointer-field branch test on src copy"
	@echo "Pattern: lw pointer; lw field+8; branch compare"
	@echo "PASS expected: x28=2 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20 means pointer/field load branch path is wrong"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/pointer_field_branch_test.S -o $(BUILDDIR)/pointer_field_branch_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/pointer_field_branch_test.elf > $(BUILDDIR)/pointer_field_branch_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/pointer_field_branch_test.elf $(BUILDDIR)/pointer_field_branch_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/pointer_field_branch_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/pointer_field_branch_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/pointer_field_branch_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

dhrystone_final_check_like_copy:
	@echo "=========================================="
	@echo "Running Dhrystone final-check-like sequence on src copy"
	@echo "Pattern: 12 consecutive value/pointer field checks"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing check number"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/dhrystone_final_check_like.S -o $(BUILDDIR)/dhrystone_final_check_like.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/dhrystone_final_check_like.elf > $(BUILDDIR)/dhrystone_final_check_like.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/dhrystone_final_check_like.elf $(BUILDDIR)/dhrystone_final_check_like.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/dhrystone_final_check_like.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/dhrystone_final_check_like_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/dhrystone_final_check_like_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=800

store_data_reuse_copy:
	@echo "=========================================="
	@echo "Running store-data reuse test on src copy"
	@echo "Pattern: addi x7,5; sw x7; addi x7,1; lw back"
	@echo "PASS expected: x28=5 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is the wrong loaded value"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/store_data_reuse_test.S -o $(BUILDDIR)/store_data_reuse_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/store_data_reuse_test.elf > $(BUILDDIR)/store_data_reuse_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/store_data_reuse_test.elf $(BUILDDIR)/store_data_reuse_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/store_data_reuse_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/store_data_reuse_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/store_data_reuse_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

store_burst_reuse_copy:
	@echo "=========================================="
	@echo "Running burst store-data reuse test on src copy"
	@echo "Pattern: four addi/sw pairs reuse x7, then load back all words"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing load number"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/store_burst_reuse_test.S -o $(BUILDDIR)/store_burst_reuse_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/store_burst_reuse_test.elf > $(BUILDDIR)/store_burst_reuse_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/store_burst_reuse_test.elf $(BUILDDIR)/store_burst_reuse_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/store_burst_reuse_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/store_burst_reuse_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/store_burst_reuse_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

repeated_load_same_rd_copy:
	@echo "=========================================="
	@echo "Running repeated-load same-rd test on src copy"
	@echo "Pattern: three loads write x10, each followed by compare branch"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing load/check number"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/repeated_load_same_rd_test.S -o $(BUILDDIR)/repeated_load_same_rd_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/repeated_load_same_rd_test.elf > $(BUILDDIR)/repeated_load_same_rd_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/repeated_load_same_rd_test.elf $(BUILDDIR)/repeated_load_same_rd_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/repeated_load_same_rd_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/repeated_load_same_rd_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/repeated_load_same_rd_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

repeated_load_same_rd_debug_copy:
	@echo "=========================================="
	@echo "Running repeated-load same-rd DEBUG test on src copy"
	@echo "Pattern: three loads write x10, each followed by compare branch"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing load/check number"
	@echo "Debug trace: DISP/ISSUE/LQOUT/LQMWB/CPL/MEMWU show where the third load dependency is lost"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/repeated_load_same_rd_test.S -o $(BUILDDIR)/repeated_load_same_rd_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/repeated_load_same_rd_test.elf > $(BUILDDIR)/repeated_load_same_rd_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/repeated_load_same_rd_test.elf $(BUILDDIR)/repeated_load_same_rd_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/repeated_load_same_rd_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/repeated_load_same_rd_debug_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/repeated_load_same_rd_debug_copy.vvp +RAW_RESULT +PRINT_COMMITS +DEBUG_LOAD_FLOW +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

loop_exit_blt_copy:
	@echo "=========================================="
	@echo "Running loop-exit BLT test on src copy"
	@echo "Pattern: index=1, runs=1; ++index; blt runs,index,pass"
	@echo "PASS expected: x28=1 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20 means loop-exit branch did not take"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/loop_exit_blt_test.S -o $(BUILDDIR)/loop_exit_blt_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/loop_exit_blt_test.elf > $(BUILDDIR)/loop_exit_blt_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/loop_exit_blt_test.elf $(BUILDDIR)/loop_exit_blt_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/loop_exit_blt_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/loop_exit_blt_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/loop_exit_blt_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=200

func2_strcmp_copy:
	@echo "=========================================="
	@echo "Running Func_2/strcmp-like smoke test on src copy"
	@echo "Pattern: lbu offsets; jal strcmp-like byte loop; bge zero,result; return"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is wrong Func_2-like return value"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/func2_strcmp_smoke.S -o $(BUILDDIR)/func2_strcmp_smoke.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/func2_strcmp_smoke.elf > $(BUILDDIR)/func2_strcmp_smoke.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/func2_strcmp_smoke.elf $(BUILDDIR)/func2_strcmp_smoke.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/func2_strcmp_smoke.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/func2_strcmp_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/func2_strcmp_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300

strcpy_stack_loop_copy:
	@echo "=========================================="
	@echo "Running strcpy stack-loop smoke test on src copy"
	@echo "Pattern: lbu source byte; increment src/dst; sb byte; bne byte,zero,loop"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing copied-byte check"
	@echo "HANG signature: reaches MAX_CYCLES means null terminator was not observed by lbu loop"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/strcpy_stack_loop_test.S -o $(BUILDDIR)/strcpy_stack_loop_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/strcpy_stack_loop_test.elf > $(BUILDDIR)/strcpy_stack_loop_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/strcpy_stack_loop_test.elf $(BUILDDIR)/strcpy_stack_loop_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/strcpy_stack_loop_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/strcpy_stack_loop_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/strcpy_stack_loop_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300

sb_lbu_basic_copy:
	@echo "=========================================="
	@echo "Running SB/LBU byte-lane basic test on src copy"
	@echo "Pattern: sb lane 0..3, then lbu same lane"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing byte lane 1..4"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/sb_lbu_basic_test.S -o $(BUILDDIR)/sb_lbu_basic_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/sb_lbu_basic_test.elf > $(BUILDDIR)/sb_lbu_basic_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/sb_lbu_basic_test.elf $(BUILDDIR)/sb_lbu_basic_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/sb_lbu_basic_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/sb_lbu_basic_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/sb_lbu_basic_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300

sb_burst_lbu_copy:
	@echo "=========================================="
	@echo "Running burst SB then LBU test on src copy"
	@echo "Pattern: six byte stores first, then six byte loads/checks"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28 is failing byte index 1..6"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/sb_burst_lbu_test.S -o $(BUILDDIR)/sb_burst_lbu_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/sb_burst_lbu_test.elf > $(BUILDDIR)/sb_burst_lbu_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/sb_burst_lbu_test.elf $(BUILDDIR)/sb_burst_lbu_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/sb_burst_lbu_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/sb_burst_lbu_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/sb_burst_lbu_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500

lbu_bne_loop_copy:
	@echo "=========================================="
	@echo "Running LBU-to-BNE loop test on src copy"
	@echo "Pattern: lbu x13; bne x13,zero,loop, without store between them"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20 x28=4 means branch did not see null byte"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/lbu_bne_loop_test.S -o $(BUILDDIR)/lbu_bne_loop_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/lbu_bne_loop_test.elf > $(BUILDDIR)/lbu_bne_loop_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/lbu_bne_loop_test.elf $(BUILDDIR)/lbu_bne_loop_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/lbu_bne_loop_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/lbu_bne_loop_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/lbu_bne_loop_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300

lbu_sb_bne_min_copy:
	@echo "=========================================="
	@echo "Running LBU-SB-BNE minimal loop test on src copy"
	@echo "Pattern: lbu x13; sb x13; bne x13,zero,loop"
	@echo "PASS expected: x28=0 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 x30=20, x28=1..3 copied-byte check, x28=4 guard/null not observed"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/lbu_sb_bne_min_test.S -o $(BUILDDIR)/lbu_sb_bne_min_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/lbu_sb_bne_min_test.elf > $(BUILDDIR)/lbu_sb_bne_min_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/lbu_sb_bne_min_test.elf $(BUILDDIR)/lbu_sb_bne_min_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/lbu_sb_bne_min_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/lbu_sb_bne_min_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/lbu_sb_bne_min_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=400

spec_lq_restore_load_copy:
	@echo "=========================================="
	@echo "Running speculative LQ restore/load test on src copy"
	@echo "Pattern: older lw; backward BNE predicted taken but actually not taken; restore must not poison older load"
	@echo "PASS expected: x28=77 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 or timeout; SPEC_LQ_DEBUG shows whether ROB head load and LQ entry diverge"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/spec_lq_restore_load_test.S -o $(BUILDDIR)/spec_lq_restore_load_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/spec_lq_restore_load_test.elf > $(BUILDDIR)/spec_lq_restore_load_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/spec_lq_restore_load_test.elf $(BUILDDIR)/spec_lq_restore_load_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/spec_lq_restore_load_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/spec_lq_restore_load_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/spec_lq_restore_load_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500 +SPEC_LQ_DEBUG

spec_lq_restore_load_forward_spec_copy:
	@echo "=========================================="
	@echo "Running forward-branch speculation restore/load test on src copy"
	@echo "Pattern: same as spec_lq_restore_load_copy, but backend checkpoint speculation is enabled"
	@echo "PASS expected: x28=77 x29=1 x30=99 and SPEC profile spec_save_count > 0"
	@echo "FAIL signature: x29=-1, timeout, or SPEC_LQ_DEBUG shows LQ/ROB restore divergence"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/spec_lq_restore_load_test.S -o $(BUILDDIR)/spec_lq_restore_load_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/spec_lq_restore_load_test.elf > $(BUILDDIR)/spec_lq_restore_load_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/spec_lq_restore_load_test.elf $(BUILDDIR)/spec_lq_restore_load_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/spec_lq_restore_load_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/spec_lq_restore_load_forward_spec_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/spec_lq_restore_load_forward_spec_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500 +SPEC_LQ_DEBUG +PRINT_PROFILE

forward_spec_restore_lane1_copy:
	@echo "=========================================="
	@echo "Running lane-1 forward branch speculation restore test on src copy"
	@echo "Pattern: lane-1 BEQ predicted not-taken, actually taken; wrong-path writes must be flushed"
	@echo "PASS expected: x28=77 x29=1 x30=99; early-resolved branch may keep spec_save_count=0"
	@echo "FAIL signature: x29=-1, x30=20, x28=-1/1, or timeout"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/forward_spec_restore_lane1_test.S -o $(BUILDDIR)/forward_spec_restore_lane1_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/forward_spec_restore_lane1_test.elf > $(BUILDDIR)/forward_spec_restore_lane1_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/forward_spec_restore_lane1_test.elf $(BUILDDIR)/forward_spec_restore_lane1_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/forward_spec_restore_lane1_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/forward_spec_restore_lane1_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/forward_spec_restore_lane1_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500 +SPEC_LQ_DEBUG +PRINT_PROFILE

forward_spec_late_load_restore_copy:
	@echo "=========================================="
	@echo "Running late load-dependent forward branch speculation restore test on src copy"
	@echo "Pattern: lw; BEQ depends on loaded value, predicted not-taken, actually taken"
	@echo "PASS expected: x28=77 x29=1 x30=99 and spec_save_count > 0, spec_restore_count > 0"
	@echo "FAIL signature: x29=-1, x30=20, x28=-1, spec_save_count=0, or timeout"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/forward_spec_late_load_restore_test.S -o $(BUILDDIR)/forward_spec_late_load_restore_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/forward_spec_late_load_restore_test.elf > $(BUILDDIR)/forward_spec_late_load_restore_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/forward_spec_late_load_restore_test.elf $(BUILDDIR)/forward_spec_late_load_restore_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/forward_spec_late_load_restore_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/forward_spec_late_load_restore_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/forward_spec_late_load_restore_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=500 +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000000 +DEBUG_PC_HI=00000040

btfnt_loop_copy:
	@echo "=========================================="
	@echo "Running BTFNT backward-loop test on src copy"
	@echo "Pattern: loop with backward bne predicted taken, final not-taken exit"
	@echo "PASS expected: x28=3 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 or x30=20 means predicted-path/fall-through recovery is wrong"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/btfnt_loop_test.S -o $(BUILDDIR)/btfnt_loop_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/btfnt_loop_test.elf > $(BUILDDIR)/btfnt_loop_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/btfnt_loop_test.elf $(BUILDDIR)/btfnt_loop_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/btfnt_loop_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/btfnt_loop_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/btfnt_loop_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300 +PRINT_PROFILE

lbu_const_bne_wakeup_copy:
	@echo "=========================================="
	@echo "Running LBU-constant-BNE wakeup test on src copy"
	@echo "Pattern: sb 65; lbu x15; bne x15,65 immediately"
	@echo "PASS expected: x28=65 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 or x30=20 means branch used wrong LBU wakeup data"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/lbu_const_bne_test.S -o $(BUILDDIR)/lbu_const_bne_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/lbu_const_bne_test.elf > $(BUILDDIR)/lbu_const_bne_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/lbu_const_bne_test.elf $(BUILDDIR)/lbu_const_bne_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/lbu_const_bne_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/lbu_const_bne_wakeup_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/lbu_const_bne_wakeup_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=300

lbu_bne_body_update_wakeup_copy:
	@echo "=========================================="
	@echo "Running LBU-BNE body-update wakeup test on src copy"
	@echo "Pattern: lbu; bne not-taken; lw/addi/sub body must execute"
	@echo "PASS expected: x28=5 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 or x30=20; x28=1 means branch skipped update body"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/lbu_bne_body_update_test.S -o $(BUILDDIR)/lbu_bne_body_update_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/lbu_bne_body_update_test.elf > $(BUILDDIR)/lbu_bne_body_update_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/lbu_bne_body_update_test.elf $(BUILDDIR)/lbu_bne_body_update_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/lbu_bne_body_update_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/lbu_bne_body_update_wakeup_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/lbu_bne_body_update_wakeup_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=400

lbu_bne_body_loop_wakeup_copy:
	@echo "=========================================="
	@echo "Running LBU-BNE body-update loop wakeup test on src copy"
	@echo "Pattern: 4x loop: reset s2; lbu; bne not-taken; lw/addi/sub; backward bne"
	@echo "PASS expected: x28=5 x29=1 x30=99"
	@echo "FAIL signature: x29=-1 or x30=20; x28=1 means branch skipped update body"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)','$(SIMDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Wl,--no-relax -Ttext=0x0 \
		test/asm/lbu_bne_body_loop_test.S -o $(BUILDDIR)/lbu_bne_body_loop_test.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(BUILDDIR)/lbu_bne_body_loop_test.elf > $(BUILDDIR)/lbu_bne_body_loop_test.dump
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/lbu_bne_body_loop_test.elf $(BUILDDIR)/lbu_bne_body_loop_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/lbu_bne_body_loop_test.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(SIMDIR)/lbu_bne_body_loop_wakeup_copy.vvp $(DHRYSTONE_TB)
	$(VVP) $(SIMDIR)/lbu_bne_body_loop_wakeup_copy.vvp +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=800

jal_skip_test:
	@echo "=========================================="
	@echo "Running directed JAL skip/flush test"
	@echo "Expected: x28=7 and x29=1"
	@echo "If x28=123 or x29=-1, JAL did not suppress wrong-path commits."
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		test/asm/jal_skip_test.S -o $(BUILDDIR)/jal_skip_test.elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/jal_skip_test.elf $(BUILDDIR)/jal_skip_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/jal_skip_test.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +MAX_CYCLES=500

branch_after_load_safe_test:
	@echo "=========================================="
	@echo "Running directed branch-after-load test with CTRL_SAFE_MODE"
	@echo "Expected: x28=2080 and x29=1, without committing the fail path."
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		test/asm/branch_after_load_test.S -o $(BUILDDIR)/branch_after_load_test.elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/branch_after_load_test.elf $(BUILDDIR)/branch_after_load_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/branch_after_load_test.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -DCTRL_SAFE_MODE -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +MAX_CYCLES=500

jal_skip_safe_test:
	@echo "=========================================="
	@echo "Running directed JAL skip/flush test with CTRL_SAFE_MODE"
	@echo "Expected: x28=7 and x29=1, without committing x28=123/x29=-1."
	@echo "=========================================="
	@mkdir -p $(BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		test/asm/jal_skip_test.S -o $(BUILDDIR)/jal_skip_test.elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/jal_skip_test.elf $(BUILDDIR)/jal_skip_test.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/jal_skip_test.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -DCTRL_SAFE_MODE -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT) +RAW_RESULT +PRINT_COMMITS +NO_COMMIT_LIMIT +MAX_CYCLES=500

dhrystone_2_1:
	@echo "=========================================="
	@echo "Running Dhrystone 2.1 benchmark on SuperScalar"
	@echo "Source: $(DHRYSTONE21_SRC_DIR)"
	@echo "Runs: $(DHRYSTONE_RUNS)"
	@echo "=========================================="
	@mkdir -p $(DHRYSTONE21_BUILDDIR) $(SIMDIR)
	python3 tools/generate_dhrystone21_rtl_port.py \
		$(DHRYSTONE21_SRC_DIR)/dhry_1.c \
		$(DHRYSTONE21_PORT_SRC)
	python3 tools/generate_dhrystone21_dhry2_port.py \
		$(DHRYSTONE21_SRC_DIR)/dhry_2.c \
		$(DHRYSTONE21_PORT_SRC2)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -O3 -ffreestanding -fno-builtin -fno-common \
		-fno-pic -fno-pie -mcmodel=medlow -mno-relax -fno-tree-loop-distribute-patterns \
		-msmall-data-limit=0 -falign-functions=4 -Wno-implicit -Wno-implicit-int -Wno-return-type \
		-ffixed-x28 -ffixed-x29 -ffixed-x30 -ffixed-x31 \
		-DTIME -DNOENUM -DDHRY_ITERS=$(DHRYSTONE_RUNS) -Dstrcmp=dhry_strcmp \
		-nostdlib -nostartfiles -Wl,--no-relax,-Map,$(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.map -T $(DHRYSTONE21_PORT_DIR)/linker.ld \
		-I $(PICOLIBC_INCLUDE) \
		-I $(DHRYSTONE21_SRC_DIR) \
		$(DHRYSTONE21_PORT_DIR)/start.S \
		$(DHRYSTONE21_PORT_SRC) \
		$(DHRYSTONE21_PORT_SRC2) \
		-o $(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.elf
	$(RISCV_OBJDUMP) -d -M no-aliases $(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.elf > $(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.dump
	$(RISCV_OBJCOPY) -O binary $(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.elf $(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.bin "$(DHRYSTONE_RTL_DIR)/instr.hex" "$(DHRYSTONE_RTL_DIR)/program_info.vh"
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(DHRYSTONE21_BUILDDIR)/dhrystone_2_1.bin "$(DHRYSTONE_RTL_DIR)/data.hex" $(DHRYSTONE21_BUILDDIR)/dhrystone_2_1_data_info.vh
	$(IVERILOG) -g2012 $(DHRYSTONE_RTL_DEFINES) -DBEEBS_DATA_INIT -DUSE_DHRYSTONE_SRC_COPY -I "$(DHRYSTONE_RTL_DIR)" -o $(DHRYSTONE21_OUT) $(DHRYSTONE_TB)
	$(VVP) $(DHRYSTONE21_OUT) +RAW_RESULT +IGNORE_SCOREBOARD +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 \
		+DHRYSTONE_REPORT +DHRYSTONE_RUNS=$(DHRYSTONE_RUNS) +FMAX_MHZ=$(DHRYSTONE_FMAX_MHZ) \
		+MAX_CYCLES=$(DHRYSTONE_MAX_CYCLES) $(DHRYSTONE_EXTRA_PLUSARGS)

dhrystone_2_1_debug:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_MAX_CYCLES=1500 DHRYSTONE_EXTRA_PLUSARGS="+PRINT_COMMITS +BEEBS_DEBUG_HEAD"

dhrystone_2_1_proc1_debug:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_MAX_CYCLES=6000 DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +BEEBS_DEBUG_HEAD"

dhrystone_2_1_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_lsu_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_issue_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_load_cpl_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_mem_wakeup_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_exec_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_decode_combo_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_rob_cpl_commit_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_load_commit_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_store_commit_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pipe_cpl_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_ru_branch_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_RU_BRANCH_RESOLVE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_sq_query_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_rs_head_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_div_comb_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_prefetch_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_btfnt_prefetch_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_wakeup_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_wakeup_markers:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE"

dhrystone_2_1_fast_branch_wakeup_focus:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000005c0 +DEBUG_PC_HI=000006a0"

dhrystone_2_1_fast_btfnt_ru_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_RU_BRANCH_RESOLVE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_global_wakeup_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_WAKEUP_SELECT_BYPASS" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_btfnt_head_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_lq_ooo_complete_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_single_branch_spec_profile:
	@echo "=========================================="
	@echo "Experimental BTFNT frontend path on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf target: DMIPS/MHz should improve over 0.600530 baseline"
	@echo "Backend checkpoint speculation is gated off unless FAST_ENABLE_FORWARD_BRANCH_SPEC is added"
	@echo "If FAIL/stall: check BTFNT correction, load/store progress, and branch_pending profile"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_forward_branch_spec_profile:
	@echo "=========================================="
	@echo "Experimental forward branch speculation on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf target: DMIPS/MHz should improve over 0.600530 baseline"
	@echo "Expected profile: spec_save_count > 0 and branch_pending_blocks_fe lower than baseline"
	@echo "If FAIL/stall: rerun dhrystone_2_1_fast_forward_branch_spec_debug_log"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_forward_branch_spec: dhrystone_2_1_fast_forward_branch_spec_log

dhrystone_2_1_fast_forward_branch_spec_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_forward_branch_spec_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving bounded forward-spec log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected profile: spec_save_count > 0 and branch_pending_blocks_fe lower than 1361"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1_fast_forward_branch_spec_profile 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_forward_branch_spec_quick: dhrystone_2_1_fast_forward_branch_spec_quick_log

dhrystone_2_1_fast_forward_branch_spec_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_forward_branch_spec_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick forward-spec profile log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "If it does not complete Dhrystone, final profile should still show the blocking state"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=3000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_forward_branch_spec_markers_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_forward_branch_spec_markers_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving forward-spec marker log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Focus markers: x30=17 -> x28=13, x30=171 -> x28=1, x30=172 -> x28=7, x30=18 -> x28=5"; \
	bash -o pipefail -c 'timeout 120s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_forward_branch_spec_debug_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_forward_branch_spec_debug_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving bounded forward-spec debug log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "This target is intentionally verbose; use only after the normal profile fails."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=12000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE +SPEC_LQ_DEBUG +BEEBS_DEBUG_HEAD +DEBUG_PC_LO=00000390 +DEBUG_PC_HI=000003c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_forward_branch_spec_load_direct_profile:
	@echo "=========================================="
	@echo "Experimental forward branch spec + direct load completion on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf target: improve over forward-spec DMIPS/MHz 0.437137"
	@echo "Expected profile: rob_head_wait_load and lq_head_mem_wait should drop"
	@echo "If FAIL/stall: direct speculative load completion is unsafe; use normal forward-spec"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_LOAD_CPL_DIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_forward_branch_spec_load_direct: dhrystone_2_1_fast_forward_branch_spec_load_direct_log

dhrystone_2_1_fast_forward_branch_spec_load_direct_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_forward_branch_spec_load_direct_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving bounded forward-spec load-direct log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected profile: DMIPS/MHz > 0.437137, rob_head_wait_load < 1838"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1_fast_forward_branch_spec_load_direct_profile 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_forward_branch_spec_load_direct_quick: dhrystone_2_1_fast_forward_branch_spec_load_direct_quick_log

dhrystone_2_1_fast_forward_branch_spec_load_direct_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_forward_branch_spec_load_direct_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick forward-spec load-direct profile log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected quick profile: measured_cycles below 1264 and no final-check marker mismatch"; \
	echo "If timeout/fail: direct LQ completion under speculation needs stronger gating"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_LOAD_CPL_DIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_branch_spec_load_direct_profile:
	@echo "=========================================="
	@echo "Experimental PHT-filtered backward branch spec + direct load completion on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf target: improve over stable PHT/load-direct baseline measured_cycles=4062, DMIPS/MHz=0.560465"
	@echo "Expected profile: issue2_ready2_blocked=0, branch_pending_blocks_fe around/below 250, jal_pending_cycles around/below 130"
	@echo "If slower: remaining bottleneck is likely ROB-head load/complete pressure, not branch_pending alone"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pht_branch_spec_load_direct: dhrystone_2_1_fast_pht_branch_spec_load_direct_log

dhrystone_2_1_fast_pht_branch_spec_load_direct_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_branch_spec_load_direct_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving bounded PHT branch-spec load-direct log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected profile: measured_cycles < 4062 and DMIPS/MHz > 0.560465"; \
	echo "Focus counters: issue2_ready2_blocked=0, branch_pending_blocks_fe <= ~250, jal_pending_cycles <= ~130"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1_fast_pht_branch_spec_load_direct_profile 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_branch_spec_load_direct_quick: dhrystone_2_1_fast_pht_branch_spec_load_direct_quick_log

dhrystone_2_1_fast_pht_branch_spec_load_direct_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_branch_spec_load_direct_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick PHT branch-spec load-direct profile log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected quick profile: issue2_ready2_blocked=0, branch_pending_blocks_fe around/below 250, jal_pending_cycles around/below 130"; \
	echo "If timeout/fail: check speculative restore/load queue state before adding more speculation"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_fetch_btb_profile:
	@echo "=========================================="
	@echo "Experimental PHT/load-direct + fetch-stage BTB target cache on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf check: compare against stable quick measured_cycles=968, DMIPS/MHz=0.587967"
	@echo "Expected effect: flush_btfnt_predict should drop because BTB redirects next PC before decode"
	@echo "If slower/fail: keep stable PHT/load-direct and inspect BTB pending/suppress timing"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pht_fetch_btb_quick: dhrystone_2_1_fast_pht_fetch_btb_quick_log

dhrystone_2_1_fast_pht_fetch_btb_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_fetch_btb_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick fetch-BTB experiment log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against stable quick: measured_cycles=968, DMIPS/MHz=0.587967"; \
	echo "Focus counters: flush_btfnt_predict, fetch_stall_cycles, branch_pending_blocks_fe"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_fetch_btb_relaxed_pending_profile:
	@echo "=========================================="
	@echo "Experimental fetch-BTB with relaxed branch_pending on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf check: compare against fetch-BTB quick measured_cycles around 954 and stable baseline 968"
	@echo "Expected effect: branch_pending_blocks_fe should drop without increasing wrong-path commits"
	@echo "If FAIL/timeout: rollback this mode and keep plain FAST_FETCH_BTB"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pht_fetch_btb_relaxed_pending_quick: dhrystone_2_1_fast_pht_fetch_btb_relaxed_pending_quick_log

dhrystone_2_1_fast_pht_fetch_btb_relaxed_pending_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_fetch_btb_relaxed_pending_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick fetch-BTB relaxed-pending experiment log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against fetch-BTB quick: measured_cycles around 954, DMIPS/MHz around 0.5966"; \
	echo "Focus counters: fetch_btb_redirect, branch_pending_blocks_fe, flush_btfnt_predict, spec_restore"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_fetch_btb_rename_on_save_profile:
	@echo "=========================================="
	@echo "Experimental fetch-BTB relaxed-pending + rename-on-checkpoint-save on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "WARNING: this helped 1-run locally, but latest 4-run was slower than relaxed-pending baseline"
	@echo "Known 4-run comparison: relaxed-pending DMIPS/MHz=0.481312, rename-on-save DMIPS/MHz=0.467572"
	@echo "Use this only as an experiment; do not treat it as the current performance baseline"
	@echo "If FAIL/timeout: checkpoint-save/rename same-cycle timing needs waveform inspection"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_SPEC_ALLOW_RENAME_ON_SAVE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pht_fetch_btb_rename_on_save_quick: dhrystone_2_1_fast_pht_fetch_btb_rename_on_save_quick_log

dhrystone_2_1_fast_pht_fetch_btb_rename_on_save_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_fetch_btb_rename_on_save_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick fetch-BTB rename-on-save experiment log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against relaxed-pending quick: measured_cycles around 953, DMIPS/MHz around 0.5972"; \
	echo "Expected quick result from local sim: measured_cycles around 929, DMIPS/MHz around 0.6127"; \
	echo "Focus counters: decode_hold_cycles, dec_l1/l2_spec_save, branch_flush_count, spec_restore_count"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_SPEC_ALLOW_RENAME_ON_SAVE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_head_load_priority_profile:
	@echo "=========================================="
	@echo "Experimental PHT/load-direct + ROB-head load RS priority on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf check: compare against stable quick measured_cycles=968, DMIPS/MHz=0.587967"
	@echo "Expected effect: load_head_not_issued and rob_head_wait_load should drop"
	@echo "If slower: keep stable PHT/load-direct and inspect load completion/commit path"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_RS_HEAD_LOAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pht_head_load_priority_quick: dhrystone_2_1_fast_pht_head_load_priority_quick_log

dhrystone_2_1_fast_pht_head_load_priority_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_head_load_priority_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick ROB-head load-priority experiment log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against stable quick: measured_cycles=968, DMIPS/MHz=0.587967"; \
	echo "Focus counters: load_head_not_issued, rob_head_wait_load, lq_head_done_not_sent"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_RS_HEAD_LOAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_lane2_ckpt_profile:
	@echo "=========================================="
	@echo "Experimental PHT/load-direct + lane2 after branch rename-checkpoint on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf check: compare measured_cycles/DMIPS against dhrystone_2_1_fast_pht_branch_spec_load_direct"
	@echo "Expected effect: decode_hold_l2_after_br should drop; rollback must still pass"
	@echo "If slower: keep the stable PHT/load-direct target and optimize load/ROB next"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_SPEC_LANE2_AFTER_BRANCH_RENAME_CKPT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_pht_lane2_ckpt_quick: dhrystone_2_1_fast_pht_lane2_ckpt_quick_log

dhrystone_2_1_fast_pht_lane2_ckpt_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_lane2_ckpt_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick lane2-checkpoint experiment log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against stable quick: measured_cycles=968, DMIPS/MHz=0.587967"; \
	echo "Focus counters: decode_hold_l2_after_br, branch_pending_blocks_fe, rob_head_wait_load"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_SPEC_LANE2_AFTER_BRANCH_RENAME_CKPT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_fetch_btb_lane2_ckpt_quick: dhrystone_2_1_fast_pht_fetch_btb_lane2_ckpt_quick_log

dhrystone_2_1_fast_pht_fetch_btb_lane2_ckpt_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_fetch_btb_lane2_ckpt_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick fetch-BTB + lane2-checkpoint experiment log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against best quick: measured_cycles around 953, DMIPS/MHz around 0.597"; \
	echo "Focus counters: decode_hold_l2_after_br, branch_pending_blocks_fe, head_real_not_issued, load_real_not_issued"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_SPEC_LANE2_AFTER_BRANCH_RENAME_CKPT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_load_head_debug_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_load_head_debug_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT load-head debug log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Focus: ROB head load stalls, LQ waits, and load-flow around committed head PCs"; \
	echo "If log is too large, rerun without DEBUG_LOAD_FLOW and keep only PRINT_PROFILE"; \
	bash -o pipefail -c 'timeout 120s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=12000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE +BEEBS_DEBUG_HEAD +DEBUG_LOAD_FLOW" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_focus_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_focus_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 focus log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Baseline to compare: allow-rename-on-save 4-run measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "Focus: run-to-run growth around Proc_1 call/return, especially x30=14 -> x30=15"; \
	echo "Debug PC window: Proc_1 entry 0x000000b4 and main return window 0x000005c0..0x00000620"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_all_branch_spec_profile:
	@echo "=========================================="
	@echo "Experimental forward+backward branch speculation on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf target: improve over forward-spec DMIPS/MHz 0.437137"
	@echo "Expected profile: branch_pending_rs_wait < 1606 and branch_pending_blocks_fe < 2370"
	@echo "If FAIL/stall: backward branch speculation is too aggressive; keep forward-spec as the stable baseline"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_BACKWARD_BRANCHES" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_all_branch_spec: dhrystone_2_1_fast_all_branch_spec_log

dhrystone_2_1_fast_all_branch_spec_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_all_branch_spec_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving bounded all-branch-spec log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected profile: DMIPS/MHz > 0.437137, branch_pending_rs_wait < 1606"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1_fast_all_branch_spec_profile 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_all_branch_spec_quick: dhrystone_2_1_fast_all_branch_spec_quick_log

dhrystone_2_1_fast_all_branch_spec_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_all_branch_spec_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick all-branch-spec profile log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected quick profile: spec_save_count increases and branch_pending counters drop"; \
	echo "If timeout/fail: backward branch checkpoint/restore is likely unsafe for this RTL"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_BACKWARD_BRANCHES" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_head_priority_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_head_priority_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + RS head-priority log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against promoted allow-rename-on-save baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "Expected profile if useful: rob_head_wait_non_mem/head_wait_not_issued decreases without increasing branch/spec restores"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_lane2_branch_ckpt_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lane2_branch_ckpt_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + lane2-after-branch checkpoint log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, RESULT REGS x29=1 x30=31"; \
	echo "Current stable baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "Useful only if measured_cycles < 3956 and DMIPS/MHz > 0.575482"; \
	echo "Expected profile if useful: decode_hold_cycles, dec_l2_lane1_not_allow, and decode_hold_l2_after_br decrease"; \
	echo "If FAIL/timeout/slower: lane2 branch checkpoint timing is not promoted; keep allow-rename baseline"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY -DFAST_SPEC_LANE2_AFTER_BRANCH_RENAME_CKPT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_lane2_buffer_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lane2_buffer_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + lane2 buffer-behind-lane1 log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, RESULT REGS x29=1 x30=31"; \
	echo "Current stable baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "Useful only if measured_cycles < 3956 and DMIPS/MHz > 0.575482"; \
	echo "Expected profile if useful: dec_l2_buf_full, dec_l2_lane1_buffer, and decode_hold_lane2 decrease"; \
	echo "If FAIL/timeout/slower: lane2 buffering behind old lane1 is not promoted"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY -DFAST_LANE2_BUFFER_BEHIND_LANE1" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_early_rob_nonmem_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_early_rob_nonmem_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + early non-memory ROB allocation log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, RESULT REGS x29=1 x30=31"; \
	echo "Current stable baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "Useful only if measured_cycles < 3956 and DMIPS/MHz > 0.575482"; \
	echo "Expected profile if useful: decode_hold_cycles, head_real_not_issued, or dispatch0_cycles decrease without extra spec_restore"; \
	echo "If FAIL/timeout/slower: early ROB tag timing is not promoted"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY -DFAST_ROB_ALLOC_AT_RENAME_NONMEM" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_early_rob_ready_alu_log:
	@mkdir -p logs
	@echo "REJECTED: FAST_ROB_ALLOC_AT_RENAME_READY_ALU creates phantom ROB head entries."
	@echo "Observed failure: commits=0, head_real_not_issued=59995, x29=0 x30=0 at MAX_CYCLES."
	@echo "Do not run this target as an optimization path. Keep ROB allocation tied to real dispatch/issue timing."
	@exit 1

dhrystone_2_1_fast_pht_proc1_branch_load_wakeup_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_branch_load_wakeup_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + branch load-wakeup select log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against head-priority baseline: measured_cycles=4059, DMIPS/MHz=0.560879"; \
	echo "Expected profile if useful: branch_rs_wait_*_load and branch_pending_rs_wait decrease"; \
	echo "If FAIL/timeout: branch load wakeup-select is too aggressive; keep head-priority target as stable"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_lq_resp_scan_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lq_resp_scan_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + LQ response-complete scan log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against stable allow-rename baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "Expected profile if useful: load_head_exm_not_cpl/lq_head_done_not_sent/measured_cycles decrease"; \
	echo "If FAIL/timeout/slower: response scan is not safe/useful; keep allow-rename target as stable"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_LQ_RESP_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_lq_head_cpl_priority_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lq_head_cpl_priority_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 guarded baseline log after rejecting LQ head-complete priority to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against stable allow-rename baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "FAST_LQ_HEAD_CPL_PRIORITY is disabled here: it repeatedly timed out at x30=12 with rob_head_wait_alu high"; \
	echo "Expected profile: restore PASS baseline, then inspect EFFECTIVE BOTTLENECK SUMMARY"; \
	echo "Next useful optimization must lower eff_* counters, not samecycle_* accounting"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_prefetch_ckpt_barrier_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_prefetch_ckpt_barrier_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 checkpoint-barrier prefetch log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against stable baseline: measured_cycles=3956, DMIPS/MHz=0.575482"; \
	echo "This only allows fetch/decode preload during checkpoint barrier; rename/dispatch stay blocked."; \
	echo "Useful only if PASS and measured_cycles < 3956, with fetch_stall/decode_hold or eff_decode_spec_block lower."; \
	echo "If FAIL/timeout/slower: checkpoint barrier must also protect frontend timing; reject this target."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_prefetch_jal_pending_log
dhrystone_2_1_fast_pht_proc1_prefetch_jal_pending_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_prefetch_jal_pending_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 JAL-pending prefetch log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against checkpoint-prefetch baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "This allows fetch/decode preload during jal_pending only; rename/dispatch stay blocked by pre_req."; \
	echo "Useful only if PASS and measured_cycles < 3910, with jal_pending/fetch_stall lower and no flush spike."; \
	echo "If FAIL/timeout/slower: JAL pending must keep frontend blocked; reject this target."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_SPEC_PREFETCH_DURING_JAL_PENDING -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_branch_load_hotpc_log
dhrystone_2_1_fast_pht_proc1_branch_load_hotpc_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_branch_load_hotpc_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 branch-load hot-PC profile log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against checkpoint-prefetch baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Focus: BRANCH LOAD WAIT HOT PC PROFILE shows which branch PCs wait for load producers."; \
	echo "Useful next step depends on dominant bucket: not_issued -> RS/load issue selection; issued_not_exm -> LSU pipe; exm_not_cpl -> LQ/memory complete."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000380 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_branch_load_producer_priority_log
dhrystone_2_1_fast_pht_proc1_branch_load_producer_priority_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_branch_load_producer_priority_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 branch-load producer-priority log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against checkpoint-prefetch baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Expected profile if useful: branch_hot_pc_4a4 not_issued/issued_not_exm and branch_pending_rs_wait decrease."; \
	echo "If FAIL/timeout/slower: reject FAST_RS_BRANCH_LOAD_PRODUCER_PRIORITY and keep checkpoint-prefetch baseline."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_RS_BRANCH_LOAD_PRODUCER_PRIORITY -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000380 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_4a4_load_trace_log
dhrystone_2_1_fast_pht_proc1_4a4_load_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_4a4_load_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 0x4a4 load-use branch trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against checkpoint-prefetch baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Focus: 4A4 LOAD TRACE. It classifies the lbu 0x4a0 -> beq 0x4a4 producer wait without changing RTL behavior."; \
	echo "Next decision: ready_no_issue high => RS selection issue; rs_not_ready high => producer operand dependency; missing high => dispatch/restore tracking issue."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000480 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_ckpt_block_trace_log
dhrystone_2_1_fast_pht_proc1_ckpt_block_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_ckpt_block_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 checkpoint block trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against current best: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Focus: CKPT BLOCK TRACE. If l1/l2 simple-ready is high, next optimization is selective non-memory dispatch during checkpoint barrier."; \
	echo "If ready counts are low, checkpoint barrier is not the main useful target; move to ROB/load-head wait or branch_pending RS wait."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_lane2_block_trace_log
dhrystone_2_1_fast_pht_proc1_lane2_block_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lane2_block_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 lane2 block trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against current best: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Focus: LANE2 BLOCK TRACE. It classifies lane1_not_allow and lane1_buffer as simple/load/store/branch/jal."; \
	echo "Also inspect lane2_simple_dep indep/rs/rt/rd/any to decide if lane2 can rename behind simple lane1 safely."; \
	echo "Also inspect LANE2 OLDER TRACE. If ds2_wait is high and mostly independent, ru_rs_can_take_2 drain/refill may be worth optimizing."; \
	echo "Also inspect 4A4 LOAD BASE TRACE to see whether lbu 0x4a0 is waiting on addi 0x49c."; \
	echo "Next decision: simple-independent/older-wait heavy => safe lane2 rename relaxation; dependency-heavy => keep in-order rename and optimize load/branch path."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_lane2_older_refill_log
dhrystone_2_1_fast_pht_proc1_lane2_older_refill_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lane2_older_refill_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 lane2 older drain/refill experiment log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against current best: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Experiment: FAST_LANE2_OLDER_DRAIN_REFILL_SAFE allows lane2 buffer drain+refill only when lane1 decode has no real request."; \
	echo "Keep only if PASS and measured_cycles improves; reject if FAIL/timeout/slower."; \
	echo "Also inspect 4A4 LOAD BASE TRACE to find the next load-base producer bottleneck."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY -DFAST_LANE2_OLDER_DRAIN_REFILL_SAFE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_global_wakeup_trace_log
dhrystone_2_1_fast_pht_proc1_global_wakeup_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_global_wakeup_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 global wakeup-select trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against checkpoint-prefetch baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "Hypothesis: FAST_RS_WAKEUP_SELECT_BYPASS lets lbu 0x4a0 issue earlier when its ALU base producer wakes up."; \
	echo "Useful only if PASS, measured_cycles < 3910, and 4A4 branch_4a4_prod_rs_not_ready drops below 71."; \
	echo "If FAIL/timeout/slower: reject global wakeup on current RS timing and trace the 0x49c -> 0x4a0 dependency next."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000480 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_safe_global_wakeup_trace_log
dhrystone_2_1_fast_pht_proc1_safe_global_wakeup_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_safe_global_wakeup_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 safe global wakeup-select trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare: unsafe global wakeup got measured_cycles=1917 and DMIPS/MHz=1.187589 but FAILED x28=2."; \
	echo "This keeps spec-active younger-instruction gating while allowing global same-cycle wakeup outside speculation."; \
	echo "Useful only if PASS and measured_cycles improves over 3910; reject if correctness fails or branch/data markers corrupt."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_SAFE_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000480 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_load_base_wakeup_trace_log
dhrystone_2_1_fast_pht_proc1_load_base_wakeup_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_load_base_wakeup_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 load-base wakeup-select trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against checkpoint-prefetch baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "This only lets LOAD use same-cycle rs/base wakeup; store data, ALU, and speculative younger work stay conservative."; \
	echo "Useful if PASS, measured_cycles < 3910, and 4A4 branch_4a4_prod_rs_not_ready drops below 71."; \
	echo "If FAIL/timeout/slower: load-base same-cycle data path is unsafe; next step is waveform around 0x49c/0x4a0."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_RS_LOAD_BASE_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000480 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_spec_load_issue_trace_log
dhrystone_2_1_fast_pht_proc1_spec_load_issue_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_spec_load_issue_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 speculative-load issue trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against baseline: measured_cycles=3910, DMIPS/MHz=0.582253"; \
	echo "This lets LOAD issue with same-cycle wakeup under active branch speculation; stores/non-loads remain conservative."; \
	echo "Useful if PASS, measured_cycles < 3910, and 4A4 not_ready spec_active drops below 71."; \
	echo "If FAIL/timeout: speculative LOAD issue is unsafe with current LQ rollback and must be reverted."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_RS_LOAD_BASE_WAKEUP_SELECT -DFAST_RS_SPEC_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000480 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

.PHONY: dhrystone_2_1_fast_pht_proc1_lane2_refill_spec_load_trace_log
dhrystone_2_1_fast_pht_proc1_lane2_refill_spec_load_trace_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_lane2_refill_spec_load_trace_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 lane2 older drain/refill + speculative-load trace log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1, x30=31"; \
	echo "Compare against current best: measured_cycles=3868, DMIPS/MHz=0.588575"; \
	echo "This targets lane2_older/l2_buf root stalls without enabling nested branch/JAL speculation."; \
	echo "Useful if PASS, measured_cycles < 3868, and l1 lane2_older or l2 buf root drops."; \
	echo "If FAIL/timeout/slower: lane2 refill is not safe/profitable with current speculative path; keep spec_load_issue target."; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_RS_LOAD_BASE_WAKEUP_SELECT -DFAST_RS_SPEC_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_SPEC_PREFETCH_DURING_CKPT_BARRIER -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY -DFAST_LANE2_OLDER_DRAIN_REFILL_SAFE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=00000480 +DEBUG_PC_HI=000004c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_no_ckpt_barrier_log:
	@mkdir -p logs
	@echo "REJECTED: FAST_SPEC_NO_CHECKPOINT_BARRIER is functionally PASS but much slower."
	@echo "Observed: measured_cycles=5922, DMIPS/MHz=0.384432 versus stable 3956 / 0.575482."
	@echo "Root cause profile: fetch_stall/decode_hold/ROB-head-wait and early-taken flushes all rise sharply."
	@echo "Keep checkpoint barrier enabled; do not use this target as an optimization path."
	@exit 1

dhrystone_2_1_fast_pht_proc1_allow_rename_on_save_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_pht_proc1_allow_rename_on_save_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving PHT Proc_1 + allow rename on checkpoint-save log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Compare against branch-load-wakeup baseline: measured_cycles=4056, DMIPS/MHz=0.561294"; \
	echo "Expected profile if useful: dec_l*_spec_save decreases without increasing rob_head_wait/load_lq_mem_wait"; \
	echo "If FAIL/timeout/slower: keep checkpoint-save rename block as stable"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_BRANCH_LOAD_WAKEUP_SELECT -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_PHT_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT -DFAST_BRANCH_DIRECT_COMPLETE -DFAST_STORE_DIRECT_COMPLETE -DFAST_RS_SPEC_OLDER_ISSUE2 -DFAST_SPEC_NO_RESOLVE_INHIBIT -DFAST_SPEC_ALLOW_RENAME_ON_SAVE -DFAST_RU_JAL_REDIRECT -DFAST_FETCH_BTB -DFAST_FETCH_BTB_NO_PENDING_ON_HIT -DFAST_FETCH_BTB_SPEC_DISPATCH -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE +DEBUG_VERBOSE +DEBUG_PC_LO=000000b0 +DEBUG_PC_HI=00000620" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_pht_proc1_rs_branch_direct_log:
	@mkdir -p logs
	@echo "REJECTED: FAST_RS_BRANCH_DIRECT_COMPLETE is not safe with the current ROB/LQ/spec timing."
	@echo "Observed log: cycles=60000 commits=1781 x29=0 x30=14, so Dhrystone did not finish."
	@echo "It did reduce branch wait, but rob_head_wait_load rose to 58614 and the core stalled."
	@echo "Keep branch completion at EXM until the ROB/LQ restore timing is fixed with waveform evidence."
	@exit 1

dhrystone_2_1_fast_all_branch_spec_load_direct_profile:
	@echo "=========================================="
	@echo "Experimental all-branch spec + direct load completion on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Perf target: improve over load-direct forward-spec DMIPS/MHz 0.532664"
	@echo "Expected profile: branch_pending_rs_wait < 966 without increasing rob_head_wait_load above 1406"
	@echo "If slower: backward speculation cost still outweighs saved branch-pending cycles"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_all_branch_spec_load_direct: dhrystone_2_1_fast_all_branch_spec_load_direct_log

dhrystone_2_1_fast_all_branch_spec_load_direct_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_all_branch_spec_load_direct_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving bounded all-branch-spec load-direct log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected profile: DMIPS/MHz > 0.532664, branch_pending_rs_wait < 966"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1_fast_all_branch_spec_load_direct_profile 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_all_branch_spec_load_direct_quick: dhrystone_2_1_fast_all_branch_spec_load_direct_quick_log

dhrystone_2_1_fast_all_branch_spec_load_direct_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_all_branch_spec_load_direct_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick all-branch-spec load-direct profile log to $$log"; \
	echo "PASS expected if complete: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected quick profile: measured_cycles below 1009"; \
	echo "If timeout/fail: combo speculation is unsafe; keep forward-spec load-direct baseline"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=8000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC -DFAST_ENABLE_FORWARD_BRANCH_SPEC -DFAST_SPEC_BACKWARD_BRANCHES -DFAST_SPEC_LOAD_CPL_DIRECT" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS +PRINT_PROFILE" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_single_branch_spec_lq_debug:
	@echo "=========================================="
	@echo "Dhrystone BTFNT frontend LQ/ROB debug on src copy"
	@echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"
	@echo "Backend checkpoint speculation is gated off unless FAST_ENABLE_FORWARD_BRANCH_SPEC is added"
	@echo "If it stalls, inspect BEEBS_HEAD_DEBUG, redirect events, and LQ/SQ progress"
	@echo "=========================================="
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE +SPEC_LQ_DEBUG +BEEBS_DEBUG_HEAD"

dhrystone_2_1_fast_single_branch_spec_lq_debug_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_single_branch_spec_lq_debug_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving log to $$log"; \
	bash -o pipefail -c 'timeout 180s $(MAKE) -f Makefile dhrystone_2_1_fast_single_branch_spec_lq_debug 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_single_branch_spec_lq_debug_quick_log:
	@mkdir -p logs
	@log="logs/dhrystone_2_1_fast_single_branch_spec_lq_debug_quick_$$(date +%Y%m%d_%H%M%S).log"; \
	echo "Saving quick bounded log to $$log"; \
	echo "PASS expected: BEEBS RESULT: PASS x28=0, x29=1"; \
	echo "Expected debug: spec_save_count should stay 0 unless FAST_ENABLE_FORWARD_BRANCH_SPEC is enabled"; \
	echo "Timeout expected output: command exits 124 and log tail shows last active PC/state"; \
	bash -o pipefail -c 'timeout 90s $(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=1 DHRYSTONE_MAX_CYCLES=12000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_SINGLE_BRANCH_SPEC" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE +SPEC_LQ_DEBUG +BEEBS_DEBUG_HEAD +DEBUG_PC_LO=00000390 +DEBUG_PC_HI=000003c0" 2>&1 | tee "$$1"' bash "$$log"; \
	status=$$?; \
	echo "Saved log: $$log"; \
	exit $$status

dhrystone_2_1_fast_lq_ooo_head_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_EXEC_LOAD_COMPLETE_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_MEM_WAKEUP_BYPASS -DFAST_BRANCH_EXEC_REDIRECT -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE -DFAST_ROB_CPL_COMMIT_BYPASS -DFAST_ROB_LOAD_CPL_COMMIT_BYPASS -DFAST_LQ_CPL_COMMIT_BYPASS -DFAST_ROB_STORE_CPL_COMMIT_BYPASS -DFAST_SQ_FILL_COMMIT_BYPASS -DFAST_PIPE_CPL_BYPASS -DFAST_SQ_QUERY_BYPASS -DFAST_DIV_COMB -DFAST_BRANCH_PREFETCH_HOLD -DFAST_BTFNT_TARGET_PREFETCH -DFAST_RS_BRANCH_WAKEUP_SELECT_BYPASS -DFAST_LQ_OOO_COMPLETE_SCAN -DFAST_RS_HEAD_PRIORITY" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_nt_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_BRANCH_NT_DECODE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_fast_branch_taken_profile:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_RUNS=4 DHRYSTONE_MAX_CYCLES=60000 DHRYSTONE_RTL_DEFINES="$(DHRYSTONE_RTL_DEFINES) -DFAST_LSU_BYPASS -DFAST_ISSUE_BYPASS -DFAST_LOAD_CPL_BYPASS -DFAST_BRANCH_NT_DECODE -DFAST_BRANCH_TAKEN_DECODE" DHRYSTONE_EXTRA_PLUSARGS="+PRINT_PROFILE"

dhrystone_2_1_markers:
	$(MAKE) -f Makefile dhrystone_2_1 DHRYSTONE_MAX_CYCLES=12000 DHRYSTONE_EXTRA_PLUSARGS="+PRINT_MARKERS"

beebs_crc32:
	@echo "=========================================="
	@echo "Running BEEBS benchmark on SuperScalar: crc32"
	@echo "=========================================="
	@mkdir -p $(BEEBS_BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -O2 -ffreestanding -fno-builtin -fno-common \
		$(BEEBS_BASE_CFLAGS) \
		-ffixed-x28 -ffixed-x29 -ffixed-x30 -ffixed-x31 \
		-DBEEBS_CRC_ITERS=$(BEEBS_CRC_ITERS) $(BEEBS_EXTRA_CFLAGS) \
		-nostdlib -nostartfiles -Wl,--no-relax -T $(BEEBS_PORT_DIR)/linker.ld \
		-I $(BEEBS_PORT_DIR)/include \
		-I $(BEEBS_DIR)/support \
		$(BEEBS_PORT_DIR)/start.S \
		$(BEEBS_PORT_DIR)/beebs_crc32_standalone.c \
		-o $(BEEBS_BUILDDIR)/crc32.elf
	$(RISCV_OBJCOPY) -O binary $(BEEBS_BUILDDIR)/crc32.elf $(BEEBS_BUILDDIR)/crc32.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BEEBS_BUILDDIR)/crc32.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BEEBS_BUILDDIR)/crc32.bin $(SRC_DIR)/data.hex $(BEEBS_BUILDDIR)/crc32_data_info.vh
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -DBEEBS_DATA_INIT -I $(SRC_DIR) -o $(BEEBS_OUT) $(TB)
	$(VVP) $(BEEBS_OUT) +RAW_RESULT +IGNORE_SCOREBOARD +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=$(BEEBS_MAX_CYCLES) $(BEEBS_EXTRA_PLUSARGS)

beebs_crc32_smoke:
	$(MAKE) -f Makefile beebs_crc32 BEEBS_CRC_ITERS=16 BEEBS_EXTRA_CFLAGS=-DBEEBS_SKIP_CHECK BEEBS_MAX_CYCLES=5000

beebs_crc32_check16:
	$(MAKE) -f Makefile beebs_crc32 BEEBS_CRC_ITERS=16 BEEBS_EXTRA_CFLAGS="-DBEEBS_CRC_EXPECT=3523407757UL" BEEBS_MAX_CYCLES=20000

beebs_%:
	@echo "=========================================="
	@echo "Running BEEBS subset benchmark on SuperScalar: $*"
	@echo "=========================================="
	@mkdir -p $(BEEBS_BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -O2 -ffreestanding -fno-builtin -fno-common \
		$(BEEBS_BASE_CFLAGS) \
		-ffixed-x28 -ffixed-x29 -ffixed-x30 -ffixed-x31 \
		$(BEEBS_EXTRA_CFLAGS) \
		-nostdlib -nostartfiles -Wl,--no-relax -T $(BEEBS_PORT_DIR)/linker.ld \
		-I $(BEEBS_PORT_DIR)/include \
		-I $(BEEBS_DIR)/support \
		$(BEEBS_PORT_DIR)/start.S \
		$(BEEBS_PORT_DIR)/beebs_$*_standalone.c \
		-o $(BEEBS_BUILDDIR)/$*.elf
	$(RISCV_OBJCOPY) -O binary $(BEEBS_BUILDDIR)/$*.elf $(BEEBS_BUILDDIR)/$*.bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BEEBS_BUILDDIR)/$*.bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BEEBS_BUILDDIR)/$*.bin $(SRC_DIR)/data.hex $(BEEBS_BUILDDIR)/$*_data_info.vh
	$(IVERILOG) -g2012 $(BEEBS_RTL_DEFINES) -DBEEBS_DATA_INIT -I $(SRC_DIR) -o $(BEEBS_OUT) $(TB)
	$(VVP) $(BEEBS_OUT) +RAW_RESULT +IGNORE_SCOREBOARD +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=$(BEEBS_MAX_CYCLES) $(BEEBS_EXTRA_PLUSARGS)

beebs_subset_report: beebs_alu beebs_alu_parallel beebs_mem beebs_mix beebs_mix_parallel beebs_load_chain
	@echo "=========================================="
	@echo "BEEBS lightweight subset completed"
	@echo "=========================================="

beebs_subset_summary:
	@echo "=========================================="
	@echo "BEEBS-compatible subset benchmark summary"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	printf "%-18s | %8s | %8s | %6s | %-6s | %s\n" "Benchmark" "Commits" "Cycles" "IPC" "Result" "x28"; \
	printf "%-18s-+-%8s-+-%8s-+-%6s-+-%-6s-+-%s\n" "------------------" "--------" "--------" "------" "------" "----------"; \
	for b in $(BEEBS_SUBSET); do \
		printf "Running %-12s ... " "$$b" >&2; \
		out=`$(MAKE) --no-print-directory beebs_$$b 2>&1`; status=$$?; \
		echo "$$out" > "$(SIMDIR)/beebs_report_$$b.log"; \
		commits=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
		cycles=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
		bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
		result=`printf "%s\n" "$$out" | sed -n 's/.*BEEBS RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
		x28=`printf "%s\n" "$$out" | sed -n 's/.*RESULT REGS: x28=\([0-9][0-9]*\).*/\1/p' | tail -n 1`; \
		if [ -z "$$x28" ]; then x28="-"; fi; \
		if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
			printf "FAIL/UNKNOWN, see $(SIMDIR)/beebs_report_$$b.log\n" >&2; \
			printf "%-18s | %8s | %8s | %6s | %-6s | %s\n" "$$b" "$${commits:--}" "$${cycles:--}" "$${bench_ipc:--}" "FAIL" "$$x28"; \
			total_fail=`expr $$total_fail + 1`; \
		else \
			printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
			printf "%-18s | %8s | %8s | %6s | %-6s | %s\n" "$$b" "$$commits" "$$cycles" "$$bench_ipc" "PASS" "$$x28"; \
			total_commits=`expr $$total_commits + $$commits`; \
			total_cycles=`expr $$total_cycles + $$cycles`; \
		fi; \
		total_bench=`expr $$total_bench + 1`; \
	done; \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%8s-+-%8s-+-%6s-+-%-6s-+-%s\n" "------------------" "--------" "--------" "------" "------" "----------"; \
	printf "%-18s | %8d | %8d | %6s | %-6s | %s\n" "TOTAL" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)" "-"; \
	echo "Logs: $(SIMDIR)/beebs_report_<benchmark>.log"

compile_alu:
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)' | Out-Null"
	$(IVERILOG) -g2005 -I $(SRC_DIR) -o $(ALU_OUT) $(TB_ALU)

run_alu: compile_alu
	$(VVP) $(ALU_OUT)

wave_alu: run_alu
	$(GTKWAVE) $(ALU_VCD)

src2_compile:
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
	$(SRC2_DIR)/instr.hex $(SRC2_DIR)/program_info.vh
	$(IVERILOG) -g2012 -DUSE_SRC2 -I $(SRC2_DIR) -o $(SRC2_OUT) $(TB)

src2_run: src2_compile
	$(VVP) $(SRC2_OUT)

src2_run_raw: src2_compile
	$(VVP) $(SRC2_OUT) +RAW_RESULT

src2_run_print: src2_compile
	$(VVP) $(SRC2_OUT) +PRINT_COMMITS

src2_run_raw_print: src2_compile
	$(VVP) $(SRC2_OUT) +RAW_RESULT +PRINT_COMMITS

src2_raw_run_print: src2_run_raw_print

1cycle_compile:
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
	$(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -DUSE_1CYCLE -I $(SRC_DIR) -o $(ONECYCLE_OUT) $(TB)

1cycle_run: 1cycle_compile
	$(VVP) $(ONECYCLE_OUT)

# Open waveform after running simulation
view: run
	$(GTKWAVE) $(VCD)

clean:
	$(POWERSHELL) -NoProfile -Command "Remove-Item -Recurse -Force '$(SIMDIR)','$(BUILDDIR)' -ErrorAction SilentlyContinue"

clean_logs:
	rm -rf logs/*

.PHONY: branch_spec_controller_depth2_smoke
branch_spec_controller_depth2_smoke:
	@echo "=========================================="
	@echo "Running branch speculation controller depth-2 smoke"
	@echo "PASS expected: nested correct keeps older checkpoint; older mispredict clears younger"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	$(IVERILOG) -g2012 -DFAST_BRANCH_SPEC_DEPTH2 -I "src copy" -o $(SIMDIR)/branch_spec_controller_depth2_smoke.vvp test/tb_branch_spec_controller.v
	$(VVP) $(SIMDIR)/branch_spec_controller_depth2_smoke.vvp

rebuild: clean compile

build_bench_elfs:
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(BUILDDIR)' | Out-Null"
	@for b in $(BENCHMARKS); do \
		echo "Building $$b.elf"; \
		$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
			$(RISCV_TESTS)/$$b.S -o $(BUILDDIR)/$$b.elf || exit 1; \
	done

check_jumps: build_bench_elfs
	@echo "=========================================="
	@echo "Checking generated ELF files for j/jal"
	@echo "=========================================="
	@found=0; \
	for f in $(BUILDDIR)/*.elf; do \
		if [ ! -f "$$f" ]; then continue; fi; \
		hits=`riscv64-unknown-elf-objdump -d "$$f" | grep -E '[[:space:]](j|jal)[[:space:]]' || true`; \
		if [ -n "$$hits" ]; then \
			found=1; \
			echo "---- $$f ----"; \
			echo "$$hits"; \
		fi; \
	done; \
	if [ "$$found" -eq 0 ]; then echo "No j/jal generated in existing build/*.elf"; fi

define RUN_BENCH
$(1):
	@echo "=========================================="
	@echo "Running RV32IM clean benchmark: $(1)"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		$(RISCV_TESTS)/$(1).S -o $(BUILDDIR)/$(1).elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/$(1).elf $(BUILDDIR)/$(1).bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/$(1).bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -I $(SRC_DIR) -o $(OUT) $(TB)
	$(VVP) $(OUT)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(VCD)') { Copy-Item '$(VCD)' '$(SIMDIR)/datapath_$(1).vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/datapath_$(1).vcd"
endef

$(foreach b,$(BENCHMARKS) $(DEBUG_BENCHMARKS),$(eval $(call RUN_BENCH,$(b))))

define RUN_1CYCLE_BENCH
1cycle_$(1):
	@echo "=========================================="
	@echo "Running RV32IM clean benchmark on 1-cycle execute: $(1)"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		$(RISCV_TESTS)/$(1).S -o $(BUILDDIR)/1cycle_$(1).elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/1cycle_$(1).elf $(BUILDDIR)/1cycle_$(1).bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/1cycle_$(1).bin $(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -DUSE_1CYCLE -I $(SRC_DIR) -o $(ONECYCLE_OUT) $(TB)
	$(VVP) $(ONECYCLE_OUT)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(VCD)') { Copy-Item '$(VCD)' '$(SIMDIR)/datapath_1cycle_$(1).vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/datapath_1cycle_$(1).vcd"
endef

$(foreach b,$(BENCHMARKS),$(eval $(call RUN_1CYCLE_BENCH,$(b))))

define RUN_SRC2_BENCH
src2_$(1):
	@echo "=========================================="
	@echo "Running RV32IM clean benchmark on src_2: $(1)"
	@echo "=========================================="
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		$(RISCV_TESTS)/$(1).S -o $(BUILDDIR)/src2_$(1).elf
	$(RISCV_OBJCOPY) -O binary $(BUILDDIR)/src2_$(1).elf $(BUILDDIR)/src2_$(1).bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(BUILDDIR)/src2_$(1).bin $(SRC2_DIR)/instr.hex $(SRC2_DIR)/program_info.vh
	$(IVERILOG) -g2012 -DUSE_SRC2 -I $(SRC2_DIR) -o $(SRC2_OUT) $(TB)
	$(VVP) $(SRC2_OUT)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(VCD)') { Copy-Item '$(VCD)' '$(SIMDIR)/src2_datapath_$(1).vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/src2_datapath_$(1).vcd"
endef

$(foreach b,$(BENCHMARKS),$(eval $(call RUN_SRC2_BENCH,$(b))))

define RUN_BIRISCV_BENCH
biriscv_$(1):
	@echo "=========================================="
	@echo "Running RV32IM clean benchmark on biRISC-V: $(1)"
	@echo "=========================================="
	@mkdir -p $(BIRISCV_BUILDDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x80000000 \
		$(RISCV_TESTS)/$(1).S -o $(BIRISCV_BUILDDIR)/$(1).elf
	$(MAKE) -C $(BIRISCV_TB) ELF_FILE=../../../$(BIRISCV_BUILDDIR)/$(1).elf OBJCOPY=$(BIRISCV_OBJCOPY)
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)' | Out-Null; if (Test-Path '$(BIRISCV_TB)/waveform.vcd') { Copy-Item '$(BIRISCV_TB)/waveform.vcd' '$(SIMDIR)/biriscv_$(1).vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/biriscv_$(1).vcd"
endef

$(foreach b,$(BENCHMARKS),$(eval $(call RUN_BIRISCV_BENCH,$(b))))

define RUN_RSD_BENCH
rsd_$(1):
	@echo "=========================================="
	@echo "Running RV32IM clean benchmark on RSD: $(1)"
	@echo "=========================================="
	@rm -rf $(RSD_PROCESSOR_LINK)
	@mkdir -p $(RSD_PROCESSOR_LINK)
	@cp -a "$(RSD_REAL_PROCESSOR)/." $(RSD_PROCESSOR_LINK)/
	@mkdir -p $(RSD_BUILDDIR)/$(1)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x1000 \
		$(RISCV_TESTS)/$(1).S -o $(RSD_BUILDDIR)/$(1)/$(1).elf
	$(RISCV_OBJCOPY) -O binary --strip-all --strip-debug \
		--only-section .text* --only-section .rodata* --only-section .srodata* \
		--set-start=0x1000 --pad-to=0x10000 \
		$(RSD_BUILDDIR)/$(1)/$(1).elf $(RSD_BUILDDIR)/$(1)/$(1).rom.bin
	head -c 4096 /dev/zero > $(RSD_BUILDDIR)/$(1)/dummy_rom.bin
	cat $(RSD_BUILDDIR)/$(1)/dummy_rom.bin $(RSD_BUILDDIR)/$(1)/$(1).rom.bin > $(RSD_BUILDDIR)/$(1)/code.bin
	python3 $(RSD_HEX_TOOL) $(RSD_BUILDDIR)/$(1)/code.bin $(RSD_BUILDDIR)/$(1)/code.hex 0x10000
	$(MAKE) -C $(RSD_SRC) -f Makefile.verilator.mk all RSD_VERILATOR_BIN=$(RSD_VERILATOR_BIN)
	$(MAKE) -C $(RSD_SRC) -f Makefile.verilator.mk run \
		RSD_VERILATOR_BIN=$(RSD_VERILATOR_BIN) \
		TEST_CODE=$(RSD_BUILDDIR)/$(1) \
		MAX_TEST_CYCLES=$(RSD_MAX_TEST_CYCLES) \
		ENABLE_PC_GOAL=0 SHOW_SERIAL_OUT=0 ENABLE_RV32IM_SCOREBOARD=1
	@mkdir -p $(SIMDIR)
	@if [ -f "$(RSD_SRC)/RSD.log" ]; then cp "$(RSD_SRC)/RSD.log" "$(SIMDIR)/rsd_$(1).log"; fi
	@if [ -f "$(RSD_SRC)/Kanata.log" ]; then cp "$(RSD_SRC)/Kanata.log" "$(SIMDIR)/rsd_$(1)_Kanata.log"; fi
endef

$(foreach b,$(BENCHMARKS),$(eval $(call RUN_RSD_BENCH,$(b))))

define RUN_BOOM_BENCH
boom_$(1):
	@echo "=========================================="
	@echo "Preparing BOOM-compatible benchmark: $(1)"
	@echo "=========================================="
	@mkdir -p $(BOOM_BUILDDIR) $(BOOM_ASMDIR)
	@if [ "$(BOOM_USE_RISCV_TESTS_RUNTIME)" = "1" ]; then \
		python3 tools/generate_boom_bench.py $(1) $(BOOM_ASMDIR)/$(1).S --iters $(BOOM_BENCH_ITERS) --runtime; \
		$(RISCV_GCC) -march=$(BOOM_GCC_MARCH) -mabi=$(BOOM_GCC_MABI) $(BOOM_GCC_FLAGS) -nostdlib -nostartfiles -T $(BOOM_LINKER) \
			$(BOOM_RUNTIME_SRCS) $(BOOM_ASMDIR)/$(1).S -o $(BOOM_BUILDDIR)/$(1).elf $(BOOM_LINK_LIBS); \
	else \
		python3 tools/generate_boom_bench.py $(1) $(BOOM_ASMDIR)/$(1).S --iters $(BOOM_BENCH_ITERS); \
		$(RISCV_GCC) -march=$(BOOM_GCC_MARCH) -mabi=$(BOOM_GCC_MABI) $(BOOM_GCC_FLAGS) -nostdlib -nostartfiles -T $(BOOM_LINKER) \
			$(BOOM_ASMDIR)/$(1).S -o $(BOOM_BUILDDIR)/$(1).elf $(BOOM_LINK_LIBS); \
	fi
	@mkdir -p $(BOOM_STAGEDIR)
	@cp $(BOOM_BUILDDIR)/$(1).elf $(BOOM_STAGEDIR)/$(1).elf
	@if [ -z "$(CHIPYARD_DIR)" ]; then \
		echo "BOOM repo at $(BOOM_DIR) is not self-running."; \
		echo "Generated ELF: $(BOOM_BUILDDIR)/$(1).elf"; \
		echo "To run it, install/use Chipyard and call:"; \
		echo "  make boom_$(1) CHIPYARD_DIR=/path/to/chipyard BOOM_CHIPYARD_CONFIG=$(BOOM_CHIPYARD_CONFIG)"; \
		exit 2; \
	fi
	$(MAKE) -C "$(CHIPYARD_DIR)/sims/verilator" CONFIG=$(BOOM_CHIPYARD_CONFIG) BINARY=$(BOOM_STAGEDIR)/$(1).elf $(BOOM_EXTRA_RUN_ARGS) run-binary-fast
	@mkdir -p $(SIMDIR)
	@if [ -f "$(CHIPYARD_DIR)/sims/verilator/output/$(1).log" ]; then cp "$(CHIPYARD_DIR)/sims/verilator/output/$(1).log" "$(SIMDIR)/boom_$(1).log"; fi
endef

$(foreach b,$(BENCHMARKS),$(eval $(call RUN_BOOM_BENCH,$(b))))

define RUN_MIPS_BENCH
mips_$(1):
	@echo "=========================================="
	@echo "Running RV32I clean benchmark on MIPS_SUPERSCALAR: $(1)"
	@echo "=========================================="
	@mkdir -p $(MIPS_BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		$(MIPS_RISCV_TESTS)/$(1).S -o $(MIPS_BUILDDIR)/$(1).elf
	$(RISCV_OBJCOPY) -O binary $(MIPS_BUILDDIR)/$(1).elf $(MIPS_BUILDDIR)/$(1).bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(MIPS_BUILDDIR)/$(1).bin $(MIPS_BUILDDIR)/$(1).hex $(MIPS_BUILDDIR)/$(1)_program_info.vh
	@cp $(MIPS_BUILDDIR)/$(1).hex $(MIPS_DIR)/source/imem.txt
	@cp $(MIPS_BUILDDIR)/$(1)_program_info.vh $(MIPS_DIR)/source/program_info.vh
	@program_instrs=`awk 'END { print NR }' $(MIPS_BUILDDIR)/$(1).hex`; \
	cd $(MIPS_DIR) && $(IVERILOG) -g2005 -I source -o $(MIPS_OUT) $(MIPS_TB) && \
	$(VVP) $(MIPS_OUT) +MIPS_IMEM_WORDS=$${program_instrs} +MIPS_PROGRAM_INSTRS=$${program_instrs} +MIPS_MAX_CYCLES=$(MIPS_MAX_CYCLES) +MIPS_DRAIN_CYCLES=$(MIPS_DRAIN_CYCLES) $(MIPS_EXTRA_PLUSARGS)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(MIPS_DIR)/waveform/mips_benchmark.vcd') { Copy-Item '$(MIPS_DIR)/waveform/mips_benchmark.vcd' '$(SIMDIR)/mips_$(1).vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/mips_$(1).vcd"
endef

$(foreach b,$(MIPS_SUPPORTED_BENCHMARKS),$(eval $(call RUN_MIPS_BENCH,$(b))))

define RUN_MIPS_FRIENDLY_BENCH
mipsf_$(1):
	@echo "=========================================="
	@echo "Running RV32I friendly benchmark on MIPS_SUPERSCALAR: $(1)"
	@echo "=========================================="
	@mkdir -p $(MIPS_BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x0 \
		$(MIPS_FRIENDLY_RISCV_TESTS)/$(1).S -o $(MIPS_BUILDDIR)/friendly_$(1).elf
	$(RISCV_OBJCOPY) -O binary $(MIPS_BUILDDIR)/friendly_$(1).elf $(MIPS_BUILDDIR)/friendly_$(1).bin
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/bin_to_word_hex.ps1 \
		$(MIPS_BUILDDIR)/friendly_$(1).bin $(MIPS_BUILDDIR)/friendly_$(1).hex $(MIPS_BUILDDIR)/friendly_$(1)_program_info.vh
	@cp $(MIPS_BUILDDIR)/friendly_$(1).hex $(MIPS_DIR)/source/imem.txt
	@cp $(MIPS_BUILDDIR)/friendly_$(1)_program_info.vh $(MIPS_DIR)/source/program_info.vh
	@program_instrs=`awk 'END { print NR }' $(MIPS_BUILDDIR)/friendly_$(1).hex`; \
	cd $(MIPS_DIR) && $(IVERILOG) -g2005 -I source -o $(MIPS_OUT) $(MIPS_TB) && \
	$(VVP) $(MIPS_OUT) +MIPS_IMEM_WORDS=$${program_instrs} +MIPS_PROGRAM_INSTRS=$${program_instrs} +MIPS_MAX_CYCLES=$(MIPS_MAX_CYCLES) +MIPS_DRAIN_CYCLES=$(MIPS_DRAIN_CYCLES) $(MIPS_EXTRA_PLUSARGS)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(MIPS_DIR)/waveform/mips_benchmark.vcd') { Copy-Item '$(MIPS_DIR)/waveform/mips_benchmark.vcd' '$(SIMDIR)/mipsf_$(1).vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/mipsf_$(1).vcd"
endef

$(foreach b,$(MIPS_SUPPORTED_BENCHMARKS),$(eval $(call RUN_MIPS_FRIENDLY_BENCH,$(b))))

allim: $(BENCHMARKS)

biriscv_allim: $(BIRISCV_BENCHMARKS)

boom_allim: $(BOOM_BENCHMARKS)

biriscv_make_allim: biriscv_allim

make_allim_biriscv: biriscv_allim

mips_alli: $(MIPS_BENCHMARKS)

mips_friendly_alli: $(MIPS_FRIENDLY_BENCHMARKS)

mips_allim: mips_alli

mips_make_alli: mips_alli

mips_make_allim: mips_alli

make_alli_mips: mips_alli

make_allim_mips: mips_alli

mips_info:
	@echo "=========================================="
	@echo "MIPS_SUPERSCALAR benchmark integration"
	@echo "=========================================="
	@echo "Local source: $(MIPS_DIR)"
	@echo "Current RTL decodes a RISC-V-like RV32I subset, despite the folder name."
	@echo "Benchmark source: $(MIPS_RISCV_TESTS)"
	@echo "Enabled benchmark groups: RV32I R-type, RV32I I/shift, lw/sw."
	@echo "RV32M and byte/halfword load-store are not enabled because this RTL does not implement them."
	@echo "Run one benchmark:"
	@echo "  make mips_addi"
	@echo "Run supported report:"
	@echo "  make mips_report_i"
	@echo "Run IPC-friendly report for the in-order source:"
	@echo "  make mips_friendly_report_i"
	@echo "Notes: $(MIPS_DIR)/BENCHMARK_SETUP.md"

mips_run_hex:
	@echo "=========================================="
	@echo "Running current $(MIPS_DIR)/source/imem.txt on MIPS_SUPERSCALAR"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
		$(MIPS_DIR)/source/imem.txt $(MIPS_DIR)/source/program_info.vh
	program_info=`python3 tools/count_rv32_regwrite.py $(MIPS_DIR)/source/imem.txt`; \
	program_instrs=`echo $$program_info | awk '{print $$1}'`; \
	expected_commits=`echo $$program_info | awk '{print $$2}'`; \
	cd $(MIPS_DIR) && $(IVERILOG) -g2005 -I source -o $(MIPS_OUT) $(MIPS_TB) && \
	$(VVP) $(MIPS_OUT) +RAW_RESULT +MIPS_IMEM_WORDS=$${program_instrs} +MIPS_PROGRAM_INSTRS=$${program_instrs} +MIPS_EXPECTED_COMMITS=$${expected_commits} +MIPS_MAX_CYCLES=$(MIPS_MAX_CYCLES) +MIPS_DRAIN_CYCLES=$(MIPS_DRAIN_CYCLES) $(MIPS_EXTRA_PLUSARGS)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(MIPS_DIR)/waveform/mips_benchmark.vcd') { Copy-Item '$(MIPS_DIR)/waveform/mips_benchmark.vcd' '$(SIMDIR)/mips_raw.vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/mips_raw.vcd"

mips_run_raw: mips_run_hex

mips_run_print:
	@echo "=========================================="
	@echo "Running current $(MIPS_DIR)/source/imem.txt on MIPS_SUPERSCALAR with commits"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
		$(MIPS_DIR)/source/imem.txt $(MIPS_DIR)/source/program_info.vh
	program_info=`python3 tools/count_rv32_regwrite.py $(MIPS_DIR)/source/imem.txt`; \
	program_instrs=`echo $$program_info | awk '{print $$1}'`; \
	expected_commits=`echo $$program_info | awk '{print $$2}'`; \
	cd $(MIPS_DIR) && $(IVERILOG) -g2005 -I source -o $(MIPS_OUT) $(MIPS_TB) && \
	$(VVP) $(MIPS_OUT) +PRINT_COMMITS +MIPS_IMEM_WORDS=$${program_instrs} +MIPS_PROGRAM_INSTRS=$${program_instrs} +MIPS_EXPECTED_COMMITS=$${expected_commits} +MIPS_MAX_CYCLES=$(MIPS_MAX_CYCLES) +MIPS_DRAIN_CYCLES=$(MIPS_DRAIN_CYCLES) $(MIPS_EXTRA_PLUSARGS)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(MIPS_DIR)/waveform/mips_benchmark.vcd') { Copy-Item '$(MIPS_DIR)/waveform/mips_benchmark.vcd' '$(SIMDIR)/mips_print.vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/mips_print.vcd"

mips_run_raw_print:
	@echo "=========================================="
	@echo "Running current $(MIPS_DIR)/source/imem.txt on MIPS_SUPERSCALAR with raw result and commits"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
		$(MIPS_DIR)/source/imem.txt $(MIPS_DIR)/source/program_info.vh
	program_info=`python3 tools/count_rv32_regwrite.py $(MIPS_DIR)/source/imem.txt`; \
	program_instrs=`echo $$program_info | awk '{print $$1}'`; \
	expected_commits=`echo $$program_info | awk '{print $$2}'`; \
	cd $(MIPS_DIR) && $(IVERILOG) -g2005 -I source -o $(MIPS_OUT) $(MIPS_TB) && \
	$(VVP) $(MIPS_OUT) +RAW_RESULT +PRINT_COMMITS +MIPS_IMEM_WORDS=$${program_instrs} +MIPS_PROGRAM_INSTRS=$${program_instrs} +MIPS_EXPECTED_COMMITS=$${expected_commits} +MIPS_MAX_CYCLES=$(MIPS_MAX_CYCLES) +MIPS_DRAIN_CYCLES=$(MIPS_DRAIN_CYCLES) $(MIPS_EXTRA_PLUSARGS)
	@$(POWERSHELL) -NoProfile -Command "if (Test-Path '$(MIPS_DIR)/waveform/mips_benchmark.vcd') { Copy-Item '$(MIPS_DIR)/waveform/mips_benchmark.vcd' '$(SIMDIR)/mips_raw_print.vcd' -Force }"
	@echo "Waveform: $(SIMDIR)/mips_raw_print.vcd"

boom_info:
	@echo "=========================================="
	@echo "BOOM benchmark integration"
	@echo "=========================================="
	@echo "Local BOOM source: $(BOOM_DIR)"
	@echo "BOOM README says this repo is not self-running."
	@echo "Use Chipyard simulator to run generated ELFs."
	@echo "Note: BOOM is normally RV64; this reuses the same .S source but is not strict RV32 unless Chipyard config is RV32."
	@echo "Note: x31/x30 scoreboard reporting needs a Chipyard-side commit/register trace harness."
	@echo "Default benchmark ELF settings:"
	@echo "  BOOM_GCC_MARCH=$(BOOM_GCC_MARCH)"
	@echo "  BOOM_GCC_MABI=$(BOOM_GCC_MABI)"
	@echo "  BOOM_LINKER=$(BOOM_LINKER)"
	@echo "  BOOM_GCC_FLAGS=$(BOOM_GCC_FLAGS)"
	@echo "  BOOM_CHIPYARD_CONFIG=$(BOOM_CHIPYARD_CONFIG)"
	@echo "Example:"
	@echo "  make boom_addi CHIPYARD_DIR=/path/to/chipyard"
	@echo "More notes: $(BOOM_DIR)/RV32IM_CLEAN_BENCHMARK_SETUP.md"

boom_build_elfs:
	@mkdir -p $(BOOM_BUILDDIR) $(BOOM_ASMDIR)
	@for b in $(BENCHMARKS); do \
		echo "Building BOOM ELF $$b"; \
		if [ "$(BOOM_USE_RISCV_TESTS_RUNTIME)" = "1" ]; then \
			python3 tools/generate_boom_bench.py $$b $(BOOM_ASMDIR)/$$b.S --iters $(BOOM_BENCH_ITERS) --runtime || exit 1; \
			$(RISCV_GCC) -march=$(BOOM_GCC_MARCH) -mabi=$(BOOM_GCC_MABI) $(BOOM_GCC_FLAGS) -nostdlib -nostartfiles -T $(BOOM_LINKER) \
				$(BOOM_RUNTIME_SRCS) $(BOOM_ASMDIR)/$$b.S -o $(BOOM_BUILDDIR)/$$b.elf $(BOOM_LINK_LIBS) || exit 1; \
		else \
			python3 tools/generate_boom_bench.py $$b $(BOOM_ASMDIR)/$$b.S --iters $(BOOM_BENCH_ITERS) || exit 1; \
			$(RISCV_GCC) -march=$(BOOM_GCC_MARCH) -mabi=$(BOOM_GCC_MABI) $(BOOM_GCC_FLAGS) -nostdlib -nostartfiles -T $(BOOM_LINKER) \
				$(BOOM_ASMDIR)/$$b.S -o $(BOOM_BUILDDIR)/$$b.elf $(BOOM_LINK_LIBS) || exit 1; \
		fi; \
	done

boom_report_im:
	@echo "=========================================="
	@echo "BOOM RV32IM-clean benchmark summary"
	@echo "=========================================="
	@if [ -z "$(CHIPYARD_DIR)" ]; then \
		echo "Cannot run BOOM benchmarks directly from $(BOOM_DIR)."; \
		echo "This BOOM repo is a generator fragment and requires Chipyard."; \
		echo "First build ELFs only with: make boom_build_elfs"; \
		echo "Then run with: make boom_report_im CHIPYARD_DIR=/path/to/chipyard"; \
		exit 2; \
	fi
	@mkdir -p $(SIMDIR)
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory boom_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/boom_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			if [ -z "$$commits" ]; then commits=`printf "%s\n" "$$out" | sed -n 's/^minstret = \([0-9][0-9]*\).*/\1/p' | tail -n 1`; fi; \
			if [ -z "$$cycles" ]; then cycles=`printf "%s\n" "$$out" | sed -n 's/^mcycle = \([0-9][0-9]*\).*/\1/p' | tail -n 1`; fi; \
			bench_ipc=`awk -v c=$$commits -v y=$$cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ -z "$$result" ] && [ "$$status" -eq 0 ] && printf "%s\n" "$$out" | grep -q 'Verilog .*finish'; then result=PASS; fi; \
			if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "FAIL/UNKNOWN, see $(SIMDIR)/boom_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(LOAD_STORE_BENCHMARKS); \
	report_group "RV32M" $(RV32M_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/boom_report_<benchmark>.log"

biriscv_clean:
	$(MAKE) -C $(BIRISCV_TB) clean

rsd_build:
	@rm -rf $(RSD_PROCESSOR_LINK)
	@mkdir -p $(RSD_PROCESSOR_LINK)
	@cp -a "$(RSD_REAL_PROCESSOR)/." $(RSD_PROCESSOR_LINK)/
	$(MAKE) -C $(RSD_SRC) -f Makefile.verilator.mk all RSD_VERILATOR_BIN=$(RSD_VERILATOR_BIN)

rsd_run_hex:
	@echo "=========================================="
	@echo "Running current src/instr.hex on RSD"
	@echo "=========================================="
	@rm -rf $(RSD_PROCESSOR_LINK)
	@mkdir -p $(RSD_PROCESSOR_LINK)
	@cp -a "$(RSD_REAL_PROCESSOR)/." $(RSD_PROCESSOR_LINK)/
	@mkdir -p $(RSD_BUILDDIR)/instr_hex
	python3 tools/word_hex_to_bin.py $(SRC_DIR)/instr.hex $(RSD_BUILDDIR)/instr_hex/instr.bin
	head -c 4096 /dev/zero > $(RSD_BUILDDIR)/instr_hex/dummy_rom.bin
	cat $(RSD_BUILDDIR)/instr_hex/dummy_rom.bin $(RSD_BUILDDIR)/instr_hex/instr.bin > $(RSD_BUILDDIR)/instr_hex/code.bin
	python3 $(RSD_HEX_TOOL) $(RSD_BUILDDIR)/instr_hex/code.bin $(RSD_BUILDDIR)/instr_hex/code.hex 0x10000
	$(MAKE) -C $(RSD_SRC) -f Makefile.verilator.mk all RSD_VERILATOR_BIN=$(RSD_VERILATOR_BIN)
	$(MAKE) -C $(RSD_SRC) -f Makefile.verilator.mk run \
		RSD_VERILATOR_BIN=$(RSD_VERILATOR_BIN) \
		TEST_CODE=$(RSD_BUILDDIR)/instr_hex \
		MAX_TEST_CYCLES=$(RSD_MAX_TEST_CYCLES) \
		ENABLE_PC_GOAL=0 SHOW_SERIAL_OUT=0 ENABLE_RV32IM_SCOREBOARD=1
	@mkdir -p $(SIMDIR)
	@if [ -f "$(RSD_SRC)/RSD.log" ]; then cp "$(RSD_SRC)/RSD.log" "$(SIMDIR)/rsd_instr_hex.log"; fi
	@if [ -f "$(RSD_SRC)/Kanata.log" ]; then cp "$(RSD_SRC)/Kanata.log" "$(SIMDIR)/rsd_instr_hex_Kanata.log"; fi

rsd_allim: $(RSD_BENCHMARKS)

rsd_make_allim: rsd_allim

make_allim_rsd: rsd_allim

rsd_clean:
	$(MAKE) -C $(RSD_SRC) -f Makefile.verilator.mk clean RSD_VERILATOR_BIN=$(RSD_VERILATOR_BIN)

report_im:
	@echo "=========================================="
	@echo "RV32IM-clean benchmark summary"
	@echo "=========================================="
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory $$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "FAIL/UNKNOWN, see $(SIMDIR)/report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(LOAD_STORE_BENCHMARKS); \
	report_group "RV32M" $(RV32M_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/report_<benchmark>.log"

1cycle_report_im:
	@echo "=========================================="
	@echo "1-cycle execute RV32IM-clean benchmark summary"
	@echo "=========================================="
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory 1cycle_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/1cycle_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "FAIL/UNKNOWN, see $(SIMDIR)/1cycle_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(LOAD_STORE_BENCHMARKS); \
	report_group "RV32M" $(RV32M_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/1cycle_report_<benchmark>.log"

src2_report_im:
	@echo "=========================================="
	@echo "src_2 RV32IM-clean benchmark summary"
	@echo "=========================================="
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory src2_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/src2_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "FAIL/UNKNOWN, see $(SIMDIR)/src2_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(LOAD_STORE_BENCHMARKS); \
	report_group "RV32M" $(RV32M_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/src2_report_<benchmark>.log"

mips_report_i:
	@echo "=========================================="
	@echo "MIPS_SUPERSCALAR RV32I-clean benchmark summary"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory mips_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/mips_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ -n "$$commits" ] && [ -n "$$cycles" ]; then \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			if [ "$$status" -ne 0 ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "UNKNOWN, see $(SIMDIR)/mips_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			elif [ "$$result" != "PASS" ]; then \
				fail_id=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR RESULT: FAIL test_id=\([0-9][0-9]*\).*/\1/p' | tail -n 1`; \
				printf "FAIL test_id=%s commits=%s cycles=%s IPC=%s\n" "$$fail_id" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(MIPS_LOAD_STORE_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/mips_report_<benchmark>.log"

mips_report_im: mips_report_i

mips_friendly_report_i:
	@echo "=========================================="
	@echo "MIPS_SUPERSCALAR RV32I-friendly benchmark summary"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory mipsf_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/mips_friendly_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ -n "$$commits" ] && [ -n "$$cycles" ]; then \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			if [ "$$status" -ne 0 ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "UNKNOWN, see $(SIMDIR)/mips_friendly_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			elif [ "$$result" != "PASS" ]; then \
				fail_id=`printf "%s\n" "$$out" | sed -n 's/.*MIPS_SUPERSCALAR RESULT: FAIL test_id=\([0-9][0-9]*\).*/\1/p' | tail -n 1`; \
				printf "FAIL test_id=%s commits=%s cycles=%s IPC=%s\n" "$$fail_id" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(MIPS_LOAD_STORE_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/mips_friendly_report_<benchmark>.log"

mips_friendly_report_im: mips_friendly_report_i

biriscv_report_im:
	@echo "=========================================="
	@echo "biRISC-V RV32IM-clean benchmark summary"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory biriscv_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/biriscv_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*BIRISCV PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*BIRISCV PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*BIRISCV PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*BIRISCV RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "FAIL/UNKNOWN, see $(SIMDIR)/biriscv_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(LOAD_STORE_BENCHMARKS); \
	report_group "RV32M" $(RV32M_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/biriscv_report_<benchmark>.log"

rsd_report_im:
	@echo "=========================================="
	@echo "RSD RV32IM-clean benchmark summary"
	@echo "=========================================="
	@mkdir -p $(SIMDIR)
	@total_commits=0; total_cycles=0; total_bench=0; total_fail=0; \
	report_group() { \
		group_name="$$1"; shift; \
		group_commits=0; group_cycles=0; group_bench=0; group_fail=0; \
		for b in "$$@"; do \
			printf "Running %-8s ... " "$$b" >&2; \
			out=`$(MAKE) --no-print-directory rsd_$$b 2>&1`; status=$$?; \
			echo "$$out" > "$(SIMDIR)/rsd_report_$$b.log"; \
			commits=`printf "%s\n" "$$out" | sed -n 's/.*RSD RV32IM PERF: cycles=[0-9][0-9]* commits=\([0-9][0-9]*\) IPC=.*/\1/p' | tail -n 1`; \
			cycles=`printf "%s\n" "$$out" | sed -n 's/.*RSD RV32IM PERF: cycles=\([0-9][0-9]*\) commits=[0-9][0-9]* IPC=.*/\1/p' | tail -n 1`; \
			bench_ipc=`printf "%s\n" "$$out" | sed -n 's/.*RSD RV32IM PERF: cycles=[0-9][0-9]* commits=[0-9][0-9]* IPC=\([0-9.][0-9.]*\).*/\1/p' | tail -n 1`; \
			result=`printf "%s\n" "$$out" | sed -n 's/.*RSD RV32IM RESULT: \(PASS\).*/\1/p' | tail -n 1`; \
			if [ "$$status" -ne 0 ] || [ "$$result" != "PASS" ] || [ -z "$$commits" ] || [ -z "$$cycles" ]; then \
				printf "FAIL/UNKNOWN, see $(SIMDIR)/rsd_report_$$b.log\n" >&2; \
				group_fail=`expr $$group_fail + 1`; \
			else \
				printf "PASS commits=%s cycles=%s IPC=%s\n" "$$commits" "$$cycles" "$$bench_ipc" >&2; \
				group_commits=`expr $$group_commits + $$commits`; \
				group_cycles=`expr $$group_cycles + $$cycles`; \
			fi; \
			group_bench=`expr $$group_bench + 1`; \
		done; \
		ipc=`awk -v c=$$group_commits -v y=$$group_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
		printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "$$group_name" "$$group_bench" "$$group_commits" "$$group_cycles" "$$ipc" "$$([ $$group_fail -eq 0 ] && echo PASS || echo FAIL:$$group_fail)"; \
		total_commits=`expr $$total_commits + $$group_commits`; \
		total_cycles=`expr $$total_cycles + $$group_cycles`; \
		total_bench=`expr $$total_bench + $$group_bench`; \
		total_fail=`expr $$total_fail + $$group_fail`; \
	}; \
	printf "%-18s | %4s | %8s | %8s | %6s | %s\n" "Group" "N" "Commits" "Cycles" "IPC" "Result"; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	report_group "RV32I R-type" $(RV32I_R_BENCHMARKS); \
	report_group "RV32I I/shift" $(RV32I_I_BENCHMARKS); \
	report_group "Load/Store" $(LOAD_STORE_BENCHMARKS); \
	report_group "RV32M" $(RV32M_BENCHMARKS); \
	total_ipc=`awk -v c=$$total_commits -v y=$$total_cycles 'BEGIN { if (y > 0) printf "%.3f", c / y; else printf "0.000" }'`; \
	printf "%-18s-+-%4s-+-%8s-+-%8s-+-%6s-+-%s\n" "------------------" "----" "--------" "--------" "------" "------"; \
	printf "%-18s | %4d | %8d | %8d | %6s | %s\n" "TOTAL" "$$total_bench" "$$total_commits" "$$total_cycles" "$$total_ipc" "$$([ $$total_fail -eq 0 ] && echo PASS || echo FAIL:$$total_fail)"; \
	echo "Logs: $(SIMDIR)/rsd_report_<benchmark>.log"
