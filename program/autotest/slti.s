# TAG = slti
    .text
    lui x1, 0xFFFFF     
    slt x31, x1, 000  


    lui x4, 0x00100   
    slt x31, x4, 005 
    
    lui x5, 0x00101
    slt x30 , x5 , 000
    
    # max_cycle 50
    # pout_start
    # 00000001
    # 00000000
    # pout_end
