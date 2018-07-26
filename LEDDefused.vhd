library ieee;
use ieee.std_logic_1164.all;
-- DEFUSED
entity LEDDefused is
	port( tipo : in std_logic;
	 			s0: out std_logic_vector(0 to 6);
				s1: out std_logic_vector(0 to 6);
				s2: out std_logic_vector(0 to 6);
				s3: out std_logic_vector(0 to 6);
				s4: out std_logic_vector(0 to 6);
				s5: out std_logic_vector(0 to 6);
				s6: out std_logic_vector(0 to 6)
			);
end LEDDefused;

architecture archLED of LEDDefused is
begin
	  s0 <= "1000010" when tipo = '0' else "0111000";
  	s1 <= "0010000" when tipo = '0' else "1000001";
		s2 <= "0111000" when tipo = '0' else "1000010";
		s3 <= "1000001" when tipo = '0' else "0010000";
		s4 <= "0100100" when tipo = '0' else "1000001";
		s5 <= "0010000" when tipo = '0' else "1000001";
		s6 <= "1000010" when tipo = '0' else "1000001";

end archLED;
