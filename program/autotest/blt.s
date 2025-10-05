# TAG = blt
    .text

    lui x31, 0x00001      
    lui x30, 0x00002      
    blt x31, x30, less1   
    lui x31, 0xFFFFF      
    blt x0, x0, end1      
less1:
    lui x31, 0x00002     

end1:
    lui x31, 0xFFFFF      
    lui x30, 0x00001      
    blt x31, x30, less2   
    lui x31, 0x00000      
    blt x0, x0, end2      
less2:
    lui x31, 0x00003     

end2:
    lui x31, 0x00004     
    lui x30, 0x00001      
    blt x31, x30, less3   
    lui x31, 0x00004      
    blt x0, x0, end3      
less3:
    lui x31, 0xFFFFF      

end3:
    lui x31 , 0

        # max_cycle 500
        # pout_start
        # 00001000          
        # 00002000          
        # FFFFF000          
        # 00003000
        # 00004000
        # 00004000
        # FFFFF000    
        # 00000000  
        # pout_end