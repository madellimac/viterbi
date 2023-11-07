----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: ACS   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity ACS is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			MB_0 : in std_logic_vector(3 downto 0);
			MB_1 : in std_logic_vector(3 downto 0);
			MN_0 : in std_logic_vector(6 downto 0);
			MN_1 : in std_logic_vector(6 downto 0);
			MN_out : out std_logic_vector(6 downto 0);
			decision : out std_logic);
end ACS;

architecture Behavioral of ACS is

signal MN_0_new, MN_1_new : std_logic_vector(6 downto 0);
signal next_MN : std_logic_vector(6 downto 0);

begin

	MN_0_new <= ("000")&MB_0 + MN_0;
	MN_1_new <= ("000")&MB_1 + MN_1;

	compare_and_select : process(MN_0_new,MN_1_new)
	begin
		if(MN_0_new < MN_1_new) then
			decision <= '0';
			next_MN <= MN_0_new;
		else
			decision <= '1';
			next_MN <= MN_1_new;
		end if;
	end process;

    process (rst,CLK)
    begin
        if(rst='1') then
				MN_out <= (others => '0');
		  elsif (CLK'event and CLK = '1') then
            if (enable = '1') then
                MN_out<= next_MN;
            end if;
        end if;
    end process;

end Behavioral;