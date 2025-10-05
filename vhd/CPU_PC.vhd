library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PKG.all;

entity CPU_PC is
    generic(
        mutant: integer := 0
    );
    Port (
        -- Clock/Reset
        clk    : in  std_logic ;
        rst    : in  std_logic ;
        -- Interface PC to PO
        cmd    : out PO_cmd ;
        status : in  PO_status
    );
end entity;

architecture RTL of CPU_PC is
    type State_type is (
        S_Error,
        S_Init,
        S_Pre_Fetch,
        S_Fetch,
        S_Decode,
        S_Lui,
        S_Addi,
        S_Add,
        S_Sll,
        S_Auipc,
        S_And,
        S_Or,
        S_Ori,
        S_Andi,
        S_Xor,
        S_Xori,
        S_Sub,     
        S_Srl,     
        S_Sra,     
        S_Srai,    
        S_Slli,    
        S_Srli ,
        S_Slt ,
        S_Beq ,
        S_Slti,
        S_Sltiu,
        S_Sltu,
        S_Bne,
        S_Blt,
        S_Bltu,
        S_Bge,
        S_Bgeu,
        S_Sw,     
        S_Lw,      
        S_Jal,
        S_Lb,      
        S_Lbu,     
        S_Lh,      
        S_Lhu,     
        S_Sb,      
        S_Sh,     
        S_Jalr,
        S_charger_Mem,
        S_lecture_Mem,
        S_ecriture_Mem,
        S_Csrrw,
        S_Csrrs,
        S_Csrrc,
        S_Csrrwi,
        S_Csrrsi,
        S_Csrrci,
        S_IT,
        S_Mret

    );

    signal state_d, state_q : State_type;

