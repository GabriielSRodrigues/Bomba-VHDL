library IEEE;
use IEEE.std_logic_1164.all;

entity Controle is
  port(
      clock: in std_logic;
      avanca: in std_logic;
      volta: in std_logic;
      arma : in std_logic
      );
end Controle;

architecture archControle of Controle is
    signal customclock : std_logic;
    signal codigo : std_logic_vector(3 downto 0);

    component Operation is
      port(clock: in std_logic;
          codigo: in std_logic_vector(3 downto 0);
          arma : in std_logic
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

    begin

      Divisor1 : Divisor
        port map(clock=>clock,clocksaida=>customclock);

      operacao1 : Operation
        port map(clock=>customclock,codigo=>codigo,arma=>arma);

      seletocao1: Seletor
        port map(avanca=>avanca,volta=>volta,clock=>customclock,reset=>'0',valor=>codigo);



end archControle;
