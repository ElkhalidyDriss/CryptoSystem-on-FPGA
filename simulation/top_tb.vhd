library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
entity top_tb is 
end entity; 
  
architecture top_tb_arch of top_tb is
constant CLK_PERIOD : time := 10 ns;
signal clk_tb : std_logic;
signal start_tb : std_logic;
signal busy_tb : std_logic;
signal plaintext_tb : std_logic_vector(127 downto 0);
signal valid_o_tb : std_logic;
signal ciphertext_tb : std_logic_vector(127 downto 0);
signal key_tb        : std_logic_vector(127 downto 0);
component top 
port (	clk   : in std_logic;
		start : in std_logic;
		busy  : out std_logic;
        plaintext  : in std_logic_vector(127 downto 0);
		valid_o    : out std_logic;
        ciphertext_o : out std_logic_vector(127 downto 0);
		key        : out std_logic_vector(127 downto 0));
end component;
begin
DUT : top 
port map(
        clk   => clk_tb,
	    start => start_tb,
	    busy  => busy_tb ,
        plaintext  => plaintext_tb, 
		valid_o   => valid_o_tb,
        ciphertext_o => ciphertext_tb,
		key        => key_tb
        );
CLOCK : process
begin
    clk_tb <= '1'; wait for CLK_PERIOD/2;
    clk_tb <= '0'; wait for CLK_PERIOD/2;
end process;
STIMILUS : process
begin
    --TEST1 
    report "test 1";
    plaintext_tb <= x"00112233445566778899AABBCCDDEEFF";
    start_tb <= '1';
    wait until valid_o_tb = '1';

    start_tb <= '0';
    wait;

end process;
end architecture;
