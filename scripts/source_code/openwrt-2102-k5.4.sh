#!/bin/bash

sudo mkdir -pv /build/{package,upload,buildinfo}
sudo chown -R runner:runner /build
git clone --branch openwrt-21.02 --single-branch --depth 1 https://github.com/openwrt/openwrt.git /build/openwrt
cd /build/openwrt
sed -i "/helloworld/d" feeds.conf.default
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> feeds.conf.default
rm -rf tmp/
./scripts/feeds update -a
./scripts/feeds install -a

# change uci setting
#sed -i '$d' /build/openwrt/package/emortal/default-settings/files/99-default-settings
#cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/network_dhcp_settings >> /build/openwrt/package/emortal/default-settings/files/99-default-settings
#cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/zzz-default-settings-chinese /build/openwrt/package/emortal/default-settings/files/99-default-settings-chinese
mkdir -p /build/openwrt/files/etc/uci-defaults
cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/R2S-uci > /build/openwrt/files/etc/uci-defaults/99_custom

# del default passwd
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/openwrt/package/emortal/default-settings/files/99-default-settings


# luci-theme-argon
# rm -rf /build/openwrt/feeds/luci/themes/luci-theme-argon
# svn export https://github.com/jerrykuku/luci-theme-argon/branches/trunk/  /build/openwrt/feeds/luci/themes/luci-theme-argon

# change default IP and version flag
sed -i 's#-SNAPSHOT##g' /build/openwrt/include/version.mk
sed -i 's#-SNAPSHOT##g' /build/openwrt/package/base-files/image-config.in
sed -i 's#192.168.1.1#192.168.100.51#' /build/openwrt/package/base-files/files/bin/config_generate
sed -i 's#255.255.255.0#255.255.0.0#' /build/openwrt/package/base-files/files/bin/config_generate
sed -i 's/16384/65535/g' /build/openwrt/package/kernel/linux/files/sysctl-nf-conntrack.conf
sed -i "s/enabled '0'/enabled '1'/g" /build/openwrt/feeds/packages/utils/irqbalance/files/irqbalance.config
sed -i 's,9625784cf2e4fd9842f1d407681ce4878b5b0dcddbcd31c6135114a30c71e6a8,skip,g' /build/openwrt/feeds/packages/utils/jq/Makefile

#svn export https://github.com/QiuSimons/OpenWrt-Add/trunk/luci-app-irqbalance package/new/luci-app-irqbalance
# add build date
# sed -i "/Load Average/i\\\t\t<tr><td width="33%"><%:Build Date %></td><td>`date +%F_%T`</td></tr>" /build/openwrt/package/emortal/autocore/files/generic/index.htm
# grep "Build Date" /build/openwrt/package/emortal/autocore/files/generic/index.htm
#git clone -b luci --depth 1 https://github.com/QiuSimons/openwrt-chinadns-ng.git /build/openwrt/package/new/luci-app-chinadns-ng
#svn export https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng /build/openwrt/package/new/chinadns-ng

#./scripts/feeds install -a
