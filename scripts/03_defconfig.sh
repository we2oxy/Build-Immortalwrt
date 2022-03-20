#!/bin/bash


cd /build/immortalwrt/ && ls -lash
make defconfig
./scripts/diffconfig.sh > /build/buildinfo/$1
echo "########################################"
cat -n /build/buildinfo/$1
echo "########################################"
ls -lh /build/buildinfo/