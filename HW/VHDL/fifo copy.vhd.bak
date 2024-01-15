----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: fifo   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo is
port(	rst : in std_logic;
		clk : in std_logic;
		enable : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic);
end fifo;

architecture Behavioral of fifo is

signal reg : std_logic_vector(24 downto 0);

begin

    process (rst,CLK)
    begin
        if(rst='1') then
				reg <= (others => '0');
		  elsif (CLK'event and CLK = '1') then
		  
				reg(0) <= data_in;
				reg(1) <= reg(0);
				reg(2) <= reg(1);
				reg(3) <= reg(2);
				reg(4) <= reg(3);
				reg(5) <= reg(4);
				reg(6) <= reg(5);
				reg(7) <= reg(6);
				reg(8) <= reg(7);
				reg(9) <= reg(8);
				reg(10) <= reg(9);
				reg(11) <= reg(10);
				reg(12) <= reg(11);
				reg(13) <= reg(12);
				reg(14) <= reg(13);
				reg(15) <= reg(14);
				reg(16) <= reg(15);
				reg(17) <= reg(16);
				reg(18) <= reg(17);
				reg(19) <= reg(18);
				reg(20) <= reg(19);
				reg(21) <= reg(20);
				reg(22) <= reg(21);
				reg(23) <= reg(22);
				reg(24) <= reg(23);
        end if;
    end process;
	 
	 data_out <= reg(24);
	 
end Behavioral;

