library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity act is
  port (
    LADD : in std_logic_vector(2 downto 0);
    LAD  : in std_logic_vector(7 downto 0);

    nWR : in std_logic;

    CLK_10M : in std_logic;

    RST : in std_logic;

    Signal1 : out std_logic;
    Signal2 : out std_logic;

    Trigger : out std_logic;

    CLK_OUT : out std_logic
    );
end act;

architecture RTL of act is

  --Delay Time Variable
  --CPU Down
--      SIGNAL q1_delay  : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000001100100" ;

  signal reg_duty_count    : std_logic_vector(15 downto 0) := "0000000000001000";
  signal reg_pwm_period    : std_logic_vector(15 downto 0) := "0000000000001000";
  signal reg_pwm_out_delay : std_logic_vector(15 downto 0) := "0000000000001000";
  signal t_pwm_out_delay   : integer range 0 to 255        := 0;

  signal shift_delay : std_logic_vector(19 downto 0) := "00000000000000000000";

  signal CLK_10K : std_logic;
  signal CLK_1K  : std_logic;

  signal t_signal       : std_logic;
  signal t_shift_signal : std_logic;

  --Delay Setting
  signal t_duty_cnt     : integer range 0 to 4095 := 250;
  signal t_period_cnt   : integer range 0 to 4095 := 125;
  signal tpwm_out_delay : integer range 0 to 255;

  signal t1_cnt : integer range 0 to 65535 := 0;
  signal t2_cnt : integer range 0 to 65535 := 0;
  signal t3_cnt : integer range 0 to 65535 := 0;

begin
  --Initialize Data & File
--              SCR_G2  <= '0';
  --End of Initialization.
--make 10k clk
  process(CLK_10M, RST)
  begin
    if(RST = '1') then
      t2_cnt  <= 0;                     --(others => '0');
      CLK_10K <= '0';
    elsif (rising_edge(CLK_10M)) then

      if(t2_cnt = 499) then
        t2_cnt  <= 0;
        CLK_10K <= not CLK_10K;
      else
        t2_cnt <= t2_cnt+1;
      end if;

    end if;
  end process;

--make 1k clk
  process(CLK_10K, RST)
  begin
    if(RST = '1') then
      t3_cnt <= 0;
      CLK_1K <= '0';
    elsif (rising_edge(CLK_10K)) then

      if(t3_cnt = 499) then
        t3_cnt <= 0;
        CLK_1K <= not CLK_1K;
      else
        t3_cnt <= t3_cnt+1;
      end if;

    end if;

  end process;


-- Make duty ratio to SIG_CLK Signal.
  process(CLK_10K, RST)
  begin
    if(RST = '1') then
      t1_cnt       <= 0;
      t_signal     <= '0';
      t_duty_cnt   <= CONV_INTEGER(reg_duty_count);  --CLK time / Frequency
      t_period_cnt <= CONV_INTEGER(reg_pwm_period);  --CLK Duration

    elsif (rising_edge(CLK_10K)) then

      if(t1_cnt < t_period_cnt) then

        t1_cnt <= t1_cnt+1;

        if(t1_cnt < t_duty_cnt) then
          t_signal <= '1';
        else
          t_signal <= '0';
        end if;

      else
        t1_cnt   <= 0;
        t_signal <= '0';

      end if;
    end if;
  end process;

-- delay SIG_CLK Signal to trig_sig : 1 ~ 20ms
  process(CLK_1K, RST)
  begin
    if(RST = '1') then
      t_pwm_out_delay <= CONV_INTEGER(reg_pwm_out_delay);  --CLK Duration
    elsif (rising_edge(CLK_1K)) then

      if(t_signal = '1') then
        shift_delay <= shift_delay(18 downto 0) & '1';
      else
        shift_delay <= shift_delay(18 downto 0) & '0';
      end if;


      t_shift_signal <= t_signal when(tpwm_out_delay = 0) else
                        shift_delay(0)  when(tpwm_out_delay = 1) else
                        shift_delay(1)  when(tpwm_out_delay = 2) else
                        shift_delay(2)  when(tpwm_out_delay = 3) else
                        shift_delay(3)  when(tpwm_out_delay = 4) else
                        shift_delay(4)  when(tpwm_out_delay = 5) else
                        shift_delay(5)  when(tpwm_out_delay = 6) else
                        shift_delay(6)  when(tpwm_out_delay = 7) else
                        shift_delay(7)  when(tpwm_out_delay = 8) else
                        shift_delay(8)  when(tpwm_out_delay = 9) else
                        shift_delay(9)  when(tpwm_out_delay = 10) else
                        shift_delay(10) when(tpwm_out_delay = 11) else
                        shift_delay(11) when(tpwm_out_delay = 12) else
                        shift_delay(12) when(tpwm_out_delay = 13) else
                        shift_delay(13) when(tpwm_out_delay = 14) else
                        shift_delay(14) when(tpwm_out_delay = 15) else
                        shift_delay(15) when(tpwm_out_delay = 16) else
                        shift_delay(16) when(tpwm_out_delay = 17) else
                        shift_delay(17) when(tpwm_out_delay = 18) else
                        shift_delay(18) when(tpwm_out_delay = 19) else
                        t_signal;

    end if;

  end process;


  Signal1 <= t_signal;
  Signal2 <= not t_signal;

  Trigger <= t_shift_signal;

  CLK_OUT <= CLK_10K;


  DATA_WRITE : process(nWR, LADD)
  begin
    if(rising_edge(nWR)) then
      if LADD = "000" then
        -- Set delay Low byte.
        reg_duty_count (7 downto 0) <= LAD;
      --new_flag <= '1';
      elsif LADD = "001" then
        -- Set delay High byte.
        reg_duty_count (15 downto 8) <= LAD;
        --new_flag <= '1';

      elsif LADD = "010" then
        -- Set delay Low byte.
        reg_pwm_period (7 downto 0) <= LAD;
      --new_flag <= '1';
      elsif LADD = "011" then
        -- Set delay High byte.
        reg_pwm_period (15 downto 8) <= LAD;

      elsif LADD = "100" then
        -- Set delay High byte.
        reg_pwm_out_delay (7 downto 0) <= LAD;
      --new_flag <= '1';
      elsif LADD = "101" then
        -- Set delay High byte.
        reg_pwm_out_delay (11 downto 8) <= LAD(3 downto 0);

      end if;
    end if;

  end process DATA_WRITE;

end RTL;
