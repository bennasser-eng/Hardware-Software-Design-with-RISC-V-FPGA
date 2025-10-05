# TAG = auipc
    .text

    auipc x31 , 0x12345
    auipc x31 , 0x0
    auipc x31 , 0x0fff0


    # max_cycle 50
    # pout_start
    # 12346000
    # 00001004
    # 0fff1008
    # pout_end
