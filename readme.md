# OpenCascade CMake Boilerplate, Emscripten Edition

This project is a boilerplate setup for using the OpenCascade Technology (OCCT) library in a CMake-based project. It demonstrates how to fetch, build, and link against the OpenCascade library using modern CMake practices.
## Usage
Step 1: Clone and install all dependencies:
```
git clone git@github.com:sanderboer/boilerplate-occt-emsdk.git
cd boilerplate-occt-emsdk
./scripts/setup_project.sh
```

If all goes well, the deps dir should have the subdirectories 'emsdk', where the local emscripten install lives, 'lib' and 'include', where all dependencies built with emscripten live.
You should now be able to build and run the project:
```
./build.sh
```

When the build is complete, you can run the project with:
```
cd dist
python -m http.server
```
This starts a local http server on port 8000.
Open  a browser to http://localhost:8000/occt-webgl-sample.html in your browser to see the project in action:

[[./scripts/screenshot.png]]
## Features

- **bootstrap Emscripten with freetype**: Downloads and activates Emscripten to bootstrap Emscripten with freetype support.
- **Bash scripts**: Uses a number of seperate bash scripts to download and install emsdk and download and build OpenCascade using Emscripten. 

The scripts are split by the different stages of the build process, these are used to set up a build environment for the main project. Its dependencies are installed in the 'deps' folder.
## Prerequisites

- **Python** (version 3.10 or higher), necessary for Emscripten's freetype port initialization
- **CMake** (version 3.10 or higher)
- **Git** (to clone the OpenCascade repository)

## Magic

The file scripts/06-emsdk-bootstap-freetype.sh is a bit of a hack to use Emscripten's freetype port.
After this step is complete, Cmake with emscripten's toolchain file will find emscriptens port of freetype automagically.
This feels lik a hack, because it is and it is very probable that it will break with a new version of emscripten.
In the very least emscriptens port system and the location of its toolchain file are prone to change. Therefor the emsdk version is set to mid 2024's latest, i.e. version 3.1.64 .

## Project Structure

```plaintext
OpenCascadeProject/
├── CMakeLists.txt          # Main CMake build script
├── src/
│   └── main.cpp            # Example source file using OpenCascade
├─── deps/                  # Project dependencies directory (generated during the setup process)
├──── build/                 # Build directory (generated during the build process)
└──── dist/                 # Output directory (generated during the build and install process)

## Alternative Setup
Once emsdk has been bootstrapped with freetype support, OpenCascade can also be initialized using the ExternalProject_Add mechanism.
A number of different setups have been tried (and failed), embarassing proof has been left in the archive folder for future reference.
It turns out that bootstrapping emsk with freetype is not really something cmake can accommodate and my efforts where also marred by a local python version that could not accommodate emscripten's port system.
As awesome as cmake is, it it also quite byzantine and bootstrapping external dependencies are not always possible. That is why for now I switched to a script based setup.
