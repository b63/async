----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 09:48:12 PM
-- Design Name: 
-- Module Name: CLATCH - CLATCH_imp
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

library work;
use work.types.all;

entity CLATCH is
    generic (N : natural := 2;
             ACK : std_logic := '0';
             QSTATE: std_logic_vector (N-1 downto 0) := (others => 'U');
             DELAY : time := 0 ps);
    port ( inputs : in    DRAILS_T (N-1 downto 0);
           ack_in:  in std_logic;
           ack_out: out std_logic;
           outputs: out   DRAILS_T (N-1 downto 0));
           
end CLATCH;

architecture CLATCH_imp of CLATCH is
    signal inv_ack : std_logic;
    signal m_ack : std_logic := ACK;
    signal m_outputs: DRAILS_T (N-1 downto 0);
    signal m_outputs_stable: DRAILS_T (N-1 downto 0);
    signal m_outputs_or: std_logic_vector (N-1 downto 0);
begin
    GEN_CTL: for i in 0 to N-1 generate
        GEN_START: if (QSTATE(i) = '1') generate
            UTRUE:  entity work.CTL generic map (BITS => 2, Qstart => QSTATE(i))
                            port map ( inputs => std_logic_vector'(inv_ack & inputs(i).t), output => m_outputs(i).t);
            UFALSE: entity work.CTL generic map (BITS => 2, Qstart => not QSTATE(i))
                             port map (inputs => std_logic_vector'(inv_ack & inputs(i).f), output => m_outputs(i).f);
        elsif (QSTATE(i) = '0') generate
            UTRUE:  entity work.CTL generic map (BITS => 2, Qstart => QSTATE(i))
                            port map ( inputs => std_logic_vector'(inv_ack & inputs(i).t), output => m_outputs(i).t);
            UFALSE: entity work.CTL generic map (BITS => 2, Qstart => not QSTATE(i))
                             port map (inputs => std_logic_vector'(inv_ack & inputs(i).f), output => m_outputs(i).f);
        else generate
            UTRUE:  entity work.CTL generic map (BITS => 2, Qstart => '0')
                            port map ( inputs => std_logic_vector'(inv_ack & inputs(i).t), output => m_outputs(i).t);
            UFALSE: entity work.CTL generic map (BITS => 2, Qstart => '0')
                             port map (inputs => std_logic_vector'(inv_ack & inputs(i).f), output => m_outputs(i).f);
        end generate GEN_START;
        m_outputs_or(i) <= m_outputs(i).t or m_outputs(i).f;
    end generate GEN_CTL;
    
--    CAP_OUTPUTS: process (m_ack)
--    begin
--        if (m_ack'active) then
--            m_outputs_stable <= m_outputs;
--        end if;
--    end process;
    m_outputs_stable <= m_outputs;
    
    END_CTL: entity work.CTL generic map (BITS => N, Qstart => ACK)
                      port map (inputs => m_outputs_or, output => m_ack);
    ack_out <= m_ack after DELAY;
    outputs <= m_outputs_stable after DELAY;
    inv_ack <= not ack_in;
end CLATCH_imp;
