library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
entity top_tb is 
end entity; 
  
architecture top_tb_arch of top_tb is
constant CLK_PERIOD : time := 10 ns;
signal clk_tb : std_logic;
signal start_tb : std_logic:='0';
signal busy_tb : std_logic:='0';
signal plaintext_tb : std_logic_vector(127 downto 0):=(others =>'0');
signal valid_o_tb : std_logic :='0';
signal ciphertext_tb : std_logic_vector(127 downto 0):=(others =>'0');
signal key_tb        : std_logic_vector(127 downto 0);
signal expected_ciphertext : std_logic_vector(127 downto 0):=(others => '0');
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
-- TEST 1 
report "test 1";
plaintext_tb <= x"6bc1bee22e409f96e93d7e117393172a";
expected_ciphertext <= (others => '0');
start_tb <= '1';
wait until valid_o_tb = '1';
expected_ciphertext <= x"3ad77bb40d7a3660a89ecaf32466ef97";
start_tb <= '0';
wait for CLK_PERIOD;

-- TEST 2 
report "test 2";
plaintext_tb <= x"ae2d8a571e03ac9c9eb76fac45af8e51";
expected_ciphertext <= (others => '0');
start_tb <= '1';
wait until valid_o_tb = '1';
expected_ciphertext <= x"f5d3d58503b9699de785895a96fdbaaf";
start_tb <= '0';
wait for CLK_PERIOD;

-- TEST 3 
report "test 3";
plaintext_tb <= x"30c81c46a35ce411e5fbc1191a0a52ef";
expected_ciphertext <= (others => '0');
start_tb <= '1';
wait until valid_o_tb = '1';
expected_ciphertext <= x"43b1cd7f598ece23881b00e3ed030688";
start_tb <= '0';
wait for CLK_PERIOD;

-- TEST 4 
report "test 4";
plaintext_tb <= x"f69f2445df4f9b17ad2b417be66c3710";
expected_ciphertext <= (others => '0');
start_tb <= '1';
wait until valid_o_tb = '1';
expected_ciphertext <= x"7b0c785e27e8ad3f8223207104725dd4";
start_tb <= '0';
wait for CLK_PERIOD;
wait;

end process;
end architecture;
