-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
-- mux using structural VHDL, generics, and generate statements.

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
  --generic(N : integer := 8);
  port(i_S          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_O          : out std_logic);

end mux;

architecture structural of mux is

  component andg2 is
    port(i_A                 : in std_logic;
         i_B                 : in std_logic;
         o_F                 : out std_logic
	);
  end component;

  component invg is
    port(i_A		: in std_logic;
	 o_F		: out std_logic
	);
  end component;

  component org2 is
    port(i_A		: in std_logic;
	 i_B		: in std_logic;
	 o_F		: out std_logic
	);
  end component;

  signal s_not : std_logic;
  signal d0_and : std_logic;
  signal d1_and : std_logic;
  
begin

  Inv_s : invg
	port map(
		i_A => i_S,
		o_F => s_not
		);
 
  -- Instantiate N mux instances.
  --G_NBit_MUX: for i in 0 to N-1 generate
  
  And_D0 : andg2
	port map(
		i_A => i_D0,
		i_B => s_not,
		o_F => d0_and
		);

  And_D1 : andg2
	port map(
		i_A => i_D1,
		i_B => i_S,
		o_F => d1_and
		);

  Or_O : org2
	port map(
		i_A => d0_and,
		i_B => d1_and,
		o_F => o_O
		);

  --end generate G_NBit_MUX;
  
end structural;
