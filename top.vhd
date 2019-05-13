--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: DIEGO PEREZ
-- Date: 2019-04-18
-- Design: top
-- Description: Implementation of N bits Gray code counter in a 7-segment display time-multiplexing module.
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------------------------------------
-- Entity declaration for top level
--------------------------------------------------------------------------------
entity top is
    port (
        -- Global input signals at Coolrunner-II board
        clk_i : in std_logic;   -- use jumpers and select 10 kHz clock
        sw_i  : in std_logic_vector(2-1 downto 0);  -- slide switches

        -- Global output signals at Coolrunner-II board
        disp_digit_o : out std_logic_vector(4-1 downto 0);  -- 7-segment
        disp_sseg_o  : out std_logic_vector(7-1 downto 0)
    );
end top;

--------------------------------------------------------------------------------
-- Architecture declaration for top level
--------------------------------------------------------------------------------
architecture Behavioral of top is

    signal  s_data3_i :  std_logic_vector(4-1 downto 0);
    signal  s_data2_i :  std_logic_vector(4-1 downto 0);
    signal  s_data1_i :  std_logic_vector(4-1 downto 0);
    signal  s_data0_i :  std_logic_vector(4-1 downto 0);
    signal s_sw_i  :  std_logic_vector(2-1 downto 0);


begin
     
     s_sw_i(0) <= sw_i(0); --switch of the up/down
     s_sw_i(1) <= sw_i(1); --switch of the reset 
     
    -- sub-block of Gray counter
    GRAY_CNT : entity work.gray_cnt
    port map (
    
        clk_i => clk_i,  
        rst_n_i => s_sw_i(1),
        g_s_up(0) => s_sw_i(0),
        
        -- We connect the output of the gray_counter to the display multiplexer
        g_out(15 downto 12) => s_data3_i,  
        g_out(11 downto 8) => s_data2_i,
        g_out(7 downto 4) => s_data1_i,
        g_out(3 downto 0)=> s_data0_i
        
        );
    
    -- sub-block of display multiplexer
    DISPMUX : entity work.disp_mux
    port map (
    
        clk_i => clk_i,                 -- 10 kHz
        
        -- We connect the output of the gray_counter to the display multiplexer
        data3_i => s_data3_i,
        data2_i => s_data2_i,
        data1_i => s_data1_i,
        data0_i => s_data0_i,
        
        an_o => disp_digit_o,
        sseg_o => disp_sseg_o
    );
    
end Behavioral;
