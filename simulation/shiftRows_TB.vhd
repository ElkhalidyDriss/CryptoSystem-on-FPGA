-- ===========================================================================
-- Project        : AES-128
-- File           : shiftRows.vhd
-- Authors        : Meziani EL-Houcine 
--                  Elkhalidy Driss
--
-- Date           : May 2024
-- Version        : 1.0
-- 
-- Description    : Shift rows testbench
-- 
-- ============================================================================


library ieee;
use ieee.std_logic_1164.all;

entity shiftRows_TB is 
end entity;


architecture shiftRows_TB_arch of shiftRows_TB is
signal i_data_tb : std_logic_vector(127 downto 0) :=(others => '0');
signal o_data_tb : std_logic_vector(127 downto 0) :=(others => '0');
component  shiftRows is
port (
    i_data : in std_logic_vector(127 downto 0); --input data
    o_data : out std_logic_vector(127 downto 0) --output data
);
end component;
        
begin
DUT : shiftRows 
port map (i_data => i_data_tb ,
          o_data => o_data_tb
         );
STIMILUS : process
begin
report "test 1";
i_data_tb <= x"63cab7040953d051cd60e0e7ba70e18c";
assert o_data_tb = x"6353e08c0960e104cd70b751bacad0e7"
       report "test 1 failed"
       severity error;
 


end process;

end architecture;