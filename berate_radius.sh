#!/bin/sh

PROGNAME="berate_radius"

usage() {
    echo "Usage: "$PROGNAME" [options] <wifi-interface> [<interface-with-internet>] [<access-point-name> [<passphrase>]]"
    echo
    echo "Options:"
    echo "  -h, --help              Show this help"
    echo "  --version               Print version number"
    echo "  -e <hosts_file>         DNS server will take into account additional hosts file"
    echo
    echo "Useful informations:"
    echo "  * If you're not using the --no-virt option, then you can create an AP with the same"
    echo "    interface you are getting your Internet connection."
    echo "  * You can pass your SSID and password through pipe or through arguments (see examples)."
    echo "  * On bridge method if the <interface-with-internet> is not a bridge interface, then"
    echo "    a bridge interface is created automatically."
    echo
    echo "Examples:"
    echo "  "$PROGNAME" wlan0 eth0 MyAccessPoint MyPassPhrase"
    echo "  echo -e 'MyAccessPoint\nMyPassPhrase' | "$PROGNAME" wlan0 eth0"
    echo "  "$PROGNAME" wlan0 eth0 MyAccessPoint"
    echo "  echo 'MyAccessPoint' | "$PROGNAME" wlan0 eth0"
    echo "  "$PROGNAME" wlan0 wlan0 MyAccessPoint MyPassPhrase"
    echo "  "$PROGNAME" -n wlan0 MyAccessPoint MyPassPhrase"
    echo "  "$PROGNAME" -m bridge wlan0 eth0 MyAccessPoint MyPassPhrase"
    echo "  "$PROGNAME" -m bridge wlan0 br0 MyAccessPoint MyPassPhrase"
    echo "  "$PROGNAME" --driver rtl871xdrv wlan0 eth0 MyAccessPoint MyPassPhrase"
    echo "  "$PROGNAME" --daemon wlan0 eth0 MyAccessPoint MyPassPhrase"
    echo "  "$PROGNAME" --stop wlan0"
}

# defaults
PASSWORD=P@ssw0rd
RANGE=0.0.0.0/0
DOMAIN=example.com

export DOMAIN=wifi.example.com
/hostapd_configs/hostapd.conf.template > /hostapd_configs/hostapd.conf

export PASSWORD=P@ssw0rd 
export RANGE=0.0.0.0/0 
/hostapd_configs/hostapd.radius_client.template > /hostapd_configs/hostapd.radius_client


# Add flag for verbosity
hostapd-mana /hostapd_configs/hostapd.conf