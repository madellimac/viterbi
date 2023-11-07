----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: data_adapter   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_adapter is
	port(	data_in : in std_logic_vector (2 downto 0);
			data_out : out std_logic_vector (2 downto 0));
end data_adapter;

architecture Behavioral of data_adapter is

begin

	data_adapter : process(data_in)
	begin
		case data_in is
			when "000" => data_out <= "011";
			when "001" => data_out <= "010";
			when "010" => data_out <= "001";
			when "011" => data_out <= "000";
			when "100" => data_out <= "111";
			when "101" => data_out <= "110";
			when "110" => data_out <= "101";
			when "111" => data_out <= "100";
			when others => data_out <= "000";
		end case;
	end process;

end Behavioral;

