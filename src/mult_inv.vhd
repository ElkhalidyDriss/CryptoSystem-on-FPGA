-- ==========================================================================
-- Project        : AES-128
-- File           : mult_inv.vhd
-- Authors        : Meziani EL-Houcine 
--                  Elkhalidy Driss
--
-- Date           : May 2024
-- Version        : 1.0
-- 
-- Description    : Implementation of the a multiplicative inversion GF(2^4) to be used in the shiftRows calculations.
-- 
-- ==========================================================================

library ieee;
use ieee.std_logic_1164.all;

entity mult_inv is 
port (
       i_data : in  std_logic_vector(3 downto 0);   --input data in GF(2^4)
       o_data : out std_logic_vector(3 downto 0) ); --output data in GF(2^4) , multiplicative inverse of the input data
end entity;
architecture mult_invArch of mult_inv is 
begin
       process (i_data) 
       begin
       case (i_data) is
            when "0000" => o_data <= "0000";
            when "0001" => o_data <= "0001"; 
            when "0010" => o_data <= "0011"; 
            when "0011" => o_data <= "0010"; 
            when "0100" => o_data <= "1111"; 
            when "0101" => o_data <= "1100"; 
            when "0110" => o_data <= "1001"; 
            when "0111" => o_data <= "1011"; 
            when "1000" => o_data <= "1010"; 
            when "1001" => o_data <= "0110"; 
            when "1010" => o_data <= "1000"; 
            when "1011" => o_data <= "0111"; 
            when "1100" => o_data <= "0101";  
            when "1101" => o_data <= "1110"; 
            when "1110" => o_data <= "1101"; 
            when "1111" => o_data <= "0100"; 
            when others => o_data <= (others => '0');
            end case;
       end process;
end architecture ;