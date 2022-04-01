#!/bin/bash

# install dependency
sudo apt install gfortran

# pull repo with 3party
git clone --recursive https://github.com/RebornHugo/incubator-mxnet mxnet -b v1.9.x

# build with multiprocess
cd mxnet
cp config/linux_gpu.cmake config.cmake

# build for specific GPUs
sed -i 's/MXNET_CUDA_ARCH "Auto"/MXNET_CUDA_ARCH "6.1;7.0;7.5;8.6"/' config.cmake
mkdir build
cd build
cmake ..
cmake --build . --parallel $(($(nproc --all)/2))
cd ..

# install with related things
python3 -m pip install --user -e ./python
python3 -m pip install --user graphviz==0.8.4 jupyter
