-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- datapath.vhd
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity datapath is
  generic (N : integer := 32);

  port (
    i_CLK      : in std_logic;
    i_RST      : in std_logic;
    i_RegWrite : in std_logic;
    i_ALUSrc   : in std_logic;
    i_nAdd_Sub : in std_logic;
    i_imm      : in std_logic_vector(N - 1 downto 0);
    i_RS1      : in std_logic_vector(4 downto 0);
    i_RS2      : in std_logic_vector(4 downto 0);
    i_RD       : in std_logic_vector(4 downto 0);
    o_Read1    : out std_logic_vector(N - 1 downto 0);
    o_Read2    : out std_logic_vector(N - 1 downto 0);
    o_Result   : out std_logic_vector(N - 1 downto 0)
  );
end datapath;

architecture structural of datapath is
  signal s_A, s_B, s_Result : std_logic_vector(N - 1 downto 0);

begin
  reg_file : entity work.reg_file
    port map
    (
      i_CLK   => i_CLK,
      i_RST   => i_RST,
      i_WE    => i_RegWrite,
      i_RS1   => i_RS1,
      i_RS2   => i_RS2,
      i_RD    => i_RD,
      i_Data  => s_Result,
      o_Read1 => s_A,
      o_Read2 => s_B
    );

  AddSub : entity work.AddSub_mod
    generic map(N => N)
    port map
    (
      i_A        => s_A,
      i_B        => s_B,
      i_nAdd_Sub => i_nAdd_Sub,
      i_imm      => i_imm,
      i_ALUSrc   => i_ALUSrc,
      o_S        => s_Result,
      o_C        => open
    );

  o_Read1  <= s_A;
  o_Read2  <= s_B;
  o_Result <= s_Result;

end structural;