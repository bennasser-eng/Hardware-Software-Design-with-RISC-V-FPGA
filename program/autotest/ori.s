# TAG = ori
    .text

    lui x31, 0x12345       
    ori x31, x31, 0x0FF    
    lui x31, 0x12345       
    ori x31, x31, 0x100   
    lui x31, 0x12345       
    ori x31, x31, 0x7FF    

    # max_cycle 50
    # pout_start
    # 12345000  
    # 123450FF  
    # 12345000  
    # 12345100  
    # 12345000  
    # 123457FF  
    # pout_end