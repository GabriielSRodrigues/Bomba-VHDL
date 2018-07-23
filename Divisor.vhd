library IEEE;
use IEEE.std_logic_1164.ALL;

entity Divisor is
  port(clock: std_logic;
      clocksaida: out std_logic
      );
end Divisor;

architecture archdivisor of Divisor is
  signal clockOut: std_logic;
  begin
    process (clock)
    VARIABLE cont  : NATURAL RANGE 0 to 2499999 := 0;
      begin
        if (clock'EVENT and clock='1') THEN
          if cont=2499999 then
            clockOut<=not clockOut;
            cont := 0;
          else
            cont:= cont+1;
          end if;
      end if;
    end process;
end archdivisor;
