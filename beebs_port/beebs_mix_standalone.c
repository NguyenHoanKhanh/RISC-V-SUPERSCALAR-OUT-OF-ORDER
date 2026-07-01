#include "beebs_finish_inline.h"

static volatile unsigned int data[16];

void beebs_entry(void)
{
    unsigned int a;
    unsigned int b;
    unsigned int c;
    unsigned int d;
    unsigned int e;
    unsigned int f;
    unsigned int g;
    unsigned int h;
    unsigned int result;
    unsigned int expected;
    int status;

    data[0] = 3;
    data[1] = 5;
    data[2] = 12;
    data[3] = 10;
    data[4] = 7;
    data[5] = 11;
    data[6] = 4;
    data[7] = 9;
    data[8] = 0;
    data[9] = 0;
    data[10] = 4;
    data[11] = 9;
    data[12] = 6;
    data[13] = 2;
    data[14] = 15;
    data[15] = 1;

    a = data[0] + data[1];
    b = data[2] ^ data[3];
    c = data[4] << 1;
    d = data[5] + 7;
    e = a + c;
    f = b ^ d;

    data[8] = e;
    data[9] = f;

    g = data[8] + data[9];
    h = (data[10] + data[11]) ^ (data[12] + data[13]);

    result = g + h + data[14] + data[15];
    expected = 63;
    status = beebs_status_from_result(result, expected);

    beebs_finish_inline(result, status);
}
