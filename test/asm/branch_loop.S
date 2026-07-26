    .section .text
    .globl _start

_start:
    addi x5, x0, 4

loop:
    addi x5, x5, -1
    bne  x5, x0, loop

    addi x28, x5, 0
    addi x29, x0, 1

done:
    addi x0, x0, 0
    jal  x0, done
