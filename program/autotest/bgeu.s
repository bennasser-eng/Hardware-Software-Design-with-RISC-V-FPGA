# TAG = bgeu
    .text

        
        lui x31, 0xFFFFF      
        lui x30, 0x00001      
        bgeu x31, x30, equal1 
        lui x31, 0x00000      
        bgeu x0, x0, end1     
    equal1:
        lui x31, 0x00002      

    end1:
        nop
        lui x31, 0x00001      
        lui x30, 0x00003      
        bgeu x31, x30, equal2 
        lui x31, 0x00004      
        bgeu x0, x0, end2     
    equal2:
        lui x31, 0x00000      

    end2:
        lui x31 , 0

        # max_cycle 50
        # pout_start
        # fffff000          
        # 00002000
        # 00001000
        # 00004000
        # 00000000    
        # pout_end