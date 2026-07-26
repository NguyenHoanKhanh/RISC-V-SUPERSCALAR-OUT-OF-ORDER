    .section .text
    .globl _start

_start:
    addi x2, x0, 512

    addi x10, x0, 2
    addi x11, x0, 3
    addi x12, x2, 20
    call proc7_like

    addi x30, x0, 13
    addi x30, x0, 140
    lw   x5, 20(x2)
    sw   x5, 28(x2)
    addi x30, x0, 150
    lw   x6, 28(x2)

    addi x7, x0, 7
    xor  x8, x6, x7
    sltiu x8, x8, 1
    slli x8, x8, 1
    addi x29, x8, -1
    addi x28, x6, 0
    jal  x0, done

proc7_like:
    addi x10, x10, 2
    add  x11, x10, x11
    sw   x11, 0(x12)
    jalr x0, 0(x1)

done:
    addi x0, x0, 0
    jal  x0, done
