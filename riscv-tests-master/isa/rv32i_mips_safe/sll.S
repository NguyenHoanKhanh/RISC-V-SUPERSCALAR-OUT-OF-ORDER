# Auto-generated RV32IM-clean benchmark.
# Source: rv32ui/sll.S
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
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x30, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
benchmark_start:
rv32im_perf_begin:

test_2:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 2
  addi x7, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_2
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
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
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_2:
  beq x0, x0, mips_safe_fail_loop_2
mips_safe_pass_2:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_3:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 3
  addi x7, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_3
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_3:
  addi x30, x0, 3
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_3:
  beq x0, x0, mips_safe_fail_loop_3
mips_safe_pass_3:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_4:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 4
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_4
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_4:
  addi x30, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_4:
  beq x0, x0, mips_safe_fail_loop_4
mips_safe_pass_4:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_5:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 5
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_5
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_5:
  addi x30, x0, 5
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_5:
  beq x0, x0, mips_safe_fail_loop_5
mips_safe_pass_5:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_6:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 6
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_6
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_6:
  addi x30, x0, 6
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_6:
  beq x0, x0, mips_safe_fail_loop_6
mips_safe_pass_6:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_7:
  addi x11, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 7
  addi x7, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_7
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_7:
  addi x30, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_7:
  beq x0, x0, mips_safe_fail_loop_7
mips_safe_pass_7:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_8:
  addi x11, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 8
  addi x7, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_8
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_8:
  addi x30, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_8:
  beq x0, x0, mips_safe_fail_loop_8
mips_safe_pass_8:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_9:
  addi x11, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 9
  addi x7, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_9
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_9:
  addi x30, x0, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_9:
  beq x0, x0, mips_safe_fail_loop_9
mips_safe_pass_9:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_10:
  addi x11, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 10
  addi x7, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_10
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_10:
  addi x30, x0, 10
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_10:
  beq x0, x0, mips_safe_fail_loop_10
mips_safe_pass_10:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_11:
  addi x11, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 11
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_11
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_11:
  addi x30, x0, 11
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_11:
  beq x0, x0, mips_safe_fail_loop_11
mips_safe_pass_11:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_12:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 12
  addi x7, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_12
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_12:
  addi x30, x0, 12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_12:
  beq x0, x0, mips_safe_fail_loop_12
mips_safe_pass_12:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_13:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 13
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_13
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_13:
  addi x30, x0, 13
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_13:
  beq x0, x0, mips_safe_fail_loop_13
mips_safe_pass_13:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_14:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 14
  addi x7, x0, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_14
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_14:
  addi x30, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_14:
  beq x0, x0, mips_safe_fail_loop_14
mips_safe_pass_14:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_15:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 15
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_15
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_15:
  addi x30, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_15:
  beq x0, x0, mips_safe_fail_loop_15
mips_safe_pass_15:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_16:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 16
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_16
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_16:
  addi x30, x0, 16
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_16:
  beq x0, x0, mips_safe_fail_loop_16
mips_safe_pass_16:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_17:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 17
  addi x7, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_17
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_17:
  addi x30, x0, 17
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_17:
  beq x0, x0, mips_safe_fail_loop_17
mips_safe_pass_17:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_18:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 18
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_18
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_18:
  addi x30, x0, 18
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_18:
  beq x0, x0, mips_safe_fail_loop_18
mips_safe_pass_18:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_19:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 19
  addi x7, x0, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_19
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_19:
  addi x30, x0, 19
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_19:
  beq x0, x0, mips_safe_fail_loop_19
mips_safe_pass_19:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_20:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 20
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_20
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_20:
  addi x30, x0, 20
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_20:
  beq x0, x0, mips_safe_fail_loop_20
mips_safe_pass_20:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_21:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 21
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_21
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_21:
  addi x30, x0, 21
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_21:
  beq x0, x0, mips_safe_fail_loop_21
mips_safe_pass_21:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_50:
    addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    addi x12, x0, 3
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    ori x12, x12, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    # check test 50
    addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
    beq x14, x7, mips_safe_pass_50
    # mips_safe: taken-branch recovery cushion before local fail path
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
fail_50:
    addi x30, x0, 50
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x0, x0, 0  # mips_safe: fail scoreboard padding
    addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_50:
    beq x0, x0, mips_safe_fail_loop_50
mips_safe_pass_50:
    addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_51:
  addi x11, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 51
  addi x7, x0, -128
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_51
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_51:
  addi x30, x0, 51
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_51:
  beq x0, x0, mips_safe_fail_loop_51
mips_safe_pass_51:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_52:
  addi x11, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x11, x11, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x12, x12, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x12, x12, 11
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 52
  addi x7, x0, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 9
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_52
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_52:
  addi x30, x0, 52
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_52:
  beq x0, x0, mips_safe_fail_loop_52
mips_safe_pass_52:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_22:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x11, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 22
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x11, x7, mips_safe_pass_22
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
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
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_22:
  beq x0, x0, mips_safe_fail_loop_22
