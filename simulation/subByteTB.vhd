library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subByteTB is
end entity subByteTB;

architecture subByteTB_arch of subByteTB is
    -- Component declaration for the unit under test (UUT)
    component subByte
        port(
            i_data : in std_logic_vector(7 downto 0); -- input data in GF(2^8)
            o_data : out std_logic_vector(7 downto 0) -- output data
        );
    end component;

    -- Signal declarations to connect to the UUT
    signal i_data_tb : std_logic_vector(7 downto 0) := (others => '0');
    signal o_data_tb : std_logic_vector(7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: subByte
        port map (
            i_data => i_data_tb,
            o_data => o_data_tb
        );

    -- Test process
    process
    begin
        -- Test vector 1
        i_data_tb <= "11110000"; -- Apply input
        wait for 10 ns;       -- Wait for output to settle
        assert o_data_tb = "10001100" -- Replace with expected output
            report "Test vector 1 failed" severity error;
        -- Test vector 2
        i_data_tb <= "00000000"; -- Apply input
        wait for 10 ns;       -- Wait for output to settle
        assert o_data_tb = "01100011" -- Replace with expected output
            report "Test vector 1 failed" severity error;
        -- Test vector 3
        i_data_tb <= "01010110"; -- Apply input
        wait for 10 ns;       -- Wait for output to settle
        assert o_data_tb = "10110001" -- Replace with expected output
            report "Test vector 1 failed" severity error;
        -- End simulation
        wait;
    end process;
end architecture subByteTB_arch;
