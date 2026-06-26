.section .text.start
.globl _start
_start:
    la sp, __stack_top
    j beebs_entry
