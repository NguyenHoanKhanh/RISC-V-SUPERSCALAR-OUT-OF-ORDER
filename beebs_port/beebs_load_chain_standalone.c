#include "beebs_finish_inline.h"

static volatile unsigned int data[4];

#define BEEBS_LOAD_STEP(idx) \
    do { \
        value = data[(idx)]; \
        acc = acc + value; \
    } while (0)

void beebs_entry(void)
{
    unsigned int acc = 0;
    unsigned int value;
    unsigned int result;
    unsigned int expected;
    int status;

    data[0] = 1;
    data[1] = 2;
    data[2] = 3;
    data[3] = 4;

    BEEBS_LOAD_STEP(0);
    BEEBS_LOAD_STEP(1);
    BEEBS_LOAD_STEP(2);
    BEEBS_LOAD_STEP(3);
    BEEBS_LOAD_STEP(0);
    BEEBS_LOAD_STEP(1);
    BEEBS_LOAD_STEP(2);
    BEEBS_LOAD_STEP(3);
    BEEBS_LOAD_STEP(0);
    BEEBS_LOAD_STEP(1);
    BEEBS_LOAD_STEP(2);
    BEEBS_LOAD_STEP(3);
    BEEBS_LOAD_STEP(0);
    BEEBS_LOAD_STEP(1);
    BEEBS_LOAD_STEP(2);
    BEEBS_LOAD_STEP(3);

    result = acc;
    expected = 40;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
