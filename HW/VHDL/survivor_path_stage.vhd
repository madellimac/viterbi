----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: survivor_path_stage   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use work.definition_pkg.all;

entity survivor_path_stage is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			decision  : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0));
end survivor_path_stage;

architecture Behavioral of survivor_path_stage is

signal reg_data : std_logic_vector(7 downto 0);

begin

    process (rst,CLK)
    begin
        if(rst='1') then
				reg_data <= (others => '0');
		  elsif (CLK'event and CLK = '1') then            
			if(enable = '1') then
            reg_data <= data_in;            
			end if;
        end if;
    end process;

process(decision, reg_data)
begin
	if(decision(0) = '0') then
		data_out(0) <= reg_data(0);
	else
		data_out(0) <= reg_data(1);
	end if;
	
	if(decision(1) = '0') then
		data_out(1) <= reg_data(2);
	else
		data_out(1) <= reg_data(3);
	end if;
	
	if(decision(2) = '0') then
		data_out(2) <= reg_data(4);
	else
		data_out(2) <= reg_data(5);
	end if;
	
	if(decision(3) = '0') then
		data_out(3) <= reg_data(6);
	else
		data_out(3) <= reg_data(7);
	end if;
	
	if(decision(4) = '0') then
		data_out(4) <= reg_data(0);
	else
		data_out(4) <= reg_data(1);
	end if;
	
	if(decision(5) = '0') then
		data_out(5) <= reg_data(2);
	else
		data_out(5) <= reg_data(3);
	end if;
	
	if(decision(6) = '0') then
		data_out(6) <= reg_data(4);
	else
		data_out(6) <= reg_data(5);
	end if;
	
	if(decision(7) = '0') then
		data_out(7) <= reg_data(6);
	else
		data_out(7) <= reg_data(7);
	end if;
	
end process;

end Behavioral;


