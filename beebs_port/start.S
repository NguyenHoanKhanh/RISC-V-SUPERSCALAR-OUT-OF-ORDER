.section .text.start
.globl _start
_start:
    lui sp, 0x4
    addi sp, sp, -4
    jal x0, beebs_entry
