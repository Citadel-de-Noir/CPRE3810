-------------------------------------------------------------------------
-- Sayon Saha
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_datapath2.vhd
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_datapath2 is
end tb_datapath2;

architecture behavior of tb_datapath2 is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal rw, sub, src, mw, mtr, it : std_logic := '0';
    signal rs1, rs2, rd : std_logic_vector(4 downto 0) := (others => '0');
    signal imm12 : std_logic_vector(11 downto 0) := (others => '0');
    signal imm20 : std_logic_vector(19 downto 0) := (others => '0');
    signal a, b, result, md, wb : std_logic_vector(31 downto 0);
begin
    clk <= not clk after 50 ns;

    DUT : entity work.datapath2
        port map (
            i_CLK => clk, i_RST => rst, i_RegWrite => rw,
            i_nAdd_Sub => sub, i_ALUSrc => src,
            i_MemWrite => mw, i_MemToReg => mtr, i_ImmType => it,
            i_RS1 => rs1, i_RS2 => rs2, i_RD => rd,
            i_Imm12 => imm12, i_Imm20 => imm20,
            o_Read1 => a, o_Read2 => b, o_ALUResult => result,
            o_MemData => md, o_MemWriteBack => wb
        );

    process
    begin
        -- Load dmem.hex into DUT/dmem/ram before running the simulation.
        wait until falling_edge(clk);
        rst <= '0';


        
        -- lui x25, 0x10010
        rs1 <= "00000"; rs2 <= "00000"; rd <= "11001";
        sub <= '1'; src <= '1'; rw <= '1';
        mw <= '0'; mtr <= '0'; it <= '1';
        imm12 <= x"000"; imm20 <= x"10010";
        wait until falling_edge(clk);

        -- addi x25, x25, 0
        rs1 <= "11001"; rs2 <= "00000"; rd <= "11001";
        sub <= '0'; src <= '1'; rw <= '1';
        mw <= '0'; mtr <= '0'; it <= '0';
        imm12 <= x"000"; imm20 <= x"00000";
        wait until falling_edge(clk);

        -- addi x2, x0, 46
        rs1 <= "00000";
        rs2 <= "00000"; rd <= "00010";
        sub <= '0';
        src <= '1';
        rw <= '1';
        mw <= '0';
        mtr <= '0';
        it <= '0';
        imm12 <= x"02E";
        imm20 <= x"00000";
        wait until falling_edge(clk);

        -- sw x2, C70(x26)
        rs1 <= "11010"; rs2 <= "00010"; rd <= "00000";
        sub <= '0'; src <= '1'; rw <= '0';
        mw <= '1'; mtr <= '0'; it <= '0';
        imm12 <= x"C70"; imm20 <= x"00000";
        wait until falling_edge(clk);

        -- lw x1, C70(x26)
        rs1 <= "11010"; rs2 <= "00000"; rd <= "00001";
        sub <= '0'; src <= '1'; rw <= '1';
        mw <= '0'; mtr <= '1'; it <= '0';
        imm12 <= x"C70"; imm20 <= x"00000";
        wait until falling_edge(clk);

     

        -- End of program: hold the register and memory contents.
        rw <= '0';
        mw <= '0';
        wait;
    end process;
end behavior;
