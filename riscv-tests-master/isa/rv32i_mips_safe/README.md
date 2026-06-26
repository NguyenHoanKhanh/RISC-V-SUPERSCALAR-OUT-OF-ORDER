# RV32I MIPS-Safe Benchmarks

This benchmark subset is derived from `rv32im_clean` for the current
`MIPS_SUPERSCALAR` in-order RTL.

Differences from `rv32im_clean`:

- Only benchmarks supported by the current RTL are included.
- RV32M benchmarks are excluded because this RTL has no multiplier/divider.
- `lb/lh/lbu/lhu/sb/sh` are excluded because load/store byte and halfword
  treatment is not implemented in this RTL.
- Extra NOP padding is inserted before branch-based checks so branch compare
  operands have time to reach the register file.
- Extra NOP padding is inserted between fail ID write (`x30`) and fail state
  write (`x31`) so the testbench can latch a stable failing test ID.

Scoreboard convention remains the same:

- `x31 = 1` means PASS
- `x31 = -1` means FAIL
- `x30` stores the failing test ID
