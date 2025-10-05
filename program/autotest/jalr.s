# TAG = jalr
    .text
    lui x10, 0x00001             
    addi x1, x10, 0x020
    addi x31, x0, 0xA
    jalr x31, 0(x1)
    addi x31, x0, 0xD
    addi x31, x0, 0x10 
    jalr x31, -8(x1) 
    addi x31, x0, 0x11  
    addi x31, x0, 0x12 
    jalr x31, 8(x1) 
    addi x31, x0, 0x16
    addi x31, x0, 0x1B
    addi x31, x0, 0x1C
    nop

    # max_cycle 50
    # pout_start
    # 0000000A    
    # 00001010
    # 00000012
    # 00001028
    # 00000016
    # 0000001B
    # 0000001C
    # pout_end