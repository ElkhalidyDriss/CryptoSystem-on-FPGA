library ieee;
use ieee.std_logic_1164.all;

entity multiplier4x4 is 
port (
       i_data1 : in std_logic_vector(3 downto 0);
       i_data2 : in std_logic_vector(3 downto 0);
       o_data : out std_logic_vector(3 downto 0)
);
end entity;


architecture multiplier4x4Arch of multiplier4x4 is 
-- Internal signals for higher and lower bits
signal i_data1_high, i_data1_low : std_logic_vector(1 downto 0);
signal i_data2_high, i_data2_low : std_logic_vector(1 downto 0);
signal o_mult1 , o_mult2 , o_mult3 , o_mult4 : std_logic_vector(1 downto 0);--output of mult1
signal o_mult1xphi : std_logic_vector(1 downto 0) ; --multiplication result  of o_mult1 a phi = 0b10 constant in the GF(2)
component mutliplier2x2 
port (  i_data1 : in std_logic_vector(1 downto 0);   --input data 1 in GF(2^2)
        i_data2 : in std_logic_vector(1 downto 0);   --input data 2 in GF(2^2)
        o_data : out std_logic_vector(1 downto 0));  --output data result in GF(2^2) of multiplication of the two inputs
end component;



begin 
-- Split the input data into higher and lower bits 
i_data1_high <= i_data1(3 downto 2);
i_data1_low  <= i_data1(1 downto 0);
i_data2_high <= i_data2(3 downto 2);
i_data2_low  <= i_data2(1 downto 0);

MULT1 : mutliplier2x2 port map( i_data1 => i_data1_high , i_data2 => i_data2_high , o_data => o_mult1);
MULT2 : mutliplier2x2 port map( i_data1 => i_data1_high , i_data2 => i_data2_low , o_data => o_mult2);
MULT3 : mutliplier2x2 port map( i_data1 => i_data1_low , i_data2 => i_data2_high , o_data => o_mult3);
MULT4 : mutliplier2x2 port map( i_data1 => i_data1_low , i_data2 => i_data2_low , o_data => o_mult4);

--Multiplication by constant phi = 0b10 in the GF(2)
o_mult1xphi(1) <= o_mult1(1) xor o_mult1(0);
o_mult1xphi(0) <= o_mult1(1);

o_data(3 downto 2) <= o_mult1 xor o_mult2 xor o_mult3;
o_data(1 downto 0) <= o_mult4 xor o_mult1xphi;

end architecture;