    .section .text
    .globl _start
_start:
    li sp, 0x100
    li t0, 1
    sw t0, 0(sp)

    li a0, 0
    li a1, 0
    lw t1, 0(sp)
    beq t1, t0, target

    li x28, -1
    li x30, 20
    li x29, -1
    j done

target:
    li x28, 77
    li x30, 99
    li x29, 1

done:
    nop
