PREG_LEDS: process(clock)
begin
    if rising_edge(clock) then 
        if reset = '1' then 
            leds <= "0000";
        else
            if dmem_we = '1' and dmem_a = x"88000000" then 
                leds <= dmem_di(3 downto 0);
            end if;
        end if;
    end if;
end process;