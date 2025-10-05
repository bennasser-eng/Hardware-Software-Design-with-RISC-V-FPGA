# TAG = sh
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
    sh x3 , 2(x1)
    lw x31 , 0(x1)

    lui x1, 0x00001
    addi x1, x1, 0x400
    lui x2, 0x67890
    addi x2, x2, 0x010
    sw x2, 4(x1)
    lw x31 , 4(x1)
    lb x31, 5(x1)                
    lb x31 , 7(x1)
    lui x3 , 0xf51ff
    addi x3 ,x3 , 0x102
    sh x3 , 4(x1)
    lb x31 , 4(x1)
    lb x31, 7(x1)
    lb x31 , 5(x1)
    lb x31, 0(x0)

    # max_cycle 250
    # pout_start
    # 00000000
    # 00000034 
    # 51025000
    # 67890010
    # 00000000
    # 00000067
    # 00000002
    # 00000067
    # FFFFFFF1
    # 00000000
    # pout_end