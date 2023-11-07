FROM ubuntu:rolling

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        curl \
        wget \
        sqlite3 \
        libicu-dev \
    && apt autoremove \
    && apt clean

RUN useradd prowlarr

RUN wget --content-disposition 'http://prowlarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64' \
    && tar -xvzf Prowlarr*.linux*.tar.gz \
    && mv Prowlarr /opt/ \
    && chown prowlarr:prowlarr -R /opt/Prowlarr \
    && rm Prowlarr*.linux*.tar.gz

CMD ["/opt/Prowlarr/Prowlarr", "-nobrowser", "-data=/config"]