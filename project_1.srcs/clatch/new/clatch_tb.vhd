----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 10:52:14 PM
-- Design Name: 
-- Module Name: clatch_tb - clatch_tb
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

library work;
use work.types.all;

entity clatch_tb is
end;

architecture bench of clatch_tb is
  constant N : natural := 2;
  signal inputs :  DRAILS_T (N-1 downto 0);
  signal outputs : DRAILS_T (N-1 downto 0);
  signal outputs_s: std_logic_vector(N-1 downto 0);
  signal ack_in: std_logic := '0';
  signal ack_out: std_logic;
begin

  uut: entity work.CLATCH generic map (N => N)
                       port map (
                        inputs => inputs,
                        outputs => outputs,
                        ack_in => ack_in,
                        ack_out => ack_out);

  stimulus: process
  begin
    -- Put initialisation code here
    --allloop: for i in 0 to 15 loop
    --    bits := to_unsigned(i, 4);
    --    inputs <= std_logic_vector(bits);
    --    wait for 2ps;
    --  end loop
    outputs_s <= drails_to_logic(outputs);
    -- check that default output is empty
    inputs <= (('X','X'), ('X','X')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    
    -- send "10"
    inputs <= (('1','0'), ('0','1')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    
    -- check that output doesn't change    
    inputs <= (('0','0'), ('0','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    inputs <= (('X','X'), ('X','X')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    -- these will screw things up? the output for the bit that's 1 will change making the output be an invalid token (1, 1), (1, 1)
    --inputs <= (('Z','1'), ('X','1')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    
    -- prev sends empty "00" and next acks with ack_in, output should change to empty
    ack_in <= '1';
    inputs <= (('0','0'), ('0','0'));
    outputs_s <= drails_to_logic(outputs); wait for 2ps;
    -- next acks the empty token with ack_in 
    ack_in <= '0';
    wait for 2ps;
    -- ready to send next token, prev sends "00" this time; output should change to "00";
    inputs <= logic_vec_to_drails("00"); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    -- next acks token with ack_in
    ack_in <=  '1'; wait for 2ps;
    -- prev sends empty token, should ack with ack_out
    inputs <= (('0','0'), ('0','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    
--    -- slowly send 11
--    inputs <= (('1','0'), ('0','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    inputs <= (('1','0'), ('1','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    -- send empty 
--    inputs <= (('0','0'), ('0','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    -- send 00 
--    inputs <= (('1','0'), ('0','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    inputs <= (('1','0'), ('1','0')); outputs_s <= drails_to_logic(outputs); wait for 2ps;
    
--    wait for 10ps;
    
--     -- send empty
--    inputs <= logic_vec_to_drails ("XX"); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    -- slowly send 11
--    inputs <= logic_vec_to_drails ("11"); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    -- send empty 
--    inputs <= logic_vec_to_drails ("XX"); outputs_s <= drails_to_logic(outputs); wait for 2ps;
--    -- send 00 
--    inputs <= logic_vec_to_drails ("00"); outputs_s <= drails_to_logic(outputs); wait for 2ps;
  end process stimulus;


end;

