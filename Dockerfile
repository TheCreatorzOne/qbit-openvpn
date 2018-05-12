FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN apt-get update && \
    apt-get install -y qbittorrent-nox && \
    addgroup --gid 1000 qbittorrent && adduser --uid 1000 --ingroup qbittorrent --home /qbittorrent --shell /bin/bash --disabled-password --gecos "" qbittorrent && \
    mkdir -p /qbittorrent/.config/qBittorrent && \
    mkdir -p /qbittorrent/.local/share/data/qBittorrent && \
    chown -R qbittorrent:qbittorrent /qbittorrent && \
    ln -s /qbittorrent/.config/qBittorrent /config && \
    ln -s /qbittorrent/.local/share/data/qBittorrent /torrents && \
    mkdir /downloads && \
    ln -s /downloads /qbittorrent/downloads && \
    chown qbittorrent:qbittorrent /downloads && \
    chmod go+rw -R /qbittorrent /downloads

VOLUME ["/config", "/torrents", "qbittorrent/downloads"]

ADD qBittorrent.conf /config/qBittorrent.conf

EXPOSE 8080
EXPOSE 6881

WORKDIR /qbittorrent

CMD ["qbittorrent-nox"]
