#!/bin/bash
# This is the build script for the project. It should be run from the root of the repository
# (./build.sh)
# It will build the project in the build directory, after it has been set up.

TOTAL_CORES=$(nproc)
COMPILE_CORES=$((TOTAL_CORES - 1))

pushd build

cmake --build . --target install -j ${COMPILE_CORES} 

popd
