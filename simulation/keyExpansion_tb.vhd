 
library ieee;
use ieee.std_logic_1164.all;


entity keyExpansion_tb is 

end entity;

architecture keyExpansion_tb_arch of keyExpansion_tb is
signal Rcon_tb : std_logic_vector(7 downto 0) :=(others => '0');
signal prevRoundKey_tb : std_logic_vector(127 downto 0) :=(others => '0');
signal nextRoundKey_tb : std_logic_vector(127 downto 0) :=(others => '0');
signal nextRoundKey_expected : std_logic_vector(127 downto 0) :=(others => '0');        
 
component keyExpansion 
port (
    Rcon : in std_logic_vector(7 downto 0);--The current round coeficient 
    prevRoundKey : in std_logic_vector(127 downto 0); 
    nextRoundKey : out std_logic_vector(127 downto 0)
);
end component;

begin
DUT :  keyExpansion
port map (
    Rcon => Rcon_tb, 
    prevRoundKey => prevRoundKey_tb, 
    nextRoundKey => nextRoundKey_tb
);
STIMILUS :process
begin
report "TEST 1";
Rcon_tb <= x"01"; 
prevRoundKey_tb <= x"0f0e0d0c0b0a09080706050403020100";
nextRoundKey_expected <= x"fe76abd6f178a6dafa72afd2fd74aad6";
wait for 10 ns;
assert nextRoundKey_tb = nextRoundKey_expected
report "TEST 1 failed" 
severity error;
wait for 10 ns;
report "TEST 2";
Rcon_tb <= x"02"; 
prevRoundKey_tb <= x"feb3306800c59bbef1bd3d640bcf92b6";
nextRoundKey_expected <= x"41bf6904bf0c596cbfc9c2d24e74ffb6";
wait for 10 ns;
assert nextRoundKey_tb = nextRoundKey_expected
        report "TEST 2 failed" 
        severity error;
wait for 10 ns; 
wait;


end process;

end architecture;