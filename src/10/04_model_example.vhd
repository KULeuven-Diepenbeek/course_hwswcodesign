library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
    use IEEE.STD_LOGIC_MISC.or_reduce;
    use ieee.std_logic_textio.all;
    use STD.textio.all;

entity basicIO_model is
    generic (
        G_DATA_WIDTH : integer := 32;
        FNAME_OUT_FILE : string := "data.dat"
    );
    port (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        di : IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
        ad : IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
        we : IN STD_LOGIC;
        do : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
        writing_out_flag : OUT STD_LOGIC
    );
end entity basicIO_model;

architecture Behavioural of basicIO_model is

    -- localised inputs
    signal clock_i, reset_i, we_i, writing_out_flag_o : STD_LOGIC;
    signal di_i, ad_i, do_o : STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
    file ofh : text;

begin

    -- (DE-)LOCALISING IN/OUTPUTS
    clock_i <= clock;    reset_i <= reset;
    di_i <= di;          ad_i <= ad;
    we_i <= we;
    do <= do_o;          writing_out_flag <= writing_out_flag_o;

    -- COMBINATORIAL
    writing_out_flag_o <= we_i when ad_i = x"80000000" else '0';

    -- MEMORY
    PMEM: process(reset_i, clock_i)
        variable v_line : line;
        variable v_temp : STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
        variable v_pointer : integer;
    begin
        if reset_i = '1' then 
            file_open(ofh, FNAME_OUT_FILE, write_mode);
        elsif rising_edge(clock_i) then 
            if we_i = '1' then 
                if ad_i = x"80000000" then 
                    write(v_line, di_i);
                    writeline(ofh, v_line);
                end if;
            end if;
        end if;
    end process;

end Behavioural;
