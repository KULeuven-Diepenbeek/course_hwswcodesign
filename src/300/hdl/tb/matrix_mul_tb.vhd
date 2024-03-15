--------------------------------------------------------------------------------
-- KU Leuven - ESAT/COSIC - Emerging technologies, Systems & Security
--------------------------------------------------------------------------------
-- Module Name:     matrix_mul_tb - Behavioural
-- Project Name:    Testbench for matrix_mul
-- Description:     
--
-- Revision     Date       Author     Comments
-- v0.1         20240305   VlJo       Initial version
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity matrix_mul_tb is
end entity matrix_mul_tb;

architecture Behavioural of matrix_mul_tb is

    component matrix_mul is
        port(
            clock : IN STD_LOGIC;
            reset_n : IN STD_LOGIC;
            ce : IN STD_LOGIC;
            A : in STD_LOGIC_VECTOR(31 downto 0);
            B : in STD_LOGIC_VECTOR(31 downto 0);
            Z : out STD_LOGIC_VECTOR(31 downto 0);
            done : out STD_LOGIC
        );
    end component;

    signal clock : STD_LOGIC;
    signal reset_n : STD_LOGIC;
    signal ce : STD_LOGIC;
    signal A : STD_LOGIC_VECTOR(31 downto 0);
    signal B : STD_LOGIC_VECTOR(31 downto 0);
    signal Z : STD_LOGIC_VECTOR(31 downto 0);
    signal done : STD_LOGIC;

    constant clock_period : time := 10 ns;

begin

    -------------------------------------------------------------------------------
    -- STIMULI
    -------------------------------------------------------------------------------
    PSTIM: process
    begin
        reset_n <= '0';
        ce <= '0';
        A <= x"00000000";
        B <= x"00000000";
        wait for clock_period * 10;
        
        reset_n <= '1';
        wait for clock_period * 10;

        ce <= '1';
        A <= x"02010402";
        B <= x"00010100";
        wait for clock_period * 1;
        ce <= '0';
        wait for clock_period * 19;
        
        ce <= '1';
        A <= x"10021E05";
        B <= x"0171fa0c";
        wait for clock_period * 1;
        ce <= '0';
        wait for clock_period * 19;
        
        wait;
    end process;


    -------------------------------------------------------------------------------
    -- DUT
    -------------------------------------------------------------------------------
    DUT: component matrix_mul port map(
        clock => clock,
        reset_n => reset_n,
        ce => ce,
        A => A,
        B => B,
        Z => Z,
        done => done
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