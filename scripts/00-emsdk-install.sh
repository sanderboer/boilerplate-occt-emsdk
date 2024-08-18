#!/bin/bash
BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
. ${BIN_DIR}/init_vars.sh

mkdir -p ${DEPS_INSTALL_DIR}/

pushd ${DEPS_INSTALL_DIR}/
git clone https://github.com/emscripten-core/emsdk.git ${EMSDK_DIR}
popd

pushd ${EMSDK_DIR}
# ./emsdk install latest
./emsdk install ${EMSDK_VERSION}
popd
# pushd ${BIN_DIR}
# emcc -sUSE_FREETYPE=1 test.c
# popd
