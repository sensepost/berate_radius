# About berate_radius

This project was created to simplify the process of creating a malicious RADIUS server.

# Usage

First, create a cerificate if you don't already have one. 

If you would like to create a certificate that is signed by a trusted CA, we recommend that you use [lego](https://go-acme.github.io/lego/usage/cli/obtain-a-certificate/) together with a CloudFlare API [key](https://go-acme.github.io/lego/dns/cloudflare/).

An example command to get your certificates using lego and a CloudFlare API key:

```
docker run --rm -it -v ./certs:/.lego/certificates \
 -e "CF_API_EMAIL=tester@example.com" \
 -e "CF_DNS_API_TOKEN=PLtbXXXXXXXXXXXXXXXVRqda" \
 goacme/lego --email "tester@example.com" --dns cloudflare --domains "wifi.example.com" -a run
```

To get the malicious RADIUS server up running you can either build the Docker image yourself or pull it from `ghcr.io/sensepost/berate_radius`.

```
docker run -it --rm -p 1813:1813/udp -p 1812:1812/udp -v ./certs:/certs ghcr.io/sensepost/berate_radius -d wifi.example.com
```

Berate_radius takes three parameters, namely domain, radius-password and radius-client-ip-range. However, these are optional as they have been set with default values. 

Note, if your volume mounts are different from the above commands then you will need to make sure to move over the certificates. As hostapd is configured to look in the certs directory for the following:

```
domain.crt
domain.issuer.crt
domain.key
```

Where domain is the domain you passed to berate_radius using `-d | --domain`.

Next, configure your Access Point with the malicious RADIUS server. If you are using hostapd, would need to set the following:

```
eap_server=0
auth_server_addr=127.0.0.1
auth_server_port=1812
auth_server_shared_secret=P@ssw0rd
```
