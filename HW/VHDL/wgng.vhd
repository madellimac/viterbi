----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:25 01/23/2009 
-- Design Name: 
-- Module Name:    hamming_wgng - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

USE work.lfsr_pkg.all; -- ajouter ces 2 fichiers au projet et les placer en haut de la
USE work.rom_pkg.all;  -- liste des fichiers du projet pour qu'ils soient compil�en premier

USE work.wgng_pkg.all;

entity wgng is
PORT (
      clk         : IN  std_logic;
		rst         : IN  std_logic;
		config      : IN  std_logic;
		seed        : IN  std_logic;
		init_lfsr_cos1_01 : IN std_logic_vector(23 downto 0);
		init_lfsr_cos1_02 : IN std_logic_vector(23 downto 0);
		init_lfsr_cos1_03 : IN std_logic_vector(23 downto 0);
		init_lfsr_cos1_04 : IN std_logic_vector(23 downto 0);
		init_lfsr_cos2_01 : IN std_logic_vector(22 downto 0);
		init_lfsr_cos2_02 : IN std_logic_vector(22 downto 0);
		init_lfsr_cos2_03 : IN std_logic_vector(22 downto 0);
		init_lfsr_cos2_04 : IN std_logic_vector(22 downto 0);
		init_lfsr_ln1_01 : IN std_logic_vector(29 downto 0);
		init_lfsr_ln1_02 : IN std_logic_vector(29 downto 0);
		init_lfsr_ln1_03 : IN std_logic_vector(29 downto 0);
		init_lfsr_ln1_04 : IN std_logic_vector(29 downto 0);
		init_lfsr_ln2_01 : IN std_logic_vector(28 downto 0);
		init_lfsr_ln2_02 : IN std_logic_vector(28 downto 0);
		init_lfsr_ln2_03 : IN std_logic_vector(28 downto 0);
		init_lfsr_ln2_04 : IN std_logic_vector(28 downto 0);
		init_lfsr_ln3_01 : IN std_logic_vector(26 downto 0);
		init_lfsr_ln3_02 : IN std_logic_vector(26 downto 0);
		init_lfsr_ln3_03 : IN std_logic_vector(26 downto 0);
		init_lfsr_ln3_04 : IN std_logic_vector(26 downto 0);
		init_lfsr_ln4_01 : IN std_logic_vector(25 downto 0);
		init_lfsr_ln4_02 : IN std_logic_vector(25 downto 0);
		init_lfsr_ln4_03 : IN std_logic_vector(25 downto 0);
		init_lfsr_ln4_04 : IN std_logic_vector(25 downto 0);
		init_lfsr_ln5_01 : IN std_logic_vector(24 downto 0);
		init_lfsr_ln5_02 : IN std_logic_vector(24 downto 0);
		init_lfsr_ln5_03 : IN std_logic_vector(24 downto 0);
		init_lfsr_ln5_04 : IN std_logic_vector(24 downto 0);
		init_lfsr_signe_01 : IN std_logic_vector(27 downto 0);
		init_lfsr_signe_02 : IN std_logic_vector(27 downto 0);
		init_lfsr_signe_03 : IN std_logic_vector(27 downto 0);
		init_lfsr_signe_04 : IN std_logic_vector(27 downto 0);		
     	wgn					: OUT std_logic_vector(10 downto 0)
		 );
end wgng;

