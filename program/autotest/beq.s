# TAG = beq
    .text

    lui x31, 0x00001      
    lui x30, 0x00001      
    beq x31, x30, equal1  
    lui x31, 0xFFFFF      
    beq x0, x0 , end1
equal1:
    lui x31, 0x00002      

end1:
    nop                   
    lui x30, 0x00003      
    beq x31, x30, equal2  
    lui x31, 0x00004      
    beq x0, x0, end2
equal2:
    lui x31, 0xFFFFF      

end2:
    nop

    # max_cycle 50
    # pout_start
    # 00001000          
    # 00002000
    # 00004000          
    # pout_end
    
