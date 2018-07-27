library IEEE;
library Bomba;

use IEEE.std_logic_1164.all;
use Bomba.Common.all;

entity Saida is
  port(
      state: in BombaStage;
      led_codigo_unidade,led_codigo_dezena : in std_logic_vector(0 to 6); -- Código que usuario ta inserindo
      tempo_dezena,tempo_unidade: in std_logic_vector(3 downto 0); -- O tempo do cronometro
      saida_led: out std_logic_vector(0 to 55)
	  );
end Saida;

architecture archSaida of Saida is

  signal led_tempo_unidade,led_tempo_dezena : std_logic_vector(0 to 6);
  signal s0,s1,s2,s3,s4,s5,s6,s7 : std_logic_vector(0 to 6);

  signal tipo_estado : std_logic;


  component LEDNumerico is
      port(eLED: in std_logic_vector(3 downto 0);
           sLED: out std_logic_vector(0 to 6)
          );
    end component;

    component LEDDefused is
      port( tipo : in std_logic;
            s0,s1,s2,s3,s4,s5,s6,s7: out std_logic_vector(0 to 6)
          );
    end component;
  begin
    with state select
  	saida_led<=
      (s0 & s1 & s2 & s3 & s4 & s5 & s6 & s7) when defused,
      (s0 & s1 & s2 & s3 & s4 & s5 & s6 & s7) when exploded,
      (led_codigo_dezena & led_codigo_unidade & "111111111111111111111111111111111111111111") when armando,
      (led_codigo_dezena & led_codigo_unidade & led_tempo_dezena & led_tempo_unidade & "1111111111111111111111111111") when contagem;

    tipo_estado <=  '1' when (state = exploded) else '0';

    led_tempo_1 : LEDNumerico
      port map(eLED=>tempo_unidade,sLED=>led_tempo_unidade);

    led_tempo_2 : LEDNumerico
      port map(eLED=>tempo_dezena,sLED=>led_tempo_dezena);

    led_status : LEDDefused
      port map(tipo => tipo_estado,s0=>s0,s1=>s1,s2=>s2,s3=>s3,s4=>s4,s5=>s5,s6=>s6,s7=>s7);


end archSaida;
