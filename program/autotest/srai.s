# TAG = srai
    .text

    lui x31, 0x12345    
    srai x31, x31, 0   
    srai x31, x31, 4   
    srai x31, x31, 4
    srai x31 , x31 , 12
    lui x31 , 0xFFF00
    srai x31 , x31 , 7

    # max_cycle 50
    # pout_start
    # 12345000
    # 12345000
    # 01234500
    # 00123450
    # 00000123
    # FFF00000
    # FFFFE000
    # pout_end