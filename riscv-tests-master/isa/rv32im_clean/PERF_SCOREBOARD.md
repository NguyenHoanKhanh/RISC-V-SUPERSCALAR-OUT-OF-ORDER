# RV32IM Scoreboard And Performance Contract

This file documents the benchmark contract for the cleaned RV32IM ISA tests.

## Scoreboard Registers

| Register | Meaning |
| --- | --- |
| `x31` | PASS/FAIL flag. `1` means pass, `-1` means fail. |
| `x30` | Failing test ID. Valid when `x31 = -1`. |

## Control Flow

Each generated file has:

- one `pass` block
- one `fail_N` block for every test case
- one infinite loop after pass or fail

The loop uses `beq x0, x0, label` as the final stop mechanism. Branch instruction tests are not included in this clean set.

## Performance Labels

| Label | Meaning |
| --- | --- |
| `_start` | Program entry. |
| `benchmark_start` | Start of the benchmark measurement window. |
| `rv32im_perf_begin` | Alias at the same point as `benchmark_start`. |
| `benchmark_end` | End of the benchmark measurement window. |
| `rv32im_perf_end` | Alias at the same point as `benchmark_end`. |

## External Measurement

The assembly does not read `cycle`, `instret`, or any CSR. The CPU testbench should measure:

- PC tracking: observe committed PC.
- `cycle_count`: count cycles in the benchmark window.
- `commit_count`: count committed instructions in the benchmark window.
- `IPC = commit_count / cycle_count`.

Recommended flow:

1. Run from `_start`.
2. Start counters at `benchmark_start` / `rv32im_perf_begin`.
3. Stop counters at `benchmark_end` / `rv32im_perf_end`.
4. Read `x31` and `x30`.
