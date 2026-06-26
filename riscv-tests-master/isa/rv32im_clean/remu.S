# Auto-generated RV32IM-clean benchmark.
# Source: rv32um/remu.S
# Scoreboard: x31 = 1 pass / -1 fail, x30 = failing test id.
# RV32IM performance window: count retired instructions and cycles from
# benchmark_start/rv32im_perf_begin through benchmark_end/rv32im_perf_end.
# IPC is measured externally as commit_count / cycle_count.

  .section .text
  .option norvc
  .text
  .globl _start
  .globl rv32im_scoreboard_init
  .globl benchmark_start
  .globl benchmark_end
  .globl rv32im_perf_begin
  .globl rv32im_perf_end
  .globl rv32im_scoreboard_finalize
_start:
rv32im_scoreboard_init:
  addi x31, x0, 0
  addi x30, x0, 0
benchmark_start:
rv32im_perf_begin:

test_2:
  addi x11, x0, 1
  slli x11, x11, 4
  ori x11, x11, 4
  addi x12, x0, 6
  remu x14, x11, x12
  # check test 2
  addi x7, x0, 2
  bne x14, x7, fail_2
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_3:
  addi x11, x0, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 14
  slli x11, x11, 4
  ori x11, x11, 12
  addi x12, x0, 6
  remu x14, x11, x12
  # check test 3
  addi x7, x0, 2
  bne x14, x7, fail_3
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_4:
  addi x11, x0, 1
  slli x11, x11, 4
  ori x11, x11, 4
  addi x12, x0, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 10
  remu x14, x11, x12
  # check test 4
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 4
  bne x14, x7, fail_4
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_5:
  addi x11, x0, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 14
  slli x11, x11, 4
  ori x11, x11, 12
  addi x12, x0, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 10
  remu x14, x11, x12
  # check test 5
  addi x7, x0, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 14
  slli x7, x7, 4
  ori x7, x7, 12
  bne x14, x7, fail_5
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_6:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 1
  remu x14, x11, x12
  # check test 6
  addi x7, x0, 0
  bne x14, x7, fail_6
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_7:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  remu x14, x11, x12
  # check test 7
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_7
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_8:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 0
  remu x14, x11, x12
  # check test 8
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_8
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_9:
  addi x11, x0, 1
  addi x12, x0, 0
  remu x14, x11, x12
  # check test 9
  addi x7, x0, 1
  bne x14, x7, fail_9
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_10:
  addi x11, x0, 0
  addi x12, x0, 0
  remu x14, x11, x12
  # check test 10
  addi x7, x0, 0
  bne x14, x7, fail_10
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

benchmark_end:
rv32im_perf_end:
pass:
rv32im_scoreboard_finalize:
  addi x31, x0, 1
pass_loop:
  beq x0, x0, pass_loop
  # branch recovery padding: keep pass loop fall-through away from fail table
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0

fail_2:
  addi x30, x0, 2
  addi x31, x0, -1
fail_loop_2:
  beq x0, x0, fail_loop_2

fail_3:
  addi x30, x0, 3
  addi x31, x0, -1
fail_loop_3:
  beq x0, x0, fail_loop_3

fail_4:
  addi x30, x0, 4
  addi x31, x0, -1
fail_loop_4:
  beq x0, x0, fail_loop_4

fail_5:
  addi x30, x0, 5
  addi x31, x0, -1
fail_loop_5:
  beq x0, x0, fail_loop_5

fail_6:
  addi x30, x0, 6
  addi x31, x0, -1
fail_loop_6:
  beq x0, x0, fail_loop_6

fail_7:
  addi x30, x0, 7
  addi x31, x0, -1
fail_loop_7:
  beq x0, x0, fail_loop_7

fail_8:
  addi x30, x0, 8
  addi x31, x0, -1
fail_loop_8:
  beq x0, x0, fail_loop_8

fail_9:
  addi x30, x0, 9
  addi x31, x0, -1
fail_loop_9:
  beq x0, x0, fail_loop_9

fail_10:
  addi x30, x0, 10
  addi x31, x0, -1
fail_loop_10:
  beq x0, x0, fail_loop_10

