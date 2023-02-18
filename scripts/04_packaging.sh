#!/bin/bash


rm -rf $(find /build/immortalwrt/bin/targets/ -type d -name "packages")
cp -rf $(find /build/immortalwrt/bin/targets/ -type f) /build/upload/
cp -rf $(find /build/immortalwrt/bin/packages/ -type f -name "*.ipk")  /build/package/
cd /build/ && zip -qr /build/upload/package_$(date +%F_%H%M%S).zip  package/
cd /build/upload/
ls -lh
mv immortalwrt-rockchip-armv8-friendlyarm_nanopi-r2s-ext4-sysupgrade.img.gz  `date +%F_%H%M%S`_R2S-EXT4.img.gz
mv immortalwrt-rockchip-armv8-friendlyarm_nanopi-r2s-squashfs-sysupgrade.img.gz `date +%F_%H%M%S`_R2S-SQFS.img.gz
#for source_name in `ls immortalwrt*`;do tag_name=$(date +%F_%H%M%S)_  modify_name=$tag_name$source_name;mv $source_name $modify_name;done
ls -lh /build/upload/
