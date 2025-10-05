# TAG = lhu
    .text

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x12345
    addi x2, x2, 0x004
    sw x2, 0(x1)
    lhu x31, 0(x1)                
    lhu x31 , 2(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x67f9f
    addi x2, x2, 0x301
    sw x2, 4(x1)
    lhu x31, 6(x1)
    lhu x31 , 4(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0xABCDE
    addi x2, x2, 0x020
    sw x2, 8(x1)
    lhu x31, 8(x1)
    lhu x31 , 10(x1)
    lhu x31, 0(x0)

    # max_cycle 100
    # pout_start
    # 00005004
    # 00001234
    # 000067f9
    # 0000f301
    # 0000e020
    # 0000ABCD
    # 00000000
    # pout_end