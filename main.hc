U0 Main(I32 argc, U8 **argv)
{
    for (I32 i = 0; i < argc; ++i) {
        "[%d] => %s\n", i, argv[i];
    }

    return 0;
}