# TAG = sb
    .text

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x12345
    addi x2, x2, 0x000
    sw x2, 0(x1)
    lb x31, 0(x1)                
    lb x31 , 2(x1)
    lui x3 , 0x01235
    addi x3 ,x3 , 0x102
    sb x3 , 1(x1)
    lb x31 , 1(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x67890
    addi x2, x2, 0x010
    sw x2, 4(x1)
    lw x31 , 4(x1)
    lb x31, 5(x1)                
    lb x31 , 7(x1)
    lui x3 , 0xf51f0
    addi x3 ,x3 , 0x102
    sb x3 , 6(x1)
    lb x31 , 6(x1)
    lb x31, 5(x1)

    lb x31, 0(x0)

    # max_cycle 10000
    # pout_start
    # 00000000
    # 00000034
    # 00000002
    # 67890010
    # 00000000
    # 00000067
    # 00000002
    # 00000000
    # 00000000
    # pout_end