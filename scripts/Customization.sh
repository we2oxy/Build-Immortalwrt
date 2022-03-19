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

function fun_sync_sourecode(){
	echo -e "\n-----$FUNCNAME start-----"
	#svn co https://github.com/zxlhhyccc/luci-app-v2raya/trunk/ /build/immortalwrt/package/emortal/luci-app-v2raya/
	#svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns /build/immortalwrt/package/emortal/luci-app-mosdns
	cd /build/immortalwrt/feeds/luci/themes/
	rm -rf luci-theme-argon
	git clone --branch 18.06 --single-branch https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon
	cd /build/immortalwrt/
	echo -e "\n-----$FUNCNAME successful-----"
}

function fun_del_snapshot(){
	echo -e "\n-----$FUNCNAME start-----"
	sed -i 's,-SNAPSHOT,,g' /build/immortalwrt/include/version.mk
	sed -i 's,-SNAPSHOT,,g' /build/immortalwrt/package/base-files/image-config.in
	echo -e "\n-----$FUNCNAME successful-----"
}

function fun_del_passwd(){
	echo -e "\n-----$FUNCNAME start-----"
	sed -i '/CYXluq4wUazHjmCDBCqXF/d'  /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
	echo -e "\n-----$FUNCNAME successful-----"
}

function fun_import_rules(){
	echo -e "\n-----$FUNCNAME start-----"
	svn co https://github.com/we2oxy/OpenWrtConfig/trunk/files/etc /build/immortalwrt/files/etc
	wget -O /build/immortalwrt/files/etc/ssrplus/direct_microsoft.txt https://raw.githubusercontent.com/1715173329/ssrplus-routing-rules/master/direct/microsoft.txt
	cat /build/immortalwrt/files/etc/ssrplus/direct_microsoft.txt >> /build/immortalwrt/files/etc/ssrplus/white.list
	cat /build/immortalwrt/files/etc/ssrplus/white.list
	rm -rf /build/immortalwrt/files/etc/.svn/
	cp -R /build/immortalwrt/files/etc/ssrplus/ /build/immortalwrt/files/etc/vssr/
	cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/shadowsocksr /build/immortalwrt/files/etc/config/
	ls -lahR /build/immortalwrt/files/
	echo -e "\n-----$FUNCNAME successful-----"
 }
 
function fun_vssr(){
	echo -e "\n-----$FUNCNAME start-----"
	sed -i '/result.encrypt_method/a\        result.fast_open = "1"' /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/subscribe.lua
	sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' /build/immortalwrt/feeds/luci/applications/luci-app-vssr/luasrc/controller/vssr.lua
	sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/update.lua
	echo -e "\ncheck result.fast_open /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/subscribe.lua\n"
	echo -e "\ncheck raw.sevencdn.com/QiuSimons /build/immortalwrt/feeds/luci/applications/luci-app-vssr/luasrc/controller/vssr.lua\n"
	echo -e "\ncheck raw.sevencdn.com/QiuSimons /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/update.lua\n"
	echo -e "\n-----$FUNCNAME successful-----"
 }
 
function fun_ssrplus(){
	echo -e "\n-----$FUNCNAME start-----"
	cd /build/immortalwrt/feeds/luci/applications/
	sed -i '/result.encrypt_method/a\                result.fast_open = "1"' luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
	sed -i 's,ispip.clang.cn/all_cn,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	sed -i 's,YW5vbnltb3Vz/domain-list-community/release/gfwlist.txt,Loyalsoldier/v2ray-rules-dat/release/gfw.txt,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	sed -i '/all_cn_cidr.txt/a\o:value("https://cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))\' luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/advanced.lua
	echo -e "\ncheck result.fast_open root/usr/share/shadowsocksr/subscribe.lua\n"
	echo -e "\ncheck cdn.jsdelivr.net/gh/QiuSimons root/etc/init.d/shadowsocksr\n"
	echo -e "\ncheck Loyalsoldier/v2ray-rules-dat  root/etc/init.d/shadowsocksr\n"
	echo -e  "\ncheck translate("QiuSimons/Chnroute") luasrc/model/cbi/shadowsocksr/advanced.lua\n"
	echo -e "\n-----$FUNCNAME successful-----"
 }

 
fun_backup_defaultsettings
fun_del_snapshot
fun_del_passwd
fun_sync_sourecode
fun_import_rules
fun_vssr
fun_ssrplus