architecture Behavioral of wgng is

	COMPONENT lfsr_slice
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		init_lfsr_cos1 : IN std_logic_vector(23 downto 0);
		init_lfsr_cos2 : IN std_logic_vector(22 downto 0);
		init_lfsr_ln1 : IN std_logic_vector(29 downto 0);
		init_lfsr_ln2 : IN std_logic_vector(28 downto 0);
		init_lfsr_ln3 : IN std_logic_vector(26 downto 0);
		init_lfsr_ln4 : IN std_logic_vector(25 downto 0);
		init_lfsr_ln5 : IN std_logic_vector(24 downto 0);
		init_lfsr_signe : IN std_logic_vector(27 downto 0);
		config : IN std_logic;
		seed : IN std_logic;          
		rbv : OUT std_logic_vector(28 downto 0)
		);
	END COMPONENT;
		
	COMPONENT rom_cos PORT(
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			rbv      : IN std_logic_vector(7 DOWNTO 0);
			Q_cos_v  : OUT std_logic_vector(7 DOWNTO 0)
			); 
	END COMPONENT;
	
	COMPONENT rom_ln PORT(
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			rbv      : IN std_logic_vector(19 DOWNTO 0);
			Q_ln_v   : OUT std_logic_vector(8 DOWNTO 0)
			); 
	END COMPONENT;
	
	COMPONENT mult9x8 PORT( 
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			Q_cos_v : IN std_logic_vector(7 DOWNTO 0);
			Q_ln_v  : IN std_logic_vector(8 DOWNTO 0);
			wgn_s   : OUT std_logic_vector(8 DOWNTO 0)
			);
	END COMPONENT;

SIGNAL rbv001, rbv002, rbv003, rbv004  : std_logic_vector(28 DOWNTO 0);
		
SIGNAL Q_cos_v001, Q_cos_v002, Q_cos_v003, Q_cos_v004:  std_logic_vector(7 DOWNTO 0);
		
SIGNAL Q_ln_v001, Q_ln_v002,Q_ln_v003, Q_ln_v004 :  std_logic_vector(8 DOWNTO 0);
		
SIGNAL wgn001_s, wgn002_s, wgn003_s, wgn004_s  : std_logic_vector(8 downto 0);
	
SIGNAL wgn001_s2, wgn002_s2, wgn003_s2, wgn004_s2 : std_logic_vector(8 downto 0);



SIGNAL A : std_logic_vector(9 downto 0);

SIGNAL B : std_logic_vector(9 downto 0);

SIGNAL C : std_logic_vector(10 downto 0);

--	SIGNAL init_lfsr_cos1_01  :  std_logic_vector(23 downto 0) := "001000010110111110010101";
--	SIGNAL init_lfsr_cos1_02  :  std_logic_vector(23 downto 0) := "111011010010101001111101";
--	SIGNAL init_lfsr_cos1_03  :  std_logic_vector(23 downto 0) := "111101010101001011110101";
--	SIGNAL init_lfsr_cos1_04  :  std_logic_vector(23 downto 0) := "000101001001101110110110";
--	
--	SIGNAL init_lfsr_cos2_01  :  std_logic_vector(22 downto 0) := "00101111111000000011011";
--	SIGNAL init_lfsr_cos2_02  :  std_logic_vector(22 downto 0) := "11001001100000111111000";
--	SIGNAL init_lfsr_cos2_03  :  std_logic_vector(22 downto 0) := "10111010010001111110101";
--	SIGNAL init_lfsr_cos2_04  :  std_logic_vector(22 downto 0) := "01101111100011110101000";
--	
--	SIGNAL init_lfsr_ln1_01   :  std_logic_vector(29 downto 0) := "010101110011101111110100101111";
--	SIGNAL init_lfsr_ln1_02   :  std_logic_vector(29 downto 0) := "100000011000111010000100111101";
--	SIGNAL init_lfsr_ln1_03   :  std_logic_vector(29 downto 0) := "011111110110001011001001110001";
--	SIGNAL init_lfsr_ln1_04   :  std_logic_vector(29 downto 0) := "010011110010000011101001110110";
--	
--	SIGNAL init_lfsr_ln2_01   :  std_logic_vector(28 downto 0) := "10001111111000111011110011001";
--	SIGNAL init_lfsr_ln2_02   :  std_logic_vector(28 downto 0) := "10011101011111110000100100010";
--	SIGNAL init_lfsr_ln2_03   :  std_logic_vector(28 downto 0) := "11111101001011110111010101011";
--	SIGNAL init_lfsr_ln2_04   :  std_logic_vector(28 downto 0) := "00000110001001101100001010100";
--	
--	SIGNAL init_lfsr_ln3_01   :  std_logic_vector(26 downto 0) := "101111111001001111101111010";
--	SIGNAL init_lfsr_ln3_02   :  std_logic_vector(26 downto 0) := "111011111110000011010001010";
--	SIGNAL init_lfsr_ln3_03   :  std_logic_vector(26 downto 0) := "101010010110010011100011111";
--	SIGNAL init_lfsr_ln3_04   :  std_logic_vector(26 downto 0) := "101010000000111101110000111";
--	
--	SIGNAL init_lfsr_ln4_01   :  std_logic_vector(25 downto 0) := "11110011100111001101010101";
--	SIGNAL init_lfsr_ln4_02   :  std_logic_vector(25 downto 0) := "11111110100010011011110110";
--	SIGNAL init_lfsr_ln4_03   :  std_logic_vector(25 downto 0) := "10111011110101111111011111";
--	SIGNAL init_lfsr_ln4_04   :  std_logic_vector(25 downto 0) := "00001000111100111110100110";
--		
--	SIGNAL init_lfsr_ln5_01   :  std_logic_vector(24 downto 0) := "1110100111100111110110101";
--	SIGNAL init_lfsr_ln5_02   :  std_logic_vector(24 downto 0) := "1011001010011101110000100";
--	SIGNAL init_lfsr_ln5_03   :  std_logic_vector(24 downto 0) := "1000110001100010011001101";
--	SIGNAL init_lfsr_ln5_04   :  std_logic_vector(24 downto 0) := "1000000011101111001101100";
--		
--	SIGNAL init_lfsr_signe_01 :  std_logic_vector(27 downto 0) := "1011001010001100010111011011";
--	SIGNAL init_lfsr_signe_02 :  std_logic_vector(27 downto 0) := "1011010001010101111110111000";
--	SIGNAL init_lfsr_signe_03 :  std_logic_vector(27 downto 0) := "1010110010101010111010001110";
--	SIGNAL init_lfsr_signe_04 :  std_logic_vector(27 downto 0) := "0000000110101010100001110011";

