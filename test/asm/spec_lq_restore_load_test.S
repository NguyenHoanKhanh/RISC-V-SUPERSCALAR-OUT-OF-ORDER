    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x7, x0, 77
    sw   x7, 0(x2)

loop:
    lw   x10, 0(x2)
    addi x11, x0, 77

    /* Backward branch: BTFNT predicts taken, but actual is not taken. */
    bne  x0, x0, loop

    addi x12, x10, 0
    bne  x12, x11, fail

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
