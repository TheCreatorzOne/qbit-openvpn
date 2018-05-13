FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

RUN apt-get update && \
    apt-get install -y qbittorrent-nox && \
    useradd -m -d /qbittorrent qbittorrent && \
    chown -R qbittorrent /qbittorrent && \
    mkdir -p /qbittorrent/.config/qBittorrent && \
    mkdir -p /qbittorrent/.local/share/data/qBittorrent && \
    ln -s /qbittorrent/.config/qBittorrent /config && \
    ln -s /qbittorrent/.local/share/data/qBittorrent /torrents && \
    mkdir /downloads && \
    ln -s /downloads /qbittorrent/downloads && \
    chown -R qbittorrent /downloads && \
    chmod 2777 -R /qbittorrent /downloads

VOLUME ["/config", "/torrents", "/qbittorrent/downloads", "/config/qBittorrent.conf"]

EXPOSE 8080 6881

USER qbittorrent

WORKDIR /qbittorrent

CMD ["qbittorrent-nox"]
