library ieee;
use ieee.std_logic_1164.all;



entity subWord is
port(  i_dataWord : in std_logic_vector(31 downto 0);
       o_dataWord : out std_logic_vector(31 downto 0));
	   
end entity;



architecture subWordArch of subWord is

component subByte 
port(
     i_data : in std_logic_vector(7 downto 0); --input data in GF(2^8)
     o_data : out std_logic_vector(7 downto 0)-- output data
);
end component;
begin
    subByte0 : subByte port map ( i_data => i_dataWord(7 downto 0), o_data => o_dataWord(7 downto 0);
    subByte1 : subByte port map ( i_data => i_dataWord(15 downto 8), o_data => o_dataWord(15 downto 8);
	subByte2 : subByte port map ( i_data => i_dataWord(23 downto 16), o_data => o_dataWord(23 downto 16);
	subByte3 : subByte port map ( i_data => i_dataWord(31 downto 24), o_data => o_dataWord(31 downto 24);

end architecture ;