# TAG = xor
    .text

    lui x31, 0x12345 
    lui x30 , 0xFFF00      
    xor x31, x31, x30 
    lui x31 , 0x12345
    lui x30 , 0x01021
    xor x31 , x31 ,x30 
    lui x30 , 0x0
    xor x31 , x31 , x30

    # max_cycle 50
    # pout_start
    # 12345000 
    # EDC45000  
    # 12345000
    # 13364000 
    # 13364000
    # pout_end