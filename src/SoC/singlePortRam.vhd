library ieee;
use ieee.std_logic_1164.all;


entity singlePortRam is generic(BUS_LENGTH : Natural :=32);
port (
		clk : in std_logic ;
		r_w : in std_logic;--read write enable signal , r_w = '1' for writing , r_w = '0' for reading 
		addr : in std_logic_vector(BUS_LENGTH-1 downto 0);
		i_data : in std_logic_vector(7 downto 0);
		o_data : out std_logic_vector(7 downto 0);
);
end entity;


architecture singlePortRamArch of singlePortRam is
type ram_t is array(2**BUS_LENGTH - 1 downto 0) of std_logic_vector(7 downto 0);
signal ram : ram_t := (others => x"00");
begin
     process (clk)
	 begin
	      if (rising_edge(clk) = '1') then 
		      if (r_w = '1') then --reading from RAM 
			      o_data <= ram(addr);
			  else --r_w = '0' 
			      ram(addr) <= i_data;
	 end process;



end architecture;