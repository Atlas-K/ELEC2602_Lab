transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_6/vhdl/next_state.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_6/vhdl/seq_detect.vhd}

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_6/vhdl/testbench_lab6p1.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_6/vhdl/next_state.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_6/vhdl/seq_detect.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  testbench_lab6p1

add wave *
view structure
view signals
run 200 ms
