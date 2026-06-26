void initialise_benchmark(void);
int benchmark(void);
int verify_benchmark(int result);

void beebs_entry(void)
{
    int result;
    int ok;
    int status;
    int test_id;

    initialise_benchmark();
    result = benchmark();
    ok = verify_benchmark(result);

    status = ok ? 1 : -1;
    test_id = ok ? 0 : 1;

    __asm__ volatile (
        "mv x30, %0\n"
        "mv x31, %1\n"
        :
        : "r"(test_id), "r"(status)
        : "x30", "x31", "memory"
    );
}

