-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- datapath_tb.vhd
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity datapath_tb is
end datapath_tb;

architecture behavior of datapath_tb is
  signal clk          : std_logic                     := '0';
  signal rst          : std_logic                     := '1';
  signal rw, sub, src : std_logic                     := '0';
  signal rs1, rs2, rd : std_logic_vector(4 downto 0)  := (others => '0');
  signal imm          : std_logic_vector(31 downto 0) := (others => '0');
  signal a, b, result : std_logic_vector(31 downto 0);
begin
  -- 100 ns clock period. Run the simulation for 2500 ns.
  clk <= not clk after 50 ns;

  DUT : entity work.datapath
    port map
    (
      i_CLK => clk, i_RST => rst, i_RegWrite => rw,
      i_nAdd_Sub => sub, i_ALUSrc => src,
      i_RS1 => rs1, i_RS2 => rs2, i_RD => rd,
      i_Imm => imm,
      o_Read1 => a, o_Read2 => b, o_Result => result
    );

  process
  begin
    -- Reset first; change instruction inputs on falling edges.
    wait until falling_edge(clk);
    rst <= '0';
    rw  <= '1';

    -- addi x1, x0, 1
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00001";
    sub <= '0';
    src <= '1';
    imm <= x"00000001";
    wait until falling_edge(clk);

    -- addi x2, x0, 2
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00010";
    sub <= '0';
    src <= '1';
    imm <= x"00000002";
    wait until falling_edge(clk);

    -- addi x3, x0, 3
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00011";
    sub <= '0';
    src <= '1';
    imm <= x"00000003";
    wait until falling_edge(clk);

    -- addi x4, x0, 4
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00100";
    sub <= '0';
    src <= '1';
    imm <= x"00000004";
    wait until falling_edge(clk);

    -- addi x5, x0, 5
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00101";
    sub <= '0';
    src <= '1';
    imm <= x"00000005";
    wait until falling_edge(clk);

    -- addi x6, x0, 6
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00110";
    sub <= '0';
    src <= '1';
    imm <= x"00000006";
    wait until falling_edge(clk);

    -- addi x7, x0, 7
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "00111";
    sub <= '0';
    src <= '1';
    imm <= x"00000007";
    wait until falling_edge(clk);

    -- addi x8, x0, 8
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "01000";
    sub <= '0';
    src <= '1';
    imm <= x"00000008";
    wait until falling_edge(clk);

    -- addi x9, x0, 9
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "01001";
    sub <= '0';
    src <= '1';
    imm <= x"00000009";
    wait until falling_edge(clk);

    -- addi x10, x0, 10
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "01010";
    sub <= '0';
    src <= '1';
    imm <= x"0000000A";
    wait until falling_edge(clk);

    -- add x11, x1, x2
    rs1 <= "00001";
    rs2 <= "00010";
    rd  <= "01011";
    sub <= '0';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- sub x12, x11, x3
    rs1 <= "01011";
    rs2 <= "00011";
    rd  <= "01100";
    sub <= '1';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- add x13, x12, x4
    rs1 <= "01100";
    rs2 <= "00100";
    rd  <= "01101";
    sub <= '0';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- sub x14, x13, x5
    rs1 <= "01101";
    rs2 <= "00101";
    rd  <= "01110";
    sub <= '1';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- add x15, x14, x6
    rs1 <= "01110";
    rs2 <= "00110";
    rd  <= "01111";
    sub <= '0';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- sub x16, x15, x7
    rs1 <= "01111";
    rs2 <= "00111";
    rd  <= "10000";
    sub <= '1';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- add x17, x16, x8
    rs1 <= "10000";
    rs2 <= "01000";
    rd  <= "10001";
    sub <= '0';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- sub x18, x17, x9
    rs1 <= "10001";
    rs2 <= "01001";
    rd  <= "10010";
    sub <= '1';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- add x19, x18, x10
    rs1 <= "10010";
    rs2 <= "01010";
    rd  <= "10011";
    sub <= '0';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- addi x20, x0, -35
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "10100";
    sub <= '0';
    src <= '1';
    imm <= x"FFFFFFDD";
    wait until falling_edge(clk);

    -- add x21, x19, x20
    rs1 <= "10011";
    rs2 <= "10100";
    rd  <= "10101";
    sub <= '0';
    src <= '0';
    imm <= x"00000000";
    wait until falling_edge(clk);

    -- lui x22, 0xFEED2
    rs1 <= "00000";
    rs2 <= "00000";
    rd  <= "10110";
    sub <= '1';
    src <= '1';
    imm <= x"FEED2000";
    wait until falling_edge(clk);

    -- addi x22, x22, 80
    rs1 <= "10110";
    rs2 <= "00000";
    rd  <= "10110";
    sub <= '0';
    src <= '1';
    imm <= x"00000050";
    wait until falling_edge(clk);

    -- Program finished. Disable writes and leave registers unchanged.
    rw <= '0';
    wait;
  end process;
end behavior;
