    .section .text
    .globl _start

_start:
    addi x2, x0, 256

    addi x7, x0, 5
    sw   x7, 8(x2)
    addi x7, x0, 1

    lw   x10, 8(x2)
    addi x11, x0, 5

    addi x28, x0, 0
    addi x29, x0, 0
    addi x30, x0, 10
    bne  x10, x11, fail

pass:
    addi x28, x10, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail:
    addi x28, x10, 0
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
