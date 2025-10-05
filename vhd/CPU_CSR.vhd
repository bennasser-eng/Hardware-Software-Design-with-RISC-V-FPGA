library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


use work.PKG.all;

entity CPU_CSR is
    generic (
        INTERRUPT_VECTOR : waddr   := w32_zero;
        mutant           : integer := 0
    );
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;

        -- Interface de et vers la PO
        cmd         : in  PO_cs_cmd;
        it          : out std_logic;
        pc          : in  w32;
        rs1         : in  w32;
        imm         : in  W32;
        csr         : out w32;
        mtvec       : out w32;
        mepc        : out w32;

        -- Interface de et vers les IP d'interruption
        irq         : in  std_logic;
        meip        : in  std_logic;
        mtip        : in  std_logic;
        mie         : out w32;
        mip         : out w32;
        mcause      : in  w32
    );
end entity;

architecture RTL of CPU_CSR is
    -- Fonction retournant la valeur à écrire dans un csr en fonction
    -- du « mode » d'écriture, qui dépend de l'instruction
    function CSR_write (CSR        : w32;
                         CSR_reg    : w32;
                         WRITE_mode : CSR_WRITE_mode_type)
        return w32 is
        variable res : w32;
    begin
        case WRITE_mode is
            when WRITE_mode_simple =>
                res := CSR;
            when WRITE_mode_set =>
                res := CSR_reg or CSR;
            when WRITE_mode_clear =>
                res := CSR_reg and (not CSR);
            when others => null;
        end case;
        return res;
    end CSR_write;

    -- Signaux pour les registres CSR
    signal mcause_d, mcause_q : w32;
    signal mip_d, mip_q       : w32;
    signal mie_d, mie_q       : w32;
    signal mstatus_d, mstatus_q : w32;
    signal mtvec_d, mtvec_q   : w32;
    signal mepc_d, mepc_q     : w32;
    signal TO_CSR             : w32;

begin
    -- Processus synchrone pour les registres CSR
    csr_register_clock : process (clk)
    begin
        if clk'event and clk='1' then
            if rst = '1' then
                mcause_q  <= w32_zero;
                mip_q     <= w32_zero;
                mie_q     <= w32_zero;
                mstatus_q <= w32_zero;
                mtvec_q   <= w32_zero;
                mepc_q    <= w32_zero;
            else
                mcause_q  <= mcause_d;
                mip_q     <= mip_d;
                mie_q     <= mie_d;  
                mstatus_q <= mstatus_d;
                mtvec_q   <= mtvec_d;
                mepc_q    <= mepc_d;
            end if;
        end if;
    end process;

    -- Processus combinatoire pour la gestion des CSR
    csr_register_main : process (all)
    begin
        -- Valeurs par défaut 
        mcause_d  <= mcause_q;
        mip_d     <= mip_q;
        mie_d     <= mie_q;  
        mstatus_d <= mstatus_q;
        mtvec_d   <= mtvec_q;
        mepc_d    <= mepc_q;

        -- Gestion de mcause
        if irq = '1' then
            mcause_d <= mcause;
        end if;

        -- Gestion de mip
        mip_d(7)  <= mtip; 
        mip_d(11) <= meip; 
        mip_d(31 downto 12) <= (others => '0');
        mip_d(10 downto 8)  <= (others => '0');
        mip_d(6 downto 0)   <= (others => '0');

        -- rs1 ou imm
        if cmd.TO_CSR_Sel = TO_CSR_from_rs1 then
            TO_CSR <= rs1;
        elsif cmd.TO_CSR_Sel = TO_CSR_from_imm then
            TO_CSR <= imm;
        else
            TO_CSR <= (others => '0');
        end if;

        -- Gestion de mie
        if cmd.CSR_we = CSR_mie then
            mie_d <= CSR_write(TO_CSR, mie_q, cmd.CSR_WRITE_mode);
        end if;

        -- Gestion de mstatus 
        if cmd.MSTATUS_mie_set = '1' then
            mstatus_d(3) <= '1';
        elsif cmd.MSTATUS_mie_reset = '1' then
            mstatus_d(3) <= '0';
        end if;

        -- Gestion de mstatus 
        if cmd.CSR_we = CSR_mstatus then
            mstatus_d <= CSR_write(TO_CSR, mstatus_q, cmd.CSR_WRITE_mode);
        end if;

        -- Gestion de mtvec
        if cmd.CSR_we = CSR_mtvec then
            mtvec_d <= CSR_write(TO_CSR, mtvec_q, cmd.CSR_WRITE_mode);
            mtvec_d(1 downto 0) <= "00";  
        end if;

        -- Gestion de mepc
        if cmd.CSR_we = CSR_mepc then
            if cmd.MEPC_sel = MEPC_from_pc then
                mepc_d <= CSR_write(pc, mepc_q, cmd.CSR_WRITE_mode);
            elsif cmd.MEPC_sel = MEPC_from_csr then
                mepc_d <= CSR_write(TO_CSR, mepc_q, cmd.CSR_WRITE_mode);
            end if;
            mepc_d(1 downto 0) <= "00";  
        end if;

        -- Sélection de la sortie csr
        case cmd.CSR_sel is
            when CSR_from_mcause =>
                csr <= mcause_q;
            when CSR_from_mip =>
                csr <= mip_q;
            when CSR_from_mie =>
                csr <= mie_q;
            when CSR_from_mstatus =>
                csr <= mstatus_q;
            when CSR_from_mtvec =>
                csr <= mtvec_q;
            when CSR_from_mepc =>
                csr <= mepc_q;
            when others =>
                csr <= (others => '0');
        end case;
    end process;

    -- Sorties
    mip   <= mip_q;
    mie   <= mie_q;
    it    <= irq AND mstatus_q(3);
    mtvec <= mtvec_q;
    mepc  <= mepc_q;

end architecture;