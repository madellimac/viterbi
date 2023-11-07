-------------------------------------------------------------------------------
--                                                                           --
-- File            : rom_sigma.vhd                                           --
-- Related file    : rom_pkg.vhd                                             --
--                                                                           --
--                                                                           --
-- Authors         : Olivier MULLER                                          --
-- Projet          : noise generator                                         --
--                                                                           --
-- creation date   : 14/05/2002                                              --
--                                                                         --
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.rom_pkg.all;


ENTITY  rom_sigma IS 
	PORT(
		clk      : IN  std_logic;
		rst      : IN  std_logic;
	  	sb      : IN std_logic_vector(5 DOWNTO 0);
      sigma  : OUT std_logic_vector(15 DOWNTO 0)
	    ); 
END  rom_sigma;

-------------------------------------------------------------------------------
-- Architecture                                                              --
-------------------------------------------------------------------------------
ARCHITECTURE rtl OF rom_sigma IS


BEGIN

	sync : PROCESS(rst,clk) 
	BEGIN
		IF rst = '1' THEN
			sigma <= rom_sig(sb);
		ELSIF (clk'EVENT AND clk='1') THEN
			sigma <= rom_sig(sb);
		END IF; 
	END PROCESS sync ;

END rtl;