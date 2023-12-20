----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: viterbi_decoder   
-- Description: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branch_metric_unit is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			y1 : in std_logic_vector(2 downto 0);
			y2 : in std_logic_vector(2 downto 0);
			MB00 : out std_logic_vector(3 downto 0);
			MB01 : out std_logic_vector(3 downto 0);
			MB10 : out std_logic_vector(3 downto 0);
			MB11 : out std_logic_vector(3 downto 0));
end branch_metric_unit;

architecture Behavioral of branch_metric_unit is

	type rom_type is array (0 to 63) of std_logic_vector (3 downto 0);                 

   signal ROM_MB00 : rom_type:= ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
                             "0001", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
									  "0010", "0010", "0010", "0011", "0100", "0101", "0110", "0111",
									  "0011", "0011", "0011", "0100", "0101", "0101", "0110", "0111",
									  "0100", "0100", "0100", "0101", "0101", "0110", "0111", "1000",
									  "0101", "0101", "0101", "0101", "0110", "0111", "0111", "1000",
									  "0110", "0110", "0110", "0110", "0111", "0111", "1000", "1001",
									  "0111", "0111", "0111", "0111", "1000", "1000", "1001", "1001");                        
																				
	signal ROM_MB01 : rom_type:= ("0111", "0111", "0111", "0111", "1000", "1000", "1001", "1001",
									  "0110", "0110", "0110", "0110", "0111", "0111", "1000", "1001",
									  "0101", "0101", "0101", "0101", "0110", "0111", "0111", "1000",
									  "0100", "0100", "0100", "0101", "0101", "0110", "0111", "1000",
									  "0011", "0011", "0011", "0100", "0101", "0101", "0110", "0111",
		  							  "0010","0010","0010","0011","0100","0101","0110","0111",
	  								  "0001","0001","0010","0011","0100","0101","0110","0111",
  									  "0000","0001","0010","0011","0100","0101","0110","0111");
	
	signal ROM_MB10 : rom_type:= ("0111","0110","0101","0100","0011","0010","0001","0000",
										"0111","0110","0101","0100","0011","0010","0001","0001",
										"0111","0110","0101","0100","0011","0010","0010","0010",
										"0111","0110","0101","0101","0100","0011","0011","0011",
										"1000","0111","0110","0101","0101","0100","0100","0100",
										"1000","0111","0111","0110","0101","0101","0101","0101",
										"1001","1000","0111","0111","0110","0110","0110","0110",
										"1001","1001","1000","1000","0111","0111","0111","0111");

	signal ROM_MB11 : rom_type:= ("1001","1001","1000","1000","0111","0111","0111","0111",
											"1001","1000","0111","0111","0110","0110","0110","0110",
											"1000","0111","0111","0110","0101","0101","0101","0101",
											"1000","0111","0110","0101","0101","0100","0100","0100",
											"0111","0110","0101","0101","0100","0011","0011","0011",
											"0111","0110","0101","0100","0011","0010","0010","0010",
											"0111","0110","0101","0100","0011","0010","0001","0001",
											"0111","0110","0101","0100","0011","0010","0001","0000");

	signal address : std_logic_vector(5 downto 0);
	--signal rMB00, rMB01, rMB10, rMB11 : std_logic_vector(3 downto 0);
	
begin

address <= y2&y1;

    --rMB00 <= ROM_MB00(conv_integer(address));
    --rMB01 <= ROM_MB01(conv_integer(address));
    --rMB10 <= ROM_MB10(conv_integer(address));
    --rMB11 <= ROM_MB11(conv_integer(address));

    process (rst,CLK)
    begin
        if(rst='1') then
				MB00 <= (others => '0');
				MB01 <= (others => '0');
				MB10 <= (others => '0');
				MB11 <= (others => '0');
		  elsif (CLK'event and CLK = '1') then
            if (enable = '1') then
                --MB00 <= rMB00;
					 --MB01 <= rMB01;
					 --MB10 <= rMB10;
					 --MB11 <= rMB11;		
			MB00 <= std_logic_vector(unsigned('0'&y1) + unsigned('0'&y2)); 
			MB01 <= std_logic_vector(unsigned('0'&y1) + to_unsigned(7,4) - unsigned('0'&y2)); 
			MB10 <= std_logic_vector(to_unsigned(7,4) - unsigned('0'&y1) + unsigned('0'&y2));
			MB11 <= std_logic_vector(to_unsigned(7,4) - unsigned('0'&y1) + to_unsigned(7,4) - unsigned('0'&y2));
            end if;
        end if;
    end process;
	 
--MB00 <= y1 + y2;
--MB01 <= y1 + (7-y2);
--MB10 <= (7-y1) + y2;
--MB11 <= (7-y1) + (7-y2)

end Behavioral;

