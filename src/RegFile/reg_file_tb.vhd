library IEEE;
use IEEE.std_logic_1164.all;

entity reg_file_tb is
end reg_file_tb;

architecture behavior of reg_file_tb is
    component reg_file is
        port (
            i_CLK, i_RST, i_WE : in std_logic;
            i_RS1, i_RS2, i_RD : in std_logic_vector(4 downto 0);
            i_Data : in std_logic_vector(31 downto 0);
            o_Read1, o_Read2 : out std_logic_vector(31 downto 0)
        );
    end component;

    signal s_CLK : std_logic := '0';
    signal s_RST : std_logic := '1';
    signal s_WE  : std_logic := '0';

    signal s_RS1, s_RS2, s_RD : std_logic_vector(4 downto 0)
        := (others => '0');
    signal s_Data : std_logic_vector(31 downto 0)
        := (others => '0');
    signal s_Read1, s_Read2 : std_logic_vector(31 downto 0);

begin
    DUT : reg_file
        port map (
            i_CLK   => s_CLK,
            i_RST   => s_RST,
            i_WE    => s_WE,
            i_RS1   => s_RS1,
            i_RS2   => s_RS2,
            i_RD    => s_RD,
            i_Data  => s_Data,
            o_Read1 => s_Read1,
            o_Read2 => s_Read2
        );

    -- Clock period = 100 ns.
    P_CLK : process
    begin
        s_CLK <= '0';
        wait for 50 ns;
        s_CLK <= '1';
        wait for 50 ns;
    end process;

    P_TB : process
    begin
        -- Reset all registers first.
        s_RS1 <= "00101";
        s_RS2 <= "01010";
        wait until falling_edge(s_CLK);
        s_RST <= '0';

        -- Test 1: write 10 into x5; read x5 and x0.
        s_WE   <= '1';
        s_RD   <= "00101";
        s_Data <= x"0000000A";
        s_RS1  <= "00101";
        s_RS2  <= "00000";
        wait until falling_edge(s_CLK);

        -- Test 2: write 20 into x10; read x5 and x10.
        s_RD   <= "01010";
        s_Data <= x"00000014";
        s_RS1  <= "00101";
        s_RS2  <= "01010";
        wait until falling_edge(s_CLK);

        -- Test 3: disable writing and try to overwrite x5.
        -- Swap the read addresses: read x10 and x5.
        s_WE   <= '0';
        s_RD   <= "00101";
        s_Data <= x"FFFFFFFF";
        s_RS1  <= "01010";
        s_RS2  <= "00101";
        wait until falling_edge(s_CLK);

        -- Test 4: try to write x0; it must remain zero.
        s_WE   <= '1';
        s_RD   <= "00000";
        s_Data <= x"FFFFFFFF";
        s_RS1  <= "00000";
        s_RS2  <= "01010";
        wait until falling_edge(s_CLK);

        s_WE <= '0';
        wait;
    end process;
end behavior;
