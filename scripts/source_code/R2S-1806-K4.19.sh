#!/bin/bash

sudo mkdir -pv /build/{package,upload,buildinfo}
sudo chown -R runner:runner /build
# git clone --branch 1806-rockchip-419 --single-branch https://github.com/1715173329/immortalwrt.git /build/immortalwrt
git clone --branch 1806-rockchip-419 --single-branch https://github.com/we2oxy/Immortalwrt.git /build/immortalwrt
cd /build/immortalwrt
rm -rf tmp/
./scripts/feeds update -a
./scripts/feeds install -a

# change uci setting
sed -i '$d' /build/immortalwrt/package/emortal/default-settings/files/zzz-default-settings
cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/network_dhcp_settings >> /build/immortalwrt/package/emortal/default-settings/files/zzz-default-settings
cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/zzz-default-settings-chinese /build/immortalwrt/package/emortal/default-settings/files/zzz-default-settings-chinese

# del default passwd
sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/immortalwrt/package/emortal/default-settings/files/zzz-default-settings


# luci-theme-argon
rm -rf /build/immortalwrt/feeds/luci/themes/luci-theme-argon
svn export https://github.com/jerrykuku/luci-theme-argon/branches/18.06/  /build/immortalwrt/feeds/luci/themes/luci-theme-argon

# change default IP and version flag
sed -i 's#-SNAPSHOT##g' /build/immortalwrt/include/version.mk
sed -i 's#-SNAPSHOT##g' /build/immortalwrt/package/base-files/image-config.in
sed -i 's#192.168.1.1#192.168.99.1#' /build/immortalwrt/package/base-files/files/bin/config_generate

#add build date
sed -i "/Load Average/i\\\t\t<tr><td width="33%"><%:Build Date %></td><td>`date +%F_%T`</td></tr>" /build/immortalwrt/package/emortal/autocore/files/arm/index.htm
grep "Build Date" /build/immortalwrt/package/emortal/autocore/files/arm/index.htm