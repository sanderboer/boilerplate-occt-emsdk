cmake_minimum_required(VERSION 3.2)

project(occt-webgl-sample)

set(APP_VERSION_MAJOR 1)
set(APP_VERSION_MINOR 0)
set(APP_TARGET occt-webgl-sample)

# set(CMAKE_TOOLCHAIN_FILE "/home/sander/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake")
# set(CMAKE_TOOLCHAIN_FILE ${CMAKE_TOOLCHAIN_FILE})
# set(CMAKE_TOOLCHAIN_FILE ${EMSDK_TOOLCHAIN_FILE})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_FREETYPE=1")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -s USE_FREETYPE=1")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s USE_FREETYPE=1")

set(CMAKE_INSTALL_PREFIX "${DIST_DIR}")
# # Set OpenCASCADE_DIR before any calls to find_package

# Open CASCADE Technology

set(OpenCASCADE_DIR "${OCCT_INSTALL_DIR}/lib/cmake/opencascade" CACHE PATH "Custom OpenCASCADE directory" FORCE)
# unset(OpenCASCADE_DIR CACHE)
# set(OpenCASCADE_DIR "/opt/emsdk-occt/lib/cmake/opencascade" CACHE PATH "Custom OpenCASCADE directory" FORCE)
# Set OpenCASCADE_DIR with FORCE to ensure it overrides any system settings

find_package(OpenCASCADE REQUIRED NO_DEFAULT_PATH)
if(OpenCASCADE_FOUND)
  message (STATUS "Using OpenCASCADE from \"${OpenCASCADE_DIR}\"" )
  INCLUDE_DIRECTORIES(${OpenCASCADE_INCLUDE_DIR})
  LINK_DIRECTORIES(${OpenCASCADE_LIBRARY_DIR})
else()
  message(WARNING "Could not find OpenCASCADE, please set OpenCASCADE_DIR variable." )
  set(OCCT_LIBRARY_DIR)
  set(OCCT_BIN_DIR)
endif()

set(OpenCASCADE_LIBS TKRWMesh TKDEGLTF TKDEOBJ TKDEPLY TKBinXCAF TKBin TKBinL TKOpenGles TKXCAF TKVCAF TKCAF TKV3d TKHLR TKMesh TKService TKShHealing TKPrim TKTopAlgo TKGeomAlgo TKBRep TKGeomBase TKG3d TKG2d TKMath TKLCAF TKCDF TKernel)


# option to enable or disable use of precompiled headers
if (NOT DEFINED SOURCE_MAP_BASE)
  set (SOURCE_MAP_BASE "" CACHE STRING "Path to source map server for debugging C++ code; e.g. http://localhost:9090/")
endif()

# customize build
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind")
if (NOT "${SOURCE_MAP_BASE}" STREQUAL "")
  set(CMAKE_CXX_FLAGS_DEBUG "-g4 --source-map-base ${SOURCE_MAP_BASE}")
endif()

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s WASM=1")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s MAX_WEBGL_VERSION=2")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s MODULARIZE=1")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s EXPORT_NAME='createOccViewerModule'")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s ALLOW_MEMORY_GROWTH=1")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --extern-post-js ${CMAKE_CURRENT_SOURCE_DIR}/src/occt-webgl-viewer.js")

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR})
file(GLOB SOURCES src/*.h src/*.cpp)
source_group ("Headers" FILES
  WasmOcctView.h)
source_group ("Sources" FILES
  WasmOcctView.cpp
  main.cpp)

add_executable(${APP_TARGET} ${SOURCES})
target_link_libraries(
  ${APP_TARGET}
  ${OpenCASCADE_LIBS}
  freetype
)

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}" LIBRARY DESTINATION "${CMAKE_INSTALL_PREFIX}")
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.wasm DESTINATION ${CMAKE_INSTALL_PREFIX})
if (NOT "${SOURCE_MAP_BASE}" STREQUAL "")
  if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.wasm.map DESTINATION ${CMAKE_INSTALL_PREFIX})
  endif()
endif()
install(FILES src/occt-webgl-sample.html DESTINATION ${CMAKE_INSTALL_PREFIX})
install(FILES src/samples/Ball.brep DESTINATION ${CMAKE_INSTALL_PREFIX}/samples)
install(FILES ${OpenCASCADE_RESOURCE_DIR}/DrawResources/OCC_logo.png  DESTINATION ${CMAKE_INSTALL_PREFIX})
install(FILES ${OpenCASCADE_RESOURCE_DIR}/DrawResources/lamp.ico      DESTINATION ${CMAKE_INSTALL_PREFIX})
if (CMAKE_CXX_FLAGS MATCHES "-pthread")
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.worker.js DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()
