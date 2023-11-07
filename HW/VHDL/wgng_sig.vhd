----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:30 01/23/2009 
-- Design Name: 
-- Module Name:    hamming_wgng_sig - rtl 
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

LIBRARY IEEE;
USE IEEE.std_logic_1164.all; 
USE IEEE.std_logic_arith.all;
USE work.rom_pkg.all;


ENTITY wgng_sig IS       
       PORT (
  	      clk         : IN  std_logic;
		   rst         : IN  std_logic;
		   config      : IN  std_logic;
		   seed        : IN  std_logic;
		   sigma	   	: IN  std_logic_vector(15 downto 0);
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
			wgn					: OUT std_logic_vector(9 downto 0)
			);
END wgng_sig;
             
                                                 
-------------------------------------------------------------------------------
--  Architecture                                                             --
-------------------------------------------------------------------------------
ARCHITECTURE rtl OF wgng_sig IS

component wgng is
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
end component;


COMPONENT  mult6x6
    PORT (
        clk     : IN  std_logic;
        rst     : IN  std_logic;
        sigma   : IN  std_logic_vector(15 DOWNTO 0);
        wgng    : IN  std_logic_vector(10 DOWNTO 0);
        wgn_s   : OUT std_logic_vector(9 DOWNTO 0)
    );
END COMPONENT;

SIGNAL wgn_signal : std_logic_vector(10 downto 0);
signal wgn_sigma : std_logic_vector(9 downto 0);
        
BEGIN

INST_wgng   : wgng  PORT MAP (
	clk => clk,
	rst => rst,
	config => config,
	seed => seed,
	init_lfsr_cos1_01  => init_lfsr_cos1_01, 
	init_lfsr_cos1_02  => init_lfsr_cos1_02,
	init_lfsr_cos1_03  => init_lfsr_cos1_03,
	init_lfsr_cos1_04  => init_lfsr_cos1_04,
	init_lfsr_cos2_01  => init_lfsr_cos2_01,
	init_lfsr_cos2_02  => init_lfsr_cos2_02,
	init_lfsr_cos2_03  => init_lfsr_cos2_03,
	init_lfsr_cos2_04  => init_lfsr_cos2_04,
	init_lfsr_ln1_01   => init_lfsr_ln1_01,
	init_lfsr_ln1_02   => init_lfsr_ln1_02,
	init_lfsr_ln1_03   => init_lfsr_ln1_03,
	init_lfsr_ln1_04   => init_lfsr_ln1_04,
	init_lfsr_ln2_01   => init_lfsr_ln2_01,
	init_lfsr_ln2_02   => init_lfsr_ln2_02,
	init_lfsr_ln2_03   => init_lfsr_ln2_03,
	init_lfsr_ln2_04   => init_lfsr_ln2_04,
	init_lfsr_ln3_01   => init_lfsr_ln3_01,
	init_lfsr_ln3_02   => init_lfsr_ln3_02,
	init_lfsr_ln3_03   => init_lfsr_ln3_03,
	init_lfsr_ln3_04   => init_lfsr_ln3_04,
	init_lfsr_ln4_01   => init_lfsr_ln4_01,
	init_lfsr_ln4_02   => init_lfsr_ln4_02,
	init_lfsr_ln4_03   => init_lfsr_ln4_03,
	init_lfsr_ln4_04   => init_lfsr_ln4_04,
	init_lfsr_ln5_01   => init_lfsr_ln5_01,
	init_lfsr_ln5_02   => init_lfsr_ln5_02,
	init_lfsr_ln5_03   => init_lfsr_ln5_03,
	init_lfsr_ln5_04   => init_lfsr_ln5_04,
	init_lfsr_signe_01 => init_lfsr_signe_01,
	init_lfsr_signe_02 => init_lfsr_signe_02,
	init_lfsr_signe_03 => init_lfsr_signe_03,
	init_lfsr_signe_04 => init_lfsr_signe_04,	
	wgn  => wgn_signal);  --(4,7)

inst_mult6x6_01 : mult6x6  PORT MAP (clk,rst,sigma,wgn_signal,wgn_sigma);

wgn <= wgn_sigma;
 --(4,6)

END rtl;