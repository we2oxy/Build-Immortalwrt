#!/bin/bash

sudo mkdir -pv /build/{package,upload,buildinfo}
sudo chown -R runner:runner /build
git clone --depth 1 https://github.com/coolsnowwolf/lede /build/lede
cd /build/lede
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
rm -rf tmp/
./scripts/feeds update -a
./scripts/feeds install -a
./scripts/feeds install -a -f


# change uci setting
sed -i '$d' /build/lede/package/lean/default-settings/files/zzz-default-settings
cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/R2S-lede >> /build/lede/package/lean/default-settings/files/zzz-default-settings
sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/lede/package/lean/default-settings/files/zzz-default-settings
echo "####################"
cat -n /build/lede/package/lean/default-settings/files/zzz-default-settings
echo "####################"

sed -i 's#192.168.1.1#192.168.1.188#' /build/lede/package/base-files/files/bin/config_generate
