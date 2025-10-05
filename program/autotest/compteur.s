# TAG = compteur
   .text
   ori  x1,  x0,  1
   lui x31 , 0x12345
   add x31, x31, x1
   
   # max_cycle 50
   # pout_start
   # 12345000
   # 12345001
   # pout_end
