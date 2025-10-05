# TAG = bge
    .text

        
        lui x31, 0x00001      
        lui x30, 0x00001      
        bge x31, x30, equal1  
        lui x31, 0xFFFFF      
        bge x0, x0, end1      
    equal1:
        lui x31, 0x00002      

    end1:
        nop

        
        lui x30, 0x00000     
        bge x31, x30, equal2  
        lui x31, 0xFFFFF      
        bge x0, x0, end2      
    equal2:
        lui x31, 0x00003      

    end2:
        nop

        lui x30, 0x00004      
        bge x31, x30, equal3 
        lui x31, 0x00004      
        bge x0, x0, end3      
    equal3:
        lui x31, 0xFFFFF      

    end3:
        nop

        # max_cycle 50
        # pout_start
        # 00001000          
        # 00002000         
        # 00003000         
        # 00004000          
        # pout_end