# TAG = sra
    .text

    lui x31, 0x12345   
    addi x30 , x0 , 0
    sra x31, x31, x30  
    addi x30 , x0 , 4  
    sra x31, x31, x30   
    sra x31, x31, x30
    addi x30 , x0, 12
    sra x31 , x31 , x30
    lui x31 , 0xf0000
    addi x30 , x0 , 2
    sra x31 , x31 , x30

    # max_cycle 50
    # pout_start
    # 12345000
    # 12345000
    # 01234500
    # 00123450
    # 00000123
    # F0000000
    # FC000000
    # pout_end