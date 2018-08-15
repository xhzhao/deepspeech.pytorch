#!/bin/sh

/opt/intel/vtune_amplifier_2018/bin64/amplxe-cl -collect hpc-performance -knob analyze-openmp=true  ./run.sh
