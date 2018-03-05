#!/bin/bash
#####################################################################
# Script Name	: lfs-get-sources.sh
# Description	: Downloads and performs checksum of required source
#               : packages for LFS 8.2.
# Args		: None
# Author	: gszumo
# Email		: gszumo@gmail.com
#####################################################################
# Check for LFS env variable
LFS=/mnt/lfs
if [ -z "${LFS}" ]; then
	echo "\$LFS variable not set. Exiting..."
	exit
fi
if [ ! -d "${LFS}" ]; then
	echo "\$LFS directory doesn't exist. Exiting..."
	exit
fi

echo "Creating directory \"$LFS/sources\""
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

echo "Downloading sources listing..."
wget http://www.linuxfromscratch.org/lfs/view/stable/wget-list
echo "Downloading checksum listing..."
http://www.linuxfromscratch.org/lfs/view/stable/md5sums
cp md5sums $LFS/sources

echo "Downloading sources..."
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

pushd $LFS/sources
md5sum -c md5sums
popd

