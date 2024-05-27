library ieee;
use ieee.std_logic_1164.all;


entity subByte is 
port(
     i_data : in std_logic_vector(7 downto 0); --input data in GF(2^8)
     o_data : out std_logic_vector(7 downto 0)-- output data
);
end entity;

architecture subByteArch of subByte is 
--!!For naming convetions , please refer to our proposed architecture in the documentation of this project.
signal data_m : std_logic_vector(7 downto 0); --isomorphic mapping of the input data to GF((2^4)^2)
signal data_m_inv : std_logic_vector(7 downto 0); --inverse in GF(((2^4)^2)
signal common1 , common2 , common3 , common4: std_logic;
signal b , c : std_logic_vector(3 downto 0); --upper nibble and lower nibble of data_m
signal t : std_logic_vector(3 downto 0); -- t = lambda.b^2 , output of the squarer 
signal s : std_logic_vector(3 downto 0); -- s = c(b xor c) in GF(2^4)
signal i_mult1 : std_logic_vector(3 downto 0); --input of MULT1
signal i_mult2 : std_logic_vector(3 downto 0); --input of MULT2
signal o_mult3 : std_logic_vector(3 downto 0); --output of MULT3
signal o_mult2 : std_logic_vector(3 downto 0); --output of MULT2
signal e : std_logic_vector(3 downto 0);
signal e_inv : std_logic_vector(3 downto 0);
component multiplier4x4  
port (
       i_data1 : in std_logic_vector(3 downto 0);
       i_data2 : in std_logic_vector(3 downto 0);
       o_data : out std_logic_vector(3 downto 0)
);
end component;
component mult_inv 
port (
       i_data : in  std_logic_vector(3 downto 0);   --input data in GF(2^4)
       o_data : out std_logic_vector(3 downto 0) ); --output data in GF(2^4) , multiplicative inverse of the input data
end component;
begin
------------Isomorphic mapping from GF(2^8) to GF((2^4)^2)---------
common1 <= i_data(7) xor i_data(5);
common2 <= i_data(7) xor i_data(6);
common3 <= i_data(3) xor i_data(2) xor i_data(1);
common4 <= i_data(6) xor i_data(1);
data_m(7) <= common1;
data_m(6) <= common2   xor i_data(4) xor common3;
data_m(5) <= common1   xor i_data(3) xor i_data(2);
data_m(4) <= common1   xor i_data(3) xor i_data(2) xor i_data(1);
data_m(3) <= common2   xor i_data(2) xor i_data(1);
data_m(2) <= i_data(7) xor i_data(4) xor common3;
data_m(1) <= common4   xor i_data(4);
data_m(0) <= common4   xor i_data(0);
b <= data_m(7 downto 4);
c <= data_m(3 downto 0);
--t=lambda.b^2 in GF(2^4) where lambda = 0b1100
t(3) <= b(2) xor b(1) xor b(0);
t(2) <= b(3) xor b(0);
t(1) <= b(3);
t(0) <= b(3) xor b(2);
--s=c(b xor c) in GF(2^8)
i_mult1 <= b xor c ;
MULT1 : multiplier4x4 port map (i_data1 => i_mult1 , i_data2 => c , o_data => s);

e <= s xor t;
--Multiplicative inverse of signal e in GF(2^4)
MULT_INV1 : mult_inv port map(i_data => e , o_data => e_inv );
i_mult2 <= c xor b;
MULT2 : multiplier4x4 port map (i_data1 => i_mult2 , i_data2 => e_inv, o_data => o_mult2);
MULT3 : multiplier4x4 port map (i_data1 => b , i_data2 => e_inv , o_data => o_mult3);
data_m_inv <= o_mult3 & o_mult2;
--Merged inversed isomorphism and affine transformation
o_data(7) <= data_m_inv(7) xor data_m_inv(3) xor data_m_inv(2) xor '0';
o_data(6) <= data_m_inv(7) xor data_m_inv(6) xor data_m_inv(5) xor data_m_inv(4) xor '1';
o_data(5) <= data_m_inv(7) xor data_m_inv(2) xor '1';
o_data(4) <= data_m_inv(7) xor data_m_inv(4) xor data_m_inv(1) xor data_m_inv(0) xor '0';
o_data(3) <= data_m_inv(2) xor data_m_inv(1) xor data_m_inv(0) xor '0';
o_data(2) <= data_m_inv(6) xor data_m_inv(5) xor data_m_inv(4) xor data_m_inv(3) xor data_m_inv(2) xor data_m_inv(0) xor '0';
o_data(1) <= data_m_inv(7) xor data_m_inv(0) xor '1';
o_data(0) <= data_m_inv(7) xor data_m_inv(6) xor data_m_inv(2) xor data_m_inv(1) xor data_m_inv(0) xor '1';

end architecture;