#!/bin/bash


fun_Generate_Immortalwrt_1806_k54(){
	echo "\n-----Generate_immortalwrt-1806-k54 start-----\n"
	ls -lha /home/runner/
	cd "/home/runner/immortalwrt-1806-k54"
	make defconfig 
	ls -lash
	./scripts/diffconfig.sh > /home/runner/upload/R2S-config.buildinfo
	cp ".config" /home/runner/upload/R2S-config.txt
	cat /home/runner/upload/R2S-config.buildinfo
	echo "\n-----Generate_immortalwrt-1806-k54 successful-----"
}

fun_Generate_Immortalwrt_k54_1806_x64(){
	echo "\n-----Generate_immortalwrt-k54-1806-x64 start-----\n"
	cd "/home/runner/immortalwrt-k54-1806-x64"
	make defconfig
	ls -lash
	./scripts/diffconfig.sh > /home/runner/upload/x64-k5.4-config.buildinfo
	cp ".config" /home/runner/upload/x64-k5.4-config.txt
	cat /home/runner/upload/x64-k5.4-config.buildinfo
	echo "\n-----Generate_immortalwrt-k54-1806-x64 successful-----"
}

fun_Generate_Immortalwrt_1806(){
	echo "\n-----Generate_immortalwrt-1806 start-----\n"
	cd "/home/runner/immortalwrt-1806"
	make defconfig
	ls -lash
	./scripts/diffconfig.sh > /home/runner/upload/x64-config.buildinfo
	cp ".config" /home/runner/upload/x64-config.txt
	cat /home/runner/upload/x64-config.buildinfo
	echo "\n-----Generate_immortalwrt-1806 successful-----"
}

fun_Generate_Immortalwrt_1806_rockchip_419(){
	echo "\n-----Generate_immortalwrt-1806-rockchip-419 start-----\n"
	cd "/home/runner/immortalwrt-1806-rockchip-419"
	make defconfig
	ls -lash
	pwd
	./scripts/diffconfig.sh > /home/runner/upload/rockchip-K4_19-config.buildinfo
	cp ".config" /home/runner/upload/rockchip-K4_19-config.txt
	cat /home/runner/upload/rockchip-K4_19-config.buildinfo
	echo "\n-----Generate_immortalwrt-1806-rockchip-419 successful-----"
}

fun_Generate_Immortalwrt_2102_R2S(){
	echo "\n-----Generate_Immortalwrt-2102-R2S start-----\n"
	cd "/home/runner/immortalwrt-2102"
	make defconfig
	ls -lash
	pwd
	./scripts/diffconfig.sh > /home/runner/upload/R2S-2102-config.buildinfo
	cp ".config" /home/runner/upload/R2S-2102-config.txt
	cat /home/runner/upload/R2S-2102-config.buildinfo
	echo "\n-----Generate_Immortalwrt-2102-R2S successful-----"
}

fun_Generate_Immortalwrt_2102_x64(){
	echo "\n-----Generate_Immortalwrt-2102-x64 start-----\n"
	cd "/home/runner/immortalwrt-2102-x64"
	make defconfig
	ls -lash
	pwd
	./scripts/diffconfig.sh > /home/runner/upload/x86-2102-config.buildinfo
	cp ".config" /home/runner/upload/x86-2102-config.txt
	cat /home/runner/upload/x86-2102-config.buildinfo
	echo "\n-----Generate_Immortalwrt-2102-x64 successful-----"
}

fun_Check(){
	cd /home/runner/upload/
	ls -lash
	pwd
	wc -l ./*
	sha1sum ./*
}



fun_Generate_Immortalwrt_1806_k54
fun_Generate_Immortalwrt_k54_1806_x64
fun_Generate_Immortalwrt_1806
fun_Generate_Immortalwrt_1806_rockchip_419
fun_Generate_Immortalwrt_2102_R2S
fun_Generate_Immortalwrt_2102_x64
fun_Check
