#!/bin/bash
BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
. ${BIN_DIR}/init_vars.sh
    
export GIT=https://github.com/freetype/freetype.git

mkdir -p ${FREETYPE_SRC_DIR}/
git clone --depth=1 ${GIT} ${FREETYPE_SRC_DIR}

