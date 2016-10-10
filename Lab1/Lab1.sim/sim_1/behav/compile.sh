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
echo "xvhdl -m64 -prj Lab1Sim_vhdl.prj"
ExecStep $xv_path/bin/xvhdl -m64 -prj Lab1Sim_vhdl.prj 2>&1 | tee compile.log
