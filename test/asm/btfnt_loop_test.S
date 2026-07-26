    .section .text
    .globl _start

_start:
    addi x5,  x0, 3
    addi x28, x0, 0
    addi x30, x0, 10

loop:
    addi x28, x28, 1
    addi x5,  x5, -1
    bne  x5,  x0, loop

pass:
    addi x30, x0, 99
    addi x29, x0, 1
    jal  x0, done

wrong_path:
    addi x30, x0, 20
    addi x29, x0, -1

done:
    addi x0, x0, 0
    jal  x0, done
