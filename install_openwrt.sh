#!/bin/bash

echo "Start install OpenWrt"

# Build system setup (Debian / Ubuntu)
# openwrt.org > Documentation > Developer guide > Build system setup
sudo apt-get update -y && sudo apt-get upgrade -y

# Requirements
sudo apt-get install build-essential ccache ecj fastjar file g++ gawk \
gettext git java-propose-classpath libelf-dev libncurses5-dev \
libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
python3-distutils python3-setuptools python3-dev rsync subversion \
swig time xsltproc zlib1g-dev binutils bzip2 flex gawk gcc-6+ grep \
libc-dev libz-dev perl rsync subversion unzip

# Clone OpenWrt GitHub (https://github.com/openwrt/openwrt)
git clone https://github.com/openwrt/openwrt.git
cd openwrt

# Setup branch (https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem)
git checkout openwrt-21.02
./scripts/feeds update -a
./scripts/feeds install -a

echo "------------------------------------------------"
echo "OpenWrt installation completed!"