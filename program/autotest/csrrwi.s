# TAG = csrrwi
    .text
    lui x31 , 0xF

    lui x1, %hi(traitant)
    addi x1, x1, %lo(traitant)

    csrrw x0, mtvec, x1
    addi x1, x0, 1 << 3
    
    csrrs x0, mstatus, x1 
    addi x1, x0, 1 << 2 
    lui x2, 0x0c002
    sw x1, 0(x2)

    addi x1, x0, 0x7ff
    addi x1, x1, 1

    csrrs x0, mie, x1
    addi x2, x0, 0

attente:
    beq x2, x0, attente 
    addi x31, x0, 0x5ad 
    j attente

traitant:
    addi x2, x0, 1 
    lui x3, 0x0c200 
    addi x3, x3, 4
    lw x1, 0(x3)
    mret
    # max_cycle 50
    # pout_start
    # 0000F000              
    # pout_end