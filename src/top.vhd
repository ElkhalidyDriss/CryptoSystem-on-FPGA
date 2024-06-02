library ieee;
use ieee.std_logic_1164.all;



entity top is 
port (	clk : in std_logic;
		control : std_logic_vector(1 downto 0);--[start/stop , padding/no padding]
        plaintext : std_logic_vector(127 downto 0);
        ciphertext : out std_logic_vector(127 downto 0);
		key        : out std_logic_vector(127 downto 0));
end entity;



architecture topArch of top is
signal A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15 : std_logic_vector(15 downto 0);--A0 LSbyte , A5 MSbyte of plaintext
component subByte 
port(
     i_data : in std_logic_vector(7 downto 0); --input data 
     o_data : out std_logic_vector(7 downto 0)-- output data
);
end component;
component shiftRows
    port (
        i_data : in std_logic_vector(127 downto 0); --input data
        o_data : out std_logic_vector(127 downto 0) --output data
    );
end component;
component mixColumn
port(
     clk     : in std_logic;
     i_block : in std_logic_vector(127 downto 0); --input data block  in GF(2^8)
     o_block : out std_logic_vector(127 downto 0);-- output data
     valid_i : in std_logic; --high when valid input is present
     valid_o : out std_logic  --high when valid output data 
);
end component;
component addKey
port (  roundKey : in std_logic_vector(127 downto 0);
        i_data   : in std_logic_vector(127 downto 0);
		o_data   : out std_logic_vector(127 downto 0));
end component;
component LFSR 
port(  clk  : in std_logic;
       enable : in std_logic;
       o_lfsr : out std_logic_vector(127 downto 0)
	);
end component;

begin 
    A0 <= plaintext(7 downto 0);
    A1 <= plaintext(15 downto 8);
    A2 <= plaintext(23 downto 16);
    A3 <= plaintext(31 downto 24);
    A4 <= plaintext(39 downto 32);
    A5 <= plaintext(47 downto 40);
    A6 <= plaintext(55 downto 48);
    A7 <= plaintext(63 downto 56);
    A8 <= plaintext(71 downto 64);
    A9 <= plaintext(79 downto 72);
    A10 <= plaintext(87 downto 80);
    A11 <= plaintext(95 downto 88);
    A12 <= plaintext(103 downto 96);
    A13 <= plaintext(111 downto 104);
    A14 <= plaintext(119 downto 112);
    A15 <= plaintext(127 downto 120);
	




end architecture;