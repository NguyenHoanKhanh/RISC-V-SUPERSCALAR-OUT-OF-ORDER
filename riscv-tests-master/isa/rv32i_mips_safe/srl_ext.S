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

test_22:
  addi x11, x0, 8
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
  slli x11, x11, 4
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
  srl x11, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 22
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
  addi x11, x0, 8
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
  slli x11, x11, 4
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
  srl x12, x11, x12
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 23
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
  addi x11, x0, 7
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  srl x11, x11, x11
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 24
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 28
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 29
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 30
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 31
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 32
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
  addi x1, x0, 8
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
  slli x1, x1, 4
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
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 33
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
  addi x1, x0, 8
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 34
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
  addi x1, x0, 8
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 35
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
  addi x1, x0, 8
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  addi x0, x0, 0
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 36
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
  addi x1, x0, 8
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 37
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
  addi x1, x0, 8
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 38
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
  addi x1, x0, 8
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
  slli x1, x1, 4
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  srl x14, x1, x2
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  addi x0, x0, 0  # mips_safe: producer-result padding
  # check test 39
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
  srl x2, x0, x1
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
  srl x2, x1, x0
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
  srl x1, x0, x0
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
  srl x0, x1, x2
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

