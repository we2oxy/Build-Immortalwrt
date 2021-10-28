#!/bin/bash


fun_backup_defaultsettings(){
	echo "\n-----backup start-----"
	cd /build/immortalwrt/package/emortal/default-settings/files/
	cp zzz-default-settings zzz-default-settings.bak
	mv zzz-default-settings-chinese zzz-default-settings-chinese.bak
	echo "\n-----backup successful-----"
}

fun_sync_sourecode(){
	echo "\n-----sync_sourecode start-----"
	#cd /build/immortalwrt/feeds/luci/applications/
	#ls -lah luci-app-ssr-plus/ luci-app-openclash/ luci-app-passwall/  luci-app-vssr/
	#rm -rf luci-app-ssr-plus/ luci-app-openclash/ luci-app-passwall/  luci-app-vssr/
	#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall luci-app-passwall
	#svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus luci-app-ssr-plus
	#svn co https://github.com/we2oxy/helloworld/branches/dnsproxy/luci-app-ssr-plus luci-app-ssr-plus
	#svn co https://github.com/jerrykuku/luci-app-vssr/trunk/ luci-app-vssr
	#svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash luci-app-openclash
	#svn update luci-app-passwall/ luci-app-ssr-plus/ luci-app-vssr/ luci-app-openclash/
	#ls -lah luci-app-ssr-plus/ luci-app-openclash/ luci-app-passwall/  luci-app-vssr/
	svn co https://github.com/zxlhhyccc/luci-app-v2raya/trunk/ /build/immortalwrt/package/emortal/luci-app-v2raya/
	cd /build/immortalwrt/feeds/luci/themes/
	rm -rf luci-theme-argon
	git clone --branch 18.06  --single-branch https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon
	cd /build/immortalwrt/ && ./scripts/feeds install -a
	echo "\n-----sync_sourecode successful-----"
}

fun_del_snapshot(){
	echo "\n-----del_snapshot start-----"
	cd /build/immortalwrt/
	sed -i 's,-SNAPSHOT,,g' include/version.mk
	sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in
	echo "\n-----del_snapshot successful-----"
}

fun_del_passwd(){
	echo "\n-----del_passwd start-----"
	cd /build/immortalwrt/
	sed -i '/CYXluq4wUazHjmCDBCqXF/d'  package/emortal/default-settings/files/zzz-default-settings
	echo "\n-----del_passwd successful-----"
}

fun_import_rules(){
	echo "\n-----import_rules start-----"
	svn co https://github.com/we2oxy/OpenWrtConfig/trunk/files/etc /build/immortalwrt/files/etc
	cd /build/immortalwrt/files/etc
	rm -rf .svn/
	cp -R ssrplus/ vssr/
	ls -lahR /build/immortalwrt/files/
	echo "\n-----import_rules successful-----"
 }
 
fun_vssr(){
	echo "\n-----modify vssr start-----"
	sed -i '/result.encrypt_method/a\        result.fast_open = "1"' /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/subscribe.lua
	sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' /build/immortalwrt/feeds/luci/applications/luci-app-vssr/luasrc/controller/vssr.lua
	sed -i 's,ispip.clang.cn/all_cn.txt,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,g' /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/update.lua
	echo "\ncheck result.fast_open /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/subscribe.lua\n"
	grep -C 2 "result.fast_open" /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/subscribe.lua
	echo "\ncheck raw.sevencdn.com/QiuSimons /build/immortalwrt/feeds/luci/applications/luci-app-vssr/luasrc/controller/vssr.lua\n"
	grep -C 2 "chnroute.txt" /build/immortalwrt/feeds/luci/applications/luci-app-vssr/luasrc/controller/vssr.lua
	echo "\ncheck raw.sevencdn.com/QiuSimons /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/update.lua\n"
	grep -C 2 "chnroute.txt" /build/immortalwrt/feeds/luci/applications/luci-app-vssr/root/usr/share/vssr/update.lua
	echo "\n-----modify vssr successful-----"
 }
 
fun_ssrplus(){
	echo "\n-----modify ssrplus start-----"
	#rm -rf /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus/po/zh_Hans
	cd /build/immortalwrt/feeds/luci/applications/
	sed -i '/result.encrypt_method/a\                result.fast_open = "1"' luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
	sed -i 's,ispip.clang.cn/all_cn,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	sed -i 's,YW5vbnltb3Vz/domain-list-community/release/gfwlist.txt,Loyalsoldier/v2ray-rules-dat/release/gfw.txt,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	sed -i '/all_cn_cidr.txt/a\o:value("https://cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))\' luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/advanced.lua
	echo "\ncheck result.fast_open root/usr/share/shadowsocksr/subscribe.lua\n"
	grep -C 2 "result.fast_open" luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
	echo "\ncheck cdn.jsdelivr.net/gh/QiuSimons root/etc/init.d/shadowsocksr\n"
	grep -C 2 "chnroute.txt" luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	echo "\ncheck Loyalsoldier/v2ray-rules-dat  root/etc/init.d/shadowsocksr\n"
	grep -C 2 "Loyalsoldier/v2ray-rules-dat"  luci-app-ssr-plus/root/etc/init.d/shadowsocksr
	echo  "\ncheck translate("QiuSimons/Chnroute") luasrc/model/cbi/shadowsocksr/advanced.lua\n"
	grep -C 2 'translate("QiuSimons/Chnroute")' luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/advanced.lua
	echo "\n-----modify ssrplus successful-----"
 }

 
fun_backup_defaultsettings
fun_del_snapshot
fun_del_passwd
fun_sync_sourecode
fun_import_rules
fun_vssr
fun_ssrplus

