library ieee;
use ieee.std_logic_1164.all;


entity LFSR is 
port ( clk  : in std_logic;
       enable : in std_logic;
       o_lsfr : out std_logic_vector(127 downto 0)
	   );
end entity;


architecture LFSRarch of LFSR is 
signal lfsr_reg : std_logic_vector(127 downto 0) := (others => '1');--initial  non-zero seed value
signal feedback : std_logic;



begin 
process(clk)
begin
        if (rising_edge(clk)) then
		    if enable = '1' then
			   feedback <= lfsr_reg(127) xor lfsr_reg(97) xor lfsr_reg(58) xor lfsr_reg(1) xor lfsr_reg(0);--Chosen primitive polynomial p(x) = x^127 + x^97 + x^58 + x + 1
			   lfsr_reg <= feedback & lfsr_reg(127 downto 1);
			end if;
		end if;
end process;
o_lsfr <= lfsr_reg;
end architecture;