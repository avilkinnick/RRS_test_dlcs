#!/bin/bash

# Get base directory
BASE_DIR=$(dirname $0)
cd $BASE_DIR

# Set RRS SDK path
SDK_PATH=$PWD/sdk
echo "SDK_PATH: $SDK_PATH"

# Get DLC name and build type from command-line arguments
DLC_NAME=$1
BUILD_TYPE=$2

# Build DLC
echo "Start building $DLC_NAME"
cd $DLC_NAME
mkdir -p build-$BUILD_TYPE
mkdir -p install
cd build-$BUILD_TYPE

# Delete all CMake files from build directory (to delete cache)
find . -type f,d -iname "*cmake*" -exec rm -rf {} +

cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DCMAKE_INSTALL_PREFIX=../install \
      -DCfgReader_DIR=$SDK_PATH/lib/cmake/CfgReader \
      -Ddevice_DIR=$SDK_PATH/lib/cmake/device \
      -Ddisplay_DIR=$SDK_PATH/lib/cmake/display \
      -Dfilesystem_DIR=$SDK_PATH/lib/cmake/filesystem \
      -DJournal_DIR=$SDK_PATH/lib/cmake/Journal \
      -Dphysics_DIR=$SDK_PATH/lib/cmake/physics \
      -Dsolver_DIR=$SDK_PATH/lib/cmake/solver \
      -Dvehicle_DIR=$SDK_PATH/lib/cmake/vehicle \
      -Dcore_DIR=$SDK_PATH/lib/cmake/core \
      ..
cmake --build . -j16
echo "Finish building $DLC_NAME"
