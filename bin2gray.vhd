--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: DIEGO PEREZ
-- Date: 2019-04-18
-- Design: bin2gray
-- Description: Binary digit to Gray code decoder.
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 


--------------------------------------------------------------------------------
-- Entity declaration for binary counter
--------------------------------------------------------------------------------
entity bin2gray is
    generic (
        N_BIT : integer := 2        				-- default number of bits
    );
    port(   
            -- Entity input signals
            clk_i   : in std_logic;
            b2g_in : in std_logic_vector(16-1 downto 0);  	--binary input
            
            -- Entity output signals
            b2g_out : out std_logic_vector(16-1 downto 0)  	--gray code output
    );
end bin2gray;

--------------------------------------------------------------------------------
-- Architecture declaration for binary counter
--------------------------------------------------------------------------------
architecture gate_level of bin2gray is 

begin

    p_bin2gray: process(clk_i)
    begin
        if rising_edge(clk_i) then
          L1: for count_value in 0 to (N_BIT-1-1) loop    --This loop have contains the algorithm necessary to pass from binary to Gray code
               b2g_out(count_value) <= b2g_in(count_value+1) xor b2g_in(count_value);
              end loop L1;
              b2g_out(N_BIT-1) <= b2g_in(N_BIT-1);
          if (N_BIT<16) then    
              L2: for count_value in N_BIT to (16-1) loop  --Fill the rest of bits with 0 to show it in the sseg display
                   b2g_out(count_value) <= '0';
                  end loop L2;
          end if;
              
              
        end if;
    end process p_bin2gray;

end;
