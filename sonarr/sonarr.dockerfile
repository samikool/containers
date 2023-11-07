FROM ubuntu:rolling

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        wget \
        gpg \
    && apt autoremove \
    && apt clean

RUN useradd sonarr

RUN apt install gnupg ca-certificates \
    && gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    # Get MediaInfo
    && wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-19_all.deb && dpkg -i repo-mediaarea_1.0-19_all.deb \
    # Add the Sonarr Repo
    && gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/sonarr-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8 \
    && echo "deb [signed-by=/usr/share/keyrings/sonarr-keyring.gpg] https://apt.sonarr.tv/ubuntu focal main" | tee /etc/apt/sources.list.d/sonarr.list \
    && apt update \
    && apt install -y sonarr \
    && apt autoremove \
    && apt clean

CMD ["/usr/bin/mono", "--debug", "/usr/lib/sonarr/bin/Sonarr.exe", "-nobrowser", "-data=/config"]