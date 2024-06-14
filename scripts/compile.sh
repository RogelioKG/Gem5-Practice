# 在 GEM5 目錄下混合 NVMAIN 編譯 GEM5
PROJECT_DIR="${HOME}/Gem5-Practice/project"
pushd ${PROJECT_DIR}/gem5/
scons EXTRAS=../NVmain build/X86/gem5.opt
popd
