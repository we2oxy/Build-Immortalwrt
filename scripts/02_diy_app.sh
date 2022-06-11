#!/bin/bash


# del luci-app
cd /build/immortalwrt/
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-vssr/

# luci-app-ssr-plus
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus
cd /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus
sed -i 's,ispip.clang.cn/all_cn,gh.404delivr.workers.dev/https://github.com/QiuSimons/Chnroute/raw/master/dist/chnroute/chnroute,' root/etc/init.d/shadowsocksr
sed -i 's,YW5vbnltb3Vz/domain-list-community/release/gfwlist.txt,Loyalsoldier/v2ray-rules-dat/release/gfw.txt,' root/etc/init.d/shadowsocksr
sed -i '/Clang.CN.CIDR/a\o:value("https://gh.404delivr.workers.dev/https://github.com/QiuSimons/Chnroute/raw/master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))' luasrc/model/cbi/shadowsocksr/advanced.lua
sed -i '/result.encrypt_method/a\                result.fast_open = "1"' root/usr/share/shadowsocksr/subscribe.lua


# luci-app-passwall
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall /build/immortalwrt/feeds/luci/applications/luci-app-passwall




# vssr
#svn export https://github.com/jerrykuku/luci-app-vssr/trunk/ /build/immortalwrt/feeds/luci/applications/luci-app-vssr/
#cd /build/immortalwrt/feeds/luci/applications/luci-app-vssr/
#sed -i '/result.encrypt_method/a\        result.fast_open = "1"' root/usr/share/vssr/subscribe.lua
#grep -C 3 result.fast_open root/usr/share/vssr/subscribe.lua
#sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' luasrc/controller/vssr.lua
#sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' root/usr/share/vssr/update.lua


# files
svn export https://github.com/we2oxy/OpenWrtConfig/trunk/files/etc /build/immortalwrt/files/etc
cp -R /build/immortalwrt/files/etc/ssrplus/ /build/immortalwrt/files/etc/vssr/
#cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/vssr /build/immortalwrt/files/etc/config/vssr
cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/shadowsocksr /build/immortalwrt/files/etc/config/shadowsocksr
