#!/bin/bash

# install dependency
sudo apt install gfortran

# pull repo with 3party
git clone --recursive https://github.com/apache/incubator-mxnet mxnet

# build with multiprocess
cd mxnet
cp config/linux_gpu.cmake config.cmake
mkdir build
cd build
cmake ..
cmake --build . --parallel $(($(nproc --all)/2))

# install with related things
python3 -m pip install --user -e ./python
python3 -m pip install --user graphviz==0.8.4 jupyter