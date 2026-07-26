    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x7, x0, 77
    sw   x7, 0(x2)
    lw   x10, 0(x2)
    addi x11, x0, 77
    addi x0, x0, 0

    /* Lane-1 forward branch: BTFNT/default predicts not-taken, actual is taken. */
    beq  x0, x0, target

    /* Wrong path. These must be flushed by branch speculation restore. */
    addi x10, x0, -1
    addi x28, x0, 1
    addi x30, x0, 20
    addi x29, x0, -1
    jal  x0, done

target:
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
