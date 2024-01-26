----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: viterbi_decoder   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.definition_pkg.all;


entity viterbi_decoder is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			y1 : in std_logic_vector(2 downto 0);
			y2 : in std_logic_vector(2 downto 0);
			decoded_bit : out std_logic;
			data_valid  : out std_logic
	);
end viterbi_decoder;

architecture Behavioral of viterbi_decoder is

component branch_metric_unit is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			y1 : in std_logic_vector(2 downto 0);
			y2 : in std_logic_vector(2 downto 0);
			MB00 : out std_logic_vector(3 downto 0);
			MB01 : out std_logic_vector(3 downto 0);
			MB10 : out std_logic_vector(3 downto 0);
			MB11 : out std_logic_vector(3 downto 0)
	);
end component;

component state_metric_unit is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			branch_metric : in branch_metric_array;
			decision : out std_logic_vector(7 downto 0)
	);
end component;

component survivor_path is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0)
	);
end component;

signal MB00, MB01, MB10, MB11 : std_logic_vector(3 downto 0);
signal branch_metric : branch_metric_array;
signal state_metric : state_metric_array;
signal enable_dly1, enable_dly2, enable_dly3, enable_dly4 : std_logic;
signal decision, final_decision : std_logic_vector(7 downto 0);

begin

    process (rst,CLK)
    begin
        if(rst='1') then
				enable_dly1 <= '0';
				enable_dly2 <= '0';
				enable_dly3 <= '0';
				enable_dly4 <= '0';
				--data_valid  <= '0';
		  elsif (CLK'event and CLK = '1') then            
            enable_dly1 <= enable;            
				enable_dly2 <= enable_dly1;
				enable_dly3 <= enable_dly2;
				enable_dly4 <= enable_dly3;
				--data_valid <= enable_dly4;
        end if;
    end process;
    data_valid <= enable_dly4;
	 
BMU : branch_metric_unit
	port map(rst,
			clk,
			enable_dly1,
			y1,
			y2,
			MB00,
			MB01,
			MB10,
			MB11);
						
branch_metric(0) <= MB00;
branch_metric(1) <= MB01;
branch_metric(2) <= MB10;
branch_metric(3) <= MB11;

SMU : state_metric_unit
	port map(rst,
	clk,
	enable_dly2,
	branch_metric,
	decision);
	
survivor_path_unit : survivor_path
	port map(rst, clk, enable_dly4, decision, final_decision);
	
	decoded_bit <= final_decision(0);
	
end Behavioral;