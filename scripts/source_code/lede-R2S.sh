#!/bin/bash

sudo mkdir -pv /build/{package,upload,buildinfo}
sudo chown -R runner:runner /build
git clone --depth 1 https://github.com/coolsnowwolf/lede.git /build/lede
cd /build/lede
mkdir -pv /build/lede/files/etc/
mkdir -pv /build/lede/files/etc/crontabs/
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
rm -rf tmp/
./scripts/feeds update -a
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/vla/luci-app-openclash
./scripts/feeds install -a
./scripts/feeds install -a -f


# change uci setting
cat -n /build/lede/package/lean/default-settings/files/zzz-default-settings
sed -i '$d' /build/lede/package/lean/default-settings/files/zzz-default-settings
cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/R2S-lede >> /build/lede/package/lean/default-settings/files/zzz-default-settings
sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/lede/package/lean/default-settings/files/zzz-default-settings
sed -i '/DISTRIB_REVISION=/d' /build/lede/package/lean/default-settings/files/zzz-default-settings
sed -i '/DISTRIB_REVISION/aecho "DISTRIB_REVISION='R`date +%F`'" >> /etc/openwrt_release' /build/lede/package/lean/default-settings/files/zzz-default-settings
echo "####################"
cat -n /build/lede/package/lean/default-settings/files/zzz-default-settings
echo "####################"

sed -n 's#192.168.1.1#192.168.100.51#p' /build/lede/package/base-files/files/bin/config_generate
sed -n 's#255.255.255.0#255.255.0.0#p' /build/lede/package/base-files/files/bin/config_generate

sed -i 's#192.168.1.1#192.168.100.51#' /build/lede/package/base-files/files/bin/config_generate
sed -i 's#255.255.255.0#255.255.0.0#' /build/lede/package/base-files/files/bin/config_generate

#sed -i 's/KERNEL_TESTING_PATCHVER/#KERNEL_TESTING_PATCHVER/' target/linux/rockchip/Makefile
#sed -n '/KERNEL_TESTING_PATCHVER/p' target/linux/rockchip/Makefile
