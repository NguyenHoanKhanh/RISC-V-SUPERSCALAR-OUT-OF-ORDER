    .section .text
    .globl _start

_start:
    addi x28, x0, -1
    jal  x0, pass

wrong_path:
    addi x28, x0, 123
    addi x29, x0, -1
    jal  x0, done

pass:
    addi x28, x0, 7
    addi x29, x0, 1

done:
    addi x0, x0, 0
    jal  x0, done
