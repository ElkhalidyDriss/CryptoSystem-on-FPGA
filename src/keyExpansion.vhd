library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity declaration for keyExpansion
entity keyExpansion is 
    port (
        clk : in std_logic;  -- Clock signal
        key : in std_logic_vector(127 downto 0);          -- 128-bit input key
        round_key0 : out std_logic_vector(127 downto 0);  -- Output for round key 0
        round_key1 : out std_logic_vector(127 downto 0);  -- Output for round key 1
        round_key2 : out std_logic_vector(127 downto 0);  -- Output for round key 2
        round_key3 : out std_logic_vector(127 downto 0);  -- Output for round key 3
        round_key4 : out std_logic_vector(127 downto 0);  -- Output for round key 4
        round_key5 : out std_logic_vector(127 downto 0);  -- Output for round key 5
        round_key6 : out std_logic_vector(127 downto 0);  -- Output for round key 6
        round_key7 : out std_logic_vector(127 downto 0);  -- Output for round key 7
        round_key8 : out std_logic_vector(127 downto 0);  -- Output for round key 8
        round_key9 : out std_logic_vector(127 downto 0);  -- Output for round key 9
        round_key10 : out std_logic_vector(127 downto 0)  -- Output for round key 10
    );
end entity;

-- Architecture for keyExpansion
architecture behavior of keyExpansion is
    type word_array is array (0 to 43) of std_logic_vector(31 downto 0);  -- Type declaration for array of words
    signal w : word_array;  -- Signal for storing intermediate words
    signal round_keys : array(0 to 10) of std_logic_vector(127 downto 0);  -- Signal for storing round keys
    signal temp : std_logic_vector(31 downto 0);  -- Temporary signal for intermediate calculations
    signal subWord_out : std_logic_vector(31 downto 0);  -- Output signal from SubWord component
    constant Rcon : array(1 to 10) of std_logic_vector(31 downto 0) := (  -- Round constant array
        x"01000000", x"02000000", x"04000000", x"08000000", x"10000000", 
        x"20000000", x"40000000", x"80000000", x"1B000000", x"36000000"
    );

    -- Component declaration for SubWord
    component subWord is
        port (
            i_dataWord : in std_logic_vector(31 downto 0);  -- Input data word
            o_dataWord : out std_logic_vector(31 downto 0)  -- Output data word
        );
    end component;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Initialize first round key with the input key
            w(0) <= key(127 downto 96);
            w(1) <= key(95 downto 64);
            w(2) <= key(63 downto 32);
            w(3) <= key(31 downto 0);
            round_keys(0) <= key;
            
            -- Generate round keys for rounds 1 to 10
            for i in 1 to 10 loop
                -- Temporary variable holds the last word
                temp <= w(4*i-1);
                -- Rotate word (RotWord)
                temp <= temp(23 downto 0) & temp(31 downto 24);
                
                -- Substitute word (SubWord)
                SubWord_inst : subWord
                    port map (
                        i_dataWord => temp,
                        o_dataWord => subWord_out
                    );
                
                -- XOR with round constant
                temp <= subWord_out xor Rcon(i);
                
                -- Generate words for the current round key
                w(4*i) <= w(4*i-4) xor temp;
                w(4*i+1) <= w(4*i) xor w(4*i-3);
                w(4*i+2) <= w(4*i+1) xor w(4*i-2);
                w(4*i+3) <= w(4*i+2) xor w(4*i-1);
                
                -- Concatenate words to form the round key
                round_keys(i) <= w(4*i) & w(4*i+1) & w(4*i+2) & w(4*i+3);
            end loop;
            
            -- Assign round keys to output ports
            round_key0 <= round_keys(0);
            round_key1 <= round_keys(1);
            round_key2 <= round_keys(2);
            round_key3 <= round_keys(3);
            round_key4 <= round_keys(4);
            round_key5 <= round_keys(5);
            round_key6 <= round_keys(6);
            round_key7 <= round_keys(7);
            round_key8 <= round_keys(8);
            round_key9 <= round_keys(9);
            round_key10 <= round_keys(10);
        end if;
    end process;
end behavior;