library IEEE;
library Bomba;

use IEEE.std_logic_1164.all;
use Bomba.Common.all;

entity Operation is
  port(clock: in std_logic;
      codigo: in std_logic_vector(3 downto 0);
      arma : in std_logic;
      out_dez,out_unidade : out std_logic_vector(3 downto 0);
      state: out BombaStage
      );
end Operation;

architecture archOperation of Operation is

  signal acabou,explodiu,reset_contador : std_logic;
  signal codigo_reg : std_logic_vector(3 downto 0);
  SIGNAL estado,proximo_estado: BombaStage := armando;

  component contador is
    port( clock,load: in std_logic;
  			in_dez,in_unidade : in std_logic_vector(3 downto 0);
  			out_dez,out_unidade : out std_logic_vector(3 downto 0);
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
      reset_contador <= '1' when estado=armando else '0';



    contador_1 : contador
      port map(clock=>clock,load=>reset_contador,in_dez=>"0110",in_unidade=>"0000",out_dez=>out_dez,out_unidade=>out_unidade,acabou=>explodiu);

end archOperation;
