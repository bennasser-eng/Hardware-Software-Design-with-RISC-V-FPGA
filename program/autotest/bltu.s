# TAG = bltu
    .text
    lui x31, 0x00003    
    lui x30, 0x00002      
    bltu x31, x30, less1  
    lui x31, 0xFFFFF
    bltu x31 , x30 , end1   
    bltu x0, x0, end1     
less1:
    lui x31, 0x00003      

end1:
    lui x31, 0xFFFFF      
    lui x30, 0x00001      
    bltu x31, x30, less2  
    lui x31, 0x00004      
    bltu x0, x0, end2     
less2:
    lui x31, 0xFFFFF    

end2:
    lui x31 ,0 

        # max_cycle 500
        # pout_start
        # 00003000          
        # fffff000
        # 00003000
        # fffff000
        # 00004000
        # fffff000
        # 00000000         
        # pout_end