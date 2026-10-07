library IEEE;
use IEEE.std_logic_1164.all;
use work.mux_32b_data.all;

entity mux_32t1_tb is
end mux_32t1_tb;

architecture mixture of mux_32t1_tb is
	signal s_data : t_bus_2x32 := (
		0 => x"11111101",
		5 => x"5F5F5F5F",
		16 => x"FFFF0000",
		31 => x"10101010",
		others => (others => '0')
	);

	signal s_sel : std_logic_vector(4 downto 0) := "00000";
	signal s_out : std_logic_vector(31 downto 0);
begin
	DUT : entity work.mux_32t1
	port map(
		data => s_data,
		sel => s_sel,
		o_out => s_out
	);

	P_TB : process
	begin
		-- test 1
	
		s_sel <= "00000";
		wait for 50 ns;

		-- test 2
	
		s_sel <= "00101";
		wait for 50 ns;

		-- test 3
	
		s_sel <= "11111";
		wait for 50 ns;

		-- test 4
		s_sel <= "10010";
	
		s_sel <= "00000";
		wait for 50 ns;

		wait;
	end process;
end mixture;
















