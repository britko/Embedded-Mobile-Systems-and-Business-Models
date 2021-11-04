#!/bin/bash

# Build system setup (Debian / Ubuntu)
# openwrt.org > Documentation > Developer guide > Build system setup
sudo apt update -y && sudo apt upgrade -y

sudo apt install build-essential ccache ecj fastjar file g++ gawk \
gettext git java-propose-classpath libelf-dev libncurses5-dev \
libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
python3-distutils python3-setuptools python3-dev rsync subversion \
swig time xsltproc zlib1g-dev

# Clone OpenWrt GitHub (https://github.com/openwrt/openwrt)
git clone https://github.com/openwrt/openwrt.git
cd openwrt

# Requirements
sudo apt install binutils bzip2 diff find flex gawk gcc-6+ getopt grep install libc-dev libz-dev \
make4.1+ perl python3.6+ rsync subversion unzip which

# Setup branch
git checkout openwrt-21.02
git checkout v21.02.0
./scripts/feeds update -a
./scripts/feeds install -a