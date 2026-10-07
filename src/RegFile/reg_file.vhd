library IEEE;
use IEEE.std_logic_1164.all;
use work.mux_32b_data.all;

entity reg_file is
	port(
		i_CLK, i_RST, i_WE : in std_logic;
		i_RS1, i_RS2, i_RD : in std_logic_vector(4 downto 0);
		i_Data : in std_logic_vector(31 downto 0);
		o_Read1, o_Read2 : out std_logic_vector(31 downto 0)	
	);
end entity;

architecture structural of reg_file is
	signal s_Decode : std_logic_vector(31 downto 0);
	signal s_WE : std_logic_vector(31 downto 0);
	signal s_RegData : t_bus_2x32;

begin
	Decoder : entity work.decoder_5t32
		port map(
			i_D => i_RD,
			o_Q => s_Decode
		);
	
	s_RegData(0) <= (others => '0');
	s_WE(0) <= '0';

	G_Regs : for i in 1 to 31 generate
		s_WE(i) <= s_Decode(i) and i_WE;
		
		Reg_I : entity work.reg_nbit
			generic map(N => 32)
			port map(
				i_CLK 	=> i_CLK,
				i_RST 	=> i_RST,
				i_WE 	=> s_WE(i),
				i_D 	=> i_Data, 
				o_Q	=> s_RegData(i)
			);
	end generate;

	Read_MUX1 : entity work.mux_32t1
		port map(
			data => s_RegData,
			sel => i_RS1,
			o_out => o_Read1
		);

	Read_MUX2 : entity work.mux_32T1
		port map(
			data => s_RegData,
			sel => i_RS2,
			o_out => o_Read2
		);
end structural;	







