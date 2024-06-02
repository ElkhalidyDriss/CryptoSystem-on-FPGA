library ieee;
use ieee.std_logic_1164.all;


entity LFSR is 
port ( clk  : in std_logic;
       enable : in std_logic;
       o_lfsr : out std_logic_vector(127 downto 0)
	   );
end entity;


architecture LFSRarch of LFSR is 
constant seed : std_logic_vector(127 downto 0):=x"01030101010101F10101010101011101"; --initial seed value
signal lfsr_reg : std_logic_vector(127 downto 0) :=seed;
signal feedback : std_logic;



begin 
feedback <= lfsr_reg(127) xor lfsr_reg(97) xor lfsr_reg(58) xor lfsr_reg(1) xor lfsr_reg(0);--Chosen primitive polynomial p(x) = x^127 + x^97 + x^58 + x + 1
process(clk)
begin
        if (rising_edge(clk)) then
		    if enable = '1' then
			   lfsr_reg <= (feedback&lfsr_reg(127 downto 1));
			end if;
		end if;
end process;
o_lfsr <= lfsr_reg;
end architecture;