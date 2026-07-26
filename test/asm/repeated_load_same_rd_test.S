    .section .text
    .globl _start

_start:
    addi x2, x0, 256

    addi x13, x0, 5
    addi x14, x0, 1
    addi x15, x0, 65

    sw   x13, 8(x2)
    sw   x14, 12(x2)
    sw   x15, 16(x2)

    lw   x10, 8(x2)
    addi x11, x0, 5
    bne  x10, x11, fail1

    lw   x10, 12(x2)
    addi x11, x0, 1
    bne  x10, x11, fail2

    lw   x10, 16(x2)
    addi x11, x0, 65
    bne  x10, x11, fail3

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

fail_common:
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
