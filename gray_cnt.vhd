--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: HALA AMAHJOUR, DIEGO PEREZ
-- Date: 2019-04-18
-- Design: gray_count
-- Description: Gray counter module.
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
-- Entity declaration for display multiplexer
--------------------------------------------------------------------------------
entity gray_cnt
is
    generic (
        N_BIT : integer := 16     -- default number of bits
        
    );
     port (
     -- Entity input signals    
     clk_i   : in std_logic;
     rst_n_i : in std_logic;
     g_s_up   : in std_logic_vector(0 downto 0);
     
      -- Entity output signals
     g_out   : out std_logic_vector(16-1 downto 0)
        );
     
end gray_cnt;

--------------------------------------------------------------------------------
-- Architecture declaration for display multiplexer
--------------------------------------------------------------------------------
architecture Behavioral of gray_cnt is

    constant PRESC_BIT : integer := 20; --Number of bits for the prescaler
    constant c_NBIT : integer := 16; --Number of bits of the N-bits gray counter
    signal s_clk_prescaler : std_logic_vector(PRESC_BIT-1 downto 0);
    signal s_b_in : std_logic_vector(16-1 downto 0);
 
begin

     -- sub-block of bin_cnt_presc entity
 BINCNTPRESC : entity work.bin_cnt_presc
    generic map (
        PRESC_BIT => PRESC_BIT          -- N_bit binary counter
    )
    port map (
        clk_i => clk_i,                 -- 10 kHz
        rst_n_i => '1',                 -- inactive reset
        bin_cnt_o => s_clk_prescaler    -- output bits
    );

    -- sub-block of bin_cnt_2 entity
 BINCNT2 : entity work.bin_cnt_2
    generic map (
        N_BIT => c_NBIT              
    )
  port map (
        b_in => s_b_in,  
        s_up(0) => g_s_up(0),
        clk_i => s_clk_prescaler(PRESC_BIT-1), 
        rst_n_i => rst_n_i,
        b_out => s_b_in
    );
    -- sub-block of bin2gray entity
 BIN2GRAY : entity work.bin2gray
    generic map (
        N_BIT => c_NBIT                 
    )
    port map (
        clk_i => clk_i,
        b2g_in => s_b_in,  
        b2g_out => g_out
    );


end Behavioral;

