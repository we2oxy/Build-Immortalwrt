#!/bin/bash

sudo mkdir -pv /build/{package,upload,buildinfo}
sudo chown -R runner:runner /build
git clone --branch openwrt-18.06-k5.4 --single-branch --depth 1 https://github.com/immortalwrt/immortalwrt.git /build/immortalwrt
cd /build/immortalwrt
rm -rf tmp/
./scripts/feeds update -a
./scripts/feeds install -a


# change uci setting
sed -i '$d' /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/network_dhcp_settings >> /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/zzz-default-settings-chinese /build/immortalwrt/package/emortal/default-settings/files/99-default-settings-chines


cp /build/immortalwrt/package/network/services/dnsmasq/files/dhcp.conf /build/immortalwrt/dhcp.conf-bak
cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/dhcp.conf > /build/immortalwrt/package/network/services/dnsmasq/files/dhcp.conf
diff -y /build/immortalwrt/package/network/services/dnsmasq/files/dhcp.conf /build/immortalwrt/dhcp.conf-bak

# del default passwd
sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/immortalwrt/package/emortal/default-settings/files/99-default-settings


# luci-theme-argon
#svn export https://github.com/jerrykuku/luci-theme-argon/branches/18.06/  /build/immortalwrt/feeds/luci/themes/luci-theme-argon

# change default IP and version flag
sed -i 's#-SNAPSHOT##g' /build/immortalwrt/include/version.mk
sed -i 's#-SNAPSHOT##g' /build/immortalwrt/package/base-files/image-config.in
sed -i 's#192.168.1.1#192.168.100.51#' /build/immortalwrt/package/base-files/files/bin/config_generate
sed -i 's#255.255.255.0#255.255.0.0#' /build/immortalwrt/package/base-files/files/bin/config_generate


# add build date
sed -i "/Load Average/i\\\t\t<tr><td width="33%"><%:Build Date %></td><td>`date +%F_%T`</td></tr>" /build/immortalwrt/package/emortal/autocore/files/generic/index.htm
grep "Build Date" /build/immortalwrt/package/emortal/autocore/files/generic/index.htm
