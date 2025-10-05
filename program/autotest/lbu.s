# TAG = lbu
    .text
    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x12345
    addi x2, x2, 0x000
    sw x2, 0(x1)
    lbu x31, 0(x1)                
    lbu x31 , 2(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x67890
    addi x2, x2, 0x000
    sw x2, 4(x1)
    lbu x31, 5(x1)
    lbu x31 , 7(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0xABCDE
    addi x2, x2, 0x020
    sw x2, 8(x1)
    lbu x31, 8(x1)
    lbu x31 , 11(x1)
    lbu x31, 0(x0)

    # max_cycle 200
    # pout_start
    # 00000000
    # 00000034
    # 00000000
    # 00000067
    # 00000020
    # 000000AB
    # 00000000
    # pout_end