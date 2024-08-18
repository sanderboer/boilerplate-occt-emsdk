#!/bin/bash
BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
. ${BIN_DIR}/init_vars.sh
    
export OCCT_GIT=https://github.com/Open-Cascade-SAS/OCCT.git
export OCCT_TAG=V7_8_1

mkdir -p ${OCCT_SRC_DIR}/
git clone --depth=1 --branch=${OCCT_TAG} ${OCCT_GIT} ${OCCT_SRC_DIR}

