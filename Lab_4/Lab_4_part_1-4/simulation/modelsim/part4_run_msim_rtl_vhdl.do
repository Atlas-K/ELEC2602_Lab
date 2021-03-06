transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-4/vhdl/my_latch.vhd}

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-4/vhdl/testbench_part4.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-4/vhdl/DFF_neg.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-4/vhdl/DFF_pos.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-4/vhdl/my_latch.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  testbench_part4

add wave *
view structure
view signals
run 2000 ns
