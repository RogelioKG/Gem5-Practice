# %1: associativity
# %2: test binary

case $1 in
  two-way)
    ASSOC=2
    ;;
  full-way)
    ASSOC=1
    ;;
  *)
    exit 1
    ;;
esac

PROJECT_DIR="${HOME}/Gem5-Practice/project"
WORKING_DIR="${PROJECT_DIR}/result/Q3/$1/$2"

OPTIONS="\
 --cmd ${PROJECT_DIR}/benchmark/$2.out\
 --cpu-type=TimingSimpleCPU\
 --caches --l2cache --l3cache\
 --l1i_size=8kB --l1d_size=8kB --l2_size=32kB --l3_size=256kB\
 --l3_assoc=${ASSOC}\
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