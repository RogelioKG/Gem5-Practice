# %1: filename
# %2: old | new

PROJECT_DIR="${HOME}/Gem5-Practice/project"
SRC_FILE="${PROJECT_DIR}/backup"
CACHES_PY_PATH="${PROJECT_DIR}/gem5/configs/common/Caches.py"
BASE_CC_PATH="${PROJECT_DIR}/gem5/src/mem/cache/base.cc"

case $1 in
  Caches.py)
    DST_FILE=${CACHES_PY_PATH}
    ;;
  base.cc)
    DST_FILE=${BASE_CC_PATH}
    ;;
  *)
    exit 1
    ;;
esac

case $2 in
  old)
    SRC_FILE="${SRC_FILE}/$1"
    ;;
  new)
    SRC_FILE="${SRC_FILE}/m_$1"
    ;;
  *)
    exit 1
    ;;
esac

cp ${SRC_FILE} ${DST_FILE}
