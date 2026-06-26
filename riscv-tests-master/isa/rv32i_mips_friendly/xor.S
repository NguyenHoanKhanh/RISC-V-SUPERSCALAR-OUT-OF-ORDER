# Auto-generated RV32I MIPS-friendly benchmark.
# Purpose: keep producer/consumer spacing safe for the in-order source,
# but replace a small fraction of NOP padding with independent useful instructions.

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
  # friendly: scoreboard init spacing
  addi x20, x0, 3
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x30, x0, 0
  # friendly: scoreboard init spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 59
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
benchmark_start:
rv32im_perf_begin:

test_2:
  addi x11, x0, 0
  # friendly: source register spacing
  addi x20, x0, 3
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x12, x0, 0
  # friendly: source register spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 59
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  xor x14, x11, x12
  # friendly: producer-result spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x22, x0, 115
  addi x0, x0, 0
  addi x7, x0, 0
  # friendly: branch operand spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x23, x0, 171
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x24, x0, 227
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x25, x0, 283
  addi x0, x0, 0
  beq x14, x7, mips_friendly_pass_2
  # friendly: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x26, x0, 339
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x27, x0, 395
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x28, x0, 451
  addi x0, x0, 0
fail_2:
  addi x30, x0, 2
  # friendly: useful fail-path cushion
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x29, x0, 507
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x31, x0, -1
fail_loop_2:
  beq x0, x0, fail_loop_2
  addi x0, x0, 0

mips_friendly_pass_2:

test_3:
  addi x11, x0, 1
  # friendly: source register spacing
  addi x20, x0, 563
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x12, x0, 2
  # friendly: source register spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 619
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  xor x14, x11, x12
  # friendly: producer-result spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x22, x0, 675
  addi x0, x0, 0
  addi x7, x0, 3
  # friendly: branch operand spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x23, x0, 731
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x24, x0, 787
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x25, x0, 843
  addi x0, x0, 0
  beq x14, x7, mips_friendly_pass_3
  # friendly: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x26, x0, 899
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x27, x0, 955
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x28, x0, 1011
  addi x0, x0, 0
fail_3:
  addi x30, x0, 3
  # friendly: useful fail-path cushion
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x29, x0, 1067
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x31, x0, -1
fail_loop_3:
  beq x0, x0, fail_loop_3
  addi x0, x0, 0

mips_friendly_pass_3:

test_4:
  addi x11, x0, 7
  # friendly: source register spacing
  addi x20, x0, 1123
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x12, x0, 5
  # friendly: source register spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 1179
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  xor x14, x11, x12
  # friendly: producer-result spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x22, x0, 1235
  addi x0, x0, 0
  addi x7, x0, 2
  # friendly: branch operand spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x23, x0, 1291
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x24, x0, 1347
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x25, x0, 1403
  addi x0, x0, 0
  beq x14, x7, mips_friendly_pass_4
  # friendly: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x26, x0, 1459
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x27, x0, 1515
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x28, x0, 1571
  addi x0, x0, 0
fail_4:
  addi x30, x0, 4
  # friendly: useful fail-path cushion
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x29, x0, 1627
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x31, x0, -1
fail_loop_4:
  beq x0, x0, fail_loop_4
  addi x0, x0, 0

mips_friendly_pass_4:

test_5:
  addi x11, x0, -4
  # friendly: source register spacing
  addi x20, x0, 1683
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x12, x0, 9
  # friendly: source register spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 1739
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  xor x14, x11, x12
  # friendly: producer-result spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x22, x0, 1795
  addi x0, x0, 0
  addi x7, x0, -11
  # friendly: branch operand spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x23, x0, 1851
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x24, x0, 1907
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x25, x0, 1963
  addi x0, x0, 0
  beq x14, x7, mips_friendly_pass_5
  # friendly: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x26, x0, 2019
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x27, x0, 27
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x28, x0, 83
  addi x0, x0, 0
fail_5:
  addi x30, x0, 5
  # friendly: useful fail-path cushion
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x29, x0, 139
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x31, x0, -1
fail_loop_5:
  beq x0, x0, fail_loop_5
  addi x0, x0, 0

mips_friendly_pass_5:

test_6:
  addi x11, x0, 31
  # friendly: source register spacing
  addi x20, x0, 195
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x12, x0, -8
  # friendly: source register spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 251
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  xor x14, x11, x12
  # friendly: producer-result spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x22, x0, 307
  addi x0, x0, 0
  addi x7, x0, -25
  # friendly: branch operand spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x23, x0, 363
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x24, x0, 419
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x25, x0, 475
  addi x0, x0, 0
  beq x14, x7, mips_friendly_pass_6
  # friendly: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x26, x0, 531
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x27, x0, 587
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x28, x0, 643
  addi x0, x0, 0
fail_6:
  addi x30, x0, 6
  # friendly: useful fail-path cushion
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x29, x0, 699
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x31, x0, -1
fail_loop_6:
  beq x0, x0, fail_loop_6
  addi x0, x0, 0

mips_friendly_pass_6:

test_7:
  addi x11, x0, -12
  # friendly: source register spacing
  addi x20, x0, 755
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x12, x0, -3
  # friendly: source register spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x21, x0, 811
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  xor x14, x11, x12
  # friendly: producer-result spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x22, x0, 867
  addi x0, x0, 0
  addi x7, x0, 9
  # friendly: branch operand spacing
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x23, x0, 923
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x24, x0, 979
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x25, x0, 1035
  addi x0, x0, 0
  beq x14, x7, mips_friendly_pass_7
  # friendly: taken-branch recovery cushion before local fail path
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x26, x0, 1091
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x27, x0, 1147
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x28, x0, 1203
  addi x0, x0, 0
fail_7:
  addi x30, x0, 7
  # friendly: useful fail-path cushion
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x29, x0, 1259
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x0, x0, 0
  addi x31, x0, -1
fail_loop_7:
  beq x0, x0, fail_loop_7
  addi x0, x0, 0

mips_friendly_pass_7:

rv32im_scoreboard_finalize:
benchmark_end:
rv32im_perf_end:
  addi x31, x0, 1
pass_loop:
  beq x0, x0, pass_loop
  addi x0, x0, 0

