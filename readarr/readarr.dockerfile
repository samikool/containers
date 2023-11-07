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

RUN useradd readarr

RUN wget --content-disposition 'http://readarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64' \
    && tar -xvzf Readarr*.linux*.tar.gz \
    && mv Readarr /opt/ \
    && chown readarr:readarr -R /opt/Readarr \
    && rm Readarr*.linux*.tar.gz

CMD ["/opt/Readarr/Readarr", "-nobrowser", "-data=/config"]