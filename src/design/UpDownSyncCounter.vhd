----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2026 13:40:46
-- Design Name: 
-- Module Name: UpDownSyncCounter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UpDownSyncCounter is
    Generic(
        COUNT_WIDTH : integer := 4
    );
    Port(
        reset : in std_logic;
        clk : in std_logic;
        inc_count : in std_logic;
        dec_count : in std_logic;
        count : out std_logic_vector(COUNT_WIDTH-1 DOWNTO 0)
    );
end UpDownSyncCounter;

architecture Behavioral of UpDownSyncCounter is

    component Register4Bit is
        Port (
            reset : in  STD_LOGIC;
            clk : in  STD_LOGIC;
            data_in  : in  STD_LOGIC_VECTOR(COUNT_WIDTH-1 downto 0);
            data_out : out STD_LOGIC_VECTOR(COUNT_WIDTH-1 downto 0)
        );
     end component;
    
	signal n_count : std_logic_vector(COUNT_WIDTH-1 DOWNTO 0);
	signal n_out : std_logic_vector(COUNT_WIDTH-1 DOWNTO 0);
	
begin
    
    inst_Register4Bit : Register4Bit
            port map(
                reset => reset,
                clk => clk,
                data_in => n_count,
                data_out => n_out
            );
    
    n_count <= std_logic_vector(signed(n_out) + 1) when (inc_count = '1' and dec_count = '0') else
               std_logic_vector(signed(n_out) - 1) when (inc_count = '0' and dec_count = '1') else
               n_out;
               
    count <= n_count;
    
end Behavioral;
