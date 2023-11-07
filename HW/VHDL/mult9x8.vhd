-------------------------------------------------------------------------------
--                                                                           --
-- File            : rom_cos.vhd                                             --
-- Related file    : rom_pkg.vhd                                             --
--                                                                           --
--                                                                           --
-- Authors         : H. Laamari J-L Danger E. Boutillon                      --
-- Projet          : noise generator                                         --
--                                                                           --
-- creation date   : 13/04/2000                                              --
--                                                                           --
-- Description     : multiplication of the quantized cosine value and the    --
--                   quantized logarithm value of the Box-mullet algorithm   --
--                  Input :                                                  --
--                      Q_cos_v : Quantized cosine value                     --
--                      Q_ln_v : Quantized logarithm value                   --
--                  Output :                                                 --
--                      wgn_s : white gaussian noise sample                  --
-------------------------------------------------------------------------------
-- Modification :                                                            --
--               NOTE : you can use every multiplacation function with       --
--                      pipe-line                                            --
-------------------------------------------------------------------------------
-- Copyrigth LESTER, Universite de Bretagne Sud, 2001                        --
--           ENST Paris                                                      --
-- This software is distributed under a GPL licence                          --
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mult9x8 IS
    PORT (
        clk     : IN  std_logic;
        rst     : IN  std_logic;
        Q_cos_v : IN  std_logic_vector(7 DOWNTO 0); --(1,7)
        Q_ln_v  : IN  std_logic_vector(8 DOWNTO 0); --(2,7)
        wgn_s   : OUT std_logic_vector(8 DOWNTO 0) 
    );
END mult9x8;

-------------------------------------------------------------------------------
--  Architecture                                                             --
-------------------------------------------------------------------------------
ARCHITECTURE rtl OF mult9x8 IS

--signal SA : std_logic_vector(8 DOWNTO 0);
--signal SB : std_logic_vector(7 DOWNTO 0);
--signal SC : std_logic_vector (16 DOWNTO 0);


BEGIN

multi : PROCESS(clk, rst)

	VARIABLE SA : unsigned(8 DOWNTO 0);
	VARIABLE SB : unsigned(7 DOWNTO 0);
   VARIABLE SC : unsigned (16 DOWNTO 0);
	CONSTANT arrondi : unsigned(8 DOWNTO 0) := "000000001";
	
BEGIN
	IF rst='1' THEN
		
		wgn_s <= (OTHERS => '0');
		SA := (OTHERS => '0');
		SB := (OTHERS => '0');
		SC := (OTHERS => '0');
		
	ELSIF (clk'event and clk='1') THEN
	
		SA(8)  := Q_ln_v(8);
		FOR i IN 7 DOWNTO 0 LOOP
			SA(i) := Q_ln_v(i);
         SB(i) := Q_cos_v(i);
		END LOOP;

      SC := SA*SB;
 		
		-- The 9 MSB of SC are affected to the output of the function
		if SC(7)='0' then
			wgn_s <= conv_std_logic_vector(SC(16 DOWNTO 8),9);
		else
			wgn_s <= conv_std_logic_vector(SC(16 DOWNTO 8)+arrondi,9); --(3,6)
		end if;

   -- wgn_s <= Q_ln_v * Q_cos_v; --(3,14)
 	
 	--if SC(16)='1' then
 	--   wgn_s <= SC(16 DOWNTO 7)-SC(6);
 	--else
 	--   wgn_s <= SC(16 DOWNTO 7)+SC(6);
 	--end if;   
 		
	END IF;
	END PROCESS;
END rtl;