begin


inst_lfsr_slice_01: lfsr_slice PORT MAP(
		clk => clk,
		rst => rst,
		init_lfsr_cos1  => init_lfsr_cos1_01,
		init_lfsr_cos2  => init_lfsr_cos2_01,
		init_lfsr_ln1   => init_lfsr_ln1_01,
		init_lfsr_ln2   => init_lfsr_ln2_01,
		init_lfsr_ln3   => init_lfsr_ln3_01,
		init_lfsr_ln4   => init_lfsr_ln4_01,
		init_lfsr_ln5   => init_lfsr_ln5_01,
		init_lfsr_signe => init_lfsr_signe_01,
		config => config,
		seed => seed,
		rbv => rbv001
	);

inst_lfsr_slice_02: lfsr_slice PORT MAP(
		clk => clk,
		rst => rst,
		init_lfsr_cos1  => init_lfsr_cos1_02,
		init_lfsr_cos2  => init_lfsr_cos2_02,
		init_lfsr_ln1   => init_lfsr_ln1_02,
		init_lfsr_ln2   => init_lfsr_ln2_02,
		init_lfsr_ln3   => init_lfsr_ln3_02,
		init_lfsr_ln4   => init_lfsr_ln4_02,
		init_lfsr_ln5   => init_lfsr_ln5_02,
		init_lfsr_signe => init_lfsr_signe_02,
		config => config,
		seed => seed,
		rbv => rbv002
	);
	
inst_lfsr_slice_0F: lfsr_slice PORT MAP(
		clk => clk,
		rst => rst,
		init_lfsr_cos1  => init_lfsr_cos1_03,
		init_lfsr_cos2  => init_lfsr_cos2_03,
		init_lfsr_ln1   => init_lfsr_ln1_03,
		init_lfsr_ln2   => init_lfsr_ln2_03,
		init_lfsr_ln3   => init_lfsr_ln3_03,
		init_lfsr_ln4   => init_lfsr_ln4_03,
		init_lfsr_ln5   => init_lfsr_ln5_03,
		init_lfsr_signe => init_lfsr_signe_03,
		config => config,
		seed => seed,
		rbv => rbv003
	);


