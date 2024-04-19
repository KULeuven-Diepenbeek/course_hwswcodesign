################################################################################
# Emerging technologies, Systems & Security
#
#   date: April 19th 2024
#   author: VlJo
################################################################################
# Script to generate a Vivado project for HW/SW codesign (400)
#
################################################################################

# set parameters
set pname "hwswcodesign_400"
set srcpath "/home/jvliegen/vc/github/KULeuven-Diepenbeek/course_hwswcodesign_internal/400/hdl"
set projpath "/home/jvliegen/sandbox/course_hwswcodesign"
set part "xc7vx485tffg1761-2"
set board "xilinx.com:vc707:part0:1.3"

# delete older versions
cd $projpath
exec rm -Rf $pname

# create project
create_project $pname $projpath/$pname -part $part
set_property board_part $board [current_project]
set_property target_language VHDL [current_project]


# add VHDL source files
set fnames [glob -directory $srcpath -- "*.vhd"]
foreach fname $fnames {
    add_files $fname
}

# add verilog source files
set fnames [glob -directory $srcpath -- "*.v"]
foreach fname $fnames {
    add_files $fname
}

# add simulation source files
set fnames [glob -directory $srcpath/tb -- "*.vhd"]
foreach fname $fnames {
    add_files -fileset sim_1 $fname
}


