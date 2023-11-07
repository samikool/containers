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

RUN useradd lidarr

RUN wget --content-disposition 'http://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64' \
    && tar -xvzf Lidarr*.linux*.tar.gz \
    && mv Lidarr /opt/ \
    && chown lidarr:lidarr -R /opt/Lidarr \
    && rm Lidarr*.linux*.tar.gz

CMD ["/opt/Lidarr/Lidarr", "-nobrowser", "-data=/config"]