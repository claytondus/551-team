#!/bin/sh -f
xv_path="/home/cd/Xilinx/Vivado/2014.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 0592baa871654fc9a806dd2d46bbd028 -m64 --debug off --relax -L xil_defaultlib -L secureip --snapshot Lab1Sim_behav xil_defaultlib.Lab1Sim -log elaborate.log
