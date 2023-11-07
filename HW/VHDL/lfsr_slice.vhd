----------------------------------------------------------------------------------
-- Company: Mcgill
-- Engineer: Guy-Armand Kamendje
-- 
-- Create Date:    14:56:54 01/22/2009 
-- Design Name: 
-- Module Name:    lfsr_slice - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This module implements one single LFSR slice (one bit of the AWGN channel). This module is meant
-- to be duplicated as many as required to match channel  width.
--
-- Dependencies: 
-- lfsr_pkg
-- Revision: 0.1 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.lfsr_pkg.all;
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lfsr_slice is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;  
           init_lfsr_cos1 : in std_logic_vector(23 DOWNTO 0);
           init_lfsr_cos2 : in std_logic_vector(22 DOWNTO 0);
           
           init_lfsr_ln1 : in std_logic_vector(29 DOWNTO 0);
           init_lfsr_ln2 : in std_logic_vector(28 DOWNTO 0);
           init_lfsr_ln3 : in std_logic_vector(26 DOWNTO 0);
           init_lfsr_ln4 : in std_logic_vector(25 DOWNTO 0);
           init_lfsr_ln5 : in std_logic_vector(24 DOWNTO 0);

           init_lfsr_signe : std_logic_vector(27 DOWNTO 0);
           config : in  STD_LOGIC;
           seed : in  STD_LOGIC;
           rbv : out std_logic_vector(28 DOWNTO 0));
end lfsr_slice;

architecture Behavioral of lfsr_slice is


	SIGNAL lfsr_cos1 : std_logic_vector(23 DOWNTO 0);
	SIGNAL lfsr_cos2 : std_logic_vector(22 DOWNTO 0);

	SIGNAL lfsr_ln1   : std_logic_vector(29 DOWNTO 0);
	SIGNAL lfsr_ln2   : std_logic_vector(28 DOWNTO 0);
	SIGNAL lfsr_ln3   : std_logic_vector(26 DOWNTO 0);
	SIGNAL lfsr_ln4   : std_logic_vector(25 DOWNTO 0);
	SIGNAL lfsr_ln5   : std_logic_vector(24 DOWNTO 0);

	SIGNAL lfsr_signe : std_logic_vector(27 DOWNTO 0);




begin



generation : PROCESS(clk, rst)

BEGIN

	IF rst='1' THEN
		lfsr_cos1 <= init_lfsr_cos1;
		lfsr_cos2 <= init_lfsr_cos2;
		
		lfsr_ln1 <= init_lfsr_ln1; 
		lfsr_ln2 <= init_lfsr_ln2; 
		lfsr_ln3 <= init_lfsr_ln3; 
		lfsr_ln4 <= init_lfsr_ln4; 
		lfsr_ln5 <= init_lfsr_ln5; 
		
		lfsr_signe <= init_lfsr_signe;

	ELSIF (clk'event and clk='1') THEN
		lfsr_cos1  <= gen_lfsr(lfsr_cos1,'1',16,config,seed);
		lfsr_cos2  <= gen_lfsr(lfsr_cos2,'1',16,config,lfsr_cos1(lfsr_cos1'length-1));
		lfsr_ln1   <= gen_lfsr(lfsr_ln1,'1',16,config,lfsr_cos2(lfsr_cos2'length-1));
		lfsr_ln2   <= gen_lfsr(lfsr_ln2,'1',16,config,lfsr_ln1(lfsr_ln1'length-1));
		lfsr_ln3   <= gen_lfsr(lfsr_ln3,'1',16,config,lfsr_ln2(lfsr_ln2'length-1));
		lfsr_ln4   <= gen_lfsr(lfsr_ln4,'1',16,config,lfsr_ln3(lfsr_ln3'length-1));
		lfsr_ln5   <= gen_lfsr(lfsr_ln5,'1',16,config,lfsr_ln4(lfsr_ln4'length-1));
		lfsr_signe <= gen_lfsr(lfsr_signe,'1',16,config,lfsr_ln5(lfsr_ln5'length-1));
	
	END IF;

END PROCESS generation;

rbv(3 downto 0)    <= lfsr_cos1(23 downto 20);
rbv(7 downto 4)    <= lfsr_cos2(22 downto 19);
rbv(11 downto 8)   <= lfsr_ln1(29 downto 26);
rbv(15 downto 12)  <= lfsr_ln2(28 downto 25);
rbv(19 downto 16)  <= lfsr_ln3(26 downto 23);
rbv(23 downto 20)  <= lfsr_ln4(25 downto 22);
rbv(27 downto 24)  <= lfsr_ln5(24 downto 21);
rbv(28)  <= lfsr_signe(27);

end Behavioral;

