#!/bin/bash

# Get base directory
BASE_DIR=$(dirname $0)
cd $BASE_DIR

# Set build type
BUILD_TYPE=Debug

# Delete sdk folder
rm -rf sdk

# # Update all submodules
# git submodule sync --recursive
# git submodule update --init --recursive --remote

# Build RRS sdk
cd RRS
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DCMAKE_INSTALL_PREFIX=../.. \
      -Dvsg_DIR=~/Install/lib/cmake/vsg \
      -DvsgXchange_DIR=~/Install/lib/cmake/vsgXchange \
      -DvsgImGui_DIR=~/Install/lib/cmake/vsgImGui \
      -Dktx_DIR=~/Install/lib/cmake/ktx \
      -DKTX_DIR=~/Install/lib/cmake/ktx \
      ..
cmake --build . -j16
cmake --install .
cd ../..

# Save RRS sdk path
SDK_PATH=$PWD/sdk
echo SDK_PATH: $SDK_PATH

# Build all dlcs
# ./build_dlc.sh chs2t $BUILD_TYPE
# ./build_dlc.sh cisterns_pack $BUILD_TYPE
# ./build_dlc.sh ep1m $BUILD_TYPE
# ./build_dlc.sh ra3 $BUILD_TYPE
# ./build_dlc.sh tep70 $BUILD_TYPE
