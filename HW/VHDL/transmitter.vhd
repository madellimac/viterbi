----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Designer: Camille Leroux
-- Generation Date:   Aug 29, 2012
-- Design Name: Viterbi_codec
-- Module Name: transmitter   
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity transmitter is
   Port ( rst : in std_logic;
          clk : in std_logic;
			 enable : in std_logic;
          init_lfsr : in std_logic;
			 y1 : out std_logic_vector(2 downto 0);
			 y2 : out std_logic_vector(2 downto 0);
			 information_bit : out std_logic;
          valid : out std_logic;
          snr : in std_logic_vector(5 downto 0));
end transmitter;
 
architecture RTL of transmitter is

component random_data_generator is
	port (clk : in std_logic;
			rst : in std_logic;
			init_lfsr : in std_logic;
			enable : in  std_logic;
			rand_data : out std_logic);
end component;

component viterbi_encoder is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           data : in  STD_LOGIC;
           x1 : out  STD_LOGIC;
			  x2 : out  STD_LOGIC);
end component;

component wgng_sig_plus_emi is
   Port ( clk : in std_logic;
          rst : in std_logic;
          enable : in std_logic;
          sigma : in std_logic_vector(15 downto 0);
          entree : in std_logic;
          init_lfsr_cos1_01 : in std_logic_vector(23 downto 0);
          init_lfsr_cos1_02 : in std_logic_vector(23 downto 0);
          init_lfsr_cos1_03 : in std_logic_vector(23 downto 0);
          init_lfsr_cos1_04 : in std_logic_vector(23 downto 0);
          init_lfsr_cos2_01 : in std_logic_vector(22 downto 0);
          init_lfsr_cos2_02 : in std_logic_vector(22 downto 0);
          init_lfsr_cos2_03 : in std_logic_vector(22 downto 0);
          init_lfsr_cos2_04 : in std_logic_vector(22 downto 0);
          init_lfsr_ln1_01 : in std_logic_vector(29 downto 0);
          init_lfsr_ln1_02 : in std_logic_vector(29 downto 0);
          init_lfsr_ln1_03 : in std_logic_vector(29 downto 0);
          init_lfsr_ln1_04 : in std_logic_vector(29 downto 0);
          init_lfsr_ln2_01 : in std_logic_vector(28 downto 0);
          init_lfsr_ln2_02 : in std_logic_vector(28 downto 0);
          init_lfsr_ln2_03 : in std_logic_vector(28 downto 0);
          init_lfsr_ln2_04 : in std_logic_vector(28 downto 0);
          init_lfsr_ln3_01 : in std_logic_vector(26 downto 0);
          init_lfsr_ln3_02 : in std_logic_vector(26 downto 0);
          init_lfsr_ln3_03 : in std_logic_vector(26 downto 0);
          init_lfsr_ln3_04 : in std_logic_vector(26 downto 0);
          init_lfsr_ln4_01 : in std_logic_vector(25 downto 0);
          init_lfsr_ln4_02 : in std_logic_vector(25 downto 0);
          init_lfsr_ln4_03 : in std_logic_vector(25 downto 0);
          init_lfsr_ln4_04 : in std_logic_vector(25 downto 0);
          init_lfsr_ln5_01 : in std_logic_vector(24 downto 0);
          init_lfsr_ln5_02 : in std_logic_vector(24 downto 0);
          init_lfsr_ln5_03 : in std_logic_vector(24 downto 0);
          init_lfsr_ln5_04 : in std_logic_vector(24 downto 0);
          init_lfsr_signe_01 : in std_logic_vector(27 downto 0);
          init_lfsr_signe_02 : in std_logic_vector(27 downto 0);
          init_lfsr_signe_03 : in std_logic_vector(27 downto 0);
          init_lfsr_signe_04 : in std_logic_vector(27 downto 0);
          valid : out std_logic;
          sortie : out std_logic_vector(2 downto 0));
end component;

component rom_sigma is
   Port ( clk : in std_logic;
          rst : in std_logic;
          sb : in std_logic_vector(5 downto 0);
          sigma : out std_logic_vector(15 downto 0));
end component;

component data_adapter is
	port(	data_in : in std_logic_vector (2 downto 0);
			data_out : out std_logic_vector (2 downto 0));