mips_safe_pass_22:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_23:
  addi x11, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x12, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x12, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 23
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x12, x7, mips_safe_pass_23
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_23:
  addi x30, x0, 23
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_23:
  beq x0, x0, mips_safe_fail_loop_23
mips_safe_pass_23:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_24:
  addi x11, x0, 3
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x11, x11, x11
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 24
  addi x7, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x7, x7, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x11, x7, mips_safe_pass_24
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_24:
  addi x30, x0, 24
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_24:
  beq x0, x0, mips_safe_fail_loop_24
mips_safe_pass_24:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_25:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x6, x14, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 25
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x6, x7, mips_safe_pass_25
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_25:
  addi x30, x0, 25
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_25:
  beq x0, x0, mips_safe_fail_loop_25
mips_safe_pass_25:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_26:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x6, x14, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 26
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x6, x7, mips_safe_pass_26
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_26:
  addi x30, x0, 26
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_26:
  beq x0, x0, mips_safe_fail_loop_26
mips_safe_pass_26:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_27:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x2, x2, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  addi x6, x14, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 27
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x6, x7, mips_safe_pass_27
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_27:
  addi x30, x0, 27
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_27:
  beq x0, x0, mips_safe_fail_loop_27
mips_safe_pass_27:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_28:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 28
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_28
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_28:
  addi x30, x0, 28
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_28:
  beq x0, x0, mips_safe_fail_loop_28
mips_safe_pass_28:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_29:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 29
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_29
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_29:
  addi x30, x0, 29
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_29:
  beq x0, x0, mips_safe_fail_loop_29
mips_safe_pass_29:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_30:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x2, x2, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 30
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_30
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_30:
  addi x30, x0, 30
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_30:
  beq x0, x0, mips_safe_fail_loop_30
mips_safe_pass_30:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_31:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x2, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 31
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_31
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_31:
  addi x30, x0, 31
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_31:
  beq x0, x0, mips_safe_fail_loop_31
mips_safe_pass_31:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_32:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x2, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 32
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_32
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_32:
  addi x30, x0, 32
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_32:
  beq x0, x0, mips_safe_fail_loop_32
mips_safe_pass_32:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_33:
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  addi x2, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x2, x2, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 33
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_33
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_33:
  addi x30, x0, 33
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_33:
  beq x0, x0, mips_safe_fail_loop_33
mips_safe_pass_33:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_34:
  addi x2, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 34
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_34
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_34:
  addi x30, x0, 34
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_34:
  beq x0, x0, mips_safe_fail_loop_34
mips_safe_pass_34:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_35:
  addi x2, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 35
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_35
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_35:
  addi x30, x0, 35
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_35:
  beq x0, x0, mips_safe_fail_loop_35
mips_safe_pass_35:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_36:
  addi x2, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x2, x2, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 36
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_36
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_36:
  addi x30, x0, 36
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_36:
  beq x0, x0, mips_safe_fail_loop_36
mips_safe_pass_36:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_37:
  addi x2, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 37
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_37
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_37:
  addi x30, x0, 37
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_37:
  beq x0, x0, mips_safe_fail_loop_37
mips_safe_pass_37:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_38:
  addi x2, x0, 14
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 38
  addi x7, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_38
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_38:
  addi x30, x0, 38
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_38:
  beq x0, x0, mips_safe_fail_loop_38
mips_safe_pass_38:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_39:
  addi x2, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x2, x2, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  addi x1, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 39
  addi x7, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x14, x7, mips_safe_pass_39
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_39:
  addi x30, x0, 39
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_39:
  beq x0, x0, mips_safe_fail_loop_39
mips_safe_pass_39:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_40:
  addi x1, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x2, x0, x1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 40
  addi x7, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x2, x7, mips_safe_pass_40
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_40:
  addi x30, x0, 40
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_40:
  beq x0, x0, mips_safe_fail_loop_40
mips_safe_pass_40:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_41:
  addi x1, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x2, x1, x0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 41
  addi x7, x0, 2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x7, x7, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x2, x7, mips_safe_pass_41
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_41:
  addi x30, x0, 41
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_41:
  beq x0, x0, mips_safe_fail_loop_41
mips_safe_pass_41:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_42:
  sll x1, x0, x0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 42
  addi x7, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x1, x7, mips_safe_pass_42
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_42:
  addi x30, x0, 42
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_42:
  beq x0, x0, mips_safe_fail_loop_42
mips_safe_pass_42:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

test_43:
  addi x1, x0, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x2, x0, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x2, x2, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  sll x0, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 43
  addi x7, x0, 0
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x0, x7, mips_safe_pass_43
  # mips_safe: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
fail_43:
  addi x30, x0, 43
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x0, x0, 0  # mips_safe: fail scoreboard padding
  addi x31, x0, -1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
mips_safe_fail_loop_43:
  beq x0, x0, mips_safe_fail_loop_43
mips_safe_pass_43:
  addi x0, x0, 0
  # branch delay slot padding: lane after branch must be harmless
  addi x0, x0, 0

benchmark_end:
rv32im_perf_end:
pass:
rv32im_scoreboard_finalize:
  addi x31, x0, 1
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
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

