FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

RUN apt-get update && \
    apt-get install -y unrar && \
    apt-get install -y qbittorrent-nox && \
    useradd -m -d /qbittorrent qbittorrent && \
    chown -R qbittorrent /qbittorrent && \
    mkdir -p /qbittorrent/.config/qBittorrent && \
    mkdir -p /qbittorrent/.local/share/data/qBittorrent && \
    ln -s /qbittorrent/.config/qBittorrent /config && \
    ln -s /qbittorrent/.local/share/data/qBittorrent /torrents && \
    mkdir /downloads && \
    mkdir /downloads/temp && \
    ln -s /downloads /qbittorrent/Downloads && \
    ln -s /downloads/temp /qbittorrent/Downloads/temp && \
    chown -R qbittorrent /downloads /downloads/temp && \
    chmod 2777 -R /qbittorrent /downloads /downloads/temp

VOLUME ["/config", "/torrents", "/qbittorrent/Downloads", "/config/qBittorrent.conf", "/qbittorrent/Downloads/temp"]

EXPOSE 8080 6881

USER qbittorrent

WORKDIR /qbittorrent

CMD ["qbittorrent-nox"]
