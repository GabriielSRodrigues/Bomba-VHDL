library IEEE;
library Bomba;

use IEEE.std_logic_1164.all;
use Bomba.Common.all;

entity Operation is
  port(clock: in std_logic;
      codigo: in std_logic_vector(3 downto 0);
      arma : in std_logic;
      tempo: out std_logic_vector(5 downto 0);
      state: out BombaStage
      );
end Operation;

architecture archOperation of Operation is

  signal acabou,explodiu : std_logic;
  signal codigo_reg : std_logic_vector(3 downto 0);
  SIGNAL estado,proximo_estado: BombaStage := armando;


  component contador is
    port(
		clock,load: in std_logic;
      valor : in std_logic_vector(5 downto 0);
      scont: out std_logic_vector(5 downto 0);
      acabou: out std_logic
      );
  end component;

  component LED is
	port(eLED: in std_logic_vector(3 downto 0);
		  sLED: out std_logic_vector(0 to 6)
		  );
	end component;

  begin
    process (clock)

      variable def_code : std_logic_vector(3 downto 0);
      begin
        if (clock'event and clock ='1') then
          case (estado) is
            when armando =>
              if (arma='1') THEN
                def_code := codigo;
                proximo_estado <= contagem;
              end if;
            when contagem =>
              if (explodiu = '1') then
                proximo_estado <= exploded;
              elsif (arma='1') THEN
                if(codigo = def_code) then
                  proximo_estado <= defused;
                end if;
              end if;
            when defused =>
              -- Controle cuida disso
            when exploded =>
             -- Controle cuida disso
          end case;
        end if;
      end process;

      process (proximo_estado)
        begin
          estado <= proximo_estado;
      end process;
      state <= estado;
    contador_1 : contador
      port map(clock=>clock,load=>arma, valor=>"111100", scont=>tempo,acabou=>explodiu);
--    bcd: LED
  -- 	  port map(eLED=>fio0,sLED=>fio1);

end archOperation;
