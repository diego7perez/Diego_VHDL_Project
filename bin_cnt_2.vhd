--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: DIEGO PEREZ
-- Date: 2019-04-18
-- Design: bin_cnt_2
-- Description: N-bit binary counter with synchronous reset which has a binary account of N bits.
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- for +/- arithmetic operations

--------------------------------------------------------------------------------
-- Entity declaration for binary counter
--------------------------------------------------------------------------------
entity bin_cnt_2 is
    generic (
        N_BIT : integer := 2     -- default number of bits for the N bits count
    );
    port (
        -- Entity input signals
        s_up   : in std_logic_vector(0 downto 0); --up/down signal
        b_in : in std_logic_vector(16-1 downto 0);
        clk_i   : in std_logic;
        rst_n_i : in std_logic;     -- reset =0: reset active
                                    --       =1: no reset
        -- Entity output signals
         b_out : out std_logic_vector(16-1 downto 0) 
        
    );
end bin_cnt_2;

--------------------------------------------------------------------------------
-- Architecture declaration for binary counter
--------------------------------------------------------------------------------
architecture Behavioral of bin_cnt_2 is
    signal s_reg  : std_logic_vector(N_BIT-1 downto 0); --is the signal containing the current value of the count
    signal s_next : std_logic_vector(N_BIT-1 downto 0); --is the signal containing the next value of the count	
begin


    p_bin_cnt: process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_n_i = '0' then           -- synchronous reset
                s_reg <= (others => '0');   -- clear all bits in register
            else
                s_reg <= s_next;            -- update register value
              
                L1: for count_value in 0 to (N_BIT-1) loop       --count up to N bits
                    b_out(count_value) <= s_reg(count_value);
                end loop L1;
                
                L2: for count_value in N_BIT to (16-1) loop      --fill the rest of bits with 0 to show it in the sseg display
                    b_out(count_value) <= '0';
                end loop L2;
                
            end if;
        end if;
    end process p_bin_cnt;

    --------------------------------------------------------------------------------
    -- Next-state logic
    --------------------------------------------------------------------------------
     -- If s_up=1 we are counting up and if s_up=0 we are counting down
     s_next <= (s_reg + 1) when (s_up(0) = '1') else
              (s_reg - 1);
             


end Behavioral;
