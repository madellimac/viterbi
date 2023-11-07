-------------------------------------------------------------------------------
--                                                                           --
-- Authors         : Olivier Muller       		                       --
-- Projet          : noise generator                                         --
--                                                                           --
-- creation date   : 13/04/2000                                              --
--                                                                           --
-- Description     : multiplication du bruit blanc unitaire par le sigma     --
--                  Input :                                                  --
--                      sigma      				                       --
--                      wgng					                       --
--                  Output :                                                 --
--                      wgn_s : white gaussian noise sample                  --
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY mult6x6 IS
    PORT (
        clk     : IN  std_logic;
        rst     : IN  std_logic;
        sigma   : IN  std_logic_vector(15 DOWNTO 0);
        wgng    : IN  std_logic_vector(10 DOWNTO 0);
        wgn_s   : OUT std_logic_vector(9 DOWNTO 0)
    );
END mult6x6;

-------------------------------------------------------------------------------
--  Architecture                                                             --
-------------------------------------------------------------------------------
ARCHITECTURE rtl OF mult6x6 IS

BEGIN

multi : PROCESS(clk, rst)
	
	CONSTANT arrondi : signed(9 DOWNTO 0) := "0000000001";
	VARIABLE SB : unsigned(15 DOWNTO 0);
	VARIABLE SA : signed(10 DOWNTO 0);
	VARIABLE SC : signed (27 DOWNTO 0);

BEGIN
	IF rst='1' THEN
		
		wgn_s <= (OTHERS => '0');
		SA := (OTHERS => '0');
		SB := (OTHERS => '0');
		SC := (OTHERS => '0');
		
	ELSIF (clk'event and clk='1') THEN
	
--		SA(9)  := wgng(9);
--    SA(8)  := wgng(8);
--		SA(7)  := wgng(7);
--		SA(6)  := wgng(6);

		SB(15) := sigma(15);
		SB(14) := sigma(14);
		SB(13) := sigma(13);
		SB(12) := sigma(12);
		SB(11) := sigma(11);
--		SB(10) := sigma(10);
--		SB(9) := sigma(9);
--		SB(8) := sigma(8);
--		SB(7) := sigma(7);
--		SB(6) := sigma(6);
		
		FOR i IN 10 DOWNTO 0 LOOP
			SA(i) := wgng(i);		  --(4,7)
			SB(i) := sigma(i);	  --(0,16)
		END LOOP;

     SC := SA*SB;	  -- (5,23)
	  
--		-- On prend les 10 plus grand nombre avec un arrondi au plus pres
-- 		IF SC(22) = '0' THEN
--      	wgn_s <= conv_std_logic_vector(SC(21 DOWNTO 12),10); --(4,6)
--		ELSE
--			wgn_s <= conv_std_logic_vector(SC(21 DOWNTO 12)+ arrondi,10);
--		END IF;

		-- On prend les 10 plus grand nombre avec un arrondi au plus pres
 		IF SC(16) = '0' THEN
      	wgn_s <= conv_std_logic_vector(SC(26 DOWNTO 17),10); --(4,6)
		ELSE
			wgn_s <= conv_std_logic_vector(SC(26 DOWNTO 17)+arrondi,10);
		END IF;

	END IF;
	END PROCESS;
END rtl;


