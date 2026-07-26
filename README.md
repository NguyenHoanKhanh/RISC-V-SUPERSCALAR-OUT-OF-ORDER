# Research and Design of a Superscalar RISC-V Processor Based on the Improved Tomasulo Algorithm

<!--
Image TODO:
Add a project banner or processor overview diagram here.
Recommended file: images/project_overview.png
-->

## Table of Contents

1. [About The Project](#about-the-project)
2. [Key Features](#key-features)
3. [Microarchitecture](#microarchitecture)
4. [Repository Structure](#repository-structure)
5. [Getting Started](#getting-started)
6. [How To Run](#how-to-run)
7. [Benchmark And Verification](#benchmark-and-verification)
8. [Current Results](#current-results)
9. [Future Work](#future-work)
10. [Contact](#contact)

## About The Project

This project presents the research and RTL design of a 32-bit RISC-V Superscalar
Out-of-Order processor based on an improved Tomasulo-style algorithm. The design
focuses on exploiting instruction-level parallelism while preserving correct
program behavior through register renaming, dynamic scheduling, and in-order
commit.

The processor targets the RV32IM instruction subset and is implemented in
Verilog/SystemVerilog for RTL simulation and FPGA-oriented synthesis. The main
evaluation flow uses directed RV32IM-clean assembly benchmarks to verify
functional correctness and measure commit/cycle performance.

<!--
Image TODO:
Add a high-level block diagram of the processor.
Suggested content:
- Fetch / Decode
- Rename Unit
- Reservation Station
- Execute Units
- Load/Store Queue
- Reorder Buffer
- Physical Register File
- Architectural Register File
Recommended file: images/top_level_architecture.png
-->

## Key Features

- RV32IM-compatible instruction subset.
- 2-wide superscalar instruction flow.
- Out-of-order execution based on Tomasulo-style dynamic scheduling.
- Register renaming to reduce false dependencies such as WAW and WAR hazards.
- Physical Register File for renamed operand storage.
- Reservation Station for dynamic issue of ready instructions.
- Reorder Buffer for completion tracking and in-order commit.
- Load/Store support through dedicated memory access structures.
- Multi-cycle instruction support for RV32M operations.
- RTL simulation with Icarus Verilog and VVP.
- RV32IM-clean benchmark flow through Makefile targets.

## Microarchitecture

The processor is organized around an improved Tomasulo-style backend. Incoming
instructions are decoded and renamed before entering the out-of-order execution
engine. Source operands are tracked through physical registers and wakeup/select
logic. Ready instructions are issued from the Reservation Station to the
available execution resources, while the Reorder Buffer preserves program order
at commit.

Core microarchitectural blocks include:

| Block | Role |
|---|---|
| Program Counter / Instruction Memory | Fetches instruction words for the frontend. |
| Decoder | Decodes RV32IM instruction fields and control information. |
| Rename Unit | Maps architectural registers to physical registers. |
| Physical Register File | Stores renamed register values. |
| Reservation Station | Holds waiting instructions and issues ready operations. |
| Execute Units | Execute ALU, branch, multiply/divide, and memory-related operations. |
| Load/Store Queue | Coordinates memory operations and load/store ordering behavior. |
| Reorder Buffer | Tracks completion and commits instructions in program order. |
| Architectural Register File | Holds committed architectural state. |

<!--
Image TODO:
Add Tomasulo datapath diagram.
Recommended file: images/tomasulo_datapath.png
-->

<!--
Image TODO:
Add instruction flow diagram.
Suggested stages:
Fetch -> Decode -> Rename -> Dispatch -> Issue -> Execute -> Complete -> Commit
Recommended file: images/instruction_flow.png
-->

## Repository Structure

```text
src/                         RTL source files
test/                        Testbench files
tools/                       Utility scripts for hex/program-info generation
riscv-tests-master/isa/      RV32IM-clean benchmark assembly tests
Makefile                     Main simulation and benchmark flow
GNUmakefile                  Make wrapper
```

## Getting Started

### Prerequisites

The benchmark and simulation flow is intended to run in WSL/Linux with the
following tools:

- `riscv64-unknown-elf-gcc`
- `riscv64-unknown-elf-objcopy`
- `iverilog`
- `vvp`
- PowerShell, used by helper scripts in `tools/`

Optional waveform viewer:

- `gtkwave`

### Installation

Clone the repository:

```bash
git clone https://github.com/NguyenHoanKhanh/RISC-V-SUPERSCALAR-OUT-OF-ORDER.git
cd RISC-V-SUPERSCALAR-OUT-OF-ORDER
```

Check that the required tools are available:

```bash
riscv64-unknown-elf-gcc --version
iverilog -V
vvp -V
```

## How To Run

Run the full RV32IM-clean benchmark report:

```bash
make report_im
```

Run the currently loaded program and print commit information:

```bash
make run_raw_print
```

Run a single benchmark:

```bash
make add
make addi
make lw
make mul
```

The Makefile automatically:

1. Builds the selected assembly benchmark into an ELF file.
2. Converts the ELF into a binary image.
3. Generates `src/instr.hex` and `src/program_info.vh`.
4. Compiles the RTL testbench with Icarus Verilog.
5. Runs simulation using VVP.
6. Prints pass/fail and performance counters.

## Benchmark And Verification

The main verification flow uses RV32IM-clean directed assembly benchmarks. Each
benchmark writes a pass/fail signature through the scoreboard convention used by
the testbench. The simulation output includes commit count, cycle count, IPC,
and final pass/fail status.

Example output:

```text
RESULT: PASS
PERF: cycles=<cycles> commits=<commits> IPC=<ipc>
```

The benchmark groups include:

| Group | Purpose |
|---|---|
| RV32I R-type | Register-register ALU correctness and IPC. |
| RV32I I/shift | Immediate and shift instruction behavior. |
| Load/Store | Memory access correctness. |
| RV32M | Multiply, divide, and remainder instruction behavior. |

<!--
Image TODO:
Add waveform screenshot showing commit, ROB, RS, or register writeback behavior.
Recommended file: images/waveform_commit_trace.png
-->

## Current Results

The stable RV32IM-clean report currently passes all benchmark groups in the
published flow.

Example local `make report_im` result:

```text
TOTAL | 37 | 15798 commits | 12852 cycles | IPC 1.229 | PASS
```

Thesis-level synthesis and implementation observations include FPGA-oriented
results on a Cyclone V DE1-SoC platform, with reported operating frequency around
87 MHz in the evaluated Quartus setup.

<!--
Image TODO:
Add benchmark summary table or chart.
Suggested content:
- RV32I R-type IPC
- RV32I I/shift IPC
- Load/Store IPC
- RV32M IPC
- Total IPC
Recommended file: images/rv32im_clean_ipc_summary.png
-->

<!--
Image TODO:
Add FPGA resource utilization chart.
Suggested content:
- ALMs
- ALUTs
- Logic registers
- I/O pins
Recommended file: images/fpga_resource_utilization.png
-->

## Future Work

Potential development directions include:

- Improving branch prediction and frontend redirection.
- Extending speculation and rollback support.
- Optimizing Load/Store Queue behavior.
- Improving Reservation Station wakeup/select timing.
- Reducing FPGA resource usage.
- Increasing maximum operating frequency.
- Expanding benchmark coverage beyond directed RV32IM-clean tests.

## Contact

Nguyen Hoan Khanh

Project repository:

```text
https://github.com/NguyenHoanKhanh/RISC-V-SUPERSCALAR-OUT-OF-ORDER
```
