-- ===========================================================================
-- Project        : AES-128
-- File           : mixColumn.vhd
-- Authors        : Meziani EL-Houcine 
--                  Elkhalidy Driss
--
-- Date           : May 2024
-- Version        : 1.0
-- 
-- Description    : Imlementation of mixColumn sublayer of AES 
-- 
-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;


entity mixColumn is 
port(
     i_block : in std_logic_vector(127 downto 0); --input data block  in GF(2^8)
     o_block : out std_logic_vector(127 downto 0)-- output data
);
end entity;

architecture mixColumnArch of mixColumn is
-- i_blcok bytes
signal B0, B1, B2, B3, B4, B5, B6, B7 , B8, B9, B10, B11, B12, B13, B14, B15 : std_logic_vector(7 downto 0);
-- o_block bytes
signal C0, C1, C2, C3, C4, C5, C6, C7 , C8, C9, C10, C11, C12, C13, C14, C15  : std_logic_vector(7 downto 0);

signal o_mult_by2_0, o_mult_by2_1, o_mult_by2_2, o_mult_by2_3, o_mult_by2_4, o_mult_by2_5, o_mult_by2_6,
       o_mult_by2_7, o_mult_by2_8, o_mult_by2_9, o_mult_by2_10, o_mult_by2_11, o_mult_by2_12, o_mult_by2_13,
       o_mult_by2_14, o_mult_by2_15 : std_logic_vector(7 downto 0);
signal o_mult_by3_0, o_mult_by3_1, o_mult_by3_2, o_mult_by3_3, o_mult_by3_4, o_mult_by3_5, o_mult_by3_6,
       o_mult_by3_7, o_mult_by3_8, o_mult_by3_9, o_mult_by3_10, o_mult_by3_11, o_mult_by3_12, o_mult_by3_13,
       o_mult_by3_14, o_mult_by3_15 : std_logic_vector(7 downto 0);
component  polyMultBy2 
    port(
         i_data : in std_logic_vector(7 downto 0); --input data in GF(2^8)
         o_data : out std_logic_vector(7 downto 0)-- output data in GF(2^8)
    );
    end component;
component  polyMultBy3
    port(
         i_data : in std_logic_vector(7 downto 0); --input data in GF(2^8)
         o_data : out std_logic_vector(7 downto 0)-- output data in GF(2^8)
    );
    end component;
begin
B0  <= i_block(7 downto 0);
B1  <= i_block(15 downto 8);
B2  <= i_block(23 downto 16);
B3  <= i_block(31 downto 24);
B4  <= i_block(39 downto 32);
B5  <= i_block(47 downto 40);
B6  <= i_block(55 downto 48);
B7  <= i_block(63 downto 56);
B8  <= i_block(71 downto 64);
B9  <= i_block(79 downto 72);
B10 <= i_block(87 downto 80);
B11 <= i_block(95 downto 88);
B12 <= i_block(103 downto 96);
B13 <= i_block(111 downto 104);
B14 <= i_block(119 downto 112);
B15 <= i_block(127 downto 120);
--CO Computation
multBy2_0 : polyMultBy2 port map( i_data => B0,
                                  o_data => o_mult_by2_0);
multBy3_0 : polyMultBy3 port map( i_data => B3,
                                  o_data => o_mult_by3_0 );
C0 <= o_mult_by2_0 xor o_mult_by3_0 xor B2 xor B1;
--C1 Computation
multBy2_1 : polyMultBy2 port map( i_data => B1,
                                  o_data => o_mult_by2_1);
multBy3_1 : polyMultBy3 port map( i_data => B0,
                                  o_data => o_mult_by3_1 );
C1 <=  o_mult_by2_1 xor o_mult_by3_1 xor B2 xor B3;
--C2 Computation
multBy2_2 : polyMultBy2 port map( i_data => B2,
                                  o_data => o_mult_by2_2);
multBy3_2 : polyMultBy3 port map( i_data => B1,
                                  o_data => o_mult_by3_2 );
C2 <=  o_mult_by2_2 xor o_mult_by3_2 xor B0 xor B3;
--C3 Computation
multBy2_3 : polyMultBy2 port map( i_data => B3,
                                  o_data => o_mult_by2_3);
multBy3_3 : polyMultBy3 port map( i_data => B2,
                                  o_data => o_mult_by3_3 );
