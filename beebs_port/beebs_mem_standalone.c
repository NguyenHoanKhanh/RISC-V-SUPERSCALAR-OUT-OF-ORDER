#ifndef BEEBS_MEM_WORDS
#define BEEBS_MEM_WORDS 16
#endif

#include "beebs_finish_inline.h"

static volatile unsigned int data[BEEBS_MEM_WORDS];

void beebs_entry(void)
{
    unsigned int sum;
    unsigned int result;
    unsigned int expected;
    int status;

    data[0] = 1;
    data[1] = 2;
    data[2] = 3;
    data[3] = 4;
    data[4] = 5;
    data[5] = 6;
    data[6] = 7;
    data[7] = 8;
    data[8] = 9;
    data[9] = 10;
    data[10] = 11;
    data[11] = 12;
    data[12] = 13;
    data[13] = 14;
    data[14] = 15;
    data[15] = 16;

    sum = data[0] + data[1] + data[2] + data[3] +
          data[4] + data[5] + data[6] + data[7] +
          data[8] + data[9] + data[10] + data[11] +
          data[12] + data[13] + data[14] + data[15];

    result = sum;
    expected = (BEEBS_MEM_WORDS * (BEEBS_MEM_WORDS + 1)) / 2;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
