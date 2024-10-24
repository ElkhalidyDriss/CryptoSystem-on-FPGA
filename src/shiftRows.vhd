-- ===========================================================================
-- Project        : AES-128
-- File           : shiftRows.vhd
-- Authors        : Meziani EL-Houcine 
--                  Elkhalidy Driss
--
-- Date           : May 2024
-- Version        : 1.0
-- 
-- Description    : Implementation of the shiftRows block of the AES algorithm.
-- 
-- ============================================================================


library ieee;
use ieee.std_logic_1164.all;

entity shiftRows is
    port (
        i_data : in std_logic_vector(127 downto 0); --input data
        o_data : out std_logic_vector(127 downto 0) --output data
    );
end entity;

architecture shiftRowsArch of shiftRows is
begin
    o_data(7  downto 0)   <= i_data(7 downto 0);
    o_data(15 downto 8)   <= i_data(47 downto 40);
    o_data(23 downto 16)  <= i_data(87 downto 80);
    o_data(31 downto 24)  <= i_data(127 downto 120);
    o_data(39 downto 32)  <= i_data(39 downto 32);
    o_data(47 downto 40)  <= i_data(79 downto 72);
    o_data(55 downto 48)  <= i_data(119 downto 112);
    o_data(63 downto 56)  <= i_data(31 downto 24);
    o_data(71 downto 64)  <= i_data(71 downto 64);
    o_data(79 downto 72)  <= i_data(111 downto 104);
    o_data(87 downto 80)  <= i_data(23 downto 16);
    o_data(95 downto 88)  <= i_data(63 downto 56);
    o_data(103 downto 96) <= i_data(103 downto 96);
    o_data(111 downto 104) <= i_data(15 downto 8);
    o_data(119 downto 112) <= i_data(55 downto 48);
    o_data(127 downto 120) <= i_data(95 downto 88);
    
    
end architecture;
