#!/bin/sh

# defaults
password=P@ssw0rd
range=0.0.0.0/0
domain=example.com

domain=wifi.example.com /hostapd_configs/hostapd.conf.template > /hostapd_configs/hostapd.conf

password=P@ssw0rd range=0.0.0.0/0 /hostapd_configs/hostapd.radius_client.template > /hostapd_configs/hostapd.radius_client


# Add flag for verbosity
hostapd-mana /hostapd_configs/hostapd.conf