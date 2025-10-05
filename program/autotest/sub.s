# TAG = sub
    .text

    lui x31, 0x12345   
    lui x30, 0x00001    
    sub x31, x31, x30 
    sub x31, x31, x31   
    lui x30, 0xFFFFF    
    sub x31, x30, x31   

    # max_cycle 50
    # pout_start
    # 12345000
    # 12344000
    # 00000000
    # FFFFF000
    # pout_end