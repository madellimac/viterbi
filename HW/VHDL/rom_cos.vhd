-------------------------------------------------------------------------------
--                                                                           --
-- File            : rom_cos.vhd                                             --
-- Related file    : rom_pkg.vhd                                             --
--                                                                           --
--                                                                           --
-- Authors         : H. Laamari J-L Danger                                   --
-- Projet          : noise generator                                         --
--                                                                           --
-- creation date   : 13/04/2000                                              --
--                                                                           --
-- Description     : generation of the quantized logarithm according to the  --
--                   the input value                                         --
--                  Input :                                                  --
--                      rbv : random binary vector                           --
--                  Output :                                                 --
--                      Q_cos_v : Quantized cosine value                     --
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


ENTITY  rom_cos  IS 
	PORT(
		clk      : IN  std_logic;
		rst      : IN  std_logic;
	
       	rbv      : IN std_logic_vector(7 DOWNTO 0);
            Q_cos_v  : OUT std_logic_vector(7 DOWNTO 0)
	    ); 
END  rom_cos;

-------------------------------------------------------------------------------
-- Architecture                                                              --
-------------------------------------------------------------------------------
ARCHITECTURE rtl OF rom_cos IS


BEGIN

sync : PROCESS(rst,clk) 

BEGIN
	IF rst = '1' THEN
		Q_cos_v <= (OTHERS => '0');
	ELSIF (clk'EVENT AND clk='1') THEN
		Q_cos_v <= rom_cosine(rbv) ;
      END IF; 
END PROCESS sync ;


END rtl;









