#ifndef BEEBS_ALU_PAR_ITERS
#define BEEBS_ALU_PAR_ITERS 128
#endif

#include "beebs_finish_inline.h"

#define BEEBS_KEEP_REG(x) __asm__ volatile ("" : "+r"(x))

void beebs_entry(void)
{
    unsigned int a0 = 0;
    unsigned int a1 = 0;
    unsigned int a2 = 0;
    unsigned int a3 = 0;
    unsigned int a4 = 0;
    unsigned int a5 = 0;
    unsigned int a6 = 0;
    unsigned int a7 = 0;
    unsigned int i;
    unsigned int result;
    unsigned int expected;
    int status;

    for (i = 0; i < BEEBS_ALU_PAR_ITERS; ++i) {
        a0 += i + 1;
        a1 += i + 2;
        a2 += i + 3;
        a3 += i + 4;
        a4 += i + 5;
        a5 += i + 6;
        a6 += i + 7;
        a7 += i + 8;

        BEEBS_KEEP_REG(a0);
        BEEBS_KEEP_REG(a1);
        BEEBS_KEEP_REG(a2);
        BEEBS_KEEP_REG(a3);
        BEEBS_KEEP_REG(a4);
        BEEBS_KEEP_REG(a5);
        BEEBS_KEEP_REG(a6);
        BEEBS_KEEP_REG(a7);
    }

    result = a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7;
    expected = 8 * ((BEEBS_ALU_PAR_ITERS * (BEEBS_ALU_PAR_ITERS + 1)) / 2)
             + 28 * BEEBS_ALU_PAR_ITERS;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
