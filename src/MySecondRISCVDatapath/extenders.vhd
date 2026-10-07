-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- extenders.vhd
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity extend_n is
    generic (N : integer := 12);

    port (
        i_D    : in  std_logic_vector(N-1 downto 0);
        i_Sign : in  std_logic;
        o_Q    : out std_logic_vector(31 downto 0)
    );
end extend_n;

architecture dataflow of extend_n is
begin
    o_Q(N-1 downto 0) <= i_D;

    o_Q(31 downto N) <= (others => i_D(N-1))
                       when i_Sign = '1'
                       else (others => '0');
end dataflow;