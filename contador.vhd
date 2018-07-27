library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity contador is
	port( clock,load: in std_logic;
			in_dez,in_unidade : in std_logic_vector(3 downto 0);
			out_dez,out_unidade : out std_logic_vector(3 downto 0);
			acabou: out std_logic
		  );
end contador;

architecture ContRegre of contador is
begin
	process(clock,load)
		variable dezena,unidade:std_logic_vector(3 downto 0);

		begin
			if load='1' then
				dezena := in_dez;
				unidade := in_unidade;
				acabou <= '0';
		--borda
			elsif clock'EVENT and clock='1' then
					if unidade=0 and dezena = 0 THEN
						acabou <= '1';
					elsif unidade = 0 THEN
						unidade := "1001";
						dezena := dezena-1;
					else
            unidade := unidade-1;
					end if;
			end if;

			out_dez <= dezena;
			out_unidade <= unidade;

	end process;

end ContRegre;
