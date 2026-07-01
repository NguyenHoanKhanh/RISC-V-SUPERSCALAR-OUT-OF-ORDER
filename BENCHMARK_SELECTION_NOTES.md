# Benchmark selection notes

## Current design condition

The current processor can run the controlled `riscv-tests` flow well, especially the
RV32IM clean tests that were adapted for this workspace. These tests are useful for
ISA-level functional checking and controlled IPC measurement, but they are not full
application benchmarks.

The current RTL is still limited for general C workloads because branch/jump handling,
stack usage, load/store behavior, and memory mapping are not yet as complete as a
production OoO CPU. Therefore, benchmarks that rely heavily on function calls, complex
branches, tables in memory, or runtime support can expose correctness limitations before
they provide meaningful IPC data.

## Benchmark roles

| Benchmark group | Main role | Current suitability |
|---|---|---|
| `riscv-tests` | ISA correctness / directed assembly tests | High |
| Custom assembly no-conflict/conflict tests | Controlled IPC and OoO behavior | High |
| BEEBS subset | Small embedded C workloads | Medium, only selected kernels |
| Mälardalen-style small kernels | Small C kernels, WCET/embedded style | Medium to high |
| CoreMark | Embedded CPU benchmark | Medium to low for current RTL |
| Embench | Embedded application benchmark suite | Medium to low for current RTL |
| MiBench | Larger embedded workloads | Low for current RTL |
| SPEC CPU | Industry CPU benchmark | Not suitable for current RTL |

## Why full BEEBS is not the best current benchmark

BEEBS is a valid benchmark suite with academic references, but the full suite is not a
clean match for the current RTL state. Many BEEBS programs are real C programs with
loops, branches, stack accesses, function calls, load/store traffic, and data tables.

If a BEEBS program hangs or produces very low IPC now, it may be measuring missing or
incomplete control-flow/memory support rather than the actual OoO execution capability.
For that reason, BEEBS should be used as a staged extension, not as the main benchmark
until the RTL supports the required program behavior more robustly.

## Recommended benchmark strategy

1. Use `riscv-tests` for ISA functional correctness.
2. Use custom assembly tests for controlled IPC evaluation:
   - no data conflict
   - deliberate RAW dependency
   - mixed ALU/MUL/DIV/Load/Store
3. Add a small C benchmark subset only after confirming the instruction mix is supported.
4. Prefer simple BEEBS or Mälardalen-style kernels first.
5. Only move to CoreMark or Embench after branch, jump, stack, and load/store behavior are stable.

## BEEBS usage recommendation

Use only a subset first. Good candidates to investigate:

| Candidate | Reason |
|---|---|
| `fibcall` or a loop-only Fibonacci variant | Simple integer control-flow workload |
| `cnt` | Small loop and memory behavior |
| `bs` | Simple search-style workload |
| `matmult-int` | Useful for load/store and arithmetic if memory path is stable |
| `crc32` | Useful later, but currently heavier because it uses table loads, branch loop, stack, and MUL |

Before accepting any BEEBS result, check:

- disassembled instruction list
- unsupported instructions such as `jalr`, unexpected `auipc`, CSR, or system instructions
- whether the program requires stack/data memory initialization
- whether `x28`/`x29` or the selected stop mechanism commits correctly
- whether the program terminates by design or enters a final infinite loop

## Current local BEEBS subset setup

The workspace now has a small staged BEEBS-compatible subset under `beebs_port`.
These tests use the same simple termination convention:

- `x28`: benchmark result
- `x29`: status, where `1` means PASS and `-1` means FAIL
- the testbench stops when a commit to `x29` is observed with `+BEEBS_STOP_ON_X29`

Available lightweight targets:

| Target | Source | Purpose |
|---|---|---|
| `make beebs_alu` | `beebs_port/beebs_alu_standalone.c` | ALU and simple counted loop |
| `make beebs_branch` | `beebs_port/beebs_branch_standalone.c` | Branch behavior with a small conditional loop |
| `make beebs_mem` | `beebs_port/beebs_mem_standalone.c` | Basic store/load/sum behavior |
| `make beebs_subset_report` | all three above | Runs the current lightweight subset |
| `make beebs_crc32_smoke` | `beebs_port/beebs_crc32_standalone.c` | Short CRC32 smoke test |
| `make beebs_crc32_check16` | `beebs_port/beebs_crc32_standalone.c` | CRC32 with 16 iterations and result check |
| `make beebs_crc32` | `beebs_port/beebs_crc32_standalone.c` | Heavier CRC32 test |

Recommended order:

1. `make beebs_alu`
2. `make beebs_branch`
3. `make beebs_mem`
4. `make beebs_crc32_smoke`
5. `make beebs_crc32_check16`
6. `make beebs_crc32`

If `beebs_alu` fails, the issue is not BEEBS complexity; check basic compile,
decode, execute, and commit. If `beebs_alu` passes but `beebs_branch` fails, focus
on branch redirect/flush behavior. If `beebs_branch` passes but `beebs_mem` fails,
focus on data memory, Load Queue, Store Queue, and load completion. Only use CRC32
after the three small tests are stable.

## Academic references

### BEEBS

BEEBS has a direct academic reference:

James Pallister, Simon Hollis, Jeremy Bennett,
"BEEBS: Open Benchmarks for Energy Measurements on Embedded Platforms", 2013.

Link: https://arxiv.org/abs/1308.5174

Use this to justify BEEBS as an embedded benchmark suite. Do not use it to claim a
direct IPC baseline for this processor, because the paper evaluates different platforms
and focuses mainly on embedded energy/performance behavior.

### riscv-tests

The official `riscv-tests` repository is best used as an ISA/unit-test reference:

Link: https://github.com/riscv-software-src/riscv-tests

Use it to justify functional ISA checking, not as a full performance benchmark.

### BOOM reference

BOOM is a useful reference for the general separation between CPU correctness testing
and performance evaluation of OoO RISC-V processors:

Link: https://www2.eecs.berkeley.edu/Pubs/TechRpts/2017/EECS-2017-157.pdf

The important lesson is methodological: ISA tests and application benchmarks serve
different purposes.

## Current conclusion

For the current RTL, the best evaluation set is:

- `riscv-tests` for correctness
- custom assembly tests for controlled IPC
- a small, carefully selected BEEBS/Mälardalen-style subset for early C workload testing

Full BEEBS, CoreMark, Embench, MiBench, or SPEC should not be treated as primary
benchmarks until control-flow, stack, memory, and load/store behavior are more complete.
