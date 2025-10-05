# TAG = andi
    .text

    lui x31, 0x10000   
    andi x31, x31, 0x100
    lui x31, 0x10000  
    andi x31, x31, 0x101
    andi x31, x31, 0
    lui x31 , 0x10000
    andi x31 , x31 , 2

    # max_cycle 50
    # pout_start
    # 10000000
    # 00000000
    # 10000000
    # 00000000
    # 00000000
    # 10000000
    # 00000000
    # pout_end