begin
    FSM_synchrone : process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                state_q <= S_Init;
            else
                state_q <= state_d;
            end if;
        end if;
    end process FSM_synchrone;

    FSM_comb : process (state_q, status)
    begin
        -- Valeurs par défaut de cmd à définir selon les préférences de chacun
        cmd.ALU_op            <= ALU_minus;          
        cmd.LOGICAL_op        <= LOGICAL_and;
        cmd.ALU_Y_sel         <= ALU_Y_rf_rs2;       
        cmd.SHIFTER_op        <= SHIFT_ll;
        cmd.SHIFTER_Y_sel     <= SHIFTER_Y_rs2;
        cmd.RF_we             <= '0';
        cmd.RF_SIZE_sel       <= RF_SIZE_word;
        cmd.RF_SIGN_enable    <= '0';
        cmd.DATA_sel          <= DATA_from_pc;
        cmd.PC_we             <= '0';
        cmd.PC_sel            <= PC_from_pc;
        cmd.PC_X_sel          <= PC_X_cst_x00;
        cmd.PC_Y_sel          <= PC_Y_cst_x04;
        cmd.TO_PC_Y_sel       <= TO_PC_Y_cst_x04;
        cmd.AD_we             <= '0';
        cmd.AD_Y_sel          <= AD_Y_immI;
        cmd.IR_we             <= '0';
        cmd.ADDR_sel          <= ADDR_from_pc;
        cmd.mem_we            <= '0';
        cmd.mem_ce            <= '0';
        cmd.cs.CSR_we         <=  UNDEFINED;
        cmd.cs.TO_CSR_sel     <= TO_CSR_from_rs1;
        cmd.cs.CSR_sel        <=  CSR_from_mepc;
        cmd.cs.MEPC_sel       <=  MEPC_from_csr;
        cmd.cs.MSTATUS_mie_set   <= '0';
        cmd.cs.MSTATUS_mie_reset <= '0';
        cmd.cs.CSR_WRITE_mode    <=  WRITE_mode_simple;

        state_d <= state_q;

        case state_q is
            when S_Error =>
                -- Etat transitoire en cas d'instruction non reconnue
                -- Aucune action
                state_d <= S_Init;

            when S_Init =>
                -- PC <- RESET_VECTOR
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_rstvec;
                state_d <= S_Pre_Fetch;

            when S_Pre_Fetch =>
                -- mem[PC]
                cmd.mem_we   <= '0';
                cmd.mem_ce   <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                state_d      <= S_Fetch;

            when S_Fetch =>
                -- IR <- mem_datain
                cmd.IR_we <= '1';
                if status.IT then state_d <= S_IT; 
                else 
                   state_d <= S_Decode;
                end if;

            when S_Decode =>
                if status.IR(6 downto 0) = "0110111" then        -- LUI
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_LUI;
                elsif status.IR(6 downto 0) = "0010011" then    
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    if status.IR(14 downto 12) = "000" then      -- ADDI
                        state_d <= S_Addi;
                    elsif status.IR(14 downto 12) = "110" then   -- ORI
                        state_d <= S_Ori;
                    elsif status.IR(14 downto 12) = "111" then   -- ANDI
                        state_d <= S_Andi;
                    elsif status.IR(14 downto 12) = "100" then   -- XORI
                        state_d <= S_Xori;
                    elsif status.IR(14 downto 12) = "101" and    -- SRAI
                          status.IR(31 downto 25) = "0100000" then
                        state_d <= S_Srai;
                    elsif status.IR(14 downto 12) = "001" and    -- SLLI
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Slli;
                    elsif status.IR(14 downto 12) = "101" and    -- SRLI
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Srli;

                    elsif status.IR(14 downto 12) = "010"  then      --SLTI
                        state_d <= S_Slti;
                    elsif status.IR(14 downto 12) = "011"  then      --SLTIU
                        state_d <= S_Sltiu;
                    else
                        state_d <= S_Error;
                    end if;
                elsif status.IR(6 downto 0) = "0110011" then     
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    if status.IR(14 downto 12) = "000" and       -- ADD
                       status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Add;
                    elsif status.IR(14 downto 12) = "001" and    -- SLL
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Sll;
                    elsif status.IR(14 downto 12) = "111" and    -- AND
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_And;
                    elsif status.IR(14 downto 12) = "110" and    -- OR
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Or;
                    elsif status.IR(14 downto 12) = "100" and    -- XOR
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Xor;
                    elsif status.IR(14 downto 12) = "000" and    -- SUB
                          status.IR(31 downto 25) = "0100000" then
                        state_d <= S_Sub;
                    elsif status.IR(14 downto 12) = "101" and    -- SRL
                          status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Srl;
                    elsif status.IR(14 downto 12) = "101" and    -- SRA
                          status.IR(31 downto 25) = "0100000" then
                        state_d <= S_Sra;

                    elsif status.IR(14 downto 12) = "010" and status.IR(31 downto 25) = "0000000" then
                            state_d <= S_Slt;             -- SLT
                    elsif status.IR(14 downto 12) = "011" and status.IR(31 downto 25) = "0000000" then
                        state_d <= S_Sltu;             -- SLTU
                    else
                        state_d <= S_Error;
                    end if;
                elsif status.IR(6 downto 0) = "0010111" then     -- AUIPC
                    state_d <= S_Auipc;
                
                elsif status.IR(6 downto 0) = "1100011" then    
                     
                    if status.IR(14 downto 12) = "000" then      -- BEQ  
                        state_d <= S_Beq;
                    elsif status.IR(14 downto 12) = "001" then      -- BNE
                        cmd.ALU_Y_sel <= ALU_Y_rf_rs2;    
                        state_d <= S_Bne;
                    elsif status.IR(14 downto 12) = "100" then      -- BLT
                        cmd.ALU_Y_sel <= ALU_Y_rf_rs2;    
                        state_d <= S_Blt;
                    elsif status.IR(14 downto 12) = "101" then      -- BGE
                        cmd.ALU_Y_sel <= ALU_Y_rf_rs2;    
                        state_d <= S_Bge;
                    elsif status.IR(14 downto 12) = "110" then      -- BLTU
                        cmd.ALU_Y_sel <= ALU_Y_rf_rs2;    
                        state_d <= S_Bltu;
                    elsif status.IR(14 downto 12) = "111" then      -- BGEU
                        cmd.ALU_Y_sel <= ALU_Y_rf_rs2;    
                        state_d <= S_Bgeu;
                    end if;
                elsif status.IR(6 downto 0) = "0100011" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';    
                    if status.IR(14 downto 12) = "010" then      -- SW 
                        state_d <= S_Sw;
                    elsif status.IR(14 downto 12) = "000" then   -- SB
                        state_d <= S_Sb;
                    elsif status.IR(14 downto 12) = "001" then   -- SH 
                        state_d <= S_Sh;
                    else
                        state_d <= S_Error;
                    end if;
                elsif status.IR(6 downto 0) = "0000011" then   
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    if status.IR(14 downto 12) = "010" then      -- LW 
                        state_d <= S_Lw;
                    elsif status.IR(14 downto 12) = "000" then   -- LB
                        state_d <= S_Lb;
                    elsif status.IR(14 downto 12) = "100" then   -- LBU 
                        state_d <= S_Lbu;
                    elsif status.IR(14 downto 12) = "001" then   -- LH 
                        state_d <= S_Lh;
                    elsif status.IR(14 downto 12) = "101" then   -- LHU 
                        state_d <= S_Lhu;
                    else
                        state_d <= S_Error;
                    end if;
                elsif status.IR(6 downto 0) = "1101111" then    -- JAL 
                    state_d <= S_Jal;
                elsif status.IR(6 downto 0) = "1100111" and status.IR(14 downto 12) = "000" then       -- JALR 
                        state_d <= S_Jalr; 
                elsif status.IR(6 downto 0) = "1110011" then  
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    if status.IR(14 downto 12) = "001" then      -- CSRRW
                        state_d <= S_Csrrw;
                    elsif status.IR(14 downto 12) = "010" then   -- CSRRS
                        state_d <= S_Csrrs;
                    elsif status.IR(14 downto 12) = "011" then   -- CSRRC
                        state_d <= S_Csrrc;
                    elsif status.IR(14 downto 12) = "101" then   -- CSRRWI
                        state_d <= S_Csrrwi;
                    elsif status.IR(14 downto 12) = "110" then   -- CSRRSI
                        state_d <= S_Csrrsi;
                    elsif status.IR(14 downto 12) = "111" then   -- CSRRCI
                        state_d <= S_Csrrci;
                    elsif status.IR(14 downto 12) = "000" then state_d <= S_Mret; -- MRET
                    else
                        state_d <= S_Error;
                    end if;
                else
                    state_d <= S_Error;-- Pour détecter les ratés du décodage
                end if;

            ---------- Instructions avec immediat de type U ----------
            when S_Lui =>
                
                cmd.PC_X_sel <= PC_X_cst_x00;
                cmd.PC_Y_sel <= PC_Y_immU;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_pc;
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Auipc =>
                
                cmd.PC_X_sel <= PC_X_pc;         
                cmd.PC_Y_sel <= PC_Y_immU;  
                cmd.RF_we <= '1';       
                cmd.DATA_sel <= DATA_from_pc;
              

                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                cmd.PC_sel <= PC_from_pc;
                cmd.PC_we <= '1';
              
                state_d <= S_Pre_Fetch;

            ---------- Instructions arithmétiques et logiques ----------
            when S_Addi =>
                
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.ALU_op <= ALU_plus;
                cmd.DATA_sel <= DATA_from_alu;
                cmd.RF_we <= '1';
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Add =>
                
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;      
                cmd.ALU_op <= ALU_plus;          
                cmd.DATA_sel <= DATA_from_alu;   
                cmd.RF_we <= '1';               
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Sub =>
                
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;     
                cmd.ALU_op <= ALU_minus;         
                cmd.DATA_sel <= DATA_from_alu;   
                cmd.RF_we <= '1';              
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Sll =>
                
                cmd.SHIFTER_op <= SHIFT_ll;      
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.DATA_sel <= DATA_from_shifter;
                cmd.RF_we <= '1';               
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Srl =>
                
                cmd.SHIFTER_op <= SHIFT_rl;      
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.DATA_sel <= DATA_from_shifter;
                cmd.RF_we <= '1';               

                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';

                state_d <= S_Fetch;

            when S_Sra =>
                
                cmd.SHIFTER_op <= SHIFT_ra;      
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.DATA_sel <= DATA_from_shifter;
                cmd.RF_we <= '1';               
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Slli =>
                
                cmd.SHIFTER_op <= SHIFT_ll;      
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;  
                cmd.DATA_sel <= DATA_from_shifter;
                cmd.RF_we <= '1';               
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Srli =>
                
                cmd.SHIFTER_op <= SHIFT_rl;     
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.DATA_sel <= DATA_from_shifter;
                cmd.RF_we <= '1';               
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
               
                state_d <= S_Fetch;

            when S_Srai =>
                
                cmd.SHIFTER_op <= SHIFT_ra;      
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;  
                cmd.DATA_sel <= DATA_from_shifter;
                cmd.RF_we <= '1';              
               
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_And =>
                
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.DATA_sel <= DATA_from_logical;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;

            when S_Or =>
                
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.DATA_sel <= DATA_from_logical;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;

            when S_Ori =>
                
                cmd.ALU_Y_sel <= ALU_Y_immI;     
                cmd.LOGICAL_op <= LOGICAL_or;    
                cmd.DATA_sel <= DATA_from_logical;   
                cmd.RF_we <= '1';               

                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Andi =>
                
                cmd.ALU_Y_sel <= ALU_Y_immI;     
                cmd.LOGICAL_op <= LOGICAL_and;   
                cmd.DATA_sel <= DATA_from_logical;   
                cmd.RF_we <= '1';               
                
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Xor =>
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.DATA_sel <= DATA_from_logical;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;

            when S_Xori =>
                
                cmd.ALU_Y_sel <= ALU_Y_immI;     
                cmd.LOGICAL_op <= LOGICAL_xor;   
                cmd.DATA_sel <= DATA_from_logical;   
                cmd.RF_we <= '1';               
               
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                
                state_d <= S_Fetch;

            when S_Slt =>
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;                

                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;
            
            when S_Sltu =>
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;                

                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;
            
            when S_Slti =>
                cmd.ALU_Y_sel <= ALU_Y_immI;                

                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;
            

            when S_Sltiu =>
                cmd.ALU_Y_sel <= ALU_Y_immI;                

                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;



            ---------- Instructions de saut ----------
            when S_Beq =>
                if status.jcond  then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                state_d <= S_Pre_Fetch;

            when S_Bne =>
                if status.jcond then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                state_d <= S_Pre_Fetch;
            when S_Bge =>
                if status.jcond  then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                state_d <= S_Pre_Fetch;

            when S_Bgeu =>
                if status.jcond then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                state_d <= S_Pre_Fetch;
            when S_Blt=>
                if status.jcond then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                state_d <= S_Pre_Fetch;
            
            when S_Bltu =>
                if status.jcond then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                state_d <= S_Pre_Fetch;
            
        
            when S_Jal =>
                
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_cst_x04;
                cmd.DATA_sel <= DATA_from_pc;
                cmd.RF_we <= '1';

                cmd.TO_PC_Y_sel <= TO_PC_Y_immJ;
                cmd.PC_sel <= PC_from_pc;
                cmd.PC_we <= '1';

                state_d <= S_Pre_Fetch;
    
            when S_Jalr =>
        
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_cst_x04;
                cmd.DATA_sel <= DATA_from_pc;
                cmd.RF_we <= '1';
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.ALU_op <= ALU_plus;
                cmd.PC_sel <= PC_from_alu; 
                cmd.PC_we <= '1';

                state_d <= S_Pre_Fetch;
    
            ---------- Instructions de chargement à partir de la mémoire ----------
            when S_Lw =>
                cmd.AD_Y_sel <= AD_Y_immI;
                cmd.AD_we <= '1';
                state_d <= S_lecture_Mem;

            when S_Lb =>
                cmd.AD_Y_sel <= AD_Y_immI;
                cmd.AD_we <= '1';
                state_d <= S_lecture_Mem;

            when S_Lbu =>
                cmd.AD_Y_sel <= AD_Y_immI;
                cmd.AD_we <= '1';
                state_d <= S_lecture_Mem;

            when S_Lh =>
                cmd.AD_Y_sel <= AD_Y_immI;
                cmd.AD_we <= '1';
                state_d <= S_lecture_Mem;

            when S_Lhu =>
                cmd.AD_Y_sel <= AD_Y_immI;
                cmd.AD_we <= '1';
                state_d <= S_lecture_Mem;

            when S_lecture_Mem =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_charger_Mem;

            when S_charger_Mem =>
                cmd.DATA_sel <= DATA_from_mem;
                cmd.RF_we <= '1';
                if status.IR(14 downto 12) = "010" then      -- LW
                    cmd.RF_SIZE_sel <= RF_SIZE_word;
                    cmd.RF_SIGN_enable <= '0';
                elsif status.IR(14 downto 12) = "000" then   -- LB
                    cmd.RF_SIZE_sel <= RF_SIZE_byte;
                    cmd.RF_SIGN_enable <= '1';
                elsif status.IR(14 downto 12) = "100" then   -- LBU
                    cmd.RF_SIZE_sel <= RF_SIZE_byte;
                    cmd.RF_SIGN_enable <= '0';
                elsif status.IR(14 downto 12) = "001" then   -- LH
                    cmd.RF_SIZE_sel <= RF_SIZE_half;
                    cmd.RF_SIGN_enable <= '1';
                elsif status.IR(14 downto 12) = "101" then   -- LHU
                    cmd.RF_SIZE_sel <= RF_SIZE_half;
                    cmd.RF_SIGN_enable <= '0';
                end if;
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                state_d <= S_Fetch;

            ---------- Instructions de sauvegarde en mémoire ----------
            when S_Sw =>
                cmd.AD_Y_sel <= AD_Y_immS;
                cmd.AD_we <= '1';
                state_d <= S_ecriture_Mem;

            when S_Sb =>
                cmd.AD_Y_sel <= AD_Y_immS;
                cmd.AD_we <= '1';
                state_d <= S_ecriture_Mem;
            when S_Sh =>
                cmd.AD_Y_sel <= AD_Y_immS;
                cmd.AD_we <= '1';
                state_d <= S_ecriture_Mem;

            when S_ecriture_Mem =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '1';
                if status.IR(14 downto 12) = "010" then      -- SW
                    cmd.RF_SIZE_sel <= RF_SIZE_word;
                elsif status.IR(14 downto 12) = "000" then   -- SB
                    cmd.RF_SIZE_sel <= RF_SIZE_byte;
                elsif status.IR(14 downto 12) = "001" then   -- SH
                    cmd.RF_SIZE_sel <= RF_SIZE_half;
                end if;
                state_d <= S_Pre_Fetch;

            ---------- Instructions d'accès aux CSR ----------
            when S_IT =>
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_simple;
                cmd.cs.MEPC_sel <= MEPC_from_pc;
                cmd.cs.CSR_we <= CSR_mepc;
                cmd.cs.MSTATUS_mie_reset <= '1';
                cmd.PC_sel <= PC_mtvec;
                cmd.PC_we <= '1';
                state_d <= S_Pre_Fetch;

            when S_Csrrw =>
                cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_simple;
                cmd.cs.CSR_we <= CSR_none; 
                if status.IR(11 downto 7) /= "00000" then
                    cmd.DATA_sel <= DATA_from_csr;
                    cmd.RF_we <= '1';
                end if;
                if status.IR(31 downto 20) = x"300" then
                    cmd.cs.CSR_sel <= CSR_from_mstatus;
                    cmd.cs.CSR_we <= CSR_mstatus;
                elsif status.IR(31 downto 20) = x"304" then
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    cmd.cs.CSR_we <= CSR_mie;
                elsif status.IR(31 downto 20) = x"305" then
                    cmd.cs.CSR_sel <= CSR_from_mtvec;
                    cmd.cs.CSR_we <= CSR_mtvec;
                elsif status.IR(31 downto 20) = x"341" then
                    cmd.cs.CSR_sel <= CSR_from_mepc;
                    cmd.cs.CSR_we <= CSR_mepc;
                    cmd.cs.MEPC_sel <= MEPC_from_csr;
                elsif status.IR(31 downto 20) = x"342" then
                    cmd.cs.CSR_sel <= CSR_from_mcause;
                elsif status.IR(31 downto 20) = x"344" then
                    cmd.cs.CSR_sel <= CSR_from_mip;
                end if;
                state_d <= S_Pre_Fetch;

            when S_Csrrs =>
                cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_set;
                cmd.cs.CSR_we <= CSR_none;
                if status.IR(31 downto 20) = x"304" then
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    cmd.cs.CSR_we <= CSR_mie;
                end if;
                if status.IR(11 downto 7) /= "00000" then  
                    cmd.DATA_sel <= DATA_from_csr;  
                    cmd.RF_we <= '1';
                    if status.IR(31 downto 20) = x"300" then
                        cmd.cs.CSR_sel <= CSR_from_mstatus;
                        cmd.cs.CSR_we <= CSR_mstatus;
                    elsif status.IR(31 downto 20) = x"305" then
                        cmd.cs.CSR_sel <= CSR_from_mtvec;
                        cmd.cs.CSR_we <= CSR_mtvec;
                    elsif status.IR(31 downto 20) = x"341" then
                        cmd.cs.CSR_sel <= CSR_from_mepc;
                        cmd.cs.CSR_we <= CSR_mepc;
                        cmd.cs.MEPC_sel <= MEPC_from_csr;
                    elsif status.IR(31 downto 20) = x"342" then
                        cmd.cs.CSR_sel <= CSR_from_mcause;
                    elsif status.IR(31 downto 20) = x"344" then
                        cmd.cs.CSR_sel <= CSR_from_mip;
                    end if;
                end if;
                state_d <= S_Pre_Fetch;

            when S_Csrrc =>
                cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_clear;
                cmd.cs.CSR_we <= CSR_none;
                if status.IR(31 downto 20) = x"304" then
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    cmd.cs.CSR_we <= CSR_mie;
                end if;
                if status.IR(11 downto 7) /= "00000" then  
                    cmd.DATA_sel <= DATA_from_csr;  
                    cmd.RF_we <= '1';
                    if status.IR(31 downto 20) = x"300" then
                        cmd.cs.CSR_sel <= CSR_from_mstatus;
                        cmd.cs.CSR_we <= CSR_mstatus;
                    elsif status.IR(31 downto 20) = x"305" then
                        cmd.cs.CSR_sel <= CSR_from_mtvec;
                        cmd.cs.CSR_we <= CSR_mtvec;
                    elsif status.IR(31 downto 20) = x"341" then
                        cmd.cs.CSR_sel <= CSR_from_mepc;
                        cmd.cs.CSR_we <= CSR_mepc;
                        cmd.cs.MEPC_sel <= MEPC_from_csr;
                    elsif status.IR(31 downto 20) = x"342" then
                        cmd.cs.CSR_sel <= CSR_from_mcause;
                    elsif status.IR(31 downto 20) = x"344" then
                        cmd.cs.CSR_sel <= CSR_from_mip;
                    end if;
                end if;
                state_d <= S_Pre_Fetch;

            when S_Csrrwi =>
                cmd.cs.TO_CSR_sel <= TO_CSR_from_imm;
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_simple;
                cmd.cs.CSR_we <= CSR_none;
                if status.IR(31 downto 20) = x"304" then
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    cmd.cs.CSR_we <= CSR_mie;
                end if;
                if status.IR(11 downto 7) /= "00000" then
                    cmd.DATA_sel <= DATA_from_csr;
                    cmd.RF_we <= '1';
                end if;
                if status.IR(31 downto 20) = x"300" then
                    cmd.cs.CSR_sel <= CSR_from_mstatus;
                    cmd.cs.CSR_we <= CSR_mstatus;
                elsif status.IR(31 downto 20) = x"305" then
                    cmd.cs.CSR_sel <= CSR_from_mtvec;
                    cmd.cs.CSR_we <= CSR_mtvec;
                elsif status.IR(31 downto 20) = x"341" then
                    cmd.cs.CSR_sel <= CSR_from_mepc;
                    cmd.cs.CSR_we <= CSR_mepc;
                    cmd.cs.MEPC_sel <= MEPC_from_csr;
                elsif status.IR(31 downto 20) = x"342" then
                    cmd.cs.CSR_sel <= CSR_from_mcause;
                elsif status.IR(31 downto 20) = x"344" then
                    cmd.cs.CSR_sel <= CSR_from_mip;
                end if;
                state_d <= S_Pre_Fetch;

            when S_Csrrsi =>
                cmd.cs.TO_CSR_sel <= TO_CSR_from_imm;
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_set;
                cmd.cs.CSR_we <= CSR_none;
                if status.IR(31 downto 20) = x"304" then
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    cmd.cs.CSR_we <= CSR_mie;
                end if;
                if status.IR(11 downto 7) /= "00000" then  
                    cmd.DATA_sel <= DATA_from_csr;  
                    cmd.RF_we <= '1';
                    if status.IR(31 downto 20) = x"300" then
                        cmd.cs.CSR_sel <= CSR_from_mstatus;
                        cmd.cs.CSR_we <= CSR_mstatus;
                    elsif status.IR(31 downto 20) = x"305" then
                        cmd.cs.CSR_sel <= CSR_from_mtvec;
                        cmd.cs.CSR_we <= CSR_mtvec;
                    elsif status.IR(31 downto 20) = x"341" then
                        cmd.cs.CSR_sel <= CSR_from_mepc;
                        cmd.cs.CSR_we <= CSR_mepc;
                        cmd.cs.MEPC_sel <= MEPC_from_csr;
                    elsif status.IR(31 downto 20) = x"342" then
                        cmd.cs.CSR_sel <= CSR_from_mcause;
                    elsif status.IR(31 downto 20) = x"344" then
                        cmd.cs.CSR_sel <= CSR_from_mip;
                    end if;
                end if;
                state_d <= S_Pre_Fetch;

            when S_Csrrci =>
                cmd.cs.TO_CSR_sel <= TO_CSR_from_imm;
                cmd.cs.CSR_WRITE_mode <= WRITE_mode_clear;
                cmd.cs.CSR_we <= CSR_none;   
                
                if status.IR(31 downto 20) = x"304" then
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    cmd.cs.CSR_we <= CSR_mie;
                end if;
                if status.IR(11 downto 7) /= "00000" then  
                    cmd.DATA_sel <= DATA_from_csr;  
                    cmd.RF_we <= '1';
                    if status.IR(31 downto 20) = x"300" then
                        cmd.cs.CSR_sel <= CSR_from_mstatus;
                        cmd.cs.CSR_we <= CSR_mstatus;
                    elsif status.IR(31 downto 20) = x"305" then
                        cmd.cs.CSR_sel <= CSR_from_mtvec;
                        cmd.cs.CSR_we <= CSR_mtvec;
                    elsif status.IR(31 downto 20) = x"341" then
                        cmd.cs.CSR_sel <= CSR_from_mepc;
                        cmd.cs.CSR_we <= CSR_mepc;
                        cmd.cs.MEPC_sel <= MEPC_from_csr;
                    elsif status.IR(31 downto 20) = x"342" then
                        cmd.cs.CSR_sel <= CSR_from_mcause;
                    elsif status.IR(31 downto 20) = x"344" then
                        cmd.cs.CSR_sel <= CSR_from_mip;
                    end if;
                end if;
                state_d <= S_Pre_Fetch;

            when S_Mret =>
                cmd.cs.MSTATUS_mie_set <= '1';
                cmd.PC_sel <= PC_from_mepc;
                cmd.PC_we <= '1';
                state_d <= S_Pre_Fetch;

            when others =>
                state_d <= S_Error;
        end case;
    end process FSM_comb;
end architecture;
