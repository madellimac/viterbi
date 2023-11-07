----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: random_data_generator   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity random_data_generator is
	port (clk : in std_logic;
			rst : in std_logic;
			init_lfsr : in std_logic;
			enable : in  std_logic;
			rand_data : out std_logic);
end random_data_generator;

architecture Behavioral of random_data_generator is

signal reg : std_logic_vector (14 downto 0);
signal linear_feedback : std_logic;

begin


linear_feedback <= (reg(14) xor reg(13));

process (clk, rst) begin
	if (rst = '1') then
		reg <= (others => '0');
	elsif (rising_edge(clk)) then
		
		if(init_lfsr = '1') then
			reg <= "000000010101001";
		elsif(enable = '1') then
			reg <= (reg(13 downto 0) & linear_feedback);
		end if;

	end if;
end process;

rand_data <= linear_feedback;

end Behavioral;

