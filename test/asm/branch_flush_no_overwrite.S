    .section .text
    .globl _start

_start:
    addi x27, x0, 0
    addi x30, x0, 10
    addi x5,  x0, 1
    addi x6,  x0, 1

    beq  x5, x6, pass

wrong_path:
    addi x30, x0, 20
    addi x27, x0, 123
    jal  x0, done

pass:
    addi x30, x0, 99
    addi x28, x0, 7

    addi x7,  x0, 0
    xor  x8,  x27, x7
    sltiu x8, x8, 1
    slli x8, x8, 1
    addi x29, x8, -1

done:
    addi x0, x0, 0
    jal  x0, done
