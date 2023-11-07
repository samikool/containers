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

RUN useradd radarr

RUN wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64' \
    && tar -xvzf Radarr*.linux*.tar.gz \
    && mv Radarr /opt/ \
    && chown radarr:radarr -R /opt/Radarr \
    && rm Radarr*.linux*.tar.gz

CMD ["/opt/Radarr/Radarr", "-nobrowser", "-data=/config"]