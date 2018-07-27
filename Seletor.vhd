library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Seletor is
	port(volta,avanca,clock,reset: in std_logic;
		   valor: out std_logic_vector(3 downto 0);
			 s_0, s_1 : out std_logic_vector(0 to 6)
		  );
end Seletor;


architecture archSele of Seletor is
signal vfio : std_logic_vector(3 downto 0) := "0000";
signal temp : std_logic_vector(0 to 13);

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
	with vfio select
	temp<=
		 "00000010000001" when "0000", --0
		 "00000011001111" when "0001", --1
		 "00000010010010" when "0010", --2
		 "00000010000110" when "0011", --3
		 "00000011001100" when "0100", --4
		 "00000010100100" when "0101", --5
		 "00000010100000" when "0110", --6
		 "00000010001111" when "0111", --7
		 "00000010000000" when "1000", --8
		 "00000010000100" when "1001", --9
		 "10011110000001" when "1010", -- 10
		 "10011111001111" when "1011", -- 11
		 "10011110010010" when "1100", -- 12
		 "10011110000110" when "1101", -- 13
		 "10011111001100" when "1110", -- 14
		 "10011110100100" when "1111", -- 15
		 "00000000000000" when others;
s_0 <= temp(7 to 13);
s_1 <= temp(0 to 6);
end archSele;
