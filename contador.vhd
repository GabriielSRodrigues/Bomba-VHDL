library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador is
	port( clock,load: in std_logic;
			valor : in std_logic_vector(5 downto 0);
			scont: out std_logic_vector(5 downto 0);
			acabou: out std_logic
		  );
end contador;

architecture ContRegre of contador is
begin
	process(clock,load)
		variable cont:std_logic_vector(5 downto 0);
		begin
			if load='1' then
				cont := valor;
				acabou <= '0';
		--borda
			elsif clock'EVENT and clock='1' then
				if load='1' then
					cont:= cont-1;
					if cont=0 then
						acabou <= '1';
					else
						acabou <= '0';
					end if;
				end if;
			end if;
		scont<=cont;
	end process;

end ContRegre;
