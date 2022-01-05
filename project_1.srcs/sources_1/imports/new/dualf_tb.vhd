----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2022 12:47:23 PM
-- Design Name: 
-- Module Name: dualf_tb - Behavioral
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

entity dualf_tb is
    port (start : std_logic := '0');
end;

architecture bench of dualf_tb is
  constant N : natural := 2;
  signal inputs_1, outputs_1 :  DRAILS_T (N-1 downto 0);
  signal ack_in_1: std_logic := '0';
  signal ack_out_1: std_logic;
  
  signal inputs_2, outputs_2 :  DRAILS_T (N-1 downto 0);
  signal ack_in_2: std_logic := '0';
  signal ack_out_2: std_logic;
  
  signal fin, fout : std_logic_vector (N-1 downto 0);
  --signal start: std_logic := '0';
  
  constant zero : DRAILS_T (N-1 downto 0) := (others => DRAIL_T'('0', '1'));
begin

  latch_1: entity work.CLATCH generic map (N => N)
                       port map (
                        inputs => inputs_1,
                        outputs => outputs_1,
                        ack_in => ack_in_1,
                        ack_out => ack_out_1);
  latch_2: entity work.CLATCH generic map (N => N)
                       port map (
                        inputs => inputs_2,
                        outputs => outputs_2,
                        ack_in => ack_in_2,
                        ack_out => ack_out_2);
  uut: entity work.DUALF generic map (BITS_IN => N, BITS_OUT => N)
                         port map (
                         dinputs => outputs_1,
                         sinputs => fout,
                         doutputs => inputs_2,
                         soutputs => fin
                         );
   fout <= std_logic_vector(unsigned(fin) + 1);
   inputs_1 <= outputs_2 when (start = '1') else zero;
   ack_in_1 <= ack_out_2 when (start = '1') else '1';
   
   stimulus: process
   begin
       wait for 10ps;
       start <= '0'; wait for 5ps;
       start <= '1'; wait for 10ps;
   end process stimulus;
end;
