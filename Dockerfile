FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN apt-get update && \
    apt-get install -y qbittorrent-nox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    addgroup --gid 1000 qbittorrent && adduser --uid 1000 --ingroup qbittorrent --shell /bin/bash --disabled-password --gecos "" qbittorrent && \
    mkdir -p /home/qbittorrent/.config/qBittorrent && \
    mkdir -p /home/qbittorrent/.local/share/data/qBittorrent && \
    chown -R qbittorrent:qbittorrent /home/qbittorrent/ && \
    ln -s /home/qbittorrent/.config/qBittorrent /config && \
    ln -s /home/qbittorrent/.local/share/data/qBittorrent /torrents && \
    mkdir /downloads && \
    chown qbittorrent:qbittorrent /downloads

VOLUME ["/config", "/torrents", "/downloads"]

COPY qBittorrent.conf /config/qBittorrent.conf

EXPOSE 8080
EXPOSE 6881

USER qbittorrent

CMD ["qbittorrent-nox"]
