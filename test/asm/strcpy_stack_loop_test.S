    .section .text
    .globl _start

_start:
    addi x2, x0, 256

    # Build a source string in memory, then copy it to stack-like memory using
    # the same lbu/sb/bne-zero loop shape generated in Dhrystone main.
    addi x5, x2, 96      # src
    addi x6, x2, 16      # dst
    addi x12, x0, 8      # bounded copy guard

    addi x7, x0, 68      # D
    sb   x7, 0(x5)
    addi x7, x0, 72      # H
    sb   x7, 1(x5)
    addi x7, x0, 82      # R
    sb   x7, 2(x5)
    addi x7, x0, 89      # Y
    sb   x7, 3(x5)
    addi x7, x0, 50      # 2
    sb   x7, 4(x5)
    sb   x0, 5(x5)

copy_loop:
    lbu  x13, 0(x5)
    addi x6, x6, 1
    addi x5, x5, 1
    sb   x13, -1(x6)
    addi x12, x12, -1
    beq  x12, x0, fail4
    bne  x13, x0, copy_loop

    # Check copied bytes. x28 is the failing check number.
    addi x5, x2, 16
    lbu  x10, 0(x5)
    addi x11, x0, 68
    bne  x10, x11, fail1
    lbu  x10, 4(x5)
    addi x11, x0, 50
    bne  x10, x11, fail2
    lbu  x10, 5(x5)
    bne  x10, x0, fail3

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
