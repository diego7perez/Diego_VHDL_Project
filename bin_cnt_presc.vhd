--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: HALA AMAHJOUR, DIEGO PEREZ
-- Date: 2019-04-18
-- Design: bin_cnt_presc
-- Description: N-bit binary counter with synchronous reset whose functionality 
--              is that of prescaler, controlling the speed of the count.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- for +/- arithmetic operations


entity bin_cnt_presc is
 generic (
        PRESC_BIT : integer := 5      -- default number of bits
    );
    port (
        -- Entity input signals
        clk_i   : in std_logic;
        rst_n_i : in std_logic;     -- reset =0: reset active
                                    --       =1: no reset
        -- Entity output signals
        bin_cnt_o : out std_logic_vector(PRESC_BIT-1 downto 0)
    );
end bin_cnt_presc;

--------------------------------------------------------------------------------
-- Architecture declaration for binary counter
--------------------------------------------------------------------------------
architecture Behavioral of bin_cnt_presc is
    signal s_reg  : std_logic_vector(PRESC_BIT-1 downto 0); --is the signal containing the current value of the count
    signal s_next : std_logic_vector(PRESC_BIT-1 downto 0); --is the signal containing the next value of the count
begin
    --------------------------------------------------------------------------------
    -- Register
    --------------------------------------------------------------------------------
    p_bin_cnt: process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_n_i = '0' then           -- synchronous reset
                s_reg <= (others => '0');   -- clear all bits in register
            else
                s_reg <= s_next;            -- update register value
            end if;
        end if;
    end process p_bin_cnt;

    --------------------------------------------------------------------------------
    -- Next-state logic
    --------------------------------------------------------------------------------
     s_next <= (s_reg + 1);
             
    --------------------------------------------------------------------------------
    -- Output logic
    --------------------------------------------------------------------------------
    bin_cnt_o <= s_reg;


end Behavioral;

