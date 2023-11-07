-------------------------------------------------------------------------------
--                                                                           --
-- File            : rom_ln.vhd                                              --
-- Related file    : rom_pkg.vhd                                             --
--                                                                           --
--                                                                           --
-- Authors         : Jean-Luc Danger, Emmanuel Boutillon                     --
-- Projet          : noise generator                                         --
--                                                                           --
-- Creation date   : 01/09/2000                                              --
--                                                                           --
-- Description     : generation of the quantized logarithm according to the  --
--                   the input value                                         --
--                  Input :                                                  --
--                      rbv : random binary vector                           --
--                  Output :                                                 --
--                      Q_ln_v : Quantized logarithm value                   --
-------------------------------------------------------------------------------
-- Modification :                                                            --
-------------------------------------------------------------------------------
-- Copyrigth LESTER, Universite de Bretagne Sud, 2001                        --
--           ENST Paris                                                      --
-- This software is distributed under a GPL licence                          --
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.rom_pkg.all;


ENTITY  rom_ln  IS 
	PORT(
		rst      : IN std_logic;
		clk      : IN  std_logic;
     	      rbv      : IN std_logic_vector(19 downto 0);
            Q_ln_v   : OUT std_logic_vector(8 downto 0)
	    ); 
END  rom_ln;


-------------------------------------------------------------------------------
--  Architecture                                                             --
-------------------------------------------------------------------------------
ARCHITECTURE rtl OF rom_ln IS


BEGIN
   

sync: PROCESS(rst, clk) 

VARIABLE sel : std_logic_vector(4 downto 1);
VARIABLE sel1 : std_logic;
VARIABLE sel23 : std_logic;
VARIABLE rom1 : std_logic_vector(8 downto 0);
VARIABLE rom23 : std_logic_vector(8 downto 0);
VARIABLE rom45 : std_logic_vector(8 downto 0);


BEGIN
	IF rst = '1' THEN
		Q_ln_v <= (OTHERS => '0');
	ELSIF (clk'EVENT AND clk='1') THEN
        sel(1) := NOT(rbv(3) or rbv(2) or rbv(1) or rbv(0));
        sel(2) := NOT(rbv(7) or rbv(6) or rbv(5) or rbv(4));
        sel(3) := NOT(rbv(11) or rbv(10) or rbv(9) or rbv(8));
        sel(4) := NOT(rbv(15) or rbv(14) or rbv(13) or rbv(12));
        sel23 := sel(2) and sel(3);

       	rom1  := rom_1(rbv(3 downto 0));

        IF sel(2) = '0' THEN 
            rom23 := rom_2(rbv(7 DOWNTO 4));
        ELSE
            rom23 := rom_3(rbv(11 downto 8));
        END IF;
        
        IF sel(4) = '0' THEN 
            rom45 := rom_4(rbv(15 downto 12));
        ELSE
            rom45 := rom_5(rbv(19 downto 16));
        END IF;
        
        IF sel(1) = '0' THEN 
            Q_ln_v <= rom1;
        ELSIF (sel(2) and sel(3)) = '0' THEN
            Q_ln_v <= rom23;
        ELSE
            Q_ln_v <= rom45;
        END IF;

    END IF; 
END PROCESS sync ;

END rtl;









