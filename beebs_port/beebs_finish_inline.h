#ifndef BEEBS_FINISH_INLINE_H
#define BEEBS_FINISH_INLINE_H

static __inline__ int __attribute__((always_inline))
beebs_status_from_result(unsigned int result, unsigned int expected)
{
    unsigned int status;

    __asm__ volatile (
        "xor %0, %1, %2\n"
        "sltiu %0, %0, 1\n"
        "slli %0, %0, 1\n"
        "addi %0, %0, -1\n"
        : "=&r"(status)
        : "r"(result), "r"(expected)
    );

    return (int)status;
}

static __inline__ void __attribute__((always_inline, noreturn))
beebs_finish_inline(unsigned int result, int status)
{
    __asm__ volatile (
        "addi x28, %0, 0\n"
        "addi x29, %1, 0\n"
        "addi x0, x0, 0\n"
        "addi x0, x0, 0\n"
        "1:\n"
        "jal x0, 1b\n"
        :
        : "r"(result), "r"(status)
        : "x28", "x29", "memory"
    );

    __builtin_unreachable();
}

#endif
