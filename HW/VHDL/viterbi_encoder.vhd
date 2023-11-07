----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: viterbi_encoder   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity viterbi_encoder is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           data : in  STD_LOGIC;
           x1 : out  STD_LOGIC;
			  x2 : out  STD_LOGIC);
end viterbi_encoder;

architecture Behavioral of viterbi_encoder is

signal shift_register : std_logic_vector(2 downto 0);

begin

process(rst,clk)
begin
	if(rst='1') then
		shift_register <=(others =>'0');
	elsif(clk'event and clk='1') then
		if(enable='1') then
			shift_register(1 downto 0) <= shift_register(2 downto 1);
			shift_register(2) <= data;
		end if;
	end if;
end process;

x2 <= data xor shift_register(1) xor shift_register(0);
x1 <= data xor shift_register(2) xor shift_register(0);


end Behavioral;

