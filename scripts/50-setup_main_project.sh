#!/bin/bash

BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
. ${BIN_DIR}/init_vars.sh

echo "Building with Emscripten..."
echo "================================================================================="
echo "DIST_DIR                          : $DIST_DIR"
echo "EMSDK_DIR                         : $EMSDK_DIR"
echo "EMSDK_TOOLCHAIN_FILE              : $EMSDK_TOOLCHAIN_FILE"
echo "OCCT_INSTALL_DIR                  : $DEPS_INSTALL_DIR"
echo "================================================================================="


# rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
echo "Creating build directory '$BUILD_DIR'."

# Change to the build directory
pushd "$BUILD_DIR"

# Run CMake
echo "Running CMake..."
cmake \
  -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${EMSDK_TOOLCHAIN_FILE} \
  -DOCCT_INSTALL_DIR:PATH=${DEPS_INSTALL_DIR} \
  -DDIST_DIR:PATH=${DIST_DIR} \
  ..


popd
# Build the project
# echo "Building the project..."
# cmake --build . --target install -j ${COMPILE_CORES}


