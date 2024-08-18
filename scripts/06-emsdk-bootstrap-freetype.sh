#!/bin/bash
BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
. ${BIN_DIR}/05-emsdk-activate.sh

emcc -sUSE_FREETYPE=1 -sUSE_ZLIB=1 ${BIN_DIR}/test.c -o /tmp/test.js