end component;

component Error_count_module_2 is
   Port ( rst : in std_logic;
          clk : in std_logic;
          enable : in std_logic;
          comp_1 : in std_logic_vector(1 downto 0);
          comp_2 : in std_logic_vector(1 downto 0);
          BE_Nb : out std_logic_vector(15 downto 0);
          FE_Nb : out std_logic_vector(12 downto 0);
          Bit_Nb : out std_logic_vector(49 downto 0);
          Frame_Nb : out std_logic_vector(47 downto 0);
          BER_LED : out std_logic_vector(1 downto 0);
          overflow_LED : out std_logic_vector(1 downto 0));
end component;

signal dly1_enable, dly2_enable : std_logic;
signal rand_data, x1, x2: std_logic;
signal dly_x1, dly_x2: std_logic;
signal y1_tmp, y2_tmp : std_logic_vector(2 downto 0);
signal sigma_value : std_logic_vector(15 downto 0);
signal valid_sig : std_logic_vector(1 downto 0);
signal y1_hd, y2_hd : std_logic;

signal error_comp_A, error_comp_B : std_logic_vector(1 downto 0);
				
signal BE_Nb : std_logic_vector(15 downto 0);
signal FE_Nb : std_logic_vector(12 downto 0);
signal Bit_Nb : std_logic_vector(49 downto 0);
signal Frame_Nb : std_logic_vector(47 downto 0);
signal BER_LED : std_logic_vector(1 downto 0);
signal overflow_LED : std_logic_vector(1 downto 0);

signal init_lfsr_ln1_01_0, init_lfsr_ln1_02_0, init_lfsr_ln1_03_0, init_lfsr_ln1_04_0 : std_logic_vector(29 downto 0);
signal init_lfsr_signe_01_0, init_lfsr_signe_02_0, init_lfsr_signe_03_0, init_lfsr_signe_04_0 : std_logic_vector(27 downto 0);
signal init_lfsr_cos2_01_0, init_lfsr_cos2_02_0, init_lfsr_cos2_03_0, init_lfsr_cos2_04_0 : std_logic_vector(22 downto 0);
signal init_lfsr_ln4_01_0, init_lfsr_ln4_02_0, init_lfsr_ln4_03_0, init_lfsr_ln4_04_0 : std_logic_vector(25 downto 0);
signal init_lfsr_ln2_01_0, init_lfsr_ln2_02_0, init_lfsr_ln2_03_0, init_lfsr_ln2_04_0: std_logic_vector(28 downto 0);
signal init_lfsr_cos1_01_0, init_lfsr_cos1_02_0, init_lfsr_cos1_03_0, init_lfsr_cos1_04_0: std_logic_vector(23 downto 0);
signal init_lfsr_ln5_01_0, init_lfsr_ln5_02_0, init_lfsr_ln5_03_0, init_lfsr_ln5_04_0 : std_logic_vector(24 downto 0);
signal init_lfsr_ln3_01_0, init_lfsr_ln3_02_0, init_lfsr_ln3_03_0, init_lfsr_ln3_04_0 : std_logic_vector(26 downto 0);

signal init_lfsr_ln1_01_1, init_lfsr_ln1_02_1, init_lfsr_ln1_03_1, init_lfsr_ln1_04_1 : std_logic_vector(29 downto 0);
signal init_lfsr_signe_01_1, init_lfsr_signe_02_1, init_lfsr_signe_03_1, init_lfsr_signe_04_1 : std_logic_vector(27 downto 0);
signal init_lfsr_cos2_01_1, init_lfsr_cos2_02_1, init_lfsr_cos2_03_1, init_lfsr_cos2_04_1 : std_logic_vector(22 downto 0);
signal init_lfsr_ln4_01_1, init_lfsr_ln4_02_1, init_lfsr_ln4_03_1, init_lfsr_ln4_04_1 : std_logic_vector(25 downto 0);
signal init_lfsr_ln2_01_1, init_lfsr_ln2_02_1, init_lfsr_ln2_03_1, init_lfsr_ln2_04_1: std_logic_vector(28 downto 0);
signal init_lfsr_cos1_01_1, init_lfsr_cos1_02_1, init_lfsr_cos1_03_1, init_lfsr_cos1_04_1: std_logic_vector(23 downto 0);
signal init_lfsr_ln5_01_1, init_lfsr_ln5_02_1, init_lfsr_ln5_03_1, init_lfsr_ln5_04_1 : std_logic_vector(24 downto 0);
signal init_lfsr_ln3_01_1, init_lfsr_ln3_02_1, init_lfsr_ln3_03_1, init_lfsr_ln3_04_1 : std_logic_vector(26 downto 0);

