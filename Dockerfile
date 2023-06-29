FROM alpine:3.18 AS BUILDER

RUN apk add openssl-dev libnl3-dev linux-headers git alpine-sdk

COPY --chmod=755 confedit.sh /confedit.sh

WORKDIR /hostapd-mana
RUN git clone https://github.com/sensepost/hostapd-mana . &&\
    git checkout 1302a7204d9118efa0668df1924c938dbe8d1b11

WORKDIR /hostapd-mana/hostapd
RUN /confedit.sh


FROM alpine:3.18

RUN apk add libnl3 libssl3

COPY --from=BUILDER /hostapd-mana/hostapd/hostapd_cli /usr/bin/hostapd-mana_cli
COPY --from=BUILDER /hostapd-mana/hostapd/hostapd /usr/sbin/hostapd-mana
COPY --from=BUILDER /hostapd-mana/hostapd/nt_password_hash /usr/bin/nt_password_hash

WORKDIR /hostapd_configs

COPY --chmod=755 /hostapd_configs/hostapd.conf.template /hostapd_configs/hostapd.conf.template
COPY --chmod=755 /hostapd_configs/hostapd.radius_client.template /hostapd_configs/hostapd.radius_client.template
COPY /hostapd_configs/hostapd.eap_user /hostapd_configs/hostapd.eap_user

COPY certs /certs
COPY output /output

COPY --chmod=755 berate_radius.sh /berate_radius.sh

ENTRYPOINT ["/berate_radius.sh"]