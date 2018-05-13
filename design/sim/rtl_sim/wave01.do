onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /act_tb/LADD
add wave -noupdate /act_tb/LAD
add wave -noupdate /act_tb/nWR
add wave -noupdate /act_tb/CLK_10M
add wave -noupdate /act_tb/RST
add wave -noupdate /act_tb/Signal1
add wave -noupdate /act_tb/Signal2
add wave -noupdate /act_tb/Trigger
add wave -noupdate /act_tb/CLK_OUT
add wave -noupdate /act_tb/Clk
add wave -noupdate /act_tb/DUT/CLK
add wave -noupdate /act_tb/DUT/LADD
add wave -noupdate /act_tb/DUT/LAD
add wave -noupdate -color Coral /act_tb/DUT/nWR
add wave -noupdate /act_tb/DUT/CLK_10M
add wave -noupdate /act_tb/DUT/RST
add wave -noupdate /act_tb/DUT/Signal1
add wave -noupdate /act_tb/DUT/Signal2
add wave -noupdate /act_tb/DUT/Trigger
add wave -noupdate /act_tb/DUT/CLK_OUT
add wave -noupdate -color Orchid /act_tb/DUT/reg_duty_count
add wave -noupdate -color Violet /act_tb/DUT/reg_pwm_period
add wave -noupdate -color Pink /act_tb/DUT/reg_pwm_out_delay
add wave -noupdate /act_tb/DUT/t_pwm_out_delay
add wave -noupdate /act_tb/DUT/shift_delay
add wave -noupdate /act_tb/DUT/CLK_10K
add wave -noupdate /act_tb/DUT/CLK_1K
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {653251 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 168
configure wave -valuecolwidth 54
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2898 ns}
