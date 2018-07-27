library IEEE;
library Bomba;

use IEEE.std_logic_1164.all;
use Bomba.Common.all;
USE ieee.numeric_std.ALL;



entity Controle is
  port(
      clock: in std_logic;
      avanca: in std_logic;
      volta: in std_logic;
      arma : in std_logic;
      fios: in std_logic_vector(4 downto 0);
      saida_led: out std_logic_vector(0 to 55)
      );
end Controle;

architecture archControle of Controle is
    signal customclock : std_logic;
    signal codigo : std_logic_vector(3 downto 0);
    signal state : BombaStage;

    signal led_codigo_unidade,led_codigo_dezena : std_logic_vector(0 to 6);
    signal tempo_unidade,tempo_dezena : std_logic_vector(3 downto 0);

    signal tempsaida :  std_logic_vector(0 to 55);
    signal reset_seletor : std_logic;


    component Operation is
      port(clock: in std_logic;
          codigo: in std_logic_vector(3 downto 0);
          arma : in std_logic;
          out_dez,out_unidade : out std_logic_vector(3 downto 0);
          state: out BombaStage;
          fios: in std_logic_vector(4 downto 0)
          );
    end component;

    component Divisor is
      port(clock: std_logic;
          clocksaida: out std_logic
          );
    end component;

    component Seletor is
      port(volta,avanca,clock,reset: in std_logic;
           valor: out std_logic_vector(3 downto 0);
           s_0, s_1 : out std_logic_vector(0 to 6)
          );
    end component;

    component Saida is
        port(
            state: in BombaStage;
            led_codigo_unidade,led_codigo_dezena : in std_logic_vector(0 to 6);
            tempo_dezena,tempo_unidade: in std_logic_vector(3 downto 0);
            saida_led: out std_logic_vector(0 to 55)
      	  );
    end component;

    begin
      reset_seletor <= '1' when ((state = armando) and (arma = '1')) else '0';

      saida_led <= tempsaida;

      Divisor1 : Divisor
        port map(clock=>clock,clocksaida=>customclock);

      seletocao1: Seletor
        port map(avanca=>avanca,volta=>volta,clock=>customclock,reset=>reset_seletor,valor=>codigo,s_0=>led_codigo_unidade,s_1=>led_codigo_dezena);

      operacao1 : Operation
        port map(clock=>customclock,codigo=>codigo,arma=>arma,state=>state,out_dez=>tempo_dezena,out_unidade=>tempo_unidade,fios=>fios);

      saidaUnica : Saida
        port map(state=>state,led_codigo_unidade=>led_codigo_unidade,led_codigo_dezena=>led_codigo_dezena,tempo_dezena=>tempo_dezena,tempo_unidade=>tempo_unidade,saida_led=>tempsaida);

end archControle;
