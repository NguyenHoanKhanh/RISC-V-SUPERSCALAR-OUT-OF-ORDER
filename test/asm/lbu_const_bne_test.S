    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x5, x2, 116
    addi x22, x0, 65

    sb   x22, 0(x5)
    lbu  x15, 0(x5)
    bne  x15, x22, fail

pass:
    addi x28, x15, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail:
    addi x28, x15, 0
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
