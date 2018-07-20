library IEEE;
use IEEE.std_logic_1164.all;

entity Operation is
  port(clock: in std_logic;
      desarma: in std_logic;
      arma_codigo: in std_logic_vector(3 downto 0);
      arma : in std_logic
      );
end Operation;

architecture archOperation of Operation is

  signal acabou,explodiu : std_logic;
  signal in_tempo : std_logic_vector(5 downto 0);

  signal dig0 : std_logic_vector(3 downto 0);
  signal dig1 : std_logic_vector(3 downto 0);
  signal dig2 : std_logic_vector(3 downto 0);

  TYPE BombaStage is (armando, contagem, defused, exploded);
  SIGNAL estado,proximo_estado: BombaStage;

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
    process (clock,explodiu)
      begin
        case (estado) is
          when armando =>

          when contagem =>
            if (explodiu'event and explodiu = '1') then
              proximo_estado <= exploded;
            end if;
          when defused =>
            --
          when exploded =>
           --
        end case;
      end process;

      process (proximo_estado)
        begin
          estado <= proximo_estado;
      end process;


    tempo : contador
      port map(clock=>clock,load=>arma, valor=>"111100", scont=>in_tempo,acabou=>explodiu);
    bcd: LED
   	port map(eLED=>fio0,sLED=>fio1);


end archOperation;
