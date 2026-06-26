# Auto-generated RV32IM-clean benchmark.
# Source: rv32ui/srl.S (part 1)
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
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 0
  srl x14, x11, x12
  # check test 2
  addi x7, x0, 8
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_2
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_3:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 1
  srl x14, x11, x12
  # check test 3
  addi x7, x0, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_3
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_4:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 7
  srl x14, x11, x12
  # check test 4
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_4
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_5:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 14
  srl x14, x11, x12
  # check test 5
  addi x7, x0, 2
  slli x7, x7, 4
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
  ori x11, x11, 1
  addi x12, x0, 1
  slli x12, x12, 4
  ori x12, x12, 15
  srl x14, x11, x12
  # check test 6
  addi x7, x0, 1
  bne x14, x7, fail_6
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_7:
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
  addi x12, x0, 0
  srl x14, x11, x12
  # check test 7
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
  bne x14, x7, fail_7
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_8:
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
  srl x14, x11, x12
  # check test 8
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
  bne x14, x7, fail_8
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_9:
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
  addi x12, x0, 7
  srl x14, x11, x12
  # check test 9
  addi x7, x0, 1
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
  addi x12, x0, 14
  srl x14, x11, x12
  # check test 10
  addi x7, x0, 3
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  slli x7, x7, 4
  ori x7, x7, 15
  bne x14, x7, fail_10
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_11:
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
  slli x12, x12, 4
  ori x12, x12, 15
  srl x14, x11, x12
  # check test 11
  addi x7, x0, 1
  bne x14, x7, fail_11
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_12:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  addi x12, x0, 0
  srl x14, x11, x12
  # check test 12
  addi x7, x0, 2
  slli x7, x7, 4
  ori x7, x7, 1
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 1
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 1
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 1
  bne x14, x7, fail_12
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_13:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  addi x12, x0, 1
  srl x14, x11, x12
  # check test 13
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 9
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 9
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 9
  slli x7, x7, 4
  bne x14, x7, fail_13
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_14:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  addi x12, x0, 7
  srl x14, x11, x12
  # check test 14
  addi x7, x0, 4
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 2
  bne x14, x7, fail_14
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_15:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  addi x12, x0, 14
  srl x14, x11, x12
  # check test 15
  addi x7, x0, 8
  slli x7, x7, 4
  ori x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 8
  slli x7, x7, 4
  ori x7, x7, 4
  bne x14, x7, fail_15
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_16:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  addi x12, x0, 1
  slli x12, x12, 4
  ori x12, x12, 15
  srl x14, x11, x12
  # check test 16
  addi x7, x0, 0
  bne x14, x7, fail_16
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_17:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
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
  ori x12, x12, 12
  slli x12, x12, 4
  srl x14, x11, x12
  # check test 17
  addi x7, x0, 2
  slli x7, x7, 4
  ori x7, x7, 1
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 1
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 1
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 1
  bne x14, x7, fail_17
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_18:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
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
  ori x12, x12, 12
  slli x12, x12, 4
  ori x12, x12, 1
  srl x14, x11, x12
  # check test 18
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 9
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 9
  slli x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 9
  slli x7, x7, 4
  bne x14, x7, fail_18
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_19:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
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
  ori x12, x12, 12
  slli x12, x12, 4
  ori x12, x12, 7
  srl x14, x11, x12
  # check test 19
  addi x7, x0, 4
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 2
  slli x7, x7, 4
  ori x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 2
  bne x14, x7, fail_19
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_20:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
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
  ori x12, x12, 12
  slli x12, x12, 4
  ori x12, x12, 14
  srl x14, x11, x12
  # check test 20
  addi x7, x0, 8
  slli x7, x7, 4
  ori x7, x7, 4
  slli x7, x7, 4
  ori x7, x7, 8
  slli x7, x7, 4
  ori x7, x7, 4
  bne x14, x7, fail_20
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_21:
  addi x11, x0, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
  slli x11, x11, 4
  ori x11, x11, 2
  slli x11, x11, 4
  ori x11, x11, 1
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
  srl x14, x11, x12
  # check test 21
  addi x7, x0, 0
  bne x14, x7, fail_21
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
