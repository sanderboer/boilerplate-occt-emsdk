#!/bin/bash
BIN_DIR="$( cd -P "$( dirname "$0" )"&& pwd )"
. ${BIN_DIR}/init_vars.sh

${BIN_DIR}/00-emsdk-install.sh
${BIN_DIR}/05-emsdk-activate.sh    
${BIN_DIR}/06-emsdk-bootstrap-freetype.sh
${BIN_DIR}/20-get_occt.sh
${BIN_DIR}/25-compile_install_occt.sh
${BIN_DIR}/50-setup_main_project.sh
