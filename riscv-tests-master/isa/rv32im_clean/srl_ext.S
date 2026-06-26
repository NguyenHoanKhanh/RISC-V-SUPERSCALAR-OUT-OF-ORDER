# Auto-generated RV32IM-clean benchmark.
# Source: rv32ui/srl.S (part 2)
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

test_22:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 7
  srl x11, x11, x12
  # check test 22
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x11, x7, fail_22
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_23:
  addi x11, x0, 8
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  slli x11, x11, 4
  addi x12, x0, 14
  srl x12, x11, x12
  # check test 23
  addi x7, x0, 2
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x12, x7, fail_23
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_24:
  addi x11, x0, 7
  srl x11, x11, x11
  # check test 24
  addi x7, x0, 0
  bne x11, x7, fail_24
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_25:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 7
  srl x14, x1, x2
  addi x6, x14, 0
  # check test 25
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x6, x7, fail_25
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_26:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 14
  srl x14, x1, x2
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 26
  addi x7, x0, 2
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x6, x7, fail_26
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_27:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 1
  slli x2, x2, 4
  ori x2, x2, 15
  srl x14, x1, x2
  addi x0, x0, 0
  addi x0, x0, 0
  addi x6, x14, 0
  # check test 27
  addi x7, x0, 1
  bne x6, x7, fail_27
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_28:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 7
  srl x14, x1, x2
  # check test 28
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_28
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_29:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 14
  addi x0, x0, 0
  srl x14, x1, x2
  # check test 29
  addi x7, x0, 2
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_29
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_30:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 1
  slli x2, x2, 4
  ori x2, x2, 15
  addi x0, x0, 0
  addi x0, x0, 0
  srl x14, x1, x2
  # check test 30
  addi x7, x0, 1
  bne x14, x7, fail_30
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_31:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x0, x0, 0
  addi x2, x0, 7
  srl x14, x1, x2
  # check test 31
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_31
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_32:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x0, x0, 0
  addi x2, x0, 14
  addi x0, x0, 0
  srl x14, x1, x2
  # check test 32
  addi x7, x0, 2
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_32
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_33:
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x0, x0, 0
  addi x0, x0, 0
  addi x2, x0, 1
  slli x2, x2, 4
  ori x2, x2, 15
  srl x14, x1, x2
  # check test 33
  addi x7, x0, 1
  bne x14, x7, fail_33
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_34:
  addi x2, x0, 7
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  srl x14, x1, x2
  # check test 34
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_34
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_35:
  addi x2, x0, 14
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x0, x0, 0
  srl x14, x1, x2
  # check test 35
  addi x7, x0, 2
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_35
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_36:
  addi x2, x0, 1
  slli x2, x2, 4
  ori x2, x2, 15
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x0, x0, 0
  addi x0, x0, 0
  srl x14, x1, x2
  # check test 36
  addi x7, x0, 1
  bne x14, x7, fail_36
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_37:
  addi x2, x0, 7
  addi x0, x0, 0
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  srl x14, x1, x2
  # check test 37
  addi x7, x0, 1
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_37
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_38:
  addi x2, x0, 14
  addi x0, x0, 0
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x0, x0, 0
  srl x14, x1, x2
  # check test 38
  addi x7, x0, 2
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  slli x7, x7, 4
  bne x14, x7, fail_38
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_39:
  addi x2, x0, 1
  slli x2, x2, 4
  ori x2, x2, 15
  addi x0, x0, 0
  addi x0, x0, 0
  addi x1, x0, 8
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  slli x1, x1, 4
  srl x14, x1, x2
  # check test 39
  addi x7, x0, 1
  bne x14, x7, fail_39
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_40:
  addi x1, x0, 15
  srl x2, x0, x1
  # check test 40
  addi x7, x0, 0
  bne x2, x7, fail_40
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_41:
  addi x1, x0, 2
  slli x1, x1, 4
  srl x2, x1, x0
  # check test 41
  addi x7, x0, 2
  slli x7, x7, 4
  bne x2, x7, fail_41
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_42:
  srl x1, x0, x0
  # check test 42
  addi x7, x0, 0
  bne x1, x7, fail_42
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_43:
  addi x1, x0, 4
  slli x1, x1, 4
  slli x1, x1, 4
  addi x2, x0, 8
  slli x2, x2, 4
  slli x2, x2, 4
  srl x0, x1, x2
  # check test 43
  addi x7, x0, 0
  bne x0, x7, fail_43
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

fail_39:
  addi x30, x0, 39
  addi x31, x0, -1
fail_loop_39:
  beq x0, x0, fail_loop_39

fail_40:
  addi x30, x0, 40
  addi x31, x0, -1
fail_loop_40:
  beq x0, x0, fail_loop_40

fail_41:
  addi x30, x0, 41
  addi x31, x0, -1
fail_loop_41:
  beq x0, x0, fail_loop_41

fail_42:
  addi x30, x0, 42
  addi x31, x0, -1
fail_loop_42:
  beq x0, x0, fail_loop_42

fail_43:
  addi x30, x0, 43
  addi x31, x0, -1
fail_loop_43:
  beq x0, x0, fail_loop_43
