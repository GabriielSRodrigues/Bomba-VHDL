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
      led0,led1,led2,led3,led4,led5,led6,led7: out std_logic_vector(0 to 6)
      );
end Controle;

architecture archControle of Controle is
    signal customclock : std_logic;
    signal codigo : std_logic_vector(3 downto 0);
    signal state : BombaStage;


    -----------------------------------
    --    SINAIS PARA
    --      LCD
    -- Sinais para o tempo da bomba
    signal tempo_unidade,tempo_dezena : std_logic_vector(3 downto 0);
    signal led_tempo_unidade,led_tempo_dezena : std_logic_vector(0 to 6);
    -- Sinais para o código inserido
    signal led_codigo_unidade,led_codigo_dezena : std_logic_vector(0 to 6);
    -- Sinais para o estado da bomba (defused,fudeu)
    signal s0,s1,s2,s3,s4,s5,s6,s7 : std_logic_vector(0 to 6);
    signal tipo_estado : std_logic;

    signal reset_seletor : std_logic;


    component Operation is
      port(clock: in std_logic;
          codigo: in std_logic_vector(3 downto 0);
          arma : in std_logic;
          out_dez,out_unidade : out std_logic_vector(3 downto 0);
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
           valor: out std_logic_vector(3 downto 0);
           s_0, s_1 : out std_logic_vector(0 to 6)
          );
    end component;

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

      process(state)
        begin
          if (state = armando or state = contagem) then
              led7 <= led_codigo_dezena;
              led6 <= led_codigo_unidade;
          end if;

          if(state = contagem) THEN
            led5 <= led_tempo_dezena;
            led4 <= led_tempo_unidade;
          end if;

          if(state = defused or state = exploded) THEN
            led0 <= s0;
            led1 <= s1;
            led2 <= s2;
            led3 <= s3;
            led4 <= s4;
            led5 <= s5;
            led6 <= s6;
            led7 <= s7;
          end if;

      end process;

      reset_seletor <= '1' when ((state = armando) and (arma = '1')) else '0';
      tipo_estado <=  '1' when (state = exploded) else '0';

      Divisor1 : Divisor
        port map(clock=>clock,clocksaida=>customclock);

      seletocao1: Seletor
        port map(avanca=>avanca,volta=>volta,clock=>customclock,reset=>reset_seletor,valor=>codigo,s_0=>led_codigo_unidade,s_1=>led_codigo_dezena);

      operacao1 : Operation
        port map(clock=>customclock,codigo=>codigo,arma=>arma,state=>state,out_dez=>tempo_dezena,out_unidade=>tempo_unidade);

      led_tempo_1 : LEDNumerico
        port map(eLED=>tempo_unidade,sLED=>led_tempo_unidade);

      led_tempo_2 : LEDNumerico
        port map(eLED=>tempo_dezena,sLED=>led_tempo_dezena);

      led_status : LEDDefused
        port map(tipo => tipo_estado,s0=>s0,s1=>s1,s2=>s2,s3=>s3,s4=>s4,s5=>s5,s6=>s6,s7=>s7);

end archControle;
