#
# ERA aero a.s.  
#
# Simple VPI Example - Simulation shell script
# - Compile (GCC) the source code hello.c / hello.dll
# - Compile verilog code hello.v (vcom)
# - Run Simulation in Modelsim (vsim) + code coverage option 
#
# Usage:     Help/Usage ..................... hello_mingwgcc.sh
#            Run VPI example ................ hello_mingwgcc.sh run
#            Clean directory ................ hello_mingwgcc.sh clean
#
if [ "$1" = "clean" ] ; then
	. clean.sh
fi

if [ "$1" != "run" ] ; then
    echo ""
	echo "Test script to control Modelsim simulator via VPI interface, running c code 'hello.c' from simulatio and show code coverage statistics (REPORT.txt/REPORTxml)"
    echo "### Help/Usage ....................... cygwin_mingwgcc.sh"
    echo "### Run Hello example ................ cygwin_mingwgcc.sh run"
    echo "### Clean directory .................. cygwin_mingwgcc.sh clean"
    echo ""
	exit 0
fi

# Create the library.
rm -rf work
vlib work
if [ $? -ne 0 ]; then
    echo "ERROR: Couldn't run vlib. Make sure \$PATH is set correctly."
    exit 0
fi


# Get the simulator installation directory.
a=`which vlib 2> /dev/null`
b=`/usr/bin/dirname $a`
INSTALL_HOME=`/usr/bin/dirname $b`

INSTALL_HOME_WIN_STYLE=`cygpath -w "$INSTALL_HOME"`

platform=`/usr/bin/basename $b`

CC="$INSTALL_HOME/gcc-4.5.0-mingw64vc12/bin/gcc -g -c -m64 -Wall -std=c99 -I. -I$INSTALL_HOME_WIN_STYLE/include"
LD="$INSTALL_HOME/gcc-4.5.0-mingw64vc12/bin/gcc -shared -lm -m64 $tclflags -Wl,-Bsymbolic -Wl,-export-all-symbols -o "
UCDB_LD="$INSTALL_HOME/gcc-4.5.0-mingw64vc12/bin/gcc -lm -m64 $tclflags -o "
MTIPLILIB=" -L$INSTALL_HOME_WIN_STYLE/$platform -lmtipli"

# Compile the C source(s).
echo $CC hello.c
$CC hello.c
echo $LD hello.dll hello.o $MTIPLILIB
$LD hello.dll hello.o $MTIPLILIB

# Compile the Verilog source(s).
vlog -fsmverbose -cover bsectf hello.v

# Simulate the design.
vsim -togglenovlogints -coverage -c hello -do vsim.do -pli hello.dll
exit 0
