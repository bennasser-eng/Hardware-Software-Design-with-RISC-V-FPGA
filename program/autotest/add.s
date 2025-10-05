# TAG = add
    .text

    lui x31, 0
    lui x1 , 0x12345
    add x31, x1, x31
    add x31, x1, x0
   

    # max_cycle 50
    # pout_start
    # 00000000
    # 12345000
    # 12345000
    # pout_end