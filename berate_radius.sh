#!/bin/sh

export LC_ALL=C

PROGNAME="$(basename $0)"

usage() {
    echo "Usage: "$PROGNAME" [-h] [--domain example.com] [--radius-password P@ssw0rd] [--radius-client-ip-range 0.0.0.0/0]"
    echo
    echo "Options:"
    echo "  -h, --help                               Show this help"
    echo "  -d, --domain <domain>                    Domain of the certificate (default: \"example.com\")"
    echo "  -p, --radius-password <password>         Radius client password (default: \"P@ssw0rd\")"
    echo "  -r, --radius-client-ip-range <ip range>  Radius client allowed IP range (default: \"0.0.0.0/0\")"
    echo
}

# defaults
export PASSWORD="P@ssw0rd"
export RANGE="0.0.0.0/0"
export DOMAIN="example.com"

GETOPT_ARGS=$(getopt -o hd:p:r: -l "help","domain:","radius-password:","radius-client-ip-range:" -n "$PROGNAME" -- "$@")
[ $? -ne 0 ] && exit 1
eval set -- "$GETOPT_ARGS"

while :; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -d|--domain)
            shift
            DOMAIN="$1"
            shift
            ;;
        -p|--radius-password)
            shift
            PASSWORD="$1"
            shift
            ;;
        -r|--radius-client-ip-range)
            shift
            RANGE="$1"
            shift
            ;;
        --)
            shift
            break
            ;;
    esac
done

/hostapd_configs/hostapd.conf.template > /hostapd_configs/hostapd.conf 
/hostapd_configs/hostapd.radius_client.template > /hostapd_configs/hostapd.radius_client


# Add flag for verbosity
hostapd-mana /hostapd_configs/hostapd.conf