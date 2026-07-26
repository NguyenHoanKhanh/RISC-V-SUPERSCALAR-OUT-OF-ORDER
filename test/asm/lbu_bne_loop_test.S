    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x5, x2, 32
    addi x12, x0, 8

    addi x7, x0, 68
    sb   x7, 0(x5)
    addi x7, x0, 72
    sb   x7, 1(x5)
    addi x7, x0, 82
    sb   x7, 2(x5)
    sb   x0, 3(x5)

loop:
    lbu  x13, 0(x5)
    addi x5, x5, 1
    addi x12, x12, -1
    beq  x12, x0, fail_guard
    bne  x13, x0, loop

pass:
    addi x28, x0, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail_guard:
    addi x28, x0, 4
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
