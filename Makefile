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
BEEBS_EXTRA_CFLAGS ?=
BEEBS_EXTRA_PLUSARGS ?=
# The position of the testbench.
TB := test/tb_datapath.v
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
BOOM_ELF_TEXT ?= 0x80000000
BOOM_GCC_MARCH ?= rv64im
BOOM_GCC_MABI ?= lp64
CHIPYARD_DIR ?=
BOOM_CHIPYARD_CONFIG ?= SmallBoomConfig
MIPS_DIR := MIPS_SUPERSCALAR
MIPS_BUILDDIR := $(BUILDDIR)/mips
BEEBS_BUILDDIR := $(BUILDDIR)/beebs
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

.PHONY: all compile compile_superscalar run run_raw run_print run_raw_print raw_result print_result compile_alu run_alu wave_alu beebs_crc32 beebs_crc32_smoke src2_compile src2_run src2_run_raw src2_run_print src2_run_raw_print src2_raw_run_print 1cycle_compile 1cycle_run 1cycle_report_im view wave clean rebuild build_bench_elfs check_jumps allim report_im src2_report_im biriscv_allim biriscv_make_allim make_allim_biriscv biriscv_report_im biriscv_clean rsd_build rsd_run_hex rsd_allim rsd_make_allim make_allim_rsd rsd_report_im rsd_clean boom_info boom_build_elfs boom_allim boom_report_im mips_info mips_run_hex mips_run_raw mips_run_print mips_run_raw_print mips_alli mips_allim mips_make_alli mips_make_allim make_alli_mips make_allim_mips mips_report_i mips_report_im mips_friendly_alli mips_friendly_report_i mips_friendly_report_im $(BENCHMARKS) $(DEBUG_BENCHMARKS) $(SRC2_BENCHMARKS) $(ONECYCLE_BENCHMARKS) $(BIRISCV_BENCHMARKS) $(RSD_BENCHMARKS) $(BOOM_BENCHMARKS) $(MIPS_BENCHMARKS) $(MIPS_FRIENDLY_BENCHMARKS)

all: compile

# When run compile The project will automatically create sim and build folder if They do not already exist and update PROGRAM_INSTRS 
# for tb_datapath.v
compile:
	@$(POWERSHELL) -NoProfile -Command "New-Item -ItemType Directory -Force -Path '$(SIMDIR)','$(BUILDDIR)' | Out-Null"
	$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File tools/update_program_info_from_hex.ps1 \
	$(SRC_DIR)/instr.hex $(SRC_DIR)/program_info.vh
	$(IVERILOG) -g2012 -I $(SRC_DIR) -o $(OUT) $(TB)

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

beebs_crc32:
	@echo "=========================================="
	@echo "Running BEEBS benchmark on SuperScalar: crc32"
	@echo "=========================================="
	@mkdir -p $(BEEBS_BUILDDIR) $(SIMDIR)
	$(RISCV_GCC) -march=rv32im -mabi=ilp32 -O2 -ffreestanding -fno-builtin -fno-common \
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
	$(IVERILOG) -g2012 -DBEEBS_DATA_INIT -I $(SRC_DIR) -o $(BEEBS_OUT) $(TB)
	$(VVP) $(BEEBS_OUT) +RAW_RESULT +IGNORE_SCOREBOARD +NO_COMMIT_LIMIT +BEEBS_STOP_ON_X29 +MAX_CYCLES=$(BEEBS_MAX_CYCLES) $(BEEBS_EXTRA_PLUSARGS)

beebs_crc32_smoke:
	$(MAKE) beebs_crc32 BEEBS_CRC_ITERS=16 BEEBS_EXTRA_CFLAGS=-DBEEBS_SKIP_CHECK BEEBS_MAX_CYCLES=5000

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
	@echo "Preparing RV32IM-clean benchmark for BOOM/Chipyard: $(1)"
	@echo "=========================================="
	@mkdir -p $(BOOM_BUILDDIR)
	$(RISCV_GCC) -march=$(BOOM_GCC_MARCH) -mabi=$(BOOM_GCC_MABI) -nostdlib -nostartfiles -Ttext=$(BOOM_ELF_TEXT) \
		$(RISCV_TESTS)/$(1).S -o $(BOOM_BUILDDIR)/$(1).elf
	@if [ -z "$(CHIPYARD_DIR)" ]; then \
		echo "BOOM repo at $(BOOM_DIR) is not self-running."; \
		echo "Generated ELF: $(BOOM_BUILDDIR)/$(1).elf"; \
		echo "To run it, install/use Chipyard and call:"; \
		echo "  make boom_$(1) CHIPYARD_DIR=/path/to/chipyard BOOM_CHIPYARD_CONFIG=$(BOOM_CHIPYARD_CONFIG)"; \
		exit 2; \
	fi
	$(MAKE) -C "$(CHIPYARD_DIR)/sims/verilator" CONFIG=$(BOOM_CHIPYARD_CONFIG) BINARY="$(abspath $(BOOM_BUILDDIR)/$(1).elf)" run-binary
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
	@echo "  BOOM_ELF_TEXT=$(BOOM_ELF_TEXT)"
	@echo "  BOOM_CHIPYARD_CONFIG=$(BOOM_CHIPYARD_CONFIG)"
	@echo "Example:"
	@echo "  make boom_addi CHIPYARD_DIR=/path/to/chipyard"
	@echo "More notes: $(BOOM_DIR)/RV32IM_CLEAN_BENCHMARK_SETUP.md"

boom_build_elfs:
	@mkdir -p $(BOOM_BUILDDIR)
	@for b in $(BENCHMARKS); do \
		echo "Building BOOM ELF $$b"; \
		$(RISCV_GCC) -march=$(BOOM_GCC_MARCH) -mabi=$(BOOM_GCC_MABI) -nostdlib -nostartfiles -Ttext=$(BOOM_ELF_TEXT) \
			$(RISCV_TESTS)/$$b.S -o $(BOOM_BUILDDIR)/$$b.elf || exit 1; \
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
	@for b in $(BENCHMARKS); do \
		echo "Running BOOM $$b"; \
		$(MAKE) --no-print-directory boom_$$b || exit 1; \
	done

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
