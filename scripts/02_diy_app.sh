#!/bin/bash

# del luci-app
#rm -rf /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus
#rm -rf /build/immortalwrt/feeds/luci/applications/luci-app-smartdns
#rm -rf /build/immortalwrt/feeds/packages/net/smartdns/Makefile

# del net package
#for i in {chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,microsocks,naiveproxy,redsocks2,sagernet-core,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,v2ray-core,v2ray-geodata,v2ray-plugin,v2raya,xray-core,xray-plugin} ;do echo ${i} ;done

#echo "################################################################"

#for i in {chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,microsocks,naiveproxy,redsocks2,sagernet-core,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,v2ray-core,v2ray-geodata,v2ray-plugin,v2raya,xray-core,xray-plugin} ;do rm -vrf /build/immortalwrt/feeds/packages/net/${i} ;done

# add net package
#for i in {chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,lua-neturl,microsocks,naiveproxy,redsocks2,sagernet-core,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,v2ray-core,v2ray-geodata,v2ray-plugin,v2raya,xray-core,xray-plugin} ;do echo "# svn export /build/immortalwrt/feeds/packages/net/${i}" && svn export https://github.com/fw876/helloworld/trunk/${i} /build/immortalwrt/feeds/packages/net/${i} ;done

#for i in {chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,lua-neturl,microsocks,naiveproxy,redsocks2,sagernet-core,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,v2ray-core,v2ray-geodata,v2ray-plugin,v2raya,xray-core,xray-plugin} ;do echo "# /build/immortalwrt/feeds/packages/net/${i}" && ls -lh /build/immortalwrt/feeds/packages/net/${i} ;done

# luci-app-smartdns
#svn export https://github.com/pymumu/luci-app-smartdns/branches/lede /build/immortalwrt/feeds/luci/applications/luci-app-smartdns
#svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/smartdns/Makefile /build/immortalwrt/feeds/packages/net/smartdns/Makefile

#svn export https://github.com/immortalwrt/packages/trunk/net/smartdns/Makefile /build/immortalwrt/feeds/packages/net/smartdns/Makefile
#svn export https://github.com/pymumu/openwrt-smartdns/trunk/Makefile /build/immortalwrt/feeds/packages/net/smartdns/Makefile

# luci-app-ssr-plus
#svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus
rm -rf /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus/po/zh_Hans
cd /build/immortalwrt/feeds/luci/applications/
wget -qO - https://github.com/fw876/helloworld/commit/5bbf6e7.patch | patch -p1
#wget -qO - https://github.com/we2oxy/helloworld/commit/7b9dd0c.patch | patch -p1
cd /build/immortalwrt/feeds/luci/applications/luci-app-ssr-plus
sed -i '/Clang.CN.CIDR/a\o:value("https://gh.404delivr.workers.dev/https://github.com/QiuSimons/Chnroute/raw/master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))' luasrc/model/cbi/shadowsocksr/advanced.lua
sed -n '/result.encrypt_method/a\                result.fast_open = "1"' root/usr/share/shadowsocksr/subscribe.lua
sed -i '/result.encrypt_method/a\                result.fast_open = "1"' root/usr/share/shadowsocksr/subscribe.lua
cd /build/immortalwrt/

# files
#svn export https://github.com/we2oxy/OpenWrtConfig/trunk/files/etc /build/immortalwrt/files/etc
svn export https://github.com/we2oxy/mynotebook/trunk/openwrt/files/etc /build/immortalwrt/files/etc
rm -rf /build/immortalwrt/files/etc/ssrplus/white.list
rm -rf /build/immortalwrt/files/etc/ssrplus/white.list
# ssrplus white.list
#curl "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt" >/build/immortalwrt/files/etc/ssrplus/white.list
#curl "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/google-cn.txt" >>/build/immortalwrt/files/etc/ssrplus/white.list

# ssrplus black.list
#curl -s "https://raw.hellogithub.com/hosts" | sed -e '/#/d' -e '/^$/d' | awk '{print $2}' >/build/immortalwrt/files/etc/ssrplus/black.list

#echo -e "127.0.0.1 localhost\n192.168.100.51 openwrt" >/build/immortalwrt/files/etc/hosts
#curl "https://raw.hellogithub.com/hosts" >>/build/immortalwrt/files/etc/hosts
#cat -n /build/immortalwrt/files/etc/hosts
#echo -e "1 */1 * * * /bin/sed -i '3,\$d' /etc/hosts && /usr/bin/curl https://raw.hellogithub.com/hosts >> /etc/hosts" >> /build/immortalwrt/files/etc/crontabs/root
#cat -n /build/immortalwrt/files/etc/crontabs/root

#cp -R /build/immortalwrt/files/etc/ssrplus/ /build/immortalwrt/files/etc/vssr/
#wget -O /build/immortalwrt/files/etc/accelerated-domains.china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
#wget -O /build/immortalwrt/files/etc/apple.china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf
#wget -O /build/immortalwrt/files/etc/google.china.conf https://github.com/felixonmars/dnsmasq-china-list/blob/master/google.china.conf
#echo -e "\nuci set v2raya.config.enabled=1\nuci commit v2raya\n/etc/init.d/v2raya start\n" >> /build/immortalwrt/files/etc/MyConfig/start_v2rayA
ls -lh /build/immortalwrt/files/etc
#cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/vssr /build/immortalwrt/files/etc/config/vssr
#cp /home/runner/work/Build-Immortalwrt/Build-Immortalwrt/uciconf/shadowsocksr /build/immortalwrt/files/etc/config/shadowsocksr


cd /build/immortalwrt
#./scripts/feeds install -a
