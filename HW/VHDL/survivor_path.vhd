----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: survivor_path   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use work.definition_pkg.all;

entity survivor_path is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0));
end survivor_path;

architecture Behavioral of survivor_path is

component survivor_path_stage is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			decision : in  std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0));
end component;

signal st0_out, st1_out, st2_out, st3_out, st4_out, st5_out, st6_out, st7_out, st8_out, st9_out, st10_out, st11_out, st12_out, st13_out, st14_out, st15_out, st16_out, st17_out, st18_out, st19_out : std_logic_vector(7 downto 0);

begin

stage_0 : survivor_path_stage port map(rst, clk, enable, data_in, data_in, st0_out);
stage_1 : survivor_path_stage port map(rst, clk, enable, st0_out, data_in, st1_out);
stage_2 : survivor_path_stage port map(rst, clk, enable, st1_out, data_in, st2_out);
stage_3 : survivor_path_stage port map(rst, clk, enable, st2_out, data_in, st3_out);
stage_4 : survivor_path_stage port map(rst, clk, enable, st3_out, data_in, st4_out);
stage_5 : survivor_path_stage port map(rst, clk, enable, st4_out, data_in, st5_out);
stage_6 : survivor_path_stage port map(rst, clk, enable, st5_out, data_in, st6_out);
stage_7 : survivor_path_stage port map(rst, clk, enable, st6_out, data_in, st7_out);
stage_8 : survivor_path_stage port map(rst, clk, enable, st7_out, data_in, st8_out);
stage_9 : survivor_path_stage port map(rst, clk, enable, st8_out, data_in, st9_out);
stage_10 : survivor_path_stage port map(rst, clk, enable, st9_out, data_in, st10_out);
stage_11 : survivor_path_stage port map(rst, clk, enable, st10_out, data_in, st11_out);
stage_12 : survivor_path_stage port map(rst, clk, enable, st11_out, data_in, st12_out);
stage_13 : survivor_path_stage port map(rst, clk, enable, st12_out, data_in, st13_out);
stage_14 : survivor_path_stage port map(rst, clk, enable, st13_out, data_in, st14_out);
stage_15 : survivor_path_stage port map(rst, clk, enable, st14_out, data_in, st15_out);
stage_16 : survivor_path_stage port map(rst, clk, enable, st15_out, data_in, st16_out);
stage_17 : survivor_path_stage port map(rst, clk, enable, st16_out, data_in, st17_out);
stage_18 : survivor_path_stage port map(rst, clk, enable, st17_out, data_in, st18_out);
stage_19 : survivor_path_stage port map(rst, clk, enable, st18_out, data_in, data_out);


end Behavioral;

