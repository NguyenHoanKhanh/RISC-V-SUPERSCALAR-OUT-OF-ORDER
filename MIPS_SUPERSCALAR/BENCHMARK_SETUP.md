# MIPS_SUPERSCALAR Benchmark Setup

This folder is named MIPS_SUPERSCALAR, but the current RTL decodes a small
RISC-V-like RV32I subset: R-type, I-type, load/store, branch, and JAL.

The benchmark flow is kept separate from the main `src/` flow:

- Generated hex files are written under `build/mips/`.
- Simulation outputs are written under `sim/mips_*`.
- The default `source/imem.txt` remains usable by the original testbenches.
- `source/imem.v` accepts `+MIPS_IMEM=<hex file>` for benchmark runs.

Supported benchmark groups for this core:

- RV32I R-type
- RV32I I-type and shift
- Load/store, subject to the RTL's current load/store support

RV32M benchmarks are not enabled for this source because the current RTL does
not include multiplier/divider support.

Scoreboard convention:

- `x31 = 1` means PASS
- `x31 = -1` means FAIL
- `x30` stores the failing test ID

Performance reporting is done in `test/tb_benchmark.v` by counting writeback
events, cycles, and IPC.
