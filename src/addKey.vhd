library ieee;
use ieee.std_logic_1164.all;


entity addKey is 
port (  roundKey : in std_logic_vector(127 downto 0);
        i_data   : in std_logic_vector(127 downto 0);
		o_data   : out std_logic_vector(127 downto 0));
end entity;



architecture addKeyArch of addKey is

begin
     o_data <= i_data xor roundKey;
end architecture;