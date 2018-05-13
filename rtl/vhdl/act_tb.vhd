-------------------------------------------------------------------------------
-- Title      : Testbench for design "act"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : act_tb.vhd
-- Author     :   <nova0@DESKTOP-UVE1A1Q>
-- Company    : 
-- Created    : 2018-05-12
-- Last update: 2018-05-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-05-12  1.0      nova0   Created
-------------------------------------------------------------------------------

library std, ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use std.env.all;

-------------------------------------------------------------------------------

entity act_tb is

end entity act_tb;

-------------------------------------------------------------------------------

architecture bhv of act_tb is

  -- component ports
  signal LADD    : unsigned(2 downto 0);
  signal LAD     : unsigned(7 downto 0);
  signal nWR     : std_logic := '1';
  signal CLK_10M : std_logic;
  signal RST     : std_logic := '1';
  signal Signal1 : std_logic;
  signal Signal2 : std_logic;
  signal Trigger : std_logic;
  signal CLK_OUT : std_logic;


begin  -- architecture bhv

  -- component instantiation
  DUT : entity work.act
    port map (
      LADD    => std_logic_vector(LADD),
      LAD     => std_logic_vector(LAD),
      nWR     => nWR,
      CLK_10M => CLK_10M,
      RST     => RST,
      Signal1 => Signal1,
      Signal2 => Signal2,
      Trigger => Trigger,
      CLK_OUT => CLK_OUT);

  -- clock generation
  tb_clk : process
  begin
    --CLK_10M <= not CLK_10M after 10 ns;
    CLK_10M <= '0'; wait for 10 ns;
    CLK_10M <= '1'; wait for 10 ns;

  end process;


  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here

    wait until CLK_10M = '1';
    RST <= '0';
    wait until CLK_10M = '1';
    wait until CLK_10M = '1';

    LADD <= "000";
    LAD  <= x"f4";
    nWR  <= '0';
    wait until CLK_10M = '1';
    nWR  <= '1';
    wait until CLK_10M = '1';

    LADD <= "001";
    LAD  <= x"01";
    nWR  <= '0';
    wait until CLK_10M = '1';
    nWR  <= '1';
    wait until CLK_10M = '1';

    LADD <= "010";
    LAD  <= x"E8";
    nWR  <= '0';
    wait until CLK_10M = '1';
    nWR  <= '1';
    wait until CLK_10M = '1';

    LADD <= "011";
    LAD  <= x"03";
    nWR  <= '0';
    wait until CLK_10M = '1';
    nWR  <= '1';
    wait until CLK_10M = '1';

    LADD <= "100";
    LAD  <= x"01";
    nWR  <= '0';
    wait until CLK_10M = '1';
    nWR  <= '1';
    wait until CLK_10M = '1';

    LADD <= "101";
    LAD  <= x"00";
    nWR  <= '0';
    wait until CLK_10M = '1';
    nWR  <= '1';
    wait until CLK_10M = '1';

    wait until CLK_10M = '1';
    RST <= '1';
    wait until CLK_10M = '1';
    RST <= '0';
    wait until CLK_10M = '1';

    --  wait;
    --  wait for 800 ns;
    --   wait for 800 ns;
    --  wait for 800 ns;
    stop(1);
  end process WaveGen_Proc;

  process(CLK_10M)
    variable my_line : line;
  begin
    if rising_edge(CLK_10M) then
      write(my_line, string'("@"));
      write(my_line, now);
      write(my_line, string'(" Trigger:"));
      write(my_line, Trigger);
      writeline(output, my_line);
    end if;
  end process;




end architecture bhv;

-------------------------------------------------------------------------------

configuration act_tb_bhv_cfg of act_tb is
  for bhv
  end for;
end act_tb_bhv_cfg;

-------------------------------------------------------------------------------
