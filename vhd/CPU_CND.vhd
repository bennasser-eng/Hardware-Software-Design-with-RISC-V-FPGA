library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant : integer := 0
    );
    port (
        rs1   : in w32;
        alu_y : in w32;
        IR    : in w32;
        slt   : out std_logic;
        jcond : out std_logic
    );
end entity;

architecture RTL of CPU_CND is
    signal ext_logic, z, s : std_logic;
    signal ext_op1, ext_op2, result_op : unsigned(32 downto 0);
    signal rs1_extension_signe, alu_y_extension_signe : unsigned(32 downto 0);
begin
 
    ext_logic <= (not IR(12) and not IR(6)) or (IR(6) and not IR(13));

    rs1_extension_signe <= unsigned(rs1(31) & rs1);
    alu_y_extension_signe <= unsigned(alu_y(31) & alu_y);

  
    ext_op1 <= unsigned('0' & rs1) when ext_logic = '0' else rs1_extension_signe;
    ext_op2 <= unsigned('0' & alu_y) when ext_logic = '0' else alu_y_extension_signe;

   
    result_op <= ext_op1 - ext_op2;


    process(result_op)
    begin
        if result_op = 0 then
            z <= '1';
        else
            z <= '0';
        end if;

        if result_op(32) = '1' then
            s <= '1';
        else
            s <= '0';
        end if;
    end process;

  
    slt <= s;
    jcond <= ((IR(12) xor z) and (not IR(14))) or ((IR(12) xor s) and IR(14));
end architecture;


