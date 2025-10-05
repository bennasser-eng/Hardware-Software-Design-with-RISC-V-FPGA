# TAG = or
    .text

    lui x31, 0x12345 
    lui x30 , 0xFFF00      
    or x31, x31, x30 
    lui x31 , 0x12345
    lui x30 , 0x01021
    or x31 , x31 ,x30 
    lui x30 , 0x0
    or x31 , x31 , x30


    # max_cycle 50
    # pout_start
    # 12345000  
    # FFF45000
    # 12345000
    # 13365000
    # 13365000
    # pout_end