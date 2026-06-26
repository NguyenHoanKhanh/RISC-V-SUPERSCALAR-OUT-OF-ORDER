# RV32IM Clean Benchmarks

This is a cleaned RV32IM-only benchmark set derived from the original `riscv-tests` ISA tests.

The clean tests reuse useful instruction-level cases from:

- `../rv32ui`
- `../rv32um`

Only these instruction groups are included:

- RV32I R-type: `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`, `sltu`
- RV32I I-type: `addi`, `andi`, `ori`, `xori`, `slli`, `srli`, `srai`, `slti`, `sltiu`
- Load/store: `lb`, `lh`, `lw`, `lbu`, `lhu`, `sb`, `sh`, `sw`
- RV32M: `mul`, `mulh`, `mulhsu`, `mulhu`, `div`, `divu`, `rem`, `remu`

The original CSR/trap/privileged framework was removed. These files do not include:

- `riscv_test.h`
- `test_macros.h`
- `RVTEST_*`
- `TEST_PASSFAIL`
- original framework-dependent `TEST_*` macros

The clean ISA test set does not include CSR, `ecall`, `ebreak`, trap handlers, privileged mode, supervisor mode, hypervisor mode, floating point, atomics, compressed instructions, branch tests, `jal`, `jalr`, `fence`, `fence.i`, `auipc`, or `lui`.

The original `env/` files are kept only as upstream reference material. The clean benchmark flow does not include `env/p`, trap handlers, or the original riscv-tests pass/fail macros.

## Scoreboard

PASS/FAIL is reported through integer registers:

- `x31 = 1`: PASS
- `x31 = -1`: FAIL
- `x30 = failing test ID`

Each test compares actual and expected results using RV32IM-compatible integer instructions. On failure, the benchmark writes `x30`, writes `x31 = -1`, and loops forever. If all cases pass, it writes `x31 = 1` and loops forever.

The pass/fail self-loops include NOP padding after the loop branch. This keeps wrong-path sequential fetch inside harmless `addi x0, x0, 0` instructions while a simple branch recovery path redirects the PC back to the loop.

Branch-based test checks also include one NOP after each `bne ..., fail_N` so the instruction paired immediately after a branch is harmless on a simple two-wide front end.

## Performance

IPC and performance counters are measured in the Verilog testbench, not inside the assembly. The assembly does not read CSR counters.

Useful labels:

- `_start`
- `benchmark_start`
- `rv32im_perf_begin`
- `benchmark_end`
- `rv32im_perf_end`

The testbench should count cycles and committed instructions between the begin/end labels, then report:

```text
IPC = commit_count / cycle_count
```

## Reference Benchmarks

The original `benchmarks/` folder is kept as an external/reference performance benchmark source for report discussion. It is not part of this cleaned ISA test set.

## Build Flow

From the project root:

```sh
make addi
make add
make mul
make allim
```

Each target compiles a clean `.S` file to `.elf`, converts it to `src/instr.hex`, runs the Verilog testbench, and saves a benchmark-specific waveform in `sim/`.
