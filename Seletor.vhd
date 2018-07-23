library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Seletor is
	port(volta,avanca,clock,reset: in std_logic;
		   valor: out std_logic_vector(3 downto 0)
		  );
end Seletor;


architecture archSele of Seletor is
signal vfio : std_logic_vector(3 downto 0) := "0000";
begin

  process(reset,clock)
    begin
      if(reset='1') THEN
        vfio<= "0000";
      elsif (clock'event and clock ='1') then
          if (vfio > "0000" and volta='0') THEN
            vfio <= vfio-1;
          elsif (vfio < "1111" and avanca='0') then
            vfio <= vfio+1;
        end if;
      end if;
  end process;
  valor<=vfio;
end archSele;
