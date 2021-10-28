#!/bin/bash


fun_GitSource(){
	echo "\n-----GitSource start-----\n"
	df -hP
	mkdir -pv /home/runner/upload/
	cd "/home/runner/"
	git clone --branch "openwrt-18.06-k5.4" --single-branch https://github.com/immortalwrt/immortalwrt.git "immortalwrt-1806-k54"
	git clone --branch "openwrt-18.06-k5.4" --single-branch https://github.com/immortalwrt/immortalwrt.git "immortalwrt-k54-1806-x64"
	git clone --branch "openwrt-18.06" --single-branch https://github.com/immortalwrt/immortalwrt.git "immortalwrt-1806"
	git clone --branch "1806-rockchip-419" --single-branch "https://github.com/1715173329/immortalwrt.git" "immortalwrt-1806-rockchip-419"
	git clone --branch openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt.git "immortalwrt-2102"
	git clone --branch openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt.git "immortalwrt-2102-x64"
	sudo chown -R runner:runner upload/ immortalwrt*
	df -hP
	echo "\n-----GitSource successful-----\n"
}

fun_Immortalwrt1806k54(){
	echo "\n-----Immortalwrt-1806-k54 start-----\n"
	echo "immortalwrt-1806-k54 $(date +%F_%H%M%S)"
	cd "/home/runner/immortalwrt-1806-k54"
	rm -rf tmp/
	ls -lash
	./scripts/feeds update -a
	./scripts/feeds install -a
	cat $GITHUB_WORKSPACE/buildinfo/R2S-config.buildinfo > .config
	ls -lash
	echo "\n-----Immortalwrt-1806-k54 successful-----"
}

fun_Immortalwrtk541806x64(){
	echo "\n-----Immortalwrt-k54-1806-x64 start-----\n"
	echo "immortalwrt-k54-1806-x64 $(date +%F_%H%M%S)"
	cd "/home/runner/immortalwrt-k54-1806-x64"
	rm -rf tmp/
	ls -lash
	./scripts/feeds update -a
	./scripts/feeds install -a
	cat $GITHUB_WORKSPACE/buildinfo/x64-k5.4-config.buildinfo > .config
	ls -lash
	echo "\n-----Immortalwrt-k54-1806-x64 successful-----"
}

fun_Immortalwrt1806(){
	echo "\n-----Immortalwrt-1806 start-----\n"
	echo "immortalwrt-1806 $(date +%F_%H%M%S)"
	cd "/home/runner/immortalwrt-1806"
	rm -rf tmp/
	ls -lash
	./scripts/feeds update -a
	./scripts/feeds install -a
	cat $GITHUB_WORKSPACE/buildinfo/x64-config.buildinfo > .config
	ls -lash
	echo "\n-----Immortalwrt-1806 successful-----"
}

fun_Immortalwrt1806rockchip419(){
	echo "\n-----Immortalwrt-1806-rockchip-419 start-----\n"
	echo "immortalwrt-1806-rockchip-419 $(date +%F_%H%M%S)"
	cd "/home/runner/immortalwrt-1806-rockchip-419"
	rm -rf tmp/
	ls -lash
	./scripts/feeds update -a
	./scripts/feeds install -a
	cat $GITHUB_WORKSPACE/buildinfo/rockchip-K4_19-config.buildinfo > .config
	ls -lash
	echo "\n-----Immortalwrt-1806-rockchip-419 successful-----"
}

fun_Immortalwrt2102R2S(){
	echo "\n-----Immortalwrt2102R2S start-----\n"
	echo "immortalwrt-2102 $(date +%F_%H%M%S)"
	cd "/home/runner/immortalwrt-2102"
	rm -rf tmp/
	ls -lash
	./scripts/feeds update -a
	./scripts/feeds install -a
	cat $GITHUB_WORKSPACE/buildinfo/R2S-2102-config.buildinfo > .config
	ls -lash
	echo "\n-----Immortalwrt2102R2S successful-----"
}

fun_Immortalwrt2102x64(){
	echo "\n-----Immortalwrt2102-x64 start-----\n"
	echo "immortalwrt-2102 $(date +%F_%H%M%S)"
	cd "/home/runner/immortalwrt-2102-x64"
	rm -rf tmp/
	ls -lash
	./scripts/feeds update -a
	./scripts/feeds install -a
	cat $GITHUB_WORKSPACE/buildinfo/x86-2102-config.buildinfo > .config
	ls -lash
	echo "\n-----Immortalwrt2102-x64 successful-----"
}

fun_GitSource
fun_Immortalwrt1806k54
fun_Immortalwrtk541806x64
fun_Immortalwrt1806
fun_Immortalwrt1806rockchip419
fun_Immortalwrt2102R2S
fun_Immortalwrt2102x64
