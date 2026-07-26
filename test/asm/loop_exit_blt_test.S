    .section .text
    .globl _start

_start:
    addi x5, x0, 1      # loop index = 1
    addi x6, x0, 1      # runs = 1
    addi x28, x0, 0

loop_body:
    addi x30, x0, 10    # body marker
    addi x28, x5, 0     # expose current loop index
    addi x5, x5, 1      # ++index
    blt  x6, x5, pass   # runs < index, exit after one iteration

    addi x30, x0, 20    # fail marker: branch did not exit
    addi x29, x0, -1
    jal  x0, done

pass:
    addi x30, x0, 99
    addi x29, x0, 1

done:
    addi x0, x0, 0
    jal  x0, done
