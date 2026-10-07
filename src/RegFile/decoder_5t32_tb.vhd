library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_5t32_tb is
end decoder_5t32_tb;

architecture behavior of decoder_5t32_tb is
	signal s_D : std_logic_vector(4 downto 0);
	signal s_Q : std_logic_vector(31 downto 0);

begin
	DUT : entity work.decoder_5t32
	port map(
		i_D => s_D,
		o_Q => s_Q
	);
	
	P_TB : process
	begin
		
        -- Test 1.
        	s_D   <= "00000";
        	wait for 10 ns;
	
	-- Test 2.
        	s_D   <= "00100";
        	wait for 10 ns;
	
	-- Test 3.
        	s_D   <= "10000";
        	wait for 10 ns;
	
	-- Test 4.
        	s_D   <= "01110";
        	wait for 10 ns;

	-- Test 5.
		s_D   <= "11010";
		wait for 10 ns;
	
	wait;
end process;
end behavior;
		