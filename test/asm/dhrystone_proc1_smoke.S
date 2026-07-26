    .section .text
    .globl _start

_start:
    addi x2, x0, 512

    addi x10, x0, 640
    addi x11, x0, 768
    addi x20, x10, 0

    sw   x11, 0(x10)
    sw   x0,  4(x10)
    addi x5,  x0, 2
    sw   x5,  8(x10)
    addi x5,  x0, 17
    sw   x5,  12(x10)

    sw   x10, 0(x11)
    sw   x0,  4(x11)
    addi x5,  x0, 2
    sw   x5,  8(x11)
    addi x5,  x0, 18
    sw   x5,  12(x11)

    addi x30, x0, 14
    call proc1_like
    addi x30, x0, 15

    lw   x6, 0(x20)
    lw   x7, 12(x6)
    addi x8, x0, 29
    xor  x8, x7, x8
    sltiu x8, x8, 1
    slli x8, x8, 1
    addi x29, x8, -1
    addi x28, x7, 0
    jal  x0, done

proc1_like:
    addi x2, x2, -16
    sw   x1, 12(x2)
    sw   x8, 8(x2)
    addi x8, x10, 0

    lw   x5, 0(x8)
    sw   x0, 4(x5)
    addi x6, x0, 2
    sw   x6, 8(x5)
    addi x6, x0, 17
    sw   x6, 12(x5)

    addi x10, x0, 10
    lw   x11, 12(x5)
    addi x12, x5, 12
    call proc7_like

    lw   x6, 12(x5)
    addi x7, x0, 29
    bne  x6, x7, fail

    lw   x8, 8(x2)
    lw   x1, 12(x2)
    addi x2, x2, 16
    jalr x0, 0(x1)

proc7_like:
    addi x10, x10, 2
    add  x11, x10, x11
    sw   x11, 0(x12)
    jalr x0, 0(x1)

fail:
    addi x28, x6, 0
    addi x29, x0, -1
    jal  x0, done

done:
    addi x0, x0, 0
    jal  x0, done
