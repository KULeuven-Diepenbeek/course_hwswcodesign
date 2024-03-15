--------------------------------------------------------------------------------
-- KU Leuven - ESAT/COSIC - Emerging technologies, Systems & Security
--------------------------------------------------------------------------------
-- Module Name:     eight_bit_mul_tb - Behavioural
-- Project Name:    Testbench for eight_bit_mul
-- Description:     
--
-- Revision     Date       Author     Comments
-- v0.1         20240229   VlJo       Initial version
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity eight_bit_mul_tb is
end entity eight_bit_mul_tb;

architecture Behavioural of eight_bit_mul_tb is

    component eight_bit_mul is
        port(
            clock : IN STD_LOGIC;
            reset_n : IN STD_LOGIC;
            A : in STD_LOGIC_VECTOR(7 downto 0);
            B : in STD_LOGIC_VECTOR(7 downto 0);
            Z : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component eight_bit_mul;

    signal clock : STD_LOGIC;
    signal reset_n : STD_LOGIC;
    signal A : STD_LOGIC_VECTOR(7 downto 0);
    signal B : STD_LOGIC_VECTOR(7 downto 0);
    signal Z : STD_LOGIC_VECTOR(7 downto 0);
    constant clock_period : time := 10 ns;

begin

    -------------------------------------------------------------------------------
    -- STIMULI
    -------------------------------------------------------------------------------
    PSTIM: process
    begin
        reset_n <= '0';
        A <= x"00";
        B <= x"00";
        wait for clock_period * 10;
        
        reset_n <= '1';
        wait for clock_period * 10;
        
        A <= x"02";
        B <= x"03";
        wait for clock_period*5;
        assert(Z = x"06") report ("ERROR") severity error;
        wait for clock_period*5;

        A <= x"0C";
        B <= x"06";
        wait for clock_period*5;
        assert(Z = x"48") report ("ERROR") severity error;
        wait for clock_period*5;

        A <= x"02";
        B <= x"03";
        wait for clock_period*5;
        assert(Z = x"06") report ("ERROR") severity error;
        wait for clock_period*5;

        A <= x"a5";
        B <= x"FF";
        wait for clock_period*5;
        assert(Z = x"5B") report ("ERROR") severity error;
        wait for clock_period*5;

        A <= x"F0";
        B <= x"03";
        wait for clock_period*5;
        assert(Z = x"D0") report ("ERROR") severity error;
        wait for clock_period*5;

        A <= x"72";
        B <= x"cc";
        wait for clock_period*5;
        assert(Z = x"D8") report ("ERROR") severity error;
        wait for clock_period*5;

        wait;
    end process;


    -------------------------------------------------------------------------------
    -- DUT
    -------------------------------------------------------------------------------
    DUT: component eight_bit_mul port map(
        clock => clock,
        reset_n => reset_n,
        A => A,
        B => B,
        Z => Z
    );


    -------------------------------------------------------------------------------
    -- CLOCK
    -------------------------------------------------------------------------------
    PCLK: process
    begin
        clock <= '1';
        wait for clock_period/2;
        clock <= '0';
        wait for clock_period/2;
    end process PCLK;

end Behavioural;