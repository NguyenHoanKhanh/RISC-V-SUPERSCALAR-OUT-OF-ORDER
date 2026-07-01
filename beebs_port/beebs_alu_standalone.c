#ifndef BEEBS_ALU_ITERS
#define BEEBS_ALU_ITERS 64
#endif

#include "beebs_finish_inline.h"

void beebs_entry(void)
{
    volatile unsigned int acc = 0;
    unsigned int i;
    unsigned int result;
    unsigned int expected;
    int status;

    for (i = 0; i < BEEBS_ALU_ITERS; ++i) {
        acc += i + 1;
    }

    result = acc;
    expected = (BEEBS_ALU_ITERS * (BEEBS_ALU_ITERS + 1)) / 2;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
