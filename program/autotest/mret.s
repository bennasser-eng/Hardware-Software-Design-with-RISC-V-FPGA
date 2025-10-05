# TAG = mret
   .text
    lui   x31, 0xFF             # Donne une valeur initiale à x31 (sera écrasée)
    la   x1, return_point      # Adresse de retour
    csrrw x0, mepc, x1         # Écrit dans mepc
    mret                       # Saut à return_point

    ori   x31, x0, 0xAA        # Ne sera PAS exécutée

return_point:
    lui   x31, 0x1C             # Nouvelle valeur après retour (x31 = 0x1C)
    ebreak                     # Fin du programme

    # max_cycle 10000
    # pout_start
    # 000FF000
    # 0001C000
    # pout_end
    