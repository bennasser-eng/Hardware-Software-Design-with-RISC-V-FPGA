# TAG = slli
    .text

    lui x31, 0x12345    
    slli x31, x31, 0   
    slli x31, x31, 4   
    slli x31, x31, 4
    slli x31 , x31 , 12
    lui x31 , 0xFFF00
    slli x31 , x31 , 7
    # max_cycle 50
    # pout_start
    # 12345000
    # 12345000
    # 23450000
    # 34500000
    # 00000000
    # FFF00000
    # F8000000
    # pout_end