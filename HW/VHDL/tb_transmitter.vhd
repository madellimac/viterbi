--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:16:19 08/29/2012
-- Design Name:   
-- Module Name:   /home/cleroux/work/enseignement/ENSEIRB/2012-2013/TELECOM/EN218/TP_Viterbi/ISE/viterbi_codec/tb_transmitter.vhd
-- Project Name:  viterbi_codec
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: transmitter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_transmitter IS
END tb_transmitter;
 
ARCHITECTURE behavior OF tb_transmitter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT transmitter
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         enable : IN  std_logic;
         init_lfsr : IN  std_logic;
         noisy_data : OUT  std_logic_vector(5 downto 0);
         valid : OUT  std_logic;
         snr : IN  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal enable : std_logic := '0';
   signal init_lfsr : std_logic := '0';
   signal snr : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal noisy_data : std_logic_vector(5 downto 0);
   signal valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: transmitter PORT MAP (
          rst => rst,
          clk => clk,
          enable => enable,
          init_lfsr => init_lfsr,
          noisy_data => noisy_data,
          valid => valid,
          snr => snr
        );

	clk <= not clk after 10 ns;
	rst <= '1', '0' after 112 ns;
	enable <= '1' after 154 ns;
	init_lfsr <= '1', '0' after 142 ns;
	snr <= "001100";
	
	



END;
