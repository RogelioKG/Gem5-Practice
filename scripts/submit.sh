SUBMIT_DIR="${HOME}/Gem5-Practice/doc/submit"
PROJECT_DIR="${HOME}/Gem5-Practice/project"


rm -rf ${SUBMIT_DIR}
mkdir ${SUBMIT_DIR}
mkdir ${SUBMIT_DIR}/Q3
cp -r ${PROJECT_DIR}/result/Q3/full-way/quicksort ${SUBMIT_DIR}/Q3/full-way
cp -r ${PROJECT_DIR}/result/Q3/two-way/quicksort ${SUBMIT_DIR}/Q3/two-way
mkdir ${SUBMIT_DIR}/Q4
cp -r ${PROJECT_DIR}/result/Q4/lru/quicksort ${SUBMIT_DIR}/Q4/lru
cp -r ${PROJECT_DIR}/result/Q4/lfu/quicksort ${SUBMIT_DIR}/Q4/lfu
mkdir ${SUBMIT_DIR}/Q5
cp -r ${PROJECT_DIR}/result/Q5/write-back/multiply ${SUBMIT_DIR}/Q5/write-back
cp -r ${PROJECT_DIR}/result/Q5/write-through/multiply ${SUBMIT_DIR}/Q5/write-through