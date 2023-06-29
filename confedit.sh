#!/bin/sh

# Stolen from https://git.alpinelinux.org/aports/tree/main/hostapd/APKBUILD
{ sed \
    		-e '/^#CONFIG_DRIVER_NL80211=y/s/^#//' \
			-e '/^#CONFIG_RADIUS_SERVER=y/s/^#//' \
			-e '/^#CONFIG_DRIVER_WIRED=y/s/^#//' \
			-e '/^#CONFIG_DRIVER_NONE=y/s/^#//' \
			-e '/^#CONFIG_IEEE80211N=y/s/^#//' \
			-e '/^#CONFIG_IEEE80211R=y/s/^#//' \
			-e '/^#CONFIG_IEEE80211AC=y/s/^#//' \
			-e '/^#CONFIG_IEEE80211AX=y/s/^#//' \
			-e '/^#CONFIG_FULL_DYNAMIC_VLAN=y/s/^#//' \
			-e '/^#CONFIG_LIBNL32=y/s/^#//' \
			-e '/^#CONFIG_ACS=y/s/^#//' \
			-e '/^#CONFIG_WEP=y/s/^#//' \
			-e '/^#CONFIG_SAE=y/s/^#//' \
			defconfig 
		echo "CC ?= ${CC:-gcc}" 
		echo "CFLAGS += -I/usr/include/libnl3" 
		echo "LIBS += -L/usr/lib" 
	} >> .config 
    
CFLAGS="$CFLAGS -flto=auto" make all nt_password_hash