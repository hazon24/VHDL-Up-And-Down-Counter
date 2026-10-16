library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register4bit is
    Generic (
        COUNT_WIDTH : integer := 4
    );
    Port (
        reset : in  STD_LOGIC;
        clk : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR(COUNT_WIDTH-1 downto 0);
        data_out : out STD_LOGIC_VECTOR(COUNT_WIDTH-1 downto 0)
    );
end Register4bit;

architecture Behavioral of Register4bit is

    component ff_d is
        Port (
            reset : in  STD_LOGIC;
            clk : in  STD_LOGIC;
            d : in  STD_LOGIC;
            q : out STD_LOGIC
        );
    end component;

begin

    LOOP_GEN : for I in 0 to COUNT_WIDTH-1 generate
        ff_d_inst : ff_d
            port map (
                reset => reset,
                clk => clk,
                d => data_in(I),
                q => data_out(I)
            );
    end generate LOOP_GEN;

end Behavioral;