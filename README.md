# tensorflow-on-aws
Scripts to install TensorFlow on an AWS EC2 GPU Instance

These scripts are based on the excellent guide by [@ramhiser](https://twitter.com/ramhiser) available [here](http://ramhiser.com/2016/01/05/installing-tensorflow-on-an-aws-ec2-instance-with-gpu-support/)

The first part takes about 10 mins and the second part takes about 30 mins to finish

## Note about cuDNN
This script requires an Nvidia Accelerated Computing Developer Program account. If you do not have an account already, register for an account at: https://developer.nvidia.com Once accepted (**typically takes about a day**), download cuDNN from: https://developer.nvidia.com/rdp/assets/cudnn-65-linux-v2-asset Host this file on a private location and provide the URL when the script runs.

## Note about versions
This script is for the following specific versions:

| Name       | Version |
|------------|---------|
| TensorFlow | 0.9.0   |
| CUDA       | 7.0     |
| cuDNN      | 7.0     |
| Java       | 8       |
| Bazel      | 0.2.3   |
| Python     | 2.7.6   |

## Usage
- Request an AWS EC2 (spot) instance with the following settings:
    + AMI: Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-fce3c696
    + Type: g2.2xlarge
    + Storage: 16 GB (or higher)
- SSH into the instance
- Download part 0 of 3 of the script
    + `wget https://raw.githubusercontent.com/jasimpson/tensorflow-on-aws/master/toa_part_0of2.sh`
- Set executable
    + `chmod +x toa_part_0of2.sh`
- Execute script part 0 of 2
    + `./toa_part_0of2.sh`
- Execute script part 1 of 2
    + `./toa_part_1of2.sh`
- Enter URL to download cuDNN from
- Reboot machine
    + `sudo reboot`
- SSH back into machine
- Execute script part 2 of 2
    + `./toa_part_2of2.sh`
- Test TensorFlow
    + `$ python`
    + `>>> import tensorflow as tf`
