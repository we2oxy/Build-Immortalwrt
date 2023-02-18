#!/bin/bash

sudo mkdir -pv /build/{package,upload,buildinfo}
sudo chown -R runner:runner /build
git clone --branch openwrt-21.02 --single-branch --depth 1 https://github.com/immortalwrt/immortalwrt.git /build/immortalwrt
cd /build/immortalwrt
rm -rf tmp/
./scripts/feeds update -a
./scripts/feeds install -a

# change uci setting
echo "
uci set system.@system[0].hostname='openwrt'
uci commit system

uci set dhcp.@dnsmasq[0].sequential_ip='1'
uci set dhcp.lan.start='10'
uci set dhcp.lan.limit='200'
uci set dhcp.lan.leasetime='48h'
uci commit dhcp

uci set luci.diag.dns=weixin.qq.com
uci set luci.diag.ping=223.5.5.5
uci set luci.diag.route=weixin.qq.com

uci commit luci
" >> my_sys_uci_custom.txt
echo "
uci set shadowsocksr.@global[0].run_mode='router'
uci set shadowsocksr.@global[0].pdnsd_enable='2'
uci set shadowsocksr.@global[0].enable_switch='0'
uci set shadowsocksr.@global[0].gfwlist_url='https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/gfw.txt'
uci set shadowsocksr.@global[0].chnroute_url='https://gh.404delivr.workers.dev/https://github.com/QiuSimons/Chnroute/raw/master/dist/chnroute/chnroute.txt'
uci set shadowsocksr.@server_subscribe[0].switch='0'
uci set shadowsocksr.@server_subscribe[0].proxy='0'
uci set shadowsocksr.@global[0].tunnel_forward='8.8.8.8:53'
uci set shadowsocksr.@server_subscribe[0].auto_update_time='12'
uci commit shadowsocksr
" >> my_ssr_uci_custom.txt

cat -n my_uci_custom.txt
cat -n my_ssr_uci_custom.txt
sed -i '/exit 0/r my_sys_uci_custom.txt' /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
sed -i '/exit 0/d' /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
echo "exit 0" >> /build/immortalwrt/package/emortal/default-settings/files/99-default-settings

sed -i '/exit 0/r my_ssr_uci_custom.txt' /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus/root/etc/uci-defaults
sed -i '/exit 0/d' /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus/root/etc/uci-defaults
echo "exit 0" >> /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus/root/etc/uci-defaults

cat -n /build/immortalwrt/package/emortal/default-settings/files/99-default-settings
cat -n /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus/root/etc/uci-defaults
# del default passwd
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' /build/immortalwrt/package/emortal/default-settings/files/99-default-settings


# luci-theme-argon
# rm -rf /build/immortalwrt/feeds/luci/themes/luci-theme-argon
# svn export https://github.com/jerrykuku/luci-theme-argon/branches/trunk/  /build/immortalwrt/feeds/luci/themes/luci-theme-argon

# change default IP and version flag
sed -i 's#-SNAPSHOT##g' /build/immortalwrt/include/version.mk
sed -i 's#-SNAPSHOT##g' /build/immortalwrt/package/base-files/image-config.in
sed -i 's#192.168.1.1#192.168.100.51#' /build/immortalwrt/package/base-files/files/bin/config_generate
sed -i 's#255.255.255.0#255.255.0.0#' /build/immortalwrt/package/base-files/files/bin/config_generate

# add build date
# sed -i "/Load Average/i\\\t\t<tr><td width="33%"><%:Build Date %></td><td>`date +%F_%T`</td></tr>" /build/immortalwrt/package/emortal/autocore/files/generic/index.htm
# grep "Build Date" /build/immortalwrt/package/emortal/autocore/files/generic/index.htm
