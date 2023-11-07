----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: top_level   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
	port(rst : in std_logic;
			 clk : in std_logic;
			 enable : in std_logic;
			 init_lfsr : in std_logic;
			 snr : in std_logic_vector(5 downto 0));
end top_level;

architecture Behavioral of top_level is

component transmitter is
   Port ( rst : in std_logic;
          clk : in std_logic;
			 enable : in std_logic;
          init_lfsr : in std_logic;
			 y1 : out std_logic_vector(2 downto 0);
			 y2 : out std_logic_vector(2 downto 0);
			 information_bit : out std_logic;
          valid : out std_logic;
          snr : in std_logic_vector(5 downto 0));
end component;

component viterbi_decoder is
	port(	rst : in std_logic;
			clk : in std_logic;
			enable : in std_logic;
			y1 : in std_logic_vector(2 downto 0);
			y2 : in std_logic_vector(2 downto 0);
			decoded_bit : out std_logic);
end component;

component fifo is
port(	rst : in std_logic;
		clk : in std_logic;
		enable : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic);
end component;

component Error_count_module_1 is
   Port ( rst : in std_logic;
          clk : in std_logic;
          enable : in std_logic;
          comp_1 : in std_logic;
          comp_2 : in std_logic;
          BE_Nb : out std_logic_vector(15 downto 0);
          FE_Nb : out std_logic_vector(12 downto 0);
          Bit_Nb : out std_logic_vector(49 downto 0);
          Frame_Nb : out std_logic_vector(47 downto 0);
          BER_LED : out std_logic_vector(1 downto 0);
          overflow_LED : out std_logic_vector(1 downto 0));
end component;

signal y1, y2 : std_logic_vector(2 downto 0);
signal decoded_bit : std_logic;
signal valid : std_logic;
signal information_bit, sync_information_bit : std_logic;

signal BE_Nb : std_logic_vector(15 downto 0);
signal FE_Nb : std_logic_vector(12 downto 0);
signal Bit_Nb : std_logic_vector(49 downto 0);
signal Frame_Nb : std_logic_vector(47 downto 0);
signal BER_LED : std_logic_vector(1 downto 0);
signal overflow_LED : std_logic_vector(1 downto 0);

begin

trans : transmitter
   Port map(rst,
				clk,
				enable,
				init_lfsr,
				y1,
				y2,
				information_bit,
				valid,
				snr);

dec : viterbi_decoder
	port map(	rst,
			clk,
			enable,
			y1,
			y2,
			decoded_bit);
			
delay_data : fifo
	port map(rst,
				clk,
				enable,
				information_bit,
				sync_information_bit);

error_count : Error_count_module_1
	port map(rst,
				clk,
				enable,
				sync_information_bit,
				decoded_bit,
				BE_Nb,
				FE_Nb,
				Bit_Nb,
				Frame_Nb,
				BER_LED,
				overflow_LED
	);

end Behavioral;

