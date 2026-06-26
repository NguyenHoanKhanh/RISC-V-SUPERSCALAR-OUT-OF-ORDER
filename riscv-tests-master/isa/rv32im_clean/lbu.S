# Auto-generated RV32IM-clean benchmark.
# Source: rv32ui/lbu.S
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

init_load_data:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  addi x1, x0, 15
  slli x1, x1, 4
  ori x1, x1, 15
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  ori x1, x1, 15
  slli x1, x1, 4
  ori x1, x1, 15
  sw x1, 0(x2)
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0

test_2:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  lbu x14, 0(x2)
  # check test 2
  addi x7, x0, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_2
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_3:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  lbu x14, 1(x2)
  # check test 3
  addi x7, x0, 0
  bne x14, x7, fail_3
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_4:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  lbu x14, 2(x2)
  # check test 4
  addi x7, x0, 15
  slli x7, x7, 4
  bne x14, x7, fail_4
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_5:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  lbu x14, 3(x2)
  # check test 5
  addi x7, x0, 15
  bne x14, x7, fail_5
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_6:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  ori x2, x2, 3
  lbu x14, -3(x2)
  # check test 6
  addi x7, x0, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_6
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_7:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  ori x2, x2, 3
  lbu x14, -2(x2)
  # check test 7
  addi x7, x0, 0
  bne x14, x7, fail_7
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_8:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  ori x2, x2, 3
  lbu x14, -1(x2)
  # check test 8
  addi x7, x0, 15
  slli x7, x7, 4
  bne x14, x7, fail_8
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_9:
  addi x2, x0, 4
  slli x2, x2, 4
  slli x2, x2, 4
  slli x2, x2, 4
  ori x2, x2, 3
  lbu x14, 0(x2)
  # check test 9
  addi x7, x0, 15
  bne x14, x7, fail_9
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_12:
  addi x13, x0, 4
  slli x13, x13, 4
  slli x13, x13, 4
  slli x13, x13, 4
  ori x13, x13, 1
  lbu x14, 1(x13)
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 12
  addi x7, x0, 15
  slli x7, x7, 4
  bne x6, x7, fail_12
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_13:
  addi x13, x0, 4
  slli x13, x13, 4
  slli x13, x13, 4
  slli x13, x13, 4
  ori x13, x13, 2
  lbu x14, 1(x13)
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 13
  addi x7, x0, 15
  bne x6, x7, fail_13
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_14:
  addi x13, x0, 4
  slli x13, x13, 4
  slli x13, x13, 4
  slli x13, x13, 4
  lbu x14, 1(x13)
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 14
  addi x7, x0, 0
  bne x6, x7, fail_14
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_15:
  addi x13, x0, 4
  slli x13, x13, 4
  slli x13, x13, 4
  slli x13, x13, 4
  ori x13, x13, 1
  lbu x14, 1(x13)
  # check test 15
  addi x7, x0, 15
  slli x7, x7, 4
  bne x14, x7, fail_15
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_16:
  addi x13, x0, 4
  slli x13, x13, 4
  slli x13, x13, 4
  slli x13, x13, 4
  ori x13, x13, 2
  addi x0, x0, 0
  lbu x14, 1(x13)
  # check test 16
  addi x7, x0, 15
  bne x14, x7, fail_16
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_17:
  addi x13, x0, 4
  slli x13, x13, 4
  slli x13, x13, 4
  slli x13, x13, 4
  addi x0, x0, 0
  addi x0, x0, 0
  lbu x14, 1(x13)
  # check test 17
  addi x7, x0, 0
  bne x14, x7, fail_17
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

fail_12:
  addi x30, x0, 12
  addi x31, x0, -1
fail_loop_12:
  beq x0, x0, fail_loop_12

fail_13:
  addi x30, x0, 13
  addi x31, x0, -1
fail_loop_13:
  beq x0, x0, fail_loop_13

fail_14:
  addi x30, x0, 14
  addi x31, x0, -1
fail_loop_14:
  beq x0, x0, fail_loop_14

fail_15:
  addi x30, x0, 15
  addi x31, x0, -1
fail_loop_15:
  beq x0, x0, fail_loop_15

fail_16:
  addi x30, x0, 16
  addi x31, x0, -1
fail_loop_16:
  beq x0, x0, fail_loop_16

fail_17:
  addi x30, x0, 17
  addi x31, x0, -1
fail_loop_17:
  beq x0, x0, fail_loop_17

