-------------------------------------------------------------------------------
--                                                                           --
-- Fichier         : lfsr_pkg.vhd                                            --
-- Fichiers utiles :                                                         --
--                                                                           --
--                                                                           --
-- Auteurs         : J-L Danger                                             --
-- Projet          : noise generator                                         --
--                                                                           --
-- date de creation: 6/04/2000                                               --
--                                                                           --
-- Description     : package of lfsr generator                               --
--                                                                           --
-------------------------------------------------------------------------------
-- Modification :                                                            --
-------------------------------------------------------------------------------
-- Copyrigth LESTER, Universite de Bretagne Sud, 2001                        --
--           ENST Paris                                                      --
-- This software is distributed under a GPL licence                          --
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE lfsr_pkg IS


-------------------------------------------------------------------------------
-- Function gen_lfsr                                                         --
--    Input :                                                                -- 
--          pol     : input polynomial                                       --
--          en      : enable, null function if en = '0'                      --
--          nb_iter : number of iteration                                    --
--			     	=> the function performs pol * X^nb_iter MOD pol_gen -- 
--		config  : configuration of the seed                              --
--                      => the function performs pol<<1 & seed               --
--          seed    : input seed to give a new value to the polynomial       --  
-------------------------------------------------------------------------------
  FUNCTION gen_lfsr(
    pol      : std_logic_vector;      
    en       : std_logic;             
    nb_iter  : natural;             
    config   : std_logic;
    seed     :  std_logic) 		RETURN std_logic_vector;
END lfsr_pkg; 


PACKAGE BODY lfsr_pkg IS


  FUNCTION gen_lfsr(
    pol      : std_logic_vector;
    en       : std_logic;             
    nb_iter  : natural;             
    config   : std_logic;
    seed     : std_logic) 		RETURN std_logic_vector IS

    
    VARIABLE temp : std_logic;
    VARIABLE pol_int : std_logic_vector(pol'length-1 DOWNTO 0);  -- tempory polynomial
    
    
  BEGIN
    -- selection of the generator polynomial as a function of the length of "pol".
    

-- affectation of the tempory variable pol_int
    pol_int := pol;

    iteration : FOR i IN 1 TO nb_iter LOOP
      IF ((en = '1') OR (config = '1')) THEN
        IF config = '0' THEN
          
          --cf. http://homepage.mac.com/afj/taplist.html 
          CASE pol'length is
            when 32 => temp := pol_int(31) xor pol_int(30) xor pol_int(29) xor pol_int(9);
            when 31 => temp := pol_int(30) xor pol_int(27);
            when 30 => temp := pol_int(29) xor pol_int(28) xor pol_int(27) xor pol_int(6);
            when 29 => temp := pol_int(28) xor pol_int(26);
            when 28 => temp := pol_int(27) xor pol_int(24);
            when 27 => temp := pol_int(26) xor pol_int(25) xor pol_int(24) xor pol_int(21);
            when 26 => temp := pol_int(25) xor pol_int(24) xor pol_int(23) xor pol_int(19);
            when 25 => temp := pol_int(24) xor pol_int(21);
            when 24 => temp := pol_int(23) xor pol_int(22) xor pol_int(21) xor pol_int(16);
            when 23 => temp := pol_int(22) xor pol_int(17);
            when 22 => temp := pol_int(21) xor pol_int(20);
            when 21 => temp := pol_int(20) xor pol_int(18);
            when 20 => temp := pol_int(19) xor pol_int(16);
            when 19 => temp := pol_int(18) xor pol_int(17) xor pol_int(16) xor pol_int(13);
            when 18 => temp := pol_int(17) xor pol_int(10);
            when 17 => temp := pol_int(16) xor pol_int(13);
            when 16 => temp := pol_int(15) xor pol_int(14) xor pol_int(12) xor pol_int(3);
            when 15 => temp := pol_int(14) xor pol_int(13);
            when 14 => temp := pol_int(13) xor pol_int(12) xor pol_int(11) xor pol_int(1);
            when 13 => temp := pol_int(12) xor pol_int(11) xor pol_int(10) xor pol_int(7);
            when 12 => temp := pol_int(11) xor pol_int(10) xor pol_int(9) xor pol_int(3);
            when 11 => temp := pol_int(10) xor pol_int(8);
            when 10 => temp := pol_int(9) xor pol_int(6);
            when  9 => temp := pol_int(8) xor pol_int(4);
            when  8 => temp := pol_int(7) xor pol_int(6) xor pol_int(4) xor pol_int(2);
            when  7 => temp := pol_int(6) xor pol_int(5);
            when  6 => temp := pol_int(5) xor pol_int(4);
            when  5 => temp := pol_int(4) xor pol_int(2);
            when  4 => temp := pol_int(3) xor pol_int(2);
            when  3 => temp := pol_int(2) xor pol_int(1);
            when  others => temp := '0'; 
          END CASE;
          
          pol_int(pol'length-1 DOWNTO 0) := pol_int(pol'length-2 DOWNTO 0)&temp;
          
        ELSE
          pol_int := pol_int(pol'length-2 DOWNTO 0)&seed;		   
        END IF;
      ELSE
        pol_int := pol_int;      	  
      END IF;
    END LOOP;

    
    RETURN (pol_int);

  END gen_lfsr;



END lfsr_pkg;




























