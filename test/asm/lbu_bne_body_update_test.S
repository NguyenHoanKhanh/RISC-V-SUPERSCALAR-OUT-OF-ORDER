    .section .text
    .globl _start

_start:
    addi x2, x0, 256
    addi x9, x2, 116      # byte source address, mirrors 116(s1)
    addi x22, x0, 65      # expected byte
    addi x18, x0, 1       # running value, mirrors s2

    sb   x22, 0(x9)
    addi x10, x0, 5
    sw   x10, -12(x9)     # word at 104(s1)

    lbu  x15, 0(x9)
    bne  x15, x22, skip_update
    lw   x15, -12(x9)
    addi x18, x18, 9
    sub  x18, x18, x15

skip_update:
    addi x11, x0, 5
    bne  x18, x11, fail

pass:
    addi x28, x18, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail:
    addi x28, x18, 0
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
