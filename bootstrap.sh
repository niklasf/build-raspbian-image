#!/bin/bash

# Used by rpi-update
pkgs="git-core binutils ca-certificates wget kmod"
# Stuff needed by debootstrap (need /etc/hosts)
pkgs="$pkgs netbase"
# Useful firmware packages to get free hardware working
pkgs="$pkgs firmware-linux-free"
# Other packages useful to get a debuggable environment
pkgs="$pkgs psmisc bootlogd tcpdump iputils-ping iftop vim-tiny awk"

for p in $pkgs ; do
    options+=" --package $p"
done

vmdebootstrap \
    --arch armhf \
    --distribution stretch \
    --mirror http://archive.raspbian.org/raspbian \
    --image `date +raspbian-stretch-%Y%m%d.img` \
    --size 2000M \
    --bootsize 64M \
    --boottype vfat \
    --root-password raspberry \
    --user=pi/raspberry \
    --sudo \
    --enable-dhcp \
    --log=log.debug \
    --log-level=info \
    --log-keep=1 \
    --verbose \
    --no-kernel \
    --no-extlinux \
    --no-acpid \
    --hostname raspberry \
    --foreign /usr/bin/qemu-arm-static \
    --debootstrapopts="variant=minbase keyring=`pwd`/raspbian.org.gpg" \
    --customize `pwd`/customize.sh \
    --pkglist \
    $options
