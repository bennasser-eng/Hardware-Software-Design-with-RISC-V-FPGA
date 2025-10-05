# TAG = slt
    .text


    lui x1, 0xFFFFF   
    lui x2, 0x00001   
    slt x31, x1, x2    


    lui x4, 0x00100   
    lui x5, 0x00101   
    slt x31, x4, x5    

    # max_cycle 50
    # pout_start
    # 00000001 
    # 00000001  
    # pout_end