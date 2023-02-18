#!/bin/bash


sudo timedatectl set-timezone "Asia/Shanghai"
sudo -E swapoff -a
docker rmi `docker images -q`
sudo -E rm -rf /usr/share/dotnet /etc/mysql /etc/php /usr/local/lib/android /opt/ghc /swapfile
sudo -E apt-get -qq remove --purge azure-cli ghc zulu* hhvm llvm* firefox google* dotnet* powershell mysql* php* mssql-tools msodbcsql17 android* 
sudo -E apt-get -qq update 
sudo -E apt-get full-upgrade -y 
sudo -E apt-fast -y -qq -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ccache cmake cpio curl device-tree-compiler ecj fastjar flex gawk gettext gcc-multilib g++-multilib git gperf haveged help2man intltool lib32gcc1 libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5 libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip python3-ply python-docutils qemu-utils re2c rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev ca-certificates
sudo -E apt-get -qq autoremove --purge 
sudo -E apt-get -qq clean 
ulimit -a
ulimit -n 4096
df -hP
