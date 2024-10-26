    library ieee;
    use ieee.std_logic_1164.all;


    entity keyExpansion is 
        port (
            Rcon : in std_logic_vector(7 downto 0);--The current round coeficient 
            prevRoundKey : in std_logic_vector(127 downto 0); 
            nextRoundKey : out std_logic_vector(127 downto 0)
        );
    end entity;

    
    architecture keyExpansionArch of keyExpansion is
    signal prevRoundKeyW0 , prevRoundKeyW1 , prevRoundKeyW2 , prevRoundKeyW3 : std_logic_vector(31 downto 0);
    signal nextRoundKeyW0 , nextRoundKeyW1 , nextRoundKeyW2 , nextRoundKeyW3 : std_logic_vector(31 downto 0);
    signal prevRoundKeyW3Sub: std_logic_vector(31 downto 0); --substution value of Most significant word (32 bits) of prevRoundKey 
    signal pRdKeyW3Rot : std_logic_vector(31 downto 0);--Rotated value of pRdKeyW3Sub
    component subByte is 
    port(
        i_data : in std_logic_vector(7 downto 0); --input data in GF(2^8)
        o_data : out std_logic_vector(7 downto 0)-- output data
    );
    end component;

    begin
    prevRoundKeyW0 <= prevRoundKey(31 downto 0);--Splting prevRoundKey into words 
    prevRoundKeyW1 <= prevRoundKey(63 downto 32);
    prevRoundKeyW2 <= prevRoundKey(95 downto 64);
    prevRoundKeyW3 <= prevRoundKey(127 downto 96);
    subByteInst0 : subByte port map ( i_data => prevRoundKey(103 downto 96) , o_data => prevRoundKeyW3Sub(7 downto 0));
    subByteInst1 : subByte port map ( i_data => prevRoundKey(111 downto 104) , o_data => prevRoundKeyW3Sub(15 downto 8));  
    subByteInst2 : subByte port map ( i_data => prevRoundKey(119 downto 112), o_data => prevRoundKeyW3Sub(23 downto 16));  
    subByteInst3 : subByte port map ( i_data =>  prevRoundKey(127  downto 120), o_data=> prevRoundKeyW3Sub(31 downto 24));

    pRdKeyW3Rot <= prevRoundKeyW3Sub(7 downto 0) & prevRoundKeyW3Sub(31 downto 8);
    nextRoundKeyW0(31 downto 8) <= prevRoundKeyW0 (31 downto 8) xor pRdKeyW3Rot(31 downto 8);
    nextRoundKeyW0(7 downto 0)  <= pRdKeyW3Rot(7 downto 0) xor Rcon;

    nextRoundKeyW1 <= nextRoundKeyW0 xor prevRoundKeyW1;
    nextRoundKeyW2 <= nextRoundKeyW1 xor prevRoundKeyW2;
    nextRoundKeyW3 <= nextRoundKeyW2 xor prevRoundKeyW3; 
    nextRoundKey <= nextRoundKeyW3 & nextRoundKeyW2 & nextRoundKeyW1 & nextRoundKeyW0;
    end architecture;

