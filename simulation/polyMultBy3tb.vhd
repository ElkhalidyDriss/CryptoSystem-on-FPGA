library ieee;
use ieee.std_logic_1164.all;

entity polyMultBy3tb is
end entity polyMultBy3tb;

architecture tb_arch of polyMultBy3tb is
    -- Constants
    constant CLK_PERIOD : time := 10 ns; -- Clock period (10 ns)

    -- Signals
    signal i_data      : std_logic_vector(7 downto 0) := (others => '0'); -- Input data
    signal o_data_exp  : std_logic_vector(7 downto 0);                   -- Expected output data
    signal o_data      : std_logic_vector(7 downto 0);                   -- Output data from DUT

    -- Component instantiation
    component polyMultBy3
        port(
             i_data : in std_logic_vector(7 downto 0);
             o_data : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    -- DUT instantiation
    DUT : polyMultBy3 port map(i_data => i_data, o_data => o_data);

    -- Stimulus process
    stimulus_proc : process
    begin
        -- Test cases
        i_data <= x"00";  -- Test case 1: Input is 0x00
        wait for CLK_PERIOD;
        o_data_exp <= x"00"; -- Expected output is 0x00
        assert(o_data = o_data_exp) report "Test case 1 failed" severity error;

        i_data <= x"13";  -- Test case 2: Input is 0x13
        wait for CLK_PERIOD;
        o_data_exp <= x"35"; -- Expected output is 0x35
        assert(o_data = o_data_exp) report "Test case 2 failed" severity error;
        i_data <= x"8C";  -- Test case 2: Input is 0x13
        wait for CLK_PERIOD;
        o_data_exp <= x"8F"; -- Expected output is 0x35
        assert(o_data = o_data_exp) report "Test case 2 failed" severity error;
        -- Add more test cases as needed

        wait;
    end process stimulus_proc;

end architecture tb_arch;
