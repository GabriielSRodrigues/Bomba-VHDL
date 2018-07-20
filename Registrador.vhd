
ENTITY Registrador is
	port(	clear,clock,carga: in bit;
		    load : in bit_vector(3 downto 0);
		    q : out bit_vector(3 downto 0)
	     );
end Registrador;

architecture ArchRegistrador of Registrador is
	begin
process (clock)
	variable qtemp : bit_vector(3 downto 0);
	begin
	if clear = '1' THEN
		qtemp := "0000";
	elsif clock'EVENT and clock ='1' then
		if carga = '1' then
			qtemp := load;
		else
			qtemp := qtemp;
		end if;
	end if;
	q<= qtemp;

end process;
end ArchRegistrador;
