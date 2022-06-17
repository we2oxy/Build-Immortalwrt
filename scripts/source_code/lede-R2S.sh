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
echo "####################"
cat -n /build/lede/package/lean/default-settings/files/zzz-default-settings
echo "####################"


#cat /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/R2S/network_dhcp_settings >> /build/lede/package/lean/default-settings/files/zzz-default-settings
# del default passwd
sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/lede/package/lean/default-settings/files/zzz-default-settings


# luci-theme-argon
#rm -rf /build/immortalwrt/feeds/luci/themes/luci-theme-argon
#svn export https://github.com/jerrykuku/luci-theme-argon/branches/18.06/  /build/immortalwrt/feeds/luci/themes/luci-theme-argon

# change default IP and version flag
#sed -i 's#-SNAPSHOT##g' /build/immortalwrt/include/version.mk
#sed -i 's#-SNAPSHOT##g' /build/immortalwrt/package/base-files/image-config.in
sed -i 's#192.168.1.1#192.168.1.188#' /build/lede/package/base-files/files/bin/config_generate

# add build date
#sed -i "/Load Average/i\\\t\t<tr><td width="33%"><%:Build Date %></td><td>`date +%F_%T`</td></tr>" /build/immortalwrt/package/emortal/autocore/files/generic/index.htm
#grep "Build Date" /build/immortalwrt/package/emortal/autocore/files/generic/index.htm
