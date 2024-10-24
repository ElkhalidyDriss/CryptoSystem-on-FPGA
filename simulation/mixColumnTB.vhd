library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mixColumnTB is
end entity;

architecture mixColumnTB_arch of mixColumnTB is
signal i_block_tb : std_logic_vector(127 downto 0) := (others => '0');
signal o_block_tb : std_logic_vector(127 downto 0);
component mixColumn 
port(
     i_block : in std_logic_vector(127 downto 0); --input data block  in GF(2^8)
     o_block : out std_logic_vector(127 downto 0)-- output data
    );
end component;
begin
DUT : mixColumn 
port map ( i_block => i_block_tb , 
           o_block => o_block_tb
);
STIMILUS : process
begin
    i_block_tb <= x"618b611f45cac9d89b73ad97691abea7"; 
    wait for 10 ns;
    assert o_block_tb = x"09d03a77fa515164516ad831849687ff" report "Test 1 failed" severity error;
    wait for 10 ns;
    wait;
end process;

end architecture;
