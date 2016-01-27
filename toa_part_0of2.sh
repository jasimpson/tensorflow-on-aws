#! /usr/bin/env bash

echo "Downloading installer shell scripts for tensorflow on AWS"

# Download installer scripts
wget https://raw.githubusercontent.com/jasimpson/tensorflow-on-aws/master/toa_part_1of2.sh
wget https://raw.githubusercontent.com/jasimpson/tensorflow-on-aws/master/toa_part_2of2.sh

# Set scripts executable
chmod +x toa_part_1of2.sh
chmod +x toa_part_2of2.sh

echo "Installer shell scripts downloaded"
