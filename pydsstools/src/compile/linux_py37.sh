source ~/temp/venv37/bin/activate
export PY_NPY_INCL=$HOME/temp/venv37/lib/python3.7/site-packages/numpy/core/include/
export PY_INCL=$HOME/temp/venv37/include/python3.7m/
export DSS7_INCL=../../../../../../../vs_2017/c_proj/headers/
export DSS7_LIB=../../../../../../../vs_2017/c_proj/linux64/
#if [  -n "$(uname -a | grep Ubuntu)" ]; then
#	export DEST_FOLDER=./linux64/ubuntu/py37
#	echo "Ubuntu"
#elif [  -n "$(uname -a | grep Mint)" ]; then
#	export DEST_FOLDER=./linux64/mint/py37
#	echo "Mint"
#else
#	echo "unsupported platform"
#fi
export DEST_FOLDER=../../_lib/x64/py37
export ext_name=core_heclib
mkdir -p "$DEST_FOLDER"
export ext_c_file=$DEST_FOLDER/$ext_name.c
export ext_module=$DEST_FOLDER/$ext_name.so

cython -3 ../core_heclib.pyx -o $ext_c_file

gcc -Wall -Wl,--unresolved-symbols=report-all,--warn-unresolved-symbols,--warn-once -shared -fPIC $ext_c_file -I"$DSS7_INCL" -I"$PY_INCL" -I"$PY_NPY_INCL" -L "$DSS7_LIB" -lheclib -lgfortran -lm -lquadmath -lz -o "$ext_module"