begin

	information_bit <= rand_data;

	delay_enable : process(rst, clk)
	begin
		if(rst = '1') then
			dly1_enable <= '0';
			dly2_enable <= '0';
		elsif(clk'event and clk = '1') then
			dly1_enable <= enable;
			dly2_enable <= dly1_enable;
		end if;
	end process;


	rnd_data_gen : random_data_generator
	port map (	clk,
					rst,
					init_lfsr,
					enable,
					rand_data);

	encoder : viterbi_encoder
	port map (	rst => rst,
					clk => clk,
					enable => enable,
					data => rand_data,
					--data => '1',
					x1 => x1,
					x2 => x2);
			  
	snr_to_sigma : rom_sigma
	port map(clk,
				rst,
				snr,
				sigma_value);

	wgng_inst1 : wgng_sig_plus_emi
   port map(clk => clk,
            rst => rst,
            enable => dly1_enable,
            sigma => sigma_value,
            entree => x1,
            init_lfsr_cos1_01  => init_lfsr_cos1_01_0,
            init_lfsr_cos1_02  => init_lfsr_cos1_02_0,
            init_lfsr_cos1_03  => init_lfsr_cos1_03_0,
            init_lfsr_cos1_04  => init_lfsr_cos1_04_0,
            init_lfsr_cos2_01  => init_lfsr_cos2_01_0,
            init_lfsr_cos2_02  => init_lfsr_cos2_02_0,
            init_lfsr_cos2_03  => init_lfsr_cos2_03_0,
            init_lfsr_cos2_04  => init_lfsr_cos2_04_0,
            init_lfsr_ln1_01   => init_lfsr_ln1_01_0,
            init_lfsr_ln1_02   => init_lfsr_ln1_02_0,
            init_lfsr_ln1_03   => init_lfsr_ln1_03_0,
            init_lfsr_ln1_04   => init_lfsr_ln1_04_0,
            init_lfsr_ln2_01   => init_lfsr_ln2_01_0,
            init_lfsr_ln2_02   => init_lfsr_ln2_02_0,
            init_lfsr_ln2_03   => init_lfsr_ln2_03_0,
            init_lfsr_ln2_04   => init_lfsr_ln2_04_0,
            init_lfsr_ln3_01   => init_lfsr_ln3_01_0,
            init_lfsr_ln3_02   => init_lfsr_ln3_02_0,
            init_lfsr_ln3_03   => init_lfsr_ln3_03_0,
            init_lfsr_ln3_04   => init_lfsr_ln3_04_0,
            init_lfsr_ln4_01   => init_lfsr_ln4_01_0,
            init_lfsr_ln4_02   => init_lfsr_ln4_02_0,
            init_lfsr_ln4_03   => init_lfsr_ln4_03_0,
            init_lfsr_ln4_04   => init_lfsr_ln4_04_0,
            init_lfsr_ln5_01   => init_lfsr_ln5_01_0,
            init_lfsr_ln5_02   => init_lfsr_ln5_02_0,
            init_lfsr_ln5_03   => init_lfsr_ln5_03_0,
            init_lfsr_ln5_04   => init_lfsr_ln5_04_0,
            init_lfsr_signe_01 => init_lfsr_signe_01_0,
            init_lfsr_signe_02 => init_lfsr_signe_02_0,
            init_lfsr_signe_03 => init_lfsr_signe_03_0,
            init_lfsr_signe_04 => init_lfsr_signe_04_0,
            valid => valid_sig(0),
            sortie => y1_tmp);

	wgng_inst2 : wgng_sig_plus_emi
   port map(clk => clk,
            rst => rst,
            enable => dly1_enable,
            sigma => sigma_value,
            entree => x2,
            init_lfsr_cos1_01  => init_lfsr_cos1_01_1,
            init_lfsr_cos1_02  => init_lfsr_cos1_02_1,
            init_lfsr_cos1_03  => init_lfsr_cos1_03_1,
            init_lfsr_cos1_04  => init_lfsr_cos1_04_1,
            init_lfsr_cos2_01  => init_lfsr_cos2_01_1,
            init_lfsr_cos2_02  => init_lfsr_cos2_02_1,
            init_lfsr_cos2_03  => init_lfsr_cos2_03_1,
            init_lfsr_cos2_04  => init_lfsr_cos2_04_1,
            init_lfsr_ln1_01   => init_lfsr_ln1_01_1,
            init_lfsr_ln1_02   => init_lfsr_ln1_02_1,
            init_lfsr_ln1_03   => init_lfsr_ln1_03_1,
            init_lfsr_ln1_04   => init_lfsr_ln1_04_1,
            init_lfsr_ln2_01   => init_lfsr_ln2_01_1,
            init_lfsr_ln2_02   => init_lfsr_ln2_02_1,
            init_lfsr_ln2_03   => init_lfsr_ln2_03_1,
            init_lfsr_ln2_04   => init_lfsr_ln2_04_1,
            init_lfsr_ln3_01   => init_lfsr_ln3_01_1,
            init_lfsr_ln3_02   => init_lfsr_ln3_02_1,
            init_lfsr_ln3_03   => init_lfsr_ln3_03_1,
            init_lfsr_ln3_04   => init_lfsr_ln3_04_1,
            init_lfsr_ln4_01   => init_lfsr_ln4_01_1,
            init_lfsr_ln4_02   => init_lfsr_ln4_02_1,
            init_lfsr_ln4_03   => init_lfsr_ln4_03_1,
            init_lfsr_ln4_04   => init_lfsr_ln4_04_1,
            init_lfsr_ln5_01   => init_lfsr_ln5_01_1,
            init_lfsr_ln5_02   => init_lfsr_ln5_02_1,
            init_lfsr_ln5_03   => init_lfsr_ln5_03_1,
            init_lfsr_ln5_04   => init_lfsr_ln5_04_1,
            init_lfsr_signe_01 => init_lfsr_signe_01_1,
            init_lfsr_signe_02 => init_lfsr_signe_02_1,
            init_lfsr_signe_03 => init_lfsr_signe_03_1,
            init_lfsr_signe_04 => init_lfsr_signe_04_1,
            valid => valid_sig(1),
            sortie => y2_tmp);

	y2_hd <= y2_tmp(2);
	y1_hd <= y1_tmp(2);
	
	
	convert_y2 : data_adapter
		port map(y2_tmp,
					y2);

	convert_y1 : data_adapter
		port map(y1_tmp,
					y1);
	
	delay_coded_data : process(rst, clk)
	begin
		if(rst = '1') then
			dly_x1 <= '0';
			dly_x2 <= '0';
		elsif(clk'event and clk = '1') then
			dly_x1 <= x1;
			dly_x2 <= x2;
		end if;
	end process;

	error_comp_A <= dly_x1&dly_x2;
	error_comp_B <= y1_hd&y2_hd;

	error_counter :  Error_count_module_2
	Port map(rst,
				clk,
				dly2_enable,
				error_comp_A,
				error_comp_B,
				BE_Nb,
				FE_Nb,
				Bit_Nb,
				Frame_Nb,
				BER_LED,
				overflow_LED);

   init_lfsr_ln1_01_0 <= "010001111111011110001001010111";
   init_lfsr_ln1_02_0 <= "010011100010110011111000000000";
   init_lfsr_ln1_03_0 <= "011101101101100010011010100101";
   init_lfsr_ln1_04_0 <= "111000111101100000000111101000";


   init_lfsr_signe_01_0 <= "1110010000010010001110000010";
   init_lfsr_signe_02_0 <= "0001001011011111010100000110";
   init_lfsr_signe_03_0 <= "1101111101010010100101010101";
   init_lfsr_signe_04_0 <= "0101110101110011101101111101";


   init_lfsr_cos2_01_0 <= "11101111111000101010001";
   init_lfsr_cos2_02_0 <= "00000101010010100000000";
   init_lfsr_cos2_03_0 <= "00101100001110111010101";
   init_lfsr_cos2_04_0 <= "01101100010011011011011";


   init_lfsr_ln4_01_0 <= "01101110010100011100011010";
   init_lfsr_ln4_02_0 <= "00111000000111000010010100";
   init_lfsr_ln4_03_0 <= "00011100000010110011001001";
   init_lfsr_ln4_04_0 <= "00010101111111111000010101";


   init_lfsr_ln2_01_0 <= "11101101111001101111111110000";
   init_lfsr_ln2_02_0 <= "10011111001111000101111110000";
   init_lfsr_ln2_03_0 <= "10111100001000011111010000010";
   init_lfsr_ln2_04_0 <= "11110111000000000001110010101";


   init_lfsr_cos1_01_0 <= "111110010001100110100011";
   init_lfsr_cos1_02_0 <= "011001110111111011000101";
   init_lfsr_cos1_03_0 <= "011000010101010010100010";
   init_lfsr_cos1_04_0 <= "011110001010000101101001";


   init_lfsr_ln5_01_0 <= "1011001101000011111001101";
   init_lfsr_ln5_02_0 <= "1011111111010110111101010";
   init_lfsr_ln5_03_0 <= "0011010001001010000100010";
   init_lfsr_ln5_04_0 <= "0000010100001001101100100";


   init_lfsr_ln3_01_0 <= "000101001110011110111111010";
   init_lfsr_ln3_02_0 <= "111111100010110101100010110";
   init_lfsr_ln3_03_0 <= "110000011110000111011011100";
   init_lfsr_ln3_04_0 <= "010010010101000110010000101";


   init_lfsr_ln1_01_1 <= "010110111110101110000001111101";
   init_lfsr_ln1_02_1 <= "110101101110101100100110110000";
   init_lfsr_ln1_03_1 <= "100000011110111101111001000011";
   init_lfsr_ln1_04_1 <= "110111010101010101100010110010";


   init_lfsr_signe_01_1 <= "1000100001111101011000101000";
   init_lfsr_signe_02_1 <= "1010010110111111110010101001";
   init_lfsr_signe_03_1 <= "1000101011100000111001111001";
   init_lfsr_signe_04_1 <= "0101100001010011010100111000";


   init_lfsr_cos2_01_1 <= "10110010101010100001101";
   init_lfsr_cos2_02_1 <= "00101100010110001101100";
   init_lfsr_cos2_03_1 <= "00011110101001110110011";
   init_lfsr_cos2_04_1 <= "11001111010111010110010";


   init_lfsr_ln4_01_1 <= "11001000101001000101100100";
   init_lfsr_ln4_02_1 <= "01011000111110110011011100";
   init_lfsr_ln4_03_1 <= "10000111101010111111101010";
   init_lfsr_ln4_04_1 <= "01111001001110010001011011";


   init_lfsr_ln2_01_1 <= "11001111011111111011100010110";
   init_lfsr_ln2_02_1 <= "10000111011010101000100101000";
   init_lfsr_ln2_03_1 <= "11110011000000001001100011011";
   init_lfsr_ln2_04_1 <= "00100000101111001001111100110";


   init_lfsr_cos1_01_1 <= "000110001111101101110010";
   init_lfsr_cos1_02_1 <= "101100101000101100101001";
   init_lfsr_cos1_03_1 <= "111000101001101001010011";
   init_lfsr_cos1_04_1 <= "101101010101001110111101";


   init_lfsr_ln5_01_1 <= "0110011000100101111111101";
   init_lfsr_ln5_02_1 <= "0110100011101111011100000";
   init_lfsr_ln5_03_1 <= "0011011001101111110100110";
   init_lfsr_ln5_04_1 <= "1001011101010100101001111";


   init_lfsr_ln3_01_1 <= "100100010110010001001110101";
   init_lfsr_ln3_02_1 <= "010000100100100101010111000";
   init_lfsr_ln3_03_1 <= "000110010001101011101110011";
   init_lfsr_ln3_04_1 <= "110001010110111110100110010";
	
end RTL;

