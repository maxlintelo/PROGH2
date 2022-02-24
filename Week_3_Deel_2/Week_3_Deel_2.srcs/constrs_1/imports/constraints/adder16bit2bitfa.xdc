# external clock
create_clock -period 5.000 -name sysclk -waveform {0.000 2.500} [get_ports CLK]

# clock jitter
set_clock_uncertainty 0.150 [get_clocks sysclk]

#set_output_delay -clock [get_clocks sysclk] -min -add_delay 0.000 [get_ports {S[*]}]
#set_output_delay -clock [get_clocks sysclk] -max -add_delay 4.000 [get_ports {S[*]}]
#set_output_delay -clock [get_clocks sysclk] -min -add_delay 0.000 [get_ports CO]
#set_output_delay -clock [get_clocks sysclk] -max -add_delay 4.000 [get_ports CO]
