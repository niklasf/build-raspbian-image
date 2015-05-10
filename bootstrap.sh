#!/bin/sh

/home/niklas/Projekte/vmdebootstrap/vmdebootstrap \
    --arch armhf \
    --variant minbase \
    --distribution stretch \
    --mirror http://[::1]:3142/archive.raspbian.org/raspbian \
    --image `date +raspbian-%Y%m%d.img` \
    --keyring `pwd`/raspbian.org.gpg \
    --size 2000M \
    --bootsize 64M \
    --boottype vfat \
    --root-password raspberry \
    --enable-dhcp \
    --verbose \
    --no-kernel \
    --no-extlinux \
    --hostname raspberry \
    --foreign /usr/bin/qemu-arm-static \
    --customize `pwd`/customize.sh
