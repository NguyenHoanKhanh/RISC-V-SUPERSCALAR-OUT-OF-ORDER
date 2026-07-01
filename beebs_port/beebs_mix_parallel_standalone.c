#include "beebs_finish_inline.h"

static volatile unsigned int data[16];

#define BEEBS_MIX_STEP(k) \
    do { \
        a0 += data[0] + (k); \
        a1 += data[1] + ((k) << 1); \
        a2 += (data[2] << 1) + (k); \
        a3 += data[3] + data[4]; \
    } while (0)

void beebs_entry(void)
{
    unsigned int a0 = 0;
    unsigned int a1 = 0;
    unsigned int a2 = 0;
    unsigned int a3 = 0;
    unsigned int result;
    unsigned int expected;
    int status;

    data[0] = 1;
    data[1] = 2;
    data[2] = 3;
    data[3] = 4;
    data[4] = 5;
    data[8] = 0;
    data[9] = 0;

    BEEBS_MIX_STEP(0);
    BEEBS_MIX_STEP(1);
    BEEBS_MIX_STEP(2);
    BEEBS_MIX_STEP(3);
    BEEBS_MIX_STEP(4);
    BEEBS_MIX_STEP(5);
    BEEBS_MIX_STEP(6);
    BEEBS_MIX_STEP(7);
    BEEBS_MIX_STEP(8);
    BEEBS_MIX_STEP(9);
    BEEBS_MIX_STEP(10);
    BEEBS_MIX_STEP(11);
    BEEBS_MIX_STEP(12);
    BEEBS_MIX_STEP(13);
    BEEBS_MIX_STEP(14);
    BEEBS_MIX_STEP(15);

    data[8] = a0 + a1;
    data[9] = a2 + a3;

    result = data[8] + data[9];
    expected = 768;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
