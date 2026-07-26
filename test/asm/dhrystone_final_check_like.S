    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x5, x0, 512
    addi x6, x0, 640

    sw   x5, 0(x2)
    sw   x6, 4(x2)

    addi x7, x0, 5
    sw   x7, 8(x2)
    addi x7, x0, 1
    sw   x7, 12(x2)
    addi x7, x0, 65
    sw   x7, 16(x2)
    addi x7, x0, 66
    sw   x7, 20(x2)
    addi x7, x0, 7
    sw   x7, 24(x2)
    addi x7, x0, 14
    sw   x7, 28(x2)

    addi x7, x0, 0
    sw   x7, 4(x5)
    addi x7, x0, 2
    sw   x7, 8(x5)
    addi x7, x0, 17
    sw   x7, 12(x5)

    addi x7, x0, 0
    sw   x7, 4(x6)
    addi x7, x0, 1
    sw   x7, 8(x6)
    addi x7, x0, 18
    sw   x7, 12(x6)

    addi x28, x0, 0
    addi x29, x0, 0
    addi x30, x0, 10

    lw   x10, 8(x2)
    addi x11, x0, 5
    bne  x10, x11, fail1

    lw   x10, 12(x2)
    addi x11, x0, 1
    bne  x10, x11, fail2

    lw   x10, 16(x2)
    addi x11, x0, 65
    bne  x10, x11, fail3

    lw   x10, 20(x2)
    addi x11, x0, 66
    bne  x10, x11, fail4

    lw   x10, 24(x2)
    addi x11, x0, 7
    bne  x10, x11, fail5

    lw   x10, 28(x2)
    addi x11, x0, 14
    bne  x10, x11, fail6

    lw   x12, 0(x2)
    lw   x10, 4(x12)
    addi x11, x0, 0
    bne  x10, x11, fail7

    lw   x10, 8(x12)
    addi x11, x0, 2
    bne  x10, x11, fail8

    lw   x10, 12(x12)
    addi x11, x0, 17
    bne  x10, x11, fail9

    lw   x12, 4(x2)
    lw   x10, 4(x12)
    addi x11, x0, 0
    bne  x10, x11, fail10

    lw   x10, 8(x12)
    addi x11, x0, 1
    bne  x10, x11, fail11

    lw   x10, 12(x12)
    addi x11, x0, 18
    bne  x10, x11, fail12

pass:
    addi x28, x0, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail1:
    addi x28, x0, 1
    jal  x0, fail_common
fail2:
    addi x28, x0, 2
    jal  x0, fail_common
fail3:
    addi x28, x0, 3
    jal  x0, fail_common
fail4:
    addi x28, x0, 4
    jal  x0, fail_common
fail5:
    addi x28, x0, 5
    jal  x0, fail_common
fail6:
    addi x28, x0, 6
    jal  x0, fail_common
fail7:
    addi x28, x0, 7
    jal  x0, fail_common
fail8:
    addi x28, x0, 8
    jal  x0, fail_common
fail9:
    addi x28, x0, 9
    jal  x0, fail_common
fail10:
    addi x28, x0, 10
    jal  x0, fail_common
fail11:
    addi x28, x0, 11
    jal  x0, fail_common
fail12:
    addi x28, x0, 12

fail_common:
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
