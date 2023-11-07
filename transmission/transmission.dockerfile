FROM ubuntu:rolling

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        openvpn \
        transmission-daemon \
        curl \
        iputils-ping \
        iproute2 \
    && apt autoremove \
    && apt clean

RUN useradd -ms /bin/bash sharing

COPY AirVPN_America_UDP-443.ovpn /AirVPN_America_UDP-443.ovpn
# COPY settings.json /settings.json
COPY run.sh /run.sh
# COPY settings.json /home/sharing/.config/transmission-daemon/settings.json

RUN chown -R sharing:sharing /home/sharing

CMD ["/bin/bash", "/run.sh"]