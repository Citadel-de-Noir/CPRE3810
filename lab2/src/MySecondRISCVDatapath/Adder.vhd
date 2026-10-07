-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Adder.vhd
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity Adder is
	port(
		i_C : in std_logic;
		i_X : in std_logic;
		i_Y : in std_logic;
		o_S : out std_logic;
		o_C : out std_logic
	);
end Adder;

architecture mixture of Adder is
	component andg2 is
		port(
			i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic
		);
	end component;
		
	component org2 is 
		port(
			i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic
		);
	end component;

	component xorg2 is 
		port(
			i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic
		);
	end component;

	signal s_xor0 : std_logic;
	signal s_and0 : std_logic;
	signal s_and1 : std_logic;

begin 
	XOR_0 : xorg2
		port map(
			i_A => i_X,
			i_B => i_Y,
			o_F => s_xor0
		);
	
	XOR_1 : xorg2
		port map(
			i_A => i_C,
			i_B => s_xor0,
			o_F => o_S
		);

	AND_0 : andg2
		port map(
			i_A => i_X,
			i_B => i_Y,
			o_F => s_and0
		);
	
	AND_1 : andg2
		port map(
			i_A => i_C,
			i_B => s_xor0,
			o_F => s_and1
		);

	OR_0 : org2
		port map(
			i_A => s_and0,
			i_B => s_and1,
			o_F => o_C
		);
	
end mixture;

