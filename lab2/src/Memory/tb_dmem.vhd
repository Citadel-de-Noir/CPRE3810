-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mem_tb.vhd
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_dmem is
end tb_dmem;

architecture mixture of tb_dmem is
    signal clk : std_logic := '0';
    signal addr : std_logic_vector(9 downto 0) := (others => '0');
    signal data, q : std_logic_vector(31 downto 0) := (others => '0');
    signal we : std_logic := '0';
    signal be : std_logic_vector(3 downto 0) := "1111";
    type words is array(0 to 9) of std_logic_vector(31 downto 0);

    begin
        clk <= not clk after 50 ns;
        dmem : entity work.mem
            port map(
                clk => clk,
                addr => addr,
                data => data,
                q => q,
                we => we,
                be => be
            );
            process
                variable saved : words;
            begin

                for i in 0 to 9 loop
                    addr <= std_logic_vector(to_unsigned(i, 10));
                    wait for 20 ns;
                    saved(i) := q;
                end loop;

                for i in 0 to 9 loop
                    wait until falling_edge(clk);
                    addr <= std_logic_vector(to_unsigned(16#100#+i, 10));
                    data <= saved(i);
                    we <= '1';
                    wait until rising_edge(clk);
                    wait for 1 ns;
                end loop;

                wait until falling_edge(clk);
                we <= '0';
                for i in 0 to 9 loop
                    addr <= std_logic_vector(to_unsigned(16#100#+i, 10));
                    wait for 20 ns;
                end loop;

                wait;
            end process;
end architecture;
