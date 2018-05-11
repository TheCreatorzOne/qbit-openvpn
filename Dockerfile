FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

RUN apt-get -y update && \
    apt-get -y install build-essential && \
    pkg-config && \
    automake && \
    libtool && \
    git

RUN apt-get install libboost-dev && \
    libboost-system-dev && \
    libboost-chrono-dev && \
    libboost-random-dev && \
    libssl-dev && \
    libgeoip-dev

RUN apt-get install qtbase5-dev && \
    qttools5-dev-tools && \
    libqt5svg5-dev

RUN apt-get install python3

RUN apt-get install libtorrent-rasterbar-dev

RUN git clone https://github.com/arvidn/libtorrent.git && cd libtorrent

RUN git checkout $(git tag | grep libtorrent-1_0_ | sort -t _ -n -k 3 | tail -n 1) && \
    ./autotool.sh && \
    ./configure && \
    --disable-debug && \
    --enable-encryption && \
    --with-libgeoip=system && \
    CXXFLAGS=-std=c++11

RUN make clean && make -j$(nproc) && \
     make install

RUN git clone https://github.com/qbittorrent/qBittorrent && \
    cd qbittorrent && \
    ./configure --disable-gui && \
    make -j$(nproc) && \
     make install'

RUN addgroup --gid 1000 qbittorrent && \
    adduser --uid 1000 --ingroup qbittorrent --home /qbittorrent --shell /bin/bash --disabled-password --gecos "" qbittorrent && \
    mkdir -p /qbittorrent/.config/qBittorrent && \
    mkdir -p /qbittorrent/.local/share/data/qBittorrent && \
    mkdir /downloads && \
    chmod go+rw -R /qBittorrent /downloads && \
    ln -s /qbittorrent/.config/qBittorrent /config && \
    ln -s /qbittorrent/.local/share/data/qBittorrent /torrents && \

COPY qBittorrent.conf /default/qBittorrent.conf
COPY entrypoint.sh /

VOLUME ["/config", "/torrents", "/downloads"]

USER qbittorrent

EXPOSE 8080 6881

WORKDIR /qbittorrent
ENV HOME=/qbittorrent

ENTRYPOINT ["/entrypoint.sh"]

CMD ["qbittorrent-nox"]
