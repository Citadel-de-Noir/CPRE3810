-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Adder_nbit.vhd
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Adder_nbit is
	generic(N : integer := 32);

	port(
		i_C : in std_logic;
		i_X : in std_logic_vector(N-1 downto 0);
		i_Y : in std_logic_vector(N-1 downto 0);
		o_S : out std_logic_vector(N-1 downto 0);
		o_C : out std_logic
	);
end Adder_nbit;

architecture mixture of Adder_nbit is

	component Adder is
		port(
		i_C : in std_logic;
		i_X : in std_logic;
		i_Y : in std_logic;
		o_S : out std_logic;
		o_C : out std_logic
		);
	end component;

	signal carry : std_logic_vector(N downto 0);

begin

	carry(0) <= i_C;

	G_Adder_nbit : for i in 0 to N-1 generate
		FA : Adder
			port map(
				i_X => i_X(i),
				i_Y => i_Y(i),
				i_C => carry(i),
				o_S => o_S(i),
				o_C => carry(i+1)
			);
	end generate G_Adder_nbit;

	o_C <= carry(N);
end mixture;
	