inst_lfsr_slice_10: lfsr_slice PORT MAP(
		clk => clk,
		rst => rst,
		init_lfsr_cos1  => init_lfsr_cos1_04,
		init_lfsr_cos2  => init_lfsr_cos2_04,
		init_lfsr_ln1   => init_lfsr_ln1_04,
		init_lfsr_ln2   => init_lfsr_ln2_04,
		init_lfsr_ln3   => init_lfsr_ln3_04,
		init_lfsr_ln4   => init_lfsr_ln4_04,
		init_lfsr_ln5   => init_lfsr_ln5_04,
		init_lfsr_signe => init_lfsr_signe_04,
		config => config,
		seed => seed,
		rbv => rbv004
	);

inst_rom_ln001 : rom_ln PORT MAP (clk,rst,rbv001(27 downto 8),Q_ln_v001);
inst_rom_ln002 : rom_ln PORT MAP (clk,rst,rbv002(27 downto 8),Q_ln_v002);
inst_rom_ln003 : rom_ln PORT MAP (clk,rst,rbv003(27 downto 8),Q_ln_v003);
inst_rom_ln010 : rom_ln PORT MAP (clk,rst,rbv004(27 downto 8),Q_ln_v004);

inst_rom_cos001 : rom_cos PORT MAP (clk,rst,rbv001(7 downto 0),Q_cos_v001);
inst_rom_cos002 : rom_cos PORT MAP (clk,rst,rbv002(7 downto 0),Q_cos_v002);
inst_rom_cos003 : rom_cos PORT MAP (clk,rst,rbv003(7 downto 0),Q_cos_v003);
inst_rom_cos010 : rom_cos PORT MAP (clk,rst,rbv004(7 downto 0),Q_cos_v004);

inst_mult001 : mult9x8 PORT MAP (clk,rst,Q_cos_v001,Q_ln_v001,wgn001_s);
inst_mult002 : mult9x8 PORT MAP (clk,rst,Q_cos_v002,Q_ln_v002,wgn002_s);
inst_mult003 : mult9x8 PORT MAP (clk,rst,Q_cos_v003,Q_ln_v003,wgn003_s);
inst_mult010 : mult9x8 PORT MAP (clk,rst,Q_cos_v004,Q_ln_v004,wgn004_s);

process(clk,rst)
begin
    
    IF rst ='1' THEN
       
      wgn001_s2 <= (others => '0');
		wgn002_s2 <= (others => '0');
		wgn003_s2 <= (others => '0');
		wgn004_s2 <= (others => '0');
				
		A <= (others => '0');
		B <= (others => '0');
		C <= (others => '0');
	
		   ELSIF (clk'event and clk='1') THEN
      
		if rbv001(28) = '0' then wgn001_s2 <= wgn001_s; else wgn001_s2 <= NOT(wgn001_s); end if;
		if rbv002(28) = '0' then wgn002_s2 <= wgn002_s; else wgn002_s2 <= NOT(wgn002_s); end if;
		if rbv003(28) = '0' then wgn003_s2 <= wgn003_s; else wgn003_s2 <= NOT(wgn003_s); end if;
		if rbv004(28) = '0' then wgn004_s2 <= wgn004_s; else wgn004_s2 <= NOT(wgn004_s); end if;
		
		A <= (wgn001_s2(8)&wgn001_s2) + (wgn003_s2(8)&wgn003_s2); --(3,6)+(3,6) = (4,6)
		
		B <= (wgn002_s2(8)&wgn002_s2) + (wgn004_s2(8)&wgn004_s2); --(3,6)+(3,6) = (4,6)
	
		C <= (A(9)&A) + (B(9)&B); --(4,6)+(4,6) = (5,6)

    END IF;
    
end process;

wgn <= C;-- (5,6) / sqrt(nb_accu) = (4,7)
	
end Behavioral;

