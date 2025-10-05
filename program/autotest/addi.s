# TAG = addi
    .text

    lui x31, 0x12345
    addi x31, x31, 0
    addi x31, x31, 0x1
    addi x31, x31, 0xffffffff
    addi x31, x31, 0x400
    addi x31 , x31 , 0x5
    addi x31, x31, 0xfffffffe


    
    
    
    # max_cycle 50
    # pout_start
    # 12345000
    # 12345000
    # 12345001
    # 12345000
    # 12345400
    # 12345405
    # 12345403
    # pout_end
