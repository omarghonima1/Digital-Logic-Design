library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SmartPackagingSystem is
    port (
        clk        : in  std_logic;                  -- Clock input      
        reset_n    : in  std_logic;                  -- Active-low reset
        proxSensor : in  std_logic;                  -- Proximity sensor input
        seg        : out std_logic_vector(6 downto 0); -- 7-segment display output
        A1         : out std_logic;                  -- H-bridge input A1
        A2         : out std_logic;
			humansens : in std_logic ;
			alert :out std_logic 
    );
end SmartPackagingSystem;

architecture Behavioral of SmartPackagingSystem is
    signal counter      : integer range 0 to 5 := 0;  -- Counter value
    signal seg_data     : std_logic_vector(6 downto 0);
    signal clk_divider  : integer := 0;               -- Clock divider counter
    signal tick_500ms   : std_logic := '0';           -- 0.5-second tick signal
    constant CLOCK_FREQ : integer := 50000000;        -- DE10-Lite clock frequency (50 MHz)
    constant TICK_LIMIT : integer := CLOCK_FREQ / 2;  -- 0.5-second interval (50M / 2)
    signal motor_active : std_logic := '0';         
		
begin

    -- Process to generate 0.5-second tick
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            clk_divider <= 0;
            tick_500ms <= '0';
        elsif rising_edge(clk) then
            if clk_divider = TICK_LIMIT - 1 then
                clk_divider <= 0;
                tick_500ms <= '1'; -- Generate a tick
            else
                clk_divider <= clk_divider + 1;
                tick_500ms <= '0';
            end if;
        end if;
    end process;

    -- Process to handle proximity sensor, counter updates, and motor control
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            -- Reset the counter, motor, and 7-segment display
            counter <= 0;
            seg_data <= "1000000"; -- Display 0
            motor_active <= '1'; -- Start the motor
				alert<='0';
				
				
        elsif rising_edge(clk) then
            if tick_500ms = '1' then -- Only update every 0.5 seconds
                if proxSensor = '0' then -- Assuming logic '1' indicates object detection
                    if counter < 5 then
                        counter <= counter + 1; -- Increment counter
                    else
                        counter <= 0; -- Reset counter after reaching 5
                    end if;
                end if;

                -- Motor control logic
                if counter = 5 then
                    motor_active <= '0';
						  if humansens = '1' then   
						  alert <= '1';  -- Set alert if human is detected
							elsif humansens = '0' then
							alert <= '0';  -- Clear alert if no human is detected
							end if;
						  -- Start the motor
                else
                    motor_active <= '1';
						  alert<='0';
						  -- Stop the motor
					end if;
					
	 


                -- Update the 7-segment display based on the counter value
                case counter is
                    when 0 => seg_data <= "1000000"; -- Display 0
                    when 1 => seg_data <= "1111001"; -- Display 1
                    when 2 => seg_data <= "0100100"; -- Display 2
                    when 3 => seg_data <= "0110000"; -- Display 3
                    when 4 => seg_data <= "0011001"; -- Display 4
                    when 5 => seg_data <= "0010010"; -- Display 5
                    when others => seg_data <= "1000000"; -- Blank
                end case;
            end if;
        end if;
    end process;
	
    -- Assign motor control signals for H-bridge
    A1 <= not motor_active;      -- High when the motor is active
    A2 <= motor_active;  -- Low when the motor is active

    -- Assign the 7-segment data to the output
    seg <= seg_data;

end Behavioral;
