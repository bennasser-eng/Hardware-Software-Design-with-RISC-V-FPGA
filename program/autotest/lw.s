# TAG = lw
    .text   

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x12345
    addi x2, x2, 0x000
    sw x2, 0(x1)
    lw x31, 0(x1)                


    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x67890
    addi x2, x2, 0x000
    sw x2, 4(x1)
    lw x31, 4(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0xABCDE
    addi x2, x2, 0x000
    sw x2, 8(x1)
    lw x31, 8(x1)
    lw x31, 0(x0)


    # max_cycle 150
    # pout_start
    # 12345000
    # 67890000
    # ABCDE000
    # 00000000
    # pout_end   
    