#! /usr/bin/env bash

echo "Installing tensorflow on AWS"
echo "Running installer part 1 of 2"

# Get cuDNN link
# This script requires an Nvidia Accelerated Computing Developer Program account
# Register for an account at: https://developer.nvidia.com
# Once accepted (typically takes about a day), download cuDNN from:
# https://developer.nvidia.com/rdp/assets/cudnn-65-linux-v2-asset
# Host this file on a private location and point to it using CUDNN_URL
CUDNN_URL=

# Request for cuDNN URL if it doesn't exist
if [ -z "$CUDNN_URL" ]; then
    echo "Enter URL to download cuDNN from: "
    read CUDNN_URL
    echo "cuDNN will be downloaded from: $CUDNN_URL"
fi

# Install dependencies
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential git python-pip libfreetype6-dev libxft-dev libncurses-dev libopenblas-dev gfortran python-matplotlib libblas-dev liblapack-dev libatlas-base-dev python-dev python-pydot linux-headers-generic linux-image-extra-virtual unzip python-numpy swig python-pandas python-sklearn zip
sudo pip install -U pip

# Install CUDA
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1410/x86_64/cuda-repo-ubuntu1410_7.0-28_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1410_7.0-28_amd64.deb
rm cuda-repo-ubuntu1410_7.0-28_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda

# Install cuDNN
wget $CUDNN_URL
tar -xf cudnn-6.5-linux-x64-v2.tar
rm cudnn-6.5-linux-x64-v2.tar
sudo cp -R cudnn-6.5-linux-x64-v2/lib* /usr/local/cuda/lib64/
sudo cp cudnn-6.5-linux-x64-v2/cudnn.h /usr/local/cuda/include/

# Add environmental variables
echo >> .bashrc
echo "export CUDA_HOME=/usr/local/cuda" >> .bashrc
echo "export CUDA_ROOT=/usr/local/cuda" >> .bashrc
echo "export PATH=$PATH:/usr/local/cuda/bin:$HOME/bin" >> .bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >> .bashrc

# Install Java for Bazel
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
# Hack to silently agree license agreement
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

# Install Bazel
sudo apt-get install pkg-config zip g++ zlib1g-dev unzip
wget https://github.com/bazelbuild/bazel/releases/download/0.2.3/bazel-0.2.3-installer-linux-x86_64.sh
chmod +x bazel-0.2.3-installer-linux-x86_64.sh
./bazel-0.2.3-installer-linux-x86_64.sh --user
rm bazel-0.2.3-installer-linux-x86_64.sh

# Clone tensorflow repo
git clone --recurse-submodules https://github.com/tensorflow/tensorflow

echo "Installer part 1 of 2 complete"
echo "Reboot (sudo reboot) machine before continuing to part 2 of 2"
