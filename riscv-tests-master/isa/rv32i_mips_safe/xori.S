# Auto-generated RV32IM-clean benchmark.
# Source: rv32ui/xori.S
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
  addi x13, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x14, x13, -241
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 2
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
  addi x13, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x14, x13, 240
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 3
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
  addi x13, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 8
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x14, x13, 1807
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 4
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
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
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
  addi x13, x0, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  slli x13, x13, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x13, x13, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x14, x13, 240
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 5
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
  slli x11, x11, 4
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
  ori x11, x11, 7
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
  slli x11, x11, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x11, x11, 1807
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 6
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
  beq x11, x7, mips_safe_pass_6
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
  addi x1, x0, 15
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
  ori x1, x1, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
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
  ori x1, x1, 15
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
  xori x14, x1, 240
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
  beq x6, x7, mips_safe_pass_7
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
  addi x1, x0, 15
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
  ori x1, x1, 15
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
  ori x1, x1, 8
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
  ori x1, x1, 15
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
  ori x1, x1, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x14, x1, 1807
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
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x6, x7, mips_safe_pass_8
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
  addi x1, x0, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
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
  ori x1, x1, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x14, x1, 240
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
  beq x6, x7, mips_safe_pass_9
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
  addi x1, x0, 15
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
  ori x1, x1, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
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
  ori x1, x1, 15
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
  xori x14, x1, 240
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
  addi x1, x0, 15
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
  ori x1, x1, 15
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
  ori x1, x1, 15
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
  ori x1, x1, 15
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
  ori x1, x1, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  xori x14, x1, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 11
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
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
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
  addi x1, x0, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
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
  ori x1, x1, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  xori x14, x1, 240
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 12
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
  xori x1, x0, 240
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 13
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
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  addi x0, x0, 0  # mips_safe: branch operand padding
  beq x1, x7, mips_safe_pass_13
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
  addi x1, x0, 15
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
  ori x1, x1, 15
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  ori x1, x1, 15
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
  ori x1, x1, 15
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  xori x0, x1, 1807
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 14
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
  beq x0, x7, mips_safe_pass_14
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

