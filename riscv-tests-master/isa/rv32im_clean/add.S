# Auto-generated RV32IM-clean benchmark.
# Source: rv32ui/add.S
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
  addi x11, x0, 0
  addi x12, x0, 0
  add x14, x11, x12
  # check test 2
  addi x7, x0, 0
  bne x14, x7, fail_2
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_3:
  addi x11, x0, 1
  addi x12, x0, 1
  add x14, x11, x12
  # check test 3
  addi x7, x0, 2
  bne x14, x7, fail_3
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_4:
  addi x11, x0, 3
  addi x12, x0, 7
  add x14, x11, x12
  # check test 4
  addi x7, x0, 10
  bne x14, x7, fail_4
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_5:
  addi x11, x0, 0
  addi x12, x0, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 8
  slli x12, x12, 4
  slli x12, x12, 4
  slli x12, x12, 4
  add x14, x11, x12
  # check test 5
  addi x7, x0, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
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
  addi x12, x0, 0
  add x14, x11, x12
  # check test 6
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
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
  ori x12, x12, 8
  slli x12, x12, 4
  slli x12, x12, 4
  slli x12, x12, 4
  add x14, x11, x12
  # check test 7
  addi x7, x0, 7
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_7
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_8:
  addi x11, x0, 0
  addi x12, x0, 7
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  add x14, x11, x12
  # check test 8
  addi x7, x0, 7
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_8
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_9:
  addi x11, x0, 7
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
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  addi x12, x0, 0
  add x14, x11, x12
  # check test 9
  addi x7, x0, 7
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
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_9
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_10:
  addi x11, x0, 7
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
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  addi x12, x0, 7
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  add x14, x11, x12
  # check test 10
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 7
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 14
  bne x14, x7, fail_10
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_11:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 7
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  add x14, x11, x12
  # check test 11
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 7
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_11
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_12:
  addi x11, x0, 7
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
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  addi x12, x0, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 15
  slli x12, x12, 4
  ori x12, x12, 8
  slli x12, x12, 4
  slli x12, x12, 4
  slli x12, x12, 4
  add x14, x11, x12
  # check test 12
  addi x7, x0, 7
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 7
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_12
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_13:
  addi x11, x0, 0
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
  add x14, x11, x12
  # check test 13
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
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_13
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_14:
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
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
  addi x12, x0, 1
  add x14, x11, x12
  # check test 14
  addi x7, x0, 0
  bne x14, x7, fail_14
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_15:
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
  ori x11, x11, 15
  slli x11, x11, 4
  ori x11, x11, 15
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
  add x14, x11, x12
  # check test 15
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
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 14
  bne x14, x7, fail_15
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_16:
  addi x11, x0, 1
  addi x12, x0, 7
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
  add x14, x11, x12
  # check test 16
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_16
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_17:
  addi x11, x0, 13
  addi x12, x0, 11
  add x11, x11, x12
  # check test 17
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 8
  bne x11, x7, fail_17
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_18:
  addi x11, x0, 14
  addi x12, x0, 11
  add x12, x11, x12
  # check test 18
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 9
  bne x12, x7, fail_18
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_19:
  addi x11, x0, 13
  add x11, x11, x11
  # check test 19
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 10
  bne x11, x7, fail_19
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_20:
  addi x1, x0, 13
  addi x2, x0, 11
  add x14, x1, x2
  addi x6, x14, 0
  # check test 20
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 8
  bne x6, x7, fail_20
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_21:
  addi x1, x0, 14
  addi x2, x0, 11
  add x14, x1, x2
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 21
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 9
  bne x6, x7, fail_21
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_22:
  addi x1, x0, 15
  addi x2, x0, 11
  add x14, x1, x2
  addi x0, x0, 0
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 22
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 10
  bne x6, x7, fail_22
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_23:
  addi x1, x0, 13
  addi x2, x0, 11
  add x14, x1, x2
  # check test 23
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 8
  bne x14, x7, fail_23
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_24:
  addi x1, x0, 14
  addi x2, x0, 11
  addi x0, x0, 0
  add x14, x1, x2
  # check test 24
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 9
  bne x14, x7, fail_24
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_25:
  addi x1, x0, 15
  addi x2, x0, 11
  addi x0, x0, 0
  addi x0, x0, 0
  add x14, x1, x2
  # check test 25
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 10
  bne x14, x7, fail_25
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_26:
  addi x1, x0, 13
  addi x0, x0, 0
  addi x2, x0, 11
  add x14, x1, x2
  # check test 26
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 8
  bne x14, x7, fail_26
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_27:
  addi x1, x0, 14
  addi x0, x0, 0
  addi x2, x0, 11
  addi x0, x0, 0
  add x14, x1, x2
  # check test 27
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 9
  bne x14, x7, fail_27
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_28:
  addi x1, x0, 15
  addi x0, x0, 0
  addi x0, x0, 0
  addi x2, x0, 11
  add x14, x1, x2
  # check test 28
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 10
  bne x14, x7, fail_28
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_29:
  addi x2, x0, 11
  addi x1, x0, 13
  add x14, x1, x2
  # check test 29
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 8
  bne x14, x7, fail_29
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_30:
  addi x2, x0, 11
  addi x1, x0, 14
  addi x0, x0, 0
  add x14, x1, x2
  # check test 30
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 9
  bne x14, x7, fail_30
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_31:
  addi x2, x0, 11
  addi x1, x0, 15
  addi x0, x0, 0
  addi x0, x0, 0
  add x14, x1, x2
  # check test 31
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 10
  bne x14, x7, fail_31
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_32:
  addi x2, x0, 11
  addi x0, x0, 0
  addi x1, x0, 13
  add x14, x1, x2
  # check test 32
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 8
  bne x14, x7, fail_32
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_33:
  addi x2, x0, 11
  addi x0, x0, 0
  addi x1, x0, 14
  addi x0, x0, 0
  add x14, x1, x2
  # check test 33
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 9
  bne x14, x7, fail_33
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_34:
  addi x2, x0, 11
  addi x0, x0, 0
  addi x0, x0, 0
  addi x1, x0, 15
  add x14, x1, x2
  # check test 34
  addi x7, x0, 1
  slli x7, x7, 4
  ori x7, x7, 10
  bne x14, x7, fail_34
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_35:
  addi x1, x0, 15
  add x2, x0, x1
  # check test 35
  addi x7, x0, 15
  bne x2, x7, fail_35
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_36:
  addi x1, x0, 2
  slli x1, x1, 4
  add x2, x1, x0
  # check test 36
  addi x7, x0, 2
  slli x7, x7, 4
  bne x2, x7, fail_36
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_37:
  add x1, x0, x0
  # check test 37
  addi x7, x0, 0
  bne x1, x7, fail_37
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_38:
  addi x1, x0, 1
  slli x1, x1, 4
  addi x2, x0, 1
  slli x2, x2, 4
  ori x2, x2, 14
  add x0, x1, x2
  # check test 38
  addi x7, x0, 0
  bne x0, x7, fail_38
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0


