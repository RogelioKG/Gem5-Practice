PROJECT_DIR="${HOME}/Gem5-Practice/project"
WORKING_DIR="${PROJECT_DIR}/result/Q2/enable_l3"

OPTIONS="\
 --cmd ${PROJECT_DIR}/gem5/tests/test-progs/hello/bin/x86/linux/hello\
 --cpu-type=TimingSimpleCPU\
 --caches --l2cache --l3cache\
 --l1i_size=32kB --l1d_size=32kB --l2_size=128kB --l3_size=1MB\
 --mem-type=NVMainMemory\
 --nvmain-config=${PROJECT_DIR}/NVmain/Config/PCM_ISSCC_2012_4GB.config\
 --output=${WORKING_DIR}/std_output.txt\
"

# m5out will be generated in working dir
pushd ${WORKING_DIR}

# command
${PROJECT_DIR}/gem5/build/X86/gem5.opt ${PROJECT_DIR}/gem5/configs/example/se.py ${OPTIONS} > ${WORKING_DIR}/cmd_output.txt

# back to original dir
popd