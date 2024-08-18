#!/bin/sh

BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
SRC_DIR="$( cd -P "$( dirname "$0" )"&& cd ../src && pwd )"
ROOT_DIR="$( cd -P "$( dirname "$0" )"&& cd .. && pwd )"
DIST_DIR=${ROOT_DIR}/dist
BUILD_DIR=${ROOT_DIR}/build
DEPS_SRC_DIR=${ROOT_DIR}/deps_src
BUILD_DEPS_DIR=${ROOT_DIR}/build_deps
DEPS_INSTALL_DIR=${ROOT_DIR}/deps
OCCT_SRC_DIR=${BUILD_DEPS_DIR}/occt_src
OCCT_BUILD_DIR=${BUILD_DEPS_DIR}/occt_build
FREETYPE_SRC_DIR=${BUILD_DEPS_DIR}/freetype_src
FREETYPE_BUILD_DIR=${BUILD_DEPS_DIR}/freetype_build
TOTAL_CORES=$(nproc)
COMPILE_CORES=$((TOTAL_CORES - 1))
EMSDK_VERSION=3.1.64

EMSDK_DIR=${DEPS_INSTALL_DIR}/emsdk
EMSDK_TOOLCHAIN_FILE=${EMSDK_DIR}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake

echo "================================================================================="
echo "❤ Path Variables"
echo "================================================================================="
echo "ROOT_DIR                          : $ROOT_DIR"
echo "SRC_DIR                           : $SRC_DIR"
echo "BIN_DIR                           : $BIN_DIR"
echo "OCCT_SRC_DIR                      : $OCCT_SRC_DIR"
echo "DEPS_INSTALL_DIR                  : $DEPS_INSTALL_DIR"
echo "BUILD_DEPS_DIR                    : $BUILD_DEPS_DIR"
echo "EMSDK_DIR                         : $EMSDK_DIR"
echo "EMSDK_TOOLCHAIN_FILE              : $EMSDK_TOOLCHAIN_FILE"
echo "COMPILE_CORES                     : $COMPILE_CORES"
echo "================================================================================="
# echo "❤ Load Environment Variables"
# echo "================================================================================="
# echo "================================================================================="

