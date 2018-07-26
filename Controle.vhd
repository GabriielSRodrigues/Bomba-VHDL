library IEEE;
library Bomba;

use IEEE.std_logic_1164.all;
use Bomba.Common.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity Controle is
  port(
      clock: in std_logic;
      avanca: in std_logic;
      volta: in std_logic;
      arma : in std_logic;
      s0: out std_logic_vector(0 to 6);
      s1: out std_logic_vector(0 to 6);
      s2: out std_logic_vector(0 to 6);
      s3: out std_logic_vector(0 to 6);
      s4: out std_logic_vector(0 to 6);
      s5: out std_logic_vector(0 to 6);
      s6: out std_logic_vector(0 to 6)
      );
end Controle;

architecture archControle of Controle is
    signal customclock : std_logic;
    signal codigo : std_logic_vector(3 downto 0);
    signal state : BombaStage;
    signal tempo : std_logic_vector(5 downto 0);
    signal t0 : std_logic_vector(3 downto 0);
    signal t1 : std_logic_vector(3 downto 0);
    signal t2 : std_logic_vector(3 downto 0);


    component Operation is
      port(clock: in std_logic;
          codigo: in std_logic_vector(3 downto 0);
          arma : in std_logic;
          tempo: out std_logic_vector(5 downto 0);
          state: out BombaStage
          );
    end component;

    component Divisor is
      port(clock: std_logic;
          clocksaida: out std_logic
          );
    end component;
    component Seletor is
      	port(volta,avanca,clock,reset: in std_logic;
      		   valor: out std_logic_vector(3 downto 0)
      		  );
    end component;
    component LEDNumerico is
      port(eLED: in std_logic_vector(3 downto 0);
    		   sLED: out std_logic_vector(0 to 6)
    		  );
    end component;
    component LEDDefused is
      port( tipo : in std_logic;
            s0: out std_logic_vector(0 to 6);
            s1: out std_logic_vector(0 to 6);
            s2: out std_logic_vector(0 to 6);
            s3: out std_logic_vector(0 to 6);
            s4: out std_logic_vector(0 to 6);
            s5: out std_logic_vector(0 to 6);
            s6: out std_logic_vector(0 to 6)
          );
    end component;
    begin
      process(state)
        begin
          if (state = armando or state = contagem) then

          end if;

      end process;
      process(tempo,codigo)
        variable ti : integer;
        begin
          ti := to_integer(unsigned(tempo));
          t0 <= (ti REM 60) REM 10;
          t1 <=  (ti REM 60) / 10 ;
          t3 <=  (ti / 60);
      end process;
      -- 0:00

      Divisor1 : Divisor
        port map(clock=>clock,clocksaida=>customclock);

      operacao1 : Operation
        port map(clock=>customclock,codigo=>codigo,arma=>arma,state=>state,tempo=>tempo);

      seletocao1: Seletor
        port map(avanca=>avanca,volta=>volta,clock=>customclock,reset=>'0',valor=>codigo);


end archControle;
