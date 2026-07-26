    .section .text
    .globl _start

_start:
    addi x2, x0, 256

    # str1 = "DHRYSTONE PROGRAM, 1'ST STRING"
    # str2 = "DHRYSTONE PROGRAM, 2'ND STRING"
    # Only the beginning and the first differing byte are needed here.
    addi x5, x2, 16
    addi x6, x2, 64

    addi x7, x0, 68      # D
    sb   x7, 0(x5)
    sb   x7, 0(x6)
    addi x7, x0, 72      # H
    sb   x7, 1(x5)
    sb   x7, 1(x6)
    addi x7, x0, 82      # R
    sb   x7, 2(x5)
    sb   x7, 2(x6)
    addi x7, x0, 89      # Y
    sb   x7, 3(x5)
    sb   x7, 3(x6)
    addi x7, x0, 49      # '1'
    sb   x7, 4(x5)
    addi x7, x0, 50      # '2'
    sb   x7, 4(x6)
    sb   x0, 5(x5)
    sb   x0, 5(x6)

    addi x10, x5, 0
    addi x11, x6, 0
    jal  x1, func2_like

    # Expected func2_like result is 0 because str1 < str2.
    addi x12, x0, 0
    bne  x10, x12, fail

pass:
    addi x28, x0, 0
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

fail:
    addi x28, x10, 0
    addi x30, x0, 20
    addi x29, x0, -1
    jal  x0, done

func2_like:
    addi x2, x2, -16
    sw   x1, 12(x2)
    lbu  x14, 2(x10)
    lbu  x15, 3(x11)
    beq  x15, x14, func2_equal_path
    jal  x1, strcmp_like
    addi x15, x0, 0
    bge  x0, x10, func2_ret
    addi x15, x0, 1

func2_ret:
    lw   x1, 12(x2)
    addi x10, x15, 0
    addi x2, x2, 16
    jalr x0, 0(x1)

func2_equal_path:
    addi x15, x0, 1
    jal  x0, func2_ret

strcmp_like:
    lbu  x13, 0(x10)
    lbu  x14, 0(x11)
    bne  x13, x14, strcmp_diff
    beq  x13, x0, strcmp_equal
    addi x10, x10, 1
    addi x11, x11, 1
    jal  x0, strcmp_like

strcmp_diff:
    sub  x10, x13, x14
    jalr x0, 0(x1)

strcmp_equal:
    addi x10, x0, 0
    jalr x0, 0(x1)

done:
    addi x0, x0, 0
    jal  x0, done
