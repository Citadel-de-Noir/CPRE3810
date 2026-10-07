-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_extenders.vhd
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_extenders is
end tb_extenders;

architecture behavior of tb_extenders is
    signal s_D    : std_logic_vector(11 downto 0);
    signal s_Sign : std_logic;
    signal s_Q    : std_logic_vector(31 downto 0);
begin
    DUT : entity work.extend_n
        generic map (N => 12)
        port map (
            i_D    => s_D,
            i_Sign => s_Sign,
            o_Q    => s_Q
        );

    process
    begin
        -- Sign-extend +5: expect 00000005.
        s_D    <= x"005";
        s_Sign <= '1';
        wait for 50 ns;

        -- Sign-extend -4: expect FFFFFFFC.
        s_D    <= x"FFC";
        s_Sign <= '1';
        wait for 50 ns;

        -- Zero-extend FFC: expect 00000FFC.
        s_D    <= x"FFC";
        s_Sign <= '0';
        wait for 50 ns;

        -- Zero-extend 800: expect 00000800.
        s_D    <= x"800";
        s_Sign <= '0';
        wait for 50 ns;

        wait;
    end process;
end behavior;