#!/bin/bash

# Get base directory
BASE_DIR=$(dirname $0)
cd $BASE_DIR

# Delete sdk folder
rm -rf sdk

# Update all submodules
git submodule sync --recursive
git submodule update --init --recursive --remote

# Build RRS sdk
cd RRS
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
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

# Function for building dlc
function build_dlc {
      DLC_NAME=$1
      cd $DLC_NAME
      echo $PWD
      mkdir -p build
      mkdir -p install
      cd build
      cmake -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=../install \
            -DCfgReader_DIR=$SDK_PATH/lib/cmake/CfgReader \
            -Ddevice_DIR=$SDK_PATH/lib/cmake/device \
            -Ddisplay_DIR=$SDK_PATH/lib/cmake/display \
            -Dfilesystem_DIR=$SDK_PATH/lib/cmake/filesystem \
            -DJournal_DIR=$SDK_PATH/lib/cmake/Journal \
            -Dphysics_DIR=$SDK_PATH/lib/cmake/physics \
            -Dsolver_DIR=$SDK_PATH/lib/cmake/solver \
            -Dvehicle_DIR=$SDK_PATH/lib/cmake/vehicle \
            ..
      cmake --build . -j16
      cmake --install .
      cd ../..
}

# Build all dlcs
build_dlc chs2t
build_dlc cisterns_pack
build_dlc ep1m
build_dlc ra3
build_dlc tep70
