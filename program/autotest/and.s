# TAG = and
    .text

    lui x31, 0x12345    
    lui x30, 0xfffff   
    and x31, x31, x30   
    lui x30, 0x0000f
    and x31, x31, x30   
    and x31, x31, x31   

    # max_cycle 50
    # pout_start
    # 12345000
    # 12345000
    # 00005000
    # 00005000
    # pout_end