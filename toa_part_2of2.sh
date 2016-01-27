#! /usr/bin/env bash

echo "Installing tensorflow on AWS"
echo "Running installer part 2 of 2"

# Switch to tensorflow directory
cd tensorflow

# Running tensorflow configuration
echo "Set Cuda compute capability to 3.0 (Default is 3.5,5.2)"
echo "Use default values for all other parameters"
TF_UNOFFICIAL_SETTING=1 ./configure

# Build tensorflow
bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
sudo pip install --upgrade /tmp/tensorflow_pkg/*.whl

echo "Installer part 2 of 2 complete"
echo "Successfully installed tensorflow on AWS"
