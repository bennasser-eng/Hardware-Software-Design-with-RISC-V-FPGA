# TAG = jal
    .text
    jal x31, label1     
    lui x31, 0xFFFFF       
label1:
    jal x31, label2     
    lui x31, 0xFFFFF       
label2:
    jal x31, end           
    lui x31, 0xFFFFF      
end:
   lui x31 , 0
    # max_cycle 50
    # pout_start
    # 00001004
    # 0000100c
    # 00001014
    # 00000000
    # pout_end