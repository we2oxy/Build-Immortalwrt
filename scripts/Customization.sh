#!/bin/bash

function fun_change_network(){
	# 交换 lan/wan 口
	echo -e "\n-----$FUNCNAME start-----"
	#head -30 /build/immortalwrt/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
	#sed -i "s,'eth1' 'eth0','eth0' 'eth1',g" /build/immortalwrt/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
	#head -30 /build/immortalwrt/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
	echo -e "\n-----$FUNCNAME successful-----"
}

function fun_backup_defaultsettings(){
	echo -e "\n-----$FUNCNAME start-----"
	cd /build/immortalwrt/package/emortal/default-settings/files/
	for i in `ls .`; do cp ${i} "${i}_bak"; done
	echo -e "\n-----$FUNCNAME successful-----"
}



function fun_del_snapshot(){
	echo -e "\n-----$FUNCNAME start-----"
	sed -i 's,-SNAPSHOT,,g' /build/immortalwrt/include/version.mk
	sed -i 's,-SNAPSHOT,,g' /build/immortalwrt/package/base-files/image-config.in
	sed -i '/CYXluq4wUazHjmCDBCqXF/d'  /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
	echo -e "\n-----$FUNCNAME successful-----"
}

function fun_import_rules(){
	echo -e "\n-----$FUNCNAME start-----"
	svn export https://github.com/we2oxy/OpenWrtConfig/trunk/files/etc /build/immortalwrt/files/etc
	wget -O /build/immortalwrt/files/etc/ssrplus/direct_microsoft.txt https://raw.githubusercontent.com/1715173329/ssrplus-routing-rules/master/direct/microsoft.txt
	cat /build/immortalwrt/files/etc/ssrplus/direct_microsoft.txt >> /build/immortalwrt/files/etc/ssrplus/white.list
	cat /build/immortalwrt/files/etc/ssrplus/white.list
	cp -R /build/immortalwrt/files/etc/ssrplus/ /build/immortalwrt/files/etc/vssr/
	#cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/shadowsocksr /build/immortalwrt/files/etc/config/
	#cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/shadowsocksr /build/immortalwrt/files/etc/config/
	ls -lahR /build/immortalwrt/files/
	echo -e "\n-----$FUNCNAME successful-----"
 }
 
function fun_vssr(){
	echo -e "\n-----$FUNCNAME start-----"
	cd /build/immortalwrt/feeds/luci/applications/luci-app-vssr/
	sed -i '/result.encrypt_method/a\        result.fast_open = "1"' root/usr/share/vssr/subscribe.lua
	grep -C 3 result.fast_open root/usr/share/vssr/subscribe.lua
	sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' luasrc/controller/vssr.lua
	sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' root/usr/share/vssr/update.lua
	echo -e "\n-----$FUNCNAME successful-----"
 }
 
function fun_ssrplus(){
	echo -e "\n-----$FUNCNAME start-----"
	#cd /build/immortalwrt/
	#svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/lean/luci-app-ssr-plus
	#rm -rf ./package/lean/luci-app-ssr-plus/po/zh_Hans
	## SSRP Dependies
	#rm -rf ./feeds/packages/net/shadowsocks-libev
	#rm -rf ./feeds/packages/net/xray-core
	#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/dns2socks package/lean/dns2socks
	#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/microsocks package/lean/microsocks
	#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/pdnsd-alt package/lean/pdnsd-alt
	#svn export https://github.com/fw876/helloworld/trunk/tcping package/lean/tcping
	#svn export https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/lean/shadowsocksr-libev
	#svn export https://github.com/fw876/helloworld/trunk/naiveproxy package/lean/naiveproxy
	#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/redsocks2 package/lean/redsocks2
	#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/shadowsocks-libev package/lean/shadowsocks-libev
	#svn export https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/lean/shadowsocks-rust
	#svn export https://github.com/fw876/helloworld/trunk/simple-obfs package/lean/simple-obfs
	#svn export https://github.com/fw876/helloworld/trunk/trojan package/lean/trojan
	#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/ipt2socks package/lean/ipt2socks
	#svn export https://github.com/fw876/helloworld/trunk/v2ray-plugin package/lean/v2ray-plugin
	#svn export https://github.com/fw876/helloworld/trunk/xray-plugin package/lean/xray-plugin
	#svn export https://github.com/fw876/helloworld/trunk/xray-core package/lean/xray-core
	#feeds/helloworld/luci-app-ssr-plus
	cd feeds/helloworld/luci-app-ssr-plus
	sed -i 's/143/143,25,5222/' root/etc/init.d/shadowsocksr
	sed -i 's,ispip.clang.cn/all_cn,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute,' root/etc/init.d/shadowsocksr
	sed -i 's,YW5vbnltb3Vz/domain-list-community@release/gfwlist,Loyalsoldier/v2ray-rules-dat@release/gfw,' root/etc/init.d/shadowsocksr
	sed -i '/Clang.CN.CIDR/a\o:value("https://cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))' luasrc/model/cbi/shadowsocksr/advanced.lua
	sed -n '/result.encrypt_method/a\                result.fast_open = "1"/p' root/usr/share/shadowsocksr/subscribe.lua
	sed -i '/result.encrypt_method/a\                result.fast_open = "1"' root/usr/share/shadowsocksr/subscribe.lua
	#sed -i 's,ispip.clang.cn/all_cn,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	#sed -i 's,YW5vbnltb3Vz/domain-list-community/release/gfwlist.txt,Loyalsoldier/v2ray-rules-dat/release/gfw.txt,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	#sed -i '/all_cn_cidr.txt/a\o:value("https://cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))\' luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/advanced.lua

	echo -e "\n-----$FUNCNAME successful-----"
 }

 
fun_backup_defaultsettings
fun_del_snapshot
fun_import_rules
fun_vssr

