LIBRARY IEEE;
USE IEEE.std_logic_1164.all; 
USE IEEE.std_logic_arith.all;
LIBRARY std;
USE std.textio.all; 

PACKAGE wgng_pkg IS
    
    
    
   
   ---------------- IMPORTANT: PARAMETRE n A REGLER -----------------
   ------------ n = nb de générateur de bruit à générer -------------
   CONSTANT n: integer := 32; 
   
   
   
   
   CONSTANT Esp : STRING(1 TO 1) := " ";
   CONSTANT equal_line : STRING(1 TO 21) := "%--------------------";
  
   TYPE WGN_TYPE IS ARRAY(1 to n) OF STD_LOGIC_VECTOR(9 downto 0);
   TYPE VA_type IS ARRAY(1 TO n) OF INTEGER;

   FUNCTION vec2int(r : std_logic_vector(9 DOWNTO 0) ) RETURN INTEGER;  
   FUNCTION vec2int_2(r : std_logic_vector(5 DOWNTO 0) ) RETURN INTEGER;  	
   FUNCTION Image(A : INTEGER) RETURN string;

END wgng_pkg;


PACKAGE BODY wgng_pkg IS

      ---------------------------- fonction de conversion vector to integer -----------------------------
      FUNCTION vec2int(r : std_logic_vector(9 DOWNTO 0)) RETURN INTEGER IS

      VARIABLE a : INTEGER := 0;
      VARIABLE step  : NATURAL := 1;

      BEGIN
	
	      calcul : FOR I in 0 TO 8 LOOP
		      IF (r(I) = '1') THEN 
			    a := a + step; 
		      ELSIF (r(I) /= '0') THEN
		         a := 999;
		         EXIT calcul;
		      END IF;		
		      step := step*2;
	      END LOOP;
	   
	      IF (r(9) = '1') THEN 
	         a := a - step; 
	      ELSIF (r(9) /= '0') THEN
	         a := 999;
	      END IF;			
	
	      RETURN (a);
      END vec2int;
      
      ------------------------------------------------------
      
      FUNCTION vec2int_2(r : std_logic_vector(5 DOWNTO 0)) RETURN INTEGER IS

      VARIABLE a : INTEGER := 0;
      VARIABLE step  : NATURAL := 1;

      BEGIN
	
	      calcul : FOR I in 0 TO 4 LOOP
		      IF (r(I) = '1') THEN 
			    a := a + step;
		      END IF;		
		      step := step*2;
	      END LOOP;
	   
	      IF (r(5) = '1') THEN 
	         a := a - step;
	      END IF;			
	
	      RETURN (a);
      END vec2int_2;
      
      ----------------------------- fonction de conversion interger to string -----------------------------
      
      FUNCTION Image(A : INTEGER) RETURN string IS
      VARIABLE l : LINE;
      BEGIN 
         WRITE(l, A);
         RETURN(l.all);
      END Image;  
      ------------------------------------------------------------------------------------------------
 
 END wgng_pkg;


