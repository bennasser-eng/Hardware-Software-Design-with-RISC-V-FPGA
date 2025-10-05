# TAG = sll
    .text

    lui x31, 0x12345    
    addi x30 , x0 , 0  
    sll x31, x31, x30  
    addi x30 , x0 , 4  
    sll x31, x31, x30   
    sll x31, x31, x30
    addi x30 , x0, 12
    sll x31 , x31 , x30 

    # max_cycle 50
    # pout_start
    # 12345000
    # 12345000
    # 23450000
    # 34500000
    # 00000000
    # pout_end