C3 <= o_mult_by2_3  xor o_mult_by3_3 xor B0 xor B1;
--C4 Computation
multBy2_4 : polyMultBy2 port map( i_data => B4,
                                  o_data => o_mult_by2_4);
multBy3_4 : polyMultBy3 port map( i_data => B7,
                                  o_data => o_mult_by3_4 );
C4 <= o_mult_by2_4 xor o_mult_by3_4 xor B5 xor B6;
--C5 Computation
multBy2_5 : polyMultBy2 port map( i_data => B5,
                                  o_data => o_mult_by2_5);
multBy3_5 : polyMultBy3 port map( i_data => B4,
                                  o_data => o_mult_by3_5 );
C5 <= o_mult_by2_5 xor o_mult_by3_5 xor B6 xor B7;
--C6 Computation
multBy2_6 : polyMultBy2 port map( i_data => B6,
                                  o_data => o_mult_by2_6);
multBy3_6 : polyMultBy3 port map( i_data => B5,
                                  o_data => o_mult_by3_6 );
C6 <= o_mult_by2_6 xor o_mult_by3_6 xor B4 xor B7;
--C7 Computation
multBy2_7 : polyMultBy2 port map( i_data => B7,
                                  o_data => o_mult_by2_7);
multBy3_7 : polyMultBy3 port map( i_data => B6,
                                  o_data => o_mult_by3_7 );
C7 <= o_mult_by2_7 xor o_mult_by3_7 xor B4 xor B5 ;
--C8 Computation
multBy2_8 : polyMultBy2 port map( i_data => B8,
                                  o_data => o_mult_by2_8);
multBy3_8 : polyMultBy3 port map( i_data => B11,
                                  o_data => o_mult_by3_8 );
C8 <= o_mult_by2_8 xor o_mult_by3_8 xor B10 xor B9;
--C9 Computation
multBy2_9 : polyMultBy2 port map( i_data => B9,
                                  o_data => o_mult_by2_9);
multBy3_9 : polyMultBy3 port map( i_data => B8,
                                  o_data => o_mult_by3_9 );
C9 <=  o_mult_by2_9 xor o_mult_by3_9 xor B10 xor B11;
--C10 Computation
multBy2_10 : polyMultBy2 port map( i_data => B10,
                                   o_data => o_mult_by2_10);
multBy3_10 : polyMultBy3 port map( i_data => B9,
                                   o_data => o_mult_by3_10 );
C10 <= o_mult_by2_10 xor o_mult_by3_10 xor B8 xor B11;
--C11 Computation
multBy2_11 : polyMultBy2 port map( i_data => B11,
                                   o_data => o_mult_by2_11);
multBy3_11 : polyMultBy3 port map( i_data => B10,
                                   o_data => o_mult_by3_11 );
C11 <= o_mult_by2_11 xor o_mult_by3_11 xor B8 xor B9;
--C12 Computation
multBy2_12 : polyMultBy2 port map( i_data => B12,
                                   o_data => o_mult_by2_12);
multBy3_12 : polyMultBy3 port map( i_data => B15,
                                   o_data => o_mult_by3_12 );
C12 <= o_mult_by2_12 xor o_mult_by3_12 xor B14 xor B13;
--C13 Computation
multBy2_13 : polyMultBy2 port map( i_data => B13,
                                   o_data => o_mult_by2_13);
multBy3_13 : polyMultBy3 port map( i_data => B12,
                                   o_data => o_mult_by3_13 );
C13 <=  o_mult_by2_13 xor o_mult_by3_13 xor B14 xor B15;
--C14 Computation
multBy2_14 : polyMultBy2 port map( i_data => B14,
                                   o_data => o_mult_by2_14);
multBy3_14 : polyMultBy3 port map( i_data => B13,
                                   o_data => o_mult_by3_14 );
C14 <= B12 xor B15 xor o_mult_by2_14 xor o_mult_by3_14;
--C15 Computation
multBy2_15 : polyMultBy2 port map( i_data => B15,
                                   o_data => o_mult_by2_15);
multBy3_15 : polyMultBy3 port map( i_data => B14,
                                   o_data => o_mult_by3_15 );
C15 <= o_mult_by2_15 xor B13 xor B12 xor o_mult_by3_15;

o_block <= C15 & C14 & C13 & C12 & C11 & C10 & C9 & C8 & C7 & C6 & C5 & C4 & C3 & C2 & C1 & C0;
end architecture; 