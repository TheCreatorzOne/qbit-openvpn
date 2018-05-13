FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

RUN apt-get update && \
    apt-get install -y qbittorrent-nox && \
    addgroup --gid 1000 qbittorrent && adduser --uid 1000 --gid 1000 --home /qbittorrent --shell /bin/bash --disabled-password --gecos "" qbittorrent && \
    mkdir -p /qbittorrent/.config/qBittorrent && \
    mkdir -p /qbittorrent/.local/share/data/qBittorrent && \
    chown -R 1000:1000 /qbittorrent && \
    ln -s /qbittorrent/.config/qBittorrent /config && \
    ln -s /qbittorrent/.local/share/data/qBittorrent /torrents && \
    mkdir /downloads && \
    ln -s /downloads /qbittorrent/downloads && \
    chown 1000:1000 /downloads && \
    chmod 2777 -R /qbittorrent /downloads

VOLUME ["/config", "/torrents", "/qbittorrent/downloads", "/config/qBittorrent.conf"]

EXPOSE 8080 6881

USER 1000:1000

WORKDIR /qbittorrent

CMD ["qbittorrent-nox"]
