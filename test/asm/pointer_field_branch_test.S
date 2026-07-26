    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x5, x0, 320
    addi x6, x0, 2

    sw   x5, 0(x2)
    sw   x6, 8(x5)

    lw   x7, 0(x2)
    lw   x8, 8(x7)

    addi x9, x0, 2
    addi x28, x0, 0
    addi x29, x0, 0
    addi x30, x0, 10
    bne  x8, x9, fail

pass:
    addi x28, x8, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail:
    addi x28, x8, 0
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
