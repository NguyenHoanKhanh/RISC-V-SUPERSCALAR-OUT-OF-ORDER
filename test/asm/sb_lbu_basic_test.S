    .section .text
    .globl _start

_start:
    addi x2, x0, 256

    # Write and read back byte lanes 0..3 in the same word.
    addi x5, x0, 68
    sb   x5, 0(x2)
    lbu  x10, 0(x2)
    bne  x10, x5, fail1

    addi x5, x0, 72
    sb   x5, 1(x2)
    lbu  x10, 1(x2)
    bne  x10, x5, fail2

    addi x5, x0, 82
    sb   x5, 2(x2)
    lbu  x10, 2(x2)
    bne  x10, x5, fail3

    addi x5, x0, 0
    sb   x5, 3(x2)
    lbu  x10, 3(x2)
    bne  x10, x5, fail4

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

fail_common:
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
