PROJECT_DIR="${HOME}/Gem5-Practice/project"
OPTIONS="\
 --cmd ${PROJECT_DIR}/benchmark/multiply.out\
 --cpu-type=TimingSimpleCPU\
 --caches --l2cache\
 --l1i_size=32kB --l1d_size=32kB --l2_size=128kB\
 --mem-type=NVMainMemory\
 --nvmain-config=${PROJECT_DIR}/NVmain/Config/PCM_ISSCC_2012_4GB.config\
"

# m5out will be generated in working dir
pushd ${PROJECT_DIR}/gem5

# command
${PROJECT_DIR}/gem5/build/X86/gem5.opt ${PROJECT_DIR}/gem5/configs/example/se.py ${OPTIONS}

# back to original dir
popd