benchmark_end:
rv32im_perf_end:
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

fail_11:
  addi x30, x0, 11
  addi x31, x0, -1
fail_loop_11:
  beq x0, x0, fail_loop_11

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

fail_18:
  addi x30, x0, 18
  addi x31, x0, -1
fail_loop_18:
  beq x0, x0, fail_loop_18

fail_19:
  addi x30, x0, 19
  addi x31, x0, -1
fail_loop_19:
  beq x0, x0, fail_loop_19

fail_20:
  addi x30, x0, 20
  addi x31, x0, -1
fail_loop_20:
  beq x0, x0, fail_loop_20

fail_21:
  addi x30, x0, 21
  addi x31, x0, -1
fail_loop_21:
  beq x0, x0, fail_loop_21

fail_22:
  addi x30, x0, 22
  addi x31, x0, -1
fail_loop_22:
  beq x0, x0, fail_loop_22

fail_23:
  addi x30, x0, 23
  addi x31, x0, -1
fail_loop_23:
  beq x0, x0, fail_loop_23

fail_24:
  addi x30, x0, 24
  addi x31, x0, -1
fail_loop_24:
  beq x0, x0, fail_loop_24

fail_25:
  addi x30, x0, 25
  addi x31, x0, -1
fail_loop_25:
  beq x0, x0, fail_loop_25

fail_26:
  addi x30, x0, 26
  addi x31, x0, -1
fail_loop_26:
  beq x0, x0, fail_loop_26

fail_27:
  addi x30, x0, 27
  addi x31, x0, -1
fail_loop_27:
  beq x0, x0, fail_loop_27

fail_28:
  addi x30, x0, 28
  addi x31, x0, -1
fail_loop_28:
  beq x0, x0, fail_loop_28

fail_29:
  addi x30, x0, 29
  addi x31, x0, -1
fail_loop_29:
  beq x0, x0, fail_loop_29

fail_30:
  addi x30, x0, 30
  addi x31, x0, -1
fail_loop_30:
  beq x0, x0, fail_loop_30

fail_31:
  addi x30, x0, 31
  addi x31, x0, -1
fail_loop_31:
  beq x0, x0, fail_loop_31

fail_32:
  addi x30, x0, 32
  addi x31, x0, -1
fail_loop_32:
  beq x0, x0, fail_loop_32

fail_33:
  addi x30, x0, 33
  addi x31, x0, -1
fail_loop_33:
  beq x0, x0, fail_loop_33

fail_34:
  addi x30, x0, 34
  addi x31, x0, -1
fail_loop_34:
  beq x0, x0, fail_loop_34

fail_35:
  addi x30, x0, 35
  addi x31, x0, -1
fail_loop_35:
  beq x0, x0, fail_loop_35

fail_36:
  addi x30, x0, 36
  addi x31, x0, -1
fail_loop_36:
  beq x0, x0, fail_loop_36

fail_37:
  addi x30, x0, 37
  addi x31, x0, -1
fail_loop_37:
  beq x0, x0, fail_loop_37

fail_38:
  addi x30, x0, 38
  addi x31, x0, -1
fail_loop_38:
  beq x0, x0, fail_loop_38
