    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    lui  x5, 0x1
    addi x5, x5, -2016

    sw   x5, 12(x2)
    lw   x14, 12(x2)

    addi x28, x0, 0
    addi x29, x0, 0
    addi x30, x0, 10
    bne  x14, x5, fail

pass:
    addi x28, x14, 0
    addi x29, x0, 1
    addi x30, x0, 99
    jal  x0, done

fail:
    addi x28, x14, 0
    addi x29, x0, -1
    addi x30, x0, 20

done:
    addi x0, x0, 0
    jal  x0, done
