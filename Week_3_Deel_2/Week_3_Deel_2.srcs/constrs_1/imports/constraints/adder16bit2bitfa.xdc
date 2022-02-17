# external clock
create_clock -name sysclk -period 5 -waveform {0 2.5} [get_ports CLK]

# clock jitter
set_clock_uncertainty 0.15 [get_clocks sysclk]
