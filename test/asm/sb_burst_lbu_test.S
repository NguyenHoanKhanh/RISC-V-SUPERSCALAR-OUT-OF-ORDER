    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x5, x2, 32

    # Burst byte stores before any load, matching the source-string setup used
    # by strcpy_stack_loop_test.
    addi x7, x0, 68
    sb   x7, 0(x5)
    addi x7, x0, 72
    sb   x7, 1(x5)
    addi x7, x0, 82
    sb   x7, 2(x5)
    addi x7, x0, 89
    sb   x7, 3(x5)
    addi x7, x0, 50
    sb   x7, 4(x5)
    sb   x0, 5(x5)

    lbu  x10, 0(x5)
    addi x11, x0, 68
    bne  x10, x11, fail1
    lbu  x10, 1(x5)
    addi x11, x0, 72
    bne  x10, x11, fail2
    lbu  x10, 2(x5)
    addi x11, x0, 82
    bne  x10, x11, fail3
    lbu  x10, 3(x5)
    addi x11, x0, 89
    bne  x10, x11, fail4
    lbu  x10, 4(x5)
    addi x11, x0, 50
    bne  x10, x11, fail5
    lbu  x10, 5(x5)
    bne  x10, x0, fail6

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

fail_common:
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
