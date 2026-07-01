#ifndef BEEBS_BRANCH_ITERS
#define BEEBS_BRANCH_ITERS 32
#endif

#include "beebs_finish_inline.h"

void beebs_entry(void)
{
    volatile unsigned int acc = 0;
    unsigned int i;
    unsigned int result;
    unsigned int expected;
    int status;

    for (i = 0; i < BEEBS_BRANCH_ITERS; ++i) {
        if (i & 1) {
            acc += 3;
        } else {
            acc += 1;
        }
    }

    result = acc;
    expected = (BEEBS_BRANCH_ITERS / 2) * 4;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
