.section .text
.globl beebs_finish
beebs_finish:
    addi x28, a0, 0
    addi x29, a1, 0
1:
    addi x0, x0, 0
    jal zero, 